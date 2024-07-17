<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
	/* 글씨 좌우 이동 */
	.rlmargin{
		margin: 0px 35px;
	}
	/* 클릭시 색상 변경 */
	.nav-link.headerName.active{
		text-decoration: none;
        color: #053828;
        text-decoration-line: underline;
    }
	.nav-link.headerName{
		text-decoration: none;
        color: gray;
    }
	/* 알람창  내용 padding */
	.alertInfo{
		padding: 17px;
	}
	/* 알람창 선 위아래 마진 조정  */
	.upDownMargin{
		margin: 0px;
	}
	/* 스크롤바 전체 영역 */
	.dropdown-list.dropdown-menu::-webkit-scrollbar {
	  width: 10px;
	}
	
	/* 스크롤바  qorud tortkd */
	.dropdown-list.dropdown-menu::-webkit-scrollbar-track {
	  background-color: white;
	}
	
	/* 스크롤바  색상 */
	.dropdown-list.dropdown-menu::-webkit-scrollbar-thumb {
	  background-color: #ebf1e9;
	  border-radius: 10px;
	}
	
	/* 스크롤바 핸들 호버 시 */
	.dropdown-list.dropdown-menu::-webkit-scrollbar-thumb:hover {
	  background: #555;
	}
	
	/* 알람창 크기 조절 */
	.dropdown-list.dropdown-menu {
	  max-height: 400px; 
	  overflow-y: auto;
	}
	
</style>  
<script>
$(function(){
	//header 클릭시 최상위 메뉴 들어감
		//학생 사이버캠퍼스
	$("#cybConSul").on("click", function(){
		console.log("ck");
 		location.href="/consulting/list?menuId=cybConSul";
	});	
		//학생 수강신청사이트
	$("#couRegChk").on("click", function(){
		console.log("ck");
 		location.href="/stuLecture/list?menuId=couRegChk";
	});
		//학생 공지사항
	$("#couNotIce").on("click", function(){
		console.log("ck");
 		location.href="/commonNotice/listStu?menuId=couNotIce";
	});
		//학생 인재타임
	$("#injLecDea").on("click", function(){
		console.log("ck");
 		location.href="/timePost/exchaBoard?menuId=injLecDea";
	});
		//교수 공지사항
	$("#annNotIce").on("click", function(){
		console.log("ck");
 		location.href="/commonNotice/list?menuId=annNotIce";
	});
		//교수 강의
	$("#lecProGre").on("click", function(){
		console.log("ck");
 		location.href="/profLecture/list?menuId=lecProGre";
	});
		//교수 학생
	$("#proChaMan").on("click", function(){
		console.log("ck");
 		location.href="/student/stuList?menuId=proChaMan";
	});
		//관리자 일반
	$("#manNotIce").on("click", function(){
		console.log("ck");
		location.href="/commonNotice/listAdm?menuId=manNotIce";
	});	
		//관리자 교수/교직원
	$("#pstProChk").on("click", function(){
		console.log("ck");
		location.href="/manager/profList?menuId=pstProChk";
	});	
		//관리자 학생
	$("#stuTuiPay").on("click", function(){
		console.log("ck");
		location.href="/tution/manConfirmation?menuId=stuTuiPay";
	});	
		//관리자 통계
	$("#ratEmpMan").on("click", function(){
		console.log("ck");
		location.href="/manager/empRate?menuId=ratEmpMan";
	});	
		//관리자 인재타임
	$("#injLecDeaAdmin").on("click", function(){
		console.log("ck");
		location.href="/timePost/exchaBoardAdmin?menuId=jaeLecDea";
	});	
});
</script>

