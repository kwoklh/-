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
<h4>등록금 분할 납부</h4>

<div class="card-body">
<div class="card card-light card-outline">

<div class="card-body" style="border-width: 3px">
<p>
※ 안내사항<br>

분할납부로 하는 경우는 분할 납부만 가능합니다.<br>

예시) 1차 납부 -> 미납, 1차 납부 -> 2차 납부 -> 완납
</p>
</div>
</div>
</div>

<c:set var="now" value="<%=new Date()%>" />
<fmt:formatDate var="sysYear" value="${now}" pattern="yyyy-MM-dd"/>

<p>현재 날짜 : ${sysYear} 

<%--    
 데이터 x > 전체납부
 1차
 2차
 3차
--%>

기간 입니다.</p>

<div class="col-12">
<div class="card">


<div class="card-body table-responsive p-0" style="height: 300px;">
<table class="table table-head-fixed text-nowrap" style="border: 3px">
<thead>
<tr>
<th>기간</th>
<th>납부금액</th>
<th>납부</th>
</tr>
</thead>
<tbody>
<%-- <c:forEach var="" items="" varStatus="stat"> --%>
<!-- <tr> -->
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