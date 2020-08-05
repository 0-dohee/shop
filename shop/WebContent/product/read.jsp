<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
	
<!DOCTYPE html>
<html>
<head>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<meta charset="UTF-8">
	<title>SHOP</title>
	<link rel="stylesheet" href="../style.css">
</head>
<body>
	<div id="header">
		<h1>CHANGSIK's CHOICE</h1>
	</div>
	<div id="divPage">
		<div id="divMenu"><jsp:include page="../menu.jsp" /></div>
		<div id="divHeader">
			<h2>PRODUCT INFORMATION</h2>
		</div>
		<form name="frm" action="update" method="post" enctype="multipart/form-data">
			<table id="tbl">
				<tr>
					<td class="title" width=100>상품코드</td>
					<td width=100 class="row1"><input type="text" name="prod_id" size=10 value="${ vo.prod_id }" readonly></td>
					<td class="title" width=100>제조원/수입원</td>
					<td width=200 class="row1"><input type="text" name="company" size=27 value="${ vo.company }"></td>
					<td class="title" width=100>판매가격</td>
					<td width=100 class="row1"><input type="text" name="price1" size=10 value="${ vo.price1 }"></td>
				</tr>
				<tr>
					<td class="title">업체코드</td>
					<td colspan=3 class="row1">
						<input type="text" name="mall_id" size=10 value="${ vo.mall_id }">
						<input type="text" name="mall_name" size=47 value="${ vo.mall_name }">
					</td>
					<td class="title" class="row1">일반가격</td>
					<td class="row1"><input type="text" name="price2" size=10 value="${ vo.price2 }"></td>
				</tr>
				<tr>
					<td class="title">상품이름</td>
					<td colspan=3 class="row1"><input type="text" name="prod_name" size=65 value="${ vo.prod_name }"></td>
					<td class="title" class="row1">판매중지</td>
					<td class="row1"><input type="checkbox" name="prod_del" value="1" <c:out value="${vo.prod_del=='1'?'checked':''}"/> >판매중지</td>
				</tr>
				<tr>
					<td class="title">상품이미지</td>
					<td colspan=5 class="row1">
						<c:if test="${vo.image==null}"> <img src="http://placehold.it/150x120" id="image" width=150/> </c:if>
						<c:if test="${vo.image!=null}"> <img src="/img/product/${vo.image}" id="image" width=150/> </c:if>
						<input type="file" name="image" accept="image/*" style="visibility: hidden;"> 
					</td>
				</tr>
				<tr>
					<td class="title">상품설명</td>
					<td colspan=5 class="row1"><textarea rows="10" cols="100" name="detail">${ vo.detail }</textarea></td>
				</tr>
			</table>
			<div id="pagination">
				<input type="submit" value="수정">
				<input type="reset" value="취소">
				<input type="button" value="삭제" id="btnDelete">
			</div>
		</form>
	</div>
	
</body>
<script>
	var prod_id="${vo.prod_id}";
	
	// 삭제 버튼을 클릭했을때
	$("#btnDelete").on("click", function(){
		if(!confirm("삭제하시겠습니까 ?")) return;
		$.ajax({
			type:"get",
			url:"delete",
			data:{"prod_id":prod_id},
			dataType:"json",
			success:function(data) {
				if(data.count==0) {
					alert("삭제 완료 !");
					location.href="list.jsp";
				}else {
					alert("해당 상품에 구매정보가 있어 삭제 불가  凸(¬‿¬)");
				}
			}
			
		});
	});
	
	// 수정버튼을 클릭했을때
	$(frm).submit(function(e){
		e.preventDefault();
		if(!confirm("수정하시겠습니까 ?")) return;
		frm.submit();
	});
	
	// 판매중지 체크박스를 클릭했을때
	$(frm.prod_del).on("click", function(){
		if($(frm.prod_del).is(":checked")) {
			alert("판매 중지 !");
		}else {
			alert("판매 개시 !");
		}
	});
	
	//업로드할 이미지 불러오기
	$("#image").on("click", function(){
		$(frm.image).click();
	});
	
	// 이미지 미리보기
	$(frm.image).on("change", function(){
		var reader=new FileReader();
		reader.onload=function(e) {
			$("#image").attr("src", e.target.result);
		}
		reader.readAsDataURL(this.files[0]);
	});
	
	//업체목록 불러오기 
	$(frm.mall_id).click(function(){ 
		window.open('/shop/mall/listAll.jsp','mall','width=400,height=400,top=200,left=900');
	});
</script>
</html>