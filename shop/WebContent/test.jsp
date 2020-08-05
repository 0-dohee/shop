<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>MARKET HONG</title>
    <style>
    	img {width:1500px;margin:auto;}
    </style>
    <script type="text/javascript">
        var imgArray = new Array();
        imgArray[0] = "ad1.jpg";
        imgArray[1] = "ad2.jpg";
        imgArray[2] = "ad3.jpg";
        imgArray[3] = "ad4.jpg";
        imgArray[4] = "ad5.jpg";
 
        function showImage() {
            var imgNum = Math.round(Math.random() * 4);
            var objImg = document.getElementById("introImg");
            objImg.src = imgArray[imgNum];
            setTimeout("showImage()", 2000);
        }
    </script>
</head>
<body onload="showImage()">
        <img id="introImg" border="0">
</body>
</html>