<nav
	class=" navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
	<ul class="nav">
		<!-- 학생 tab Sidebar Toggle (Topbar) -->
		<sec:authorize access="hasRole('ROLE_STUDENT')">
		<li class="nav-item d-none d-sm-inline-block rlmargin" id="cybConSul"> 
			<a href="#cyberCampus" class="nav-link headerName" data-toggle="tab"><b>사이버캠퍼스</b></a> 
		</li>
			<li class="nav-item d-none d-sm-inline-block rlmargin" id="couRegChk"> 
				<a href="#courseRegistration" class="nav-link headerName" data-toggle="tab"><b>수강신청시스템</b></a> 
			</li>  
 		<li class="nav-item d-none d-sm-inline-block rlmargin" id="couNotIce"> 
 			<a href="#studentAnnouncement" class="nav-link headerName" data-toggle="tab"><b>공지사항</b></a> 
 		</li>  
 		<li class="nav-item d-none d-sm-inline-block rlmargin" id="injLecDea"> 
 			<a href="#injaeTime" class="nav-link headerName" data-toggle="tab"><b>인재타임</b></a> 
 		</li> 
 		</sec:authorize>
		<!-- 학생header end -->
		
		<!-- 교직원 tab  header start-->
		<sec:authorize access="hasRole('ROLE_PROFESSOR')">
		<li class="nav-item d-none d-sm-inline-block rlmargin" id="annNotIce">
			<a href="#profAnnouncement" class="nav-link headerName"  data-toggle="tab"><b>공지사항</b></a>
		</li>
		<li class="nav-item d-none d-sm-inline-block rlmargin" id="lecProGre">
			<a href="#profLecture" class="nav-link headerName" data-toggle="tab"><b>강의</b></a>
		</li>
		<li class="nav-item d-none d-sm-inline-block rlmargin" id="proChaMan">
			<a href="#profSIC" class="nav-link headerName" data-toggle="tab"><b>학생</b></a>
		</li>
 		</sec:authorize>
		<!-- 교직원  header end -->
		<!-- 관리자 header start -->
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<li class="nav-item d-none d-sm-inline-block rlmargin"id="manNotIce">
			<a href="#managerNomal" class="nav-link headerName"  data-toggle="tab"><b>일반</b></a>
		</li>
		<li class="nav-item d-none d-sm-inline-block rlmargin" id="pstProChk">
			<a href="#managerProfEmp" class="nav-link headerName" data-toggle="tab"><b>교수/교직원</b></a>
		</li>
		<li class="nav-item d-none d-sm-inline-block rlmargin" id="stuTuiPay">
			<a href="#managerStub" class="nav-link headerName" data-toggle="tab"><b>학생</b></a>
		</li>
		<li class="nav-item d-none d-sm-inline-block rlmargin" id="ratEmpMan">
			<a href="#managerStatistics" class="nav-link headerName" data-toggle="tab"><b>통계</b></a>
		</li>
		<li class="nav-item d-none d-sm-inline-block rlmargin" id="injLecDeaAdmin">
			<a href="#managerInjaeTime" class="nav-link headerName" data-toggle="tab"><b>인재타임</b></a>
		</li>
	</sec:authorize>
		<!-- 관리자 header end -->
	</ul>
	<!-- Topbar Navbar -->
	<ul class="navbar-nav ml-auto">

		<li class="nav-item dropdown no-arrow d-sm-none">
		<a class="nav-link dropdown-toggle" href="#" id="searchDropdown"
			role="button" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"> 
			<i class="fas fa-search fa-fw"></i>
		</a> 
			<div
				class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
				aria-labelledby="searchDropdown">
				<form class="form-inline mr-auto w-100 navbar-search">
					<div class="input-group">
						<input type="text" class="form-control bg-light border-0 small"
							placeholder="Search for..." aria-label="Search"
							aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn btn-primary" type="button">
								<i class="fas fa-search fa-sm"></i>
							</button>
						</div>
					</div>
				</form>
			</div></li>

		<!-- Nav Item - Alerts 추후 db 자료 들어갈 예정 -->
		<li class="nav-item dropdown no-arrow mx-1"><a
			class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
			role="button" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
				<span class="badge badge-danger badge-counter">4+</span>
		</a> 
		<!-- Dropdown - Alerts -->
			<div
				class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
				aria-labelledby="alertsDropdown">
