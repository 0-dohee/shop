<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<meta charset="UTF-8">
	<title>SHOP</title>
	<link rel="stylesheet" href="../style.css">
	<style>
		.row .order_id, .row .name, .row .tel, .row .btn {
			text-align:center;
		}
	</style>
</head>
<body>
	<div id="header">
		<h1>CHANGSIK's CHOICE</h1>
	</div>
	<div id="divPage">
		<div id="divMenu"><jsp:include page="../menu.jsp" /></div>
		<!-- 내용 입력 시작 ---------------------------------------------->
		<div id="divHeader">
			<h2>ORDER LIST</h2>
		</div>
		<div id="divCondition">
			<div id="divSearch">
				<select id="selKey">
					<option value="order_id">주문번호</option>
					<option value="name">구매자명</option>
					<option value="address">주소</option>
				</select> 
				<input type="text" id="txtWord"> 
				<select id="selPerPage">
					<option value="3">3행</option>
					<option value="5" selected>5행</option>
					<option value="10">10행</option>
				</select> <input type="button" id="btnSearch" value="검색"> 
				<span style="font-size: 12px;">검색수: <b id="count"></b>건</span>
			</div>
			<div id="divSort">
				<select id="selOrder">
					<option value="order_id">주문번호</option>
					<option value="name">구매자명</option>
					<option value="address">주소</option>
				</select> <select id="selDesc">
					<option value="">오름차순</option>
					<option value="desc">내림차순</option>
				</select>
			</div>
		</div>
		<table id="tbl"></table>
		<script id="temp" type="text/x-handlebars-template"> 
		<tr class="title"> 
			<td width=100>주문번호</td> 
			<td width=100>구매자명</td> 
			<td width=300>주소</td> 
			<td width=150>전화번호</td> 
			<td width=50>구매정보</td> 
		</tr> 
		{{#each array}} 
		<tr class="row"> 
			<td class="order_id">{{order_id}}</td> 
			<td class="name">{{name}}</td> 
			<td class="address">{{address}}</td> 
			<td class="tel">{{tel}}</td> 
			<td class="btn"><button>보기</button></td> 
		</tr> 
		{{/each}} 
		</script>
		<div id="pagination">
			<button id="btnPre">◀</button>
			[<span id="curPage"></span>/<span id="totPage"></span>]
			<button id="btnNext">▶</button>
		</div>
		<div id="line"><h4>--------------------------------------------------------------------------------------------------------------------</h4></div>
		<div id="divInfo">
			<table id="tblInfo" style="margin-top: 30px;"></table>
			<script id="tempInfo" type="text/x-handlebars-template"> 
			<tr> 
				<td class="title" width=50>이름</td> 
				<td width=100 class="row">{{name}}</td> 
				<td class="title" width=50>전화</td> 
				<td width=200 class="row">{{tel}}</td> 
				<td class="title" width=50>이메일</td> 
				<td width=150 class="row">{{email}}</td> 
				<td class="title" width=50>구매일</td> 
				<td width=150 class="row">{{pdate}}</td> 
			</tr> 
			<tr> 
				<td class="title" width=50>주소</td> 
				<td id="address" colspan=3 class="row">{{address}}</td> 
				<td class="title" width=50 >결제</td> 
				<td id="payTYpe" width=100 class="row">{{payType}}</td> 
				<td class="title" width=50>상태</td> 
				<td id="status" width=100 class="row">{{status}}</td> 
			</tr> 
			</script>
			<br>
			<table id="tblOrder"></table> 
			<script id="tempOrder" type="text/x-handlebars-template"> 
			<tr class="title"> 
				<td width=100>상품코드</td> 
				<td width=300>상품명</td> 
				<td width=100>제조사</td> 
				<td width=100>가격</td>
				<td width=100>수량</td> 
				<td width=100>합계</td> 
			</tr> 
			{{#each .}} 
			<tr class="row"> 
				<td>{{prod_id}}</td> 
				<td>{{prod_name}}</td> 
				<td>{{company}}</td> 
				<td>{{price}}</td> 
				<td>{{quantity}}</td> 
				<td>{{sum}}</td> 
			</tr> 
			{{/each}} 
			</script>
		</div>
		<!-- 내용 입력 종료 ---------------------------------------------->
	</div>
</body>
<script>
	var url = "/shop/purchase/list";
	$("#line").hide();
	
	// 보기 버튼을 클릭했을때
	$("#tbl").on("click", ".row button", function(){
		var row=$(this).parent().parent();
		var order_id=row.find(".order_id").html();
		$.ajax({
			type:"get",
			url:"read",
			data:{"order_id":order_id},
			dataType:"json",
			success:function(data) {
				$("#line").show();
				var template = Handlebars.compile($("#tempInfo").html());
				$("#tblInfo").html(template(data));
			}
		});
		$.ajax({
			type:"get",
			url:"/shop/orders/list",
			data:{"order_id":order_id},
			dataType:"json",
			success:function(data) {
				var template = Handlebars.compile($("#tempOrder").html());
				$("#tblOrder").html(template(data));
			}
		});
	});
</script>
<script src="../home.js"></script>
</html>