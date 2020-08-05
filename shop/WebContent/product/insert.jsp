<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
			<h2>PRODUCT REGISTRATION</h2>
		</div>
		<form name="frm" action="insert" method="post" enctype="multipart/form-data">
			<table id="tbl">
				<tr>
					<td class="title" width=100>상품코드</td>
					<td width=100 class="row1"><input type="text" name="prod_id" size=10 readonly></td>
					<td class="title" width=100>제조원/수입원</td>
					<td width=200 class="row1"><input type="text" name="company" size=27></td>
					<td class="title" width=100>판매가격</td>
					<td width=100 class="row1"><input type="text" name="price1" size=10></td>
				</tr>
				<tr>
					<td class="title">업체코드</td>
					<td colspan=3 class="row1"><input type="text" name="mall_id" size=10><input
						type="text" name="mall_name" size=47></td>
					<td class="title" class="row1">일반가격</td>
					<td class="row1"><input type="text" name="price2" size=10></td>
				</tr>
				<tr>
					<td class="title">상품이름</td>
					<td colspan=5 class="row1"><input type="text" name="prod_name" size=99></td>
				</tr>
				<tr>
					<td class="title">상품이미지</td>
					<td colspan=5 class="row1">
						<img src="http://placehold.it/150x120" id="image" width=150 /> 
						<input type="file" name="image" accept="image/*" style="visibility: hidden;">
					</td>
				</tr>
				<tr>
					<td class="title">상품설명</td>
					<td colspan=5 class="row1"><textarea rows="10" cols="100" name="detail"></textarea></td>
				</tr>
			</table>
			<div id="pagination">
				<input type="submit" value="저장"> <input type="reset"
					value="취소">
			</div>
		</form>
	</div>
</body>
<script>
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
	
	//상품코드 불러오기
	$.ajax({
		type:"get",
		url:"id",
		dataType:"json",
		success:function(data) {
			$(frm.prod_id).val(data.id);
		}
	});
	
	//업체목록 불러오기 
	$(frm.mall_id).click(function(){ 
		window.open('/shop/mall/listAll.jsp','mall','width=400,height=400,top=200,left=900');
	});
</script>
</html>