<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<meta charset="UTF-8">
	<title>SHOP</title>
	<link rel="stylesheet" href="style.css">
	<style> 
		.box {width:200px; float:left; text-align:center; margin:auto; margin-bottom:10px;} 
		.price1, .prod_id, .prod_name {
			font-size:12px; width:200px; 
			text-overflow:ellipsis; 
			white-space:nowrap; 
			overflow:hidden;
		} 
		.cart0{font-size:12px; width:200px; cursor:pointer; font-weight:bold;}
		.cart1{font-size:12px; width:200px; color:red; font-weight:bold;} 
		.image img{width:150px; height:120px; margin:auto; margin-bottom:5px;} 
	</style>
</head>
<body>
	<div id="header"><h1>CHANGSIK's CHOICE</h1></div>
	<div id="divPage">
		<div id="divMenu"><jsp:include page="menu.jsp"/></div>
		<!-- 내용 입력 시작 ---------------------------------------------->
		<img src="2fe08f_1074e304e1204edd88f5eb8818d7c173_mv2.gif" style="width:980px;">
		<div id="divHeader">
			<h2>SHOW</h2>
		</div>
		<div id="divCondition">
			<div id="divSearch">
				<select id="selKey">
					<option value="prod_id">상품코드</option>
					<option value="prod_name">상품명</option>
					<option value="mall_name">업체명</option>
					<option value="company">제조사</option>
				</select> 
				<input type="text" id="txtWord"> 
				<select id="selPerPage">
					<option value="4">4행</option>
					<option value="8">8행</option>
					<option value="12" selected>12행</option>
				</select> <input type="button" id="btnSearch" value="검색"> 
				<span style="font-size: 12px;">검색수: <b id="count"></b>건</span>
			</div>
			<div id="divSort">
				<select id="selOrder">
					<option value="prod_id">상품코드</option>
					<option value="prod_name">상품명</option>
					<option value="mall_name">업체명</option>
					<option value="company">제조사</option>
					<option value="price1">판매가</option>
				</select> 
				<select id="selDesc">
					<option value="">오름차순</option>
					<option value="desc">내림차순</option>
				</select>
			</div>
		</div>
		<div id="tbl"></div>
		<script id="temp" type="text/x-handlebars-template"> 
		{{#each array}}
			<div class="box">
				<div class="image"><img src="{{printImage image}}"></div>
				<div class="prod_id">{{prod_id}}</div>
				<div class="prod_name">{{prod_name}}</div>
				<div class="price1">{{price1}}</div>
				<div class="cart{{prod_del}}">{{printDel prod_del}}</div>
			</div>
		{{/each}}
		</script>
		<div id="pagination">
			<button id="btnPre">◀</button>
			[<span id="curPage"></span>/<span id="totPage"></span>]
			<button id="btnNext">▶</button>
		</div>
		<!-- 내용 입력 종료 ---------------------------------------------->	
	</div>
</body>
<script>
	var url = "/shop/product/list";
	
	// 장바구니 버튼을 클릭한 경우
	$("#tbl").on("click", ".box .cart0", function(){
		var prod_id=$(this).parent().find(".prod_id").html();
		if(!confirm(prod_id + "상품을 장바구니로 이동하시겠습니까 ?")) return;
		$.ajax({
			type:"post",
			url:"/shop/cart/insert",
			data:{"prod_id":prod_id},
			success:function() {
				alert("장바구니에 이동 완료 !");
			}
		});
	});
	
	// 판매중지 상품 표시
	Handlebars.registerHelper("printDel", function(del){
		var src;
		if(del==1) src="판매중지"; else src="장바구니";
		return src;
	});
	
	// 이미지가 없는 상품
	Handlebars.registerHelper("printImage", function(image){
		var src;
		if(!image) src="http://placehold.it/300x200"; else src="/img/product/" + image;
		return src;
	});
</script>
<script src="home.js"></script>
</html>