<!-- 				<h5 class="dropdown-header">알람창</h5> -->
				<div class="alertInfo">
					<div class="w-100 d-flex justify-content-between">
						<span class="font-weight-bold">
							<a href="#" style="color: gray;">
								<p>[카테고리] 알람제목알람...</p>
							</a>
						</span> 
						
						<button type="button" class="btn-tool align-self-start"style="background-color: white; border: none;" >
						 	<i class="fas fa-times"></i>
						</button>
					</div>
					<div>
						<a href="#" style="color: gray;">
							<p class="font-weight-bold">알람내용알람내용알람내용알람내용...</p>
						</a>
					</div>
					<div class="small text-gray-500">
						<i class="far fa-clock mr-1"></i> 2024-12-01 18:30
					</div>
				</div>

				<hr class="upDownMargin">
				<div class="alertInfo">
					<div class="w-100 d-flex justify-content-between">
						<span class="font-weight-bold">
							<a href="#" style="color: gray;">
								<p>[카테고리] 알람제목알람...</p>
							</a>
						</span> 
						
						<button type="button" class="btn-tool align-self-start"style="background-color: white; border: none;" >
						 	<i class="fas fa-times"></i>
						</button>
					</div>
					<div>
						<a href="#" style="color: gray;">
							<p class="font-weight-bold">알람내용알람내용알람내용알람내용...</p>
						</a>
					</div>
					<div class="small text-gray-500">
						<i class="far fa-clock mr-1"></i> 2024-12-01 18:30
					</div>
				</div>

				<hr class="upDownMargin">
				<div class="alertInfo">
					<div class="w-100 d-flex justify-content-between">
						<span class="font-weight-bold">
							<a href="#" style="color: gray;">
								<p>[카테고리] 알람제목알람...</p>
							</a>
						</span> 
						
						<button type="button" class="btn-tool align-self-start"style="background-color: white; border: none;" >
						 	<i class="fas fa-times"></i>
						</button>
					</div>
					<div>
						<a href="#" style="color: gray;">
							<p class="font-weight-bold">알람내용알람내용알람내용알람내용...</p>
						</a>
					</div>
					<div class="small text-gray-500">
						<i class="far fa-clock mr-1"></i> 2024-12-01 18:30
					</div>
				</div>

				<hr class="upDownMargin">
				<div class="alertInfo">
					<div class="w-100 d-flex justify-content-between">
						<span class="font-weight-bold">
							<a href="#" style="color: gray;">
								<p>[카테고리] 알람제목알람...</p>
							</a>
						</span> 
						
						<button type="button" class="btn-tool align-self-start"style="background-color: white; border: none;" >
						 	<i class="fas fa-times"></i>
						</button>
					</div>
					<div>
						<a href="#" style="color: gray;">
							<p class="font-weight-bold">알람내용알람내용알람내용알람내용...</p>
						</a>
					</div>
					<div class="small text-gray-500">
						<i class="far fa-clock mr-1"></i> 2024-12-01 18:30
					</div>
				</div>

				<hr class="upDownMargin">
			</div> <!-- Dropdown alert end  -->
			</li>

			<!-- alert end  -->
		<!-- 로그인 하지 않은 경우 true -->
<%-- 		<sec:authorize access="isAnonymous()"> --%>
<!-- 		<li class="nav-item dropdown no-arrow"> -->
<!-- 			<a href="/login"><span class="mr-2 d-none d-lg-inline text-gray-600 small"> -->
<!-- 			로그인 해주세요</span></a>  -->
<!-- 		</li> -->
<%-- 		</sec:authorize> --%>
				
		<!-- 인증된 사용자의 경우 true -->
<%-- 		<sec:authorize access="isAuthenticated()"> --%>
<!-- 			<!-- principal : CustomUser customUser --> 
<%-- 			<sec:authentication property="principal.userInfoVO" var="userInfoVO" /> --%>
<!-- 		<!-- Nav Item - User Information --> 
<!-- 		<li class="nav-item dropdown no-arrow"><a -->
<!-- 			class="nav-link dropdown-toggle" href="#" id="userDropdown" -->
<!-- 			role="button" data-toggle="dropdown" aria-haspopup="true" -->
<!-- 			aria-expanded="false"> <span -->
<!-- 				class="mr-2 d-none d-lg-inline text-gray-600 small"> -->
<%-- 				${memberVO.userName}(${memberVO.userId})</span> <img class="img-profile rounded-circle" --%>
<!-- 				src="/resources/upload/2023/11/07/s_dc85b158-287f-4b94-9c2e-4b5ba2f43220_d001.jpg" /> -->
<!-- 		</a> Dropdown - User Information -->
<!-- 			<div -->
<!-- 				class="dropdown-menu dropdown-menu-right shadow animated--grow-in" -->
<!-- 				aria-labelledby="userDropdown"> -->
<!-- 				<a class="dropdown-item" href="#"> <i -->
<!-- 					class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Profile -->
<!-- 				</a> <a class="dropdown-item" href="#"> <i -->
<!-- 					class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> Settings -->
<!-- 				</a> <a class="dropdown-item" href="#"> <i -->
<!-- 					class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i> Activity -->
<!-- 					Log -->
<!-- 				</a> -->
<!-- 				<div class="dropdown-divider"></div>				 -->
<!-- 				<a class="dropdown-item" href="#" data-toggle="modal" -->
<!-- 					data-target="#logoutModal"> <i -->
<!-- 					class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> -->
<!-- 					Logout -->
<!-- 				</a> -->
<!-- 			</div></li> -->
<%-- 		</sec:authorize> --%>
	</ul>

</nav>






