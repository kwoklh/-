<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">   
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

* {

font-family: 'NanumSquareNeo';
color: black; 

}

</style>
</head>

<body>
<h4>등록금 납부 내역</h4>
<h6 style="text-align:right">[총 n건]</h6>


<div class="col-12">
<div class="card">


<div class="card-body table-responsive p-0" style="height: 300px;">
<table class="table table-head-fixed text-nowrap" style="border: 3px">
<thead>
<tr>
<th>연도</th>
<th>등록금</th>
<th>장학금</th>
<th>실납부액</th>
<th>납부여부</th>
</tr>
</thead>
<tbody>
<%-- <c:forEach var="" items="" varStatus="stat"> --%>
<!-- <tr> -->
<!-- <td></td> -->
<!-- <td></td> -->
<!-- <td></td> -->
<!-- <td></td> -->
<!-- <td></td> -->
<%-- </tr></c:forEach> --%>
</tbody>
</table>
</div>

</div>

</div>



<script type="text/javascript">


</script>

</body>
</html>