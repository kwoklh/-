<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<script type="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
</head>
<style>
.row {
  justify-content: center;
}
.ahrfhr {
  width: 105px;
  justify-content: center;
  display: inline-block;
}
h3 {
/*   text-align: center; /* h3 태그를 가운데 정렬 */
    margin-bottom: 30px;
    margin-top: 40px;
    color:black;
}
.card-body {
    flex: 1 1 auto;
    min-height: 1px;
    padding: 4.25rem;
}
.userImage{
	width: 260px;
	height: 320px;
}
</style>
<body>
<h3>담당학생 정보 조회</h3>
<div class="card card-solid">
	<div class="card-body pb-0"
		style="overflow: auto; width: 2000px; height: 700px;">
		<div class="row">
			<div
				class="col-md-6 d-flex align-items-stretch flex-column">
				<div class="card bg-light d-flex flex-fill" style="height:523px">
					<div class="card-header text-muted border-bottom-0">
						<br>
					</div>
					<div class="card-body pt-0">
						<div class="row">
							<div class="col-7">
								<h2 class="lead" align="center"
									style="font-weight: bold; font-size: 27px;">
									<b>${studentVO.userInfoVO.userName}</b>
								</h2>
								<br>
									<p class="text-muted text-sm" style="font-size: 18px;">
										<b>학과 : ${studentVO.comDetCodeVO.comDetCodeName}</b>
									</p>
									<p class="text-muted text-sm" style="font-size: 18px;">
										<b>학년 : ${studentVO.stGrade}학년</b>
									</p>
									<p class="text-muted text-sm" style="font-size: 18px;">
										<b>학번 : ${studentVO.stNo}</b>
									</p>
									<p class="text-muted text-sm" style="font-size: 18px;">
										<b>연락처 : ${studentVO.userInfoVO.userTel}</b>
									</p>
									<p class="text-muted text-sm" style="font-size: 18px;">
										<b>학적상태 : ${studentVO.studentStatVO.stStat}</b>
									</p>
									<p class="text-muted text-sm" style="font-size: 18px;">	
										<b>이메일 : ${studentVO.stEmail}</b>
									</p>
									<p class="text-muted text-sm" style="font-size: 18px;">	
										<b>주소 : ${studentVO.stAddr}</b>
									</p>
							</div>
							<div class="col-5 text-center" >
							<img src="${studentVO.stuAttachFileVO.stuFilePath}" 
									alt="user-avatar" class="img-square img-fluid userImage">
							</div>
						</div>
					</div>
					<div class="card-footer">
						<div class="text-center" style="font-weight: bold">
							<p style="margin: 0px 0px 0px 0px;">
								대덕인재대학교 <img src="../../../resources/images/emblem2.png"
									alt="user-avatar" class="img-circle img-fluid" width="40"
									height="40">
							</p>	
								</div>
					</div>
				</div>
					<div class="text-center mt-3">
						<button onclick="location.href='/student/stuList?menuId=proChaMan'" class="btn btn btn-block btn-outline-secondary ahrfhr">목록</button>
					</div>
			</div>

		</div>
	</div>
</div>
	
</body>
</html>