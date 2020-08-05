<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<meta charset="UTF-8">
	<title>SHOP</title>
	<style> 
		#tbl {width:350px; margin:auto;} 
		#pagination, h2 {width:350px; margin:auto; text-align:center; margin-top:10px; margin-bottom:10px;} 
		table {border-collapse:collapse;} 
		td {border:1px solid black; height:30px; font-size:12px; padding:0px 5px 0px 5px;} 
		table .title {background:#FCC8C5; text-align:center;} 
		table .row:hover {background:gray; color:white;} 
		h2 {font-family: "타이포_쌍문동";}
	</style>
</head>
<body>
	<div id="divAll">
			<h2>LIST OF COMPANIES</h2>
		<table id="tbl"></table>
		<script id="temp" type="text/x-handlebars-template"> 
		<tr class="title">
			<td width=100>업체코드</td>
			<td width=100>업체명</td>
			<td width=150>전화번호</td>
		</tr> 
		{{#each array}} 
		<tr class="row"> 
			<td class="mall_id">{{mall_id}}</td>
			<td class="mall_name">{{mall_name}}</td> 
			<td>{{tel}}</td> 
		</tr> 
		{{/each}} 
		</script>
		<div id="pagination">
			<button id="btnPre">◀</button>
			[<span id="curPage"></span>/<span id="totPage"></span>]
			<button id="btnNext">▶</button>
		</div>
	</div>
</body>
<script>
	var url="list";
	$("#tbl").on("click", ".row", function() {
		var mall_id=$(this).find(".mall_id").html();
		var mall_name=$(this).find(".mall_name").html();
		$(opener.frm.mall_id).val(mall_id);
		$(opener.frm.mall_name).val(mall_name);
		window.close();
	});
</script>
<script src="../home.js"></script>
</html>