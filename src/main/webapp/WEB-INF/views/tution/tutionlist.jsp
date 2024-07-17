<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/printThis.js"></script>
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
	<h6 style="text-align: right">[총 n건]</h6>


	<div class="col-12">
		<div class="card">


			<div class="card-body table-responsive p-0" style="height: 300px;">
				<table class="table table-head-fixed text-nowrap"
					style="border: 3px">
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
	<br>
	<!-- <p data-toggle="modal" data-target="#modal-lg">납부확인서</p> -->
	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target="#modal-lg" id="myModal">납부확인서</button>
	<div class="modal fade" id="modal-lg">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div id="myPdf">
					<div class="modal-header">
						<h4 class="modal-title" align="center">등록금 납부 확인서</h4>
						<!--         <button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
						<!--           <span aria-hidden="true">&times;</span> -->
						<!--         </button> -->
						<button id="myPdf2" type="button" class="btn btn-info"
							data-toggle="modal" data-target="#modal-info">PDF저장</button>
					</div>
					<div class="modal-body">
						<table border="1" style="width: 100%; text-align: center">
							<thead>
								<tr>
									<th colspan='2'>2022년1학기등록금</th>
									<th>구분</th>
									<th>등록금</th>
									<th>장학금액</th>
									<th>납입금액</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>대학</td>
									<td>대덕인재대학교</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>학과(전공)</td>
									<td>먼작귀학과</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>학번</td>
									<td>12341231</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>성명</td>
									<td>모몽가</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>납부일자</td>
									<td colspan='5'>2022년02월28일</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="modal-footer justify-content-between">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">

$("#myModal").on("click",function(){

	$("#myPdf2").on("click",function(){

		$("#myPdf2").css("display","none")
		
		$("#myPdf").printThis({
	
			debug:false,
			importCSS:true,
			printContainer:true,
		// 	loadCSS:"path/to/my.css",
			pageTitle:"",
			removeInLine:true

			})

	$("#myPdf").printThis();

})

})




</script>

</body>
</html>