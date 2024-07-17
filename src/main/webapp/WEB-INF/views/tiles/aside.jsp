<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
	
	#userDropdown{
		padding-bottom: 10px;
	}
	/* 프로필 배경색상 */
	#profiles{
		background-color: white;
	}
	/* 프로필사진 설정 */
	#profileMyImg{
	    float: left;
	}
	
	/* 프로필사진 + 상태 */
	#myImg{
		display: inline-grid;
		width: 70px;
    	height: 80px;
	}
	/* 재학상태 확인 */
	#situationCk{
		text-align: center;
	    font-weight: 600;
	}
	/* 프로필 정보 */
	#mySimpleInfo{
		display: inline-block;
	}
	/* 프로필 사진 크기 조절 */
	#profileMyImg{
		width: 65px;
    	height: 65px;
	}
	/* 학과, 이름 설정 */
	#myProfileInfofont{
	    font-size: medium;
    	font-weight: 600;
    }
	/*  */
	#logoutInfo{
		margin-top: 5px;
	}
	/* logoutCircle 설정 */
	#loginCircle {
		color: #858796;
	}
	/* logout 버튼 */
	.logoutClick{
		color: #858796;
		margin-left: 10px;
	}
	/* 사용자 정보 보기 설정 */
	.forwardMypage{
		text-align: center; /* 버튼 가운데 이동 */
	    margin-bottom: 10px;
	}
	.forwardMypageA{
		background-color: #9ba199;
	}
	/* aside 배경색상 설정 */
	#accordionSidebar{
		background-color: #053828;
	}
	/* 여닫이 설정 */
	.sidebar-dark .nav-item .nav-link[data-toggle=collapse]::after{
	 	color: white;
	}
	/* 대분류 글자 설정 */
	.mainCategory{
		color: white;
		font-size: medium;
   		font-weight: 800;
	}
	/* 대분류 사이 hr */
	.sidebar-dark hr.sidebar-divider {
    border-top: 1px solid white;
	}
	.portletPosition{
	 margin-top: 30px;
     margin-bottom: 10px;
	}
	
</style>

<script>
let timer;
$(function(){

	//aside tab 유지위한 파라미터 값 함수
	asideTabMaintain();
		
	//등록금 납부 알림창
	// TutionSweetalert();
	TutionSweetalert();
	
	// 세션시간 타이머 함수
	doTimer($("#sessionTimeOut").val());
	
	// 세션시간 리셋 함수
    $("#loginCircle").on('click', function(){
//         clearTimeout(timer);
        doTimer($("#sessionTimeOut").val());
        
       $.ajax({
			url:"/mainPage/loginSessionPlus",
			contentType:"application/json;charset=utf-8",
			type:"get",
			beforeSend:function(xhr){
	               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        success:function(result){
	        	console.log("result : ",result)
	        }
		});
    });
    
	// 로그아웃 버튼 클릭시
	$("#logoutBtn").on("click",function(){
		location.href="/logout";
	});

})//$function end

//aside tab 유지위한 파라미터 값 함수
function asideTabMaintain(){
	let url = window.location.href;
    console.log(url);
	let curMenuId= "sb1"
    if(url.indexOf("?")!=-1){
    curMenuId = url.split("?")[1].split("=")[1];
//  alert(curMenuId); //값만 나옴
	let firstWord = curMenuId.substring(0, 3);
	let secondWord = curMenuId.substring(3, 6);
	let lastWord = curMenuId.substring(6, 9);
	// console.log(firstWord,">",secondWord,">",lastWord)
	 $("."+firstWord).addClass("active");
	 $("."+secondWord).removeClass("collapsed");
	 $("."+lastWord).addClass("show");
	 }
}

//등록금 납부 알람창
function TutionSweetalert(){
   $("#studTution").on("click",function(){
      /* sweetalert */
      Swal.fire({
         title: "등록금 납부 선택하세요",
         showDenyButton: true,
         showCancelButton: true,
         confirmButtonText: "완납",
         denyButtonText: "분할납부",
         cancelButtonText: "취소"
      }).then((result) => {
         if (result.isConfirmed) {
            location.href="/tution/tutionall?menuId=cybTuiPay"
         } else if (result.isDenied) {
            location.href="/tution/tutionpart?menuId=cybTuiPay"
         }
      });
   })
}

function sessionTimeOut() {
      return new Promise(function(resolve, reject) {
        $.get('/logout', function(response) {
          if (response) {
              console.log("time2");
            resolve(response);
          }
          reject(new Error("Request is failed"));
        });
      });
    }

function doTimer(time){
    var date = new Date(null);
    if(time){
        date.setSeconds(time);
        document.getElementById("timeBox").innerHTML = date.toISOString().substr(14,5);
        if(time == 0){
            sessionTimeOut().then(function(data){
                clearTimeout(timer);
                alertMessage(messageType.type.E, "세션이 만료되었습니다.",
                        "다시 로그인해주세요", function(){location.href = "/logout";}  )
                return;
            }).catch(function(err){
                console.error(err);
            });
 
            return;
            
        }
 
        --time;
        timer = setTimeout(doTimer, 1000, time);
    }
    return;
}

</script>
		<sec:authentication property="principal.userInfoVO" var="userInfoVO" />
		<ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar">
		<!-- 학생 메인페이지 -->
			<a class="sidebar-brand d-flex align-items-center justify-content-center" href="/achieve/testMain">
		<!-- 교수 메인페이지 -->
<!-- 			<a class="sidebar-brand d-flex align-items-center justify-content-center" href="#"> -->
		<!-- 교직원 메인페이지  -->
<!-- 			<a class="sidebar-brand d-flex align-items-center justify-content-center" href="#"> -->
				<div class="sidebar-brand-text mx-1"><h5>학사관리시스템</h5></div>
			</a>
			<div id="profiles">
				<li class="nav-item dropdown no-arrow d-flex align-items-center">
					<div class="nav-link dropdown-toggle" id="userDropdown" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">
						<div id="myImgInfo">
							<div id="myImg">
								<img id="profileMyImg" class="img-profile rounded-circle" src="${userInfoVO.url}" alt="프로필사진">
								<sec:authorize access="hasRole('ROLE_STUDENT')">
									<span id="situationCk" class="mr-2 d-none d-lg-inline text-white-600 small text-muted">재학중</span>
								</sec:authorize>
							</div>
							<div id="mySimpleInfo">
								<sec:authorize access="hasRole('ROLE_STUDENT')">
									<span id="myProfileInfofont" class="mr-2 d-none d-lg-inline text-white-600 small text-muted">${userInfoVO.deptName}</span> <br>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_PROFESSOR')">
									<span id="myProfileInfofont" class="mr-2 d-none d-lg-inline text-white-600 small text-muted">${userInfoVO.deptName}</span> <br>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_STUDENT')">
									<span id="myProfileInfofont" class="mr-2 d-none d-lg-inline text-white-600 small text-muted">${userInfoVO.userName}</span>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_PROFESSOR')">
									<span id="myProfileInfofont" class="mr-2 d-none d-lg-inline text-white-600 small text-muted">${userInfoVO.userName}</span>
								</sec:authorize>
								<div id="logoutInfo">
									<span class="logoutTime text-muted">
										<button id="loginCircleBtn" class="btn" style="padding: 0;outline: none;box-shadow: none;">
											<i id="loginCircle" class="fas fa-sync-alt "></i>
										</button> <p id="timeBox" style="display:inline-block" ></p>
									</span>
									<span class="doLogoutClick">
										<button id="logoutBtn" class="btn" style="padding: 0;outline: none;box-shadow: none;">
											<i id="logoutClick" class="fas fa-door-open logoutClick" style="color: #858796;"></i>
										</button>
									</span>
								</div>
							</div>
						</div>
					</div>
				</li>
				<input type="hidden" id="sessionTimeOut" name="sessionTimeOut" value=<%=session.getMaxInactiveInterval() %>>
				<div class="forwardMypage">
					<a href="#" class="forwardMypageA btn btn-icon-split">
						<span class="text text-light">사용자 정보 보기</span>
					</a>
				</div>
			</div><!-- profiles end -->
			<div class="tab-content">
			<sec:authorize access="hasRole('ROLE_STUDENT')">
				<!-- 학생 tab Divider -->
				<!-- 학생  사이버캠퍼스 -->
				<div id="cyberCampus" class="cyb tab-pane">
					<li class="nav-item">
					<a class="nav-link Con collapsed" href="#" data-toggle="collapse"
							data-target="#studConsul" aria-expanded="true" aria-controls="studConsul"> 
							<span class="mainCategory">상담</span>
						</a>
						<div id="studConsul" class="Sul collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/consulting/list?menuId=cybConSul">- 상담내역</a> 
								<a class="collapse-item"href="/consulting/request?menuId=cybConSul">- 상담신청</a>
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<li class="nav-item">
					<a class="nav-link Aci collapsed" href="#" data-toggle="collapse"
							data-target="#studAchi" aria-expanded="true" aria-controls="studAchi">
							<span class="mainCategory">성적</span>
						</a>
						<div id="studAchi" class="collapse Chk" aria-labelledby="headingUtilities"
							data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/achieve/nowAch?menuId=cybAciChk">- 현재 성적 조회</a> 
								<a class="collapse-item " href="/achieve/lecEvaluation?menuId=cybAciChk">- 전체 성적 조회</a>
									
							</div>
						</div>
					</li>

					<hr class="sidebar-divider">

					<li class="nav-item">
					<a class="nav-link Tui collapsed" href="#" data-toggle="collapse"
							data-target="#studTuiPay" aria-expanded="true" aria-controls="studTuiPay">
							<span class="mainCategory">등록금/장학(금)</span>
						</a>
						<div id="studTuiPay" class="collapse Pay" aria-labelledby="headingPages" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" id="studTution">- 등록금 납부</a> <!-- 알림창 떠야 되는데? -->
								<a class="collapse-item" href="/tution/tutionlist?menuId=cybTuiPay">- 등록금 납부 내역</a> 
								<a class="collapse-item" href="/tution/scolarship?menuId=cybTuiPay">- 장학금 수혜 내역</a>
									
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<li class="nav-item">
						<a class="nav-link collapsed Rec" href="#" data-toggle="collapse"
							data-target="#studRecordManagement" aria-expanded="true" aria-controls="studRecordManagement">
							<span class="mainCategory">학적관리</span>
						</a>
						<div id="studRecordManagement" class="collapse Man" aria-labelledby="headingPages"
							data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/studstat/rest?menuId=cybRecMan">- 휴학 신청</a> 
								<a class="collapse-item" href="/studstat/comeback?menuId=cybRecMan">- 복학 신청</a> 
								<a class="collapse-item" href="/studstat/dropout?menuId=cybRecMan">- 자퇴 신청</a>
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<li class="nav-item">
						<a class="nav-link Job collapsed" href="#" data-toggle="collapse" data-target="#studJobHunting"
							aria-expanded="true" aria-controls="studJobHunting"> <span class="mainCategory">취업활동</span>
						</a>
						<div id="studJobHunting" class="collapse Hun" aria-labelledby="headingPages" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/employment/volunteer?menuId=cybJobHun">- 봉사활동 내역</a> 
								<a class="collapse-item" href="/employment/recruitment?menuId=cybJobHun">- 채용 정보</a> 
								<a class="collapse-item" href="/employment/certificate?menuId=cybJobHun">- 자격증</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<li class="nav-item">
						<a class="nav-link collapsed Inq" href="#" data-toggle="collapse" data-target="#studInquiry"
								aria-expanded="true" aria-controls="studInquiry"> 
								<span class="mainCategory">문의사항</span>
						</a>
						<div id="studInquiry" class="collapse Uir" aria-labelledby="headingPages" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/notice/list?menuId=cybInqUir">- 문의사항</a>
							</div>
						</div>
					</li>

					<!-- Divider -->
					<hr class="sidebar-divider">
				</div>
				<!-- 수강신청시스템  -->
				<div id="courseRegistration" class="tab-pane cou">
					<li class="nav-item cou">
					<a class="nav-link collapsed Reg" href="#" data-toggle="collapse"
							data-target="#studLecList" aria-expanded="true" aria-controls="studLecList">
							 <span class="mainCategory">수강조회</span>
					</a>
						<div id="studLecList" class="collapse Chk" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/stuLecture/list?menuId=couRegChk">- 수강조회</a> 
								<a class="collapse-item" href="/stuLecture/exchangeHistory?menuId=couRegChk">- 강의거래 내역</a>
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<li class="nav-item">
						<a class="nav-link collapsed Stu" href="#" data-toggle="collapse"
							data-target="#studCourseRegistration" aria-expanded="true" aria-controls="studCourseRegistration">
							<span class="mainCategory">수강신청</span>
						</a>
						<div id="studCourseRegistration" class="collapse Reg" aria-labelledby="headingUtilities"
							data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/lecture/cart?menuId=couStuReg">- 관심 과목 등록</a> 
								<a class="collapse-item"href="/lecture/enrolment?menuId=couStuReg">- 수강신청</a>
							</div>
						</div>
					</li>

					<hr class="sidebar-divider">

					<li class="nav-item">
						<a class="nav-link collapsed Reg" href="#" data-toggle="collapse"
						   data-target="#studGuide" aria-expanded="true" aria-controls="studGuide">
							<span class="mainCategory">수강편람</span>
						</a>
						<div id="studGuide" class="collapse Gui" aria-labelledby="headingPages" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/lecture/handbook?menuId=couRegGui">- 수강편람</a>
							</div>
						</div>
					</li>
					
					<hr class="sidebar-divider">
				</div>
				<!-- 수강신청시스템end -->
				<!-- 공지사항 -->
				<div id="studentAnnouncement" class="tab-pane">
					<li class="nav-item">
						<a class="nav-link collapsed Not" href="#" data-toggle="collapse"
								data-target="#studyNotice" aria-expanded="true" aria-controls="studyNotice">
								 <span class="mainCategory">공지사항</span>
						</a>
							<div id="studyNotice" class="collapse Ice" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
								<div class="bg-white py-2 collapse-inner rounded">
									<a class="collapse-item" href="/commonNotice/listStu?menuId=couNotIce">- 공지사항</a> 
								</div>
							</div>
						</li>
						<!-- <hr class="sidebar-divider"> -->
						
				</div>
				<!-- 공지사항end -->
				 <!-- 인재타임 -->
				<div id="injaeTime" class="tab-pane inj">
						<li class="nav-item">
							<a class="nav-link collapsed Lec" href="#" data-toggle="collapse"
							data-target="#studyLecDeal" aria-expanded="true" aria-controls="studyLecDeal">
							<span class="mainCategory">강의거래</span>
						</a>
						<div id="studyLecDeal" class="collapse Dea" aria-labelledby="headingUtilities"
							data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/timePost/exchaBoard?menuId=injLecDea">- 강의거래게시판</a> 
							</div>
						</div>
					</li>

					<hr class="sidebar-divider">

					<li class="nav-item">
						<a class="nav-link collapsed Top" href="#" data-toggle="collapse"
							data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
							<span class="mainCategory">추천 수강 내역</span>
						</a>
						<div id="collapsePages" class="collapse Boa" aria-labelledby="headingPages" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/timePost/lecutreBoast?menuId=injTopBoa">- 강의자랑게시글</a> 
							</div>
						</div>
					</li>
					<!-- Divider -->
					<hr class="sidebar-divider">

					<li class="nav-item">
						<a class="nav-link collapsed Fre" href="#" data-toggle="collapse"
							data-target="#recordManagement" aria-expanded="true" aria-controls="recordManagement">
							<span class="mainCategory">자유게시판</span>
						</a>
						<div id="recordManagement" class="collapse Ard" aria-labelledby="headingPages"
							data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/timePost/freeBoard?menuId=injFreArd">- 자유게시판</a> 
							</div>
						</div>
					</li>
					<!-- Divider -->
					<hr class="sidebar-divider">
				</div>
				</sec:authorize>
				<!-- 학생 end -->
				<!-- 교수 start -->
				<sec:authorize access="hasRole('ROLE_PROFESSOR')">
				 	<!-- 교수 공지사항 -->
				<div id="profAnnouncement" class="tab-pane ann">
					<li class="nav-item">
					<a class="nav-link collapsed Not" href="#" data-toggle="collapse"
							data-target="#profNotice" aria-expanded="true" aria-controls="profNotice"> 
							<span class="mainCategory">공지사항</span>
						</a>
						<div id="profNotice" class="collapse Ice" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/commonNotice/list?menuId=annNotIce">- 공지사항</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
				</div>
					<!-- 교수 강의 -->
				<div id="profLecture" class="tab-pane lec">
					<li class="nav-item">
					<a class="nav-link collapsed Pro" href="#" data-toggle="collapse"
							data-target="#profLIP" aria-expanded="true" aria-controls="profLIP"> 
							<span class="mainCategory">강의</span>
						</a>
						<div id="profLIP" class="collapse Gre" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/profLecture/list?menuId=lecProGre">- 강의시간표</a> 
								<a class="collapse-item" href="/profLecture/stuList?menuId=lecProGre">- 수강학생 조회</a>
								<a class="collapse-item" href="/profLecture/lecList?menuId=lecProGre">- 강의 조회</a>
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<!-- 교수 성적 및 출결 -->
					<li class="nav-item">
					<a class="nav-link collapsed Ach" href="#" data-toggle="collapse"
							data-target="#profAAAM" aria-expanded="true" aria-controls="profAAAM"> 
							<span class="mainCategory">성적 및 출결 관리</span>
						</a>
						<div id="profAAAM" class="collapse Att" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/profLecture/attendance?menuId=lecAchAtt">- 학생 출결</a> 
								<a class="collapse-item" href="/profLecture/achievement?menuId=lecAchAtt">- 학생 성적 입력</a>
								<a class="collapse-item" href="/profLecture/achExeption?menuId=lecAchAtt">- 성적 이의 신청 관리</a>
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<li class="nav-item">
					<a class="nav-link collapsed Las" href="#" data-toggle="collapse"
							data-target="#profLS" aria-expanded="true" aria-controls="profLS"> 
							<span class="mainCategory">강의등록</span>
						</a>
						<div id="profLS" class="collapse Sem" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/profLecture/lectureCreate?menuId=lecLasSem">- 강의등록</a> 
								<a class="collapse-item" href="/profLecture/achList?menuId=lecLasSem">- 강의계획서</a>  
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<li class="nav-item">
					<a class="nav-link collapsed Eva" href="#" data-toggle="collapse"
							data-target="#profCE" aria-expanded="true" aria-controls="profCE"> 
							<span class="mainCategory">강의평가</span>
						</a>
						<div id="profCE" class="collapse Lua" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/profLecture/evaluation?menuId=lecEvaLua">- 강의평가</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
				</div>
				<!-- 교수 학생 start -->
				<div id="profSIC" class="tab-pane pro">
					<li class="nav-item">
					<a class="nav-link collapsed Cha" href="#" data-toggle="collapse"
							data-target="#profSICmanagement" aria-expanded="true" aria-controls="profSICmanagement"> 
							<span class="mainCategory">담당 학생 관리</span>
						</a>
						<div id="profSICmanagement" class="collapse Man" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/student/stuList?menuId=proChaMan">- 담당 학생 정보 조회</a> 
								<a class="collapse-item" href="/student/requestList?menuId=proEvaLua">- 상담 신청 조회</a>
								<a class="collapse-item" href="/student/requestDetail?menuId=proEvaLua">- 상담 내역</a>
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<!-- 교수 학과 학생 조회 -->
					<li class="nav-item">
					<a class="nav-link collapsed Eva" href="#" data-toggle="collapse"
							data-target="#profDSC" aria-expanded="true" aria-controls="profDSC"> 
							<span class="mainCategory">학과 학생 조회</span>
						</a>
						<div id="profDSC" class="collapse Lua" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/student/stuTotalList?menuId=proEvaLua">- 학과 학생 조회</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<!-- 교수 휴학 학생 조회 -->
					<li class="nav-item">
					<a class="nav-link collapsed App" href="#" data-toggle="collapse"
							data-target="#profAC" aria-expanded="true" aria-controls="profAC"> 
							<span class="mainCategory">신청서 확인</span>
						</a>
						<div id="profAC" class="collapse Lic" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/student/requestList?menuId=proAppLic">- 신청서 확인</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<li class="nav-item">
					<a class="nav-link collapsed Emp" href="#" data-toggle="collapse"
							data-target="#profES" aria-expanded="true" aria-controls="profES"> 
							<span class="mainCategory">취업지원</span>
						</a>
						<div id="profES" class="collapse Sup" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/employment/recruitment?menuId=proEmpSup">- 채용정보</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
				</div>
				</sec:authorize>
				<!-- 교수 end -->
				<!-- 관리자 tab start -->
				<sec:authorize access="hasRole('ROLE_ADMIN')">
				<div id="managerNomal" class="tab-pane man">
					<!-- 관리자 일반  -->
					<li class="nav-item">
					<a class="nav-link collapsed Not" href="#" data-toggle="collapse"
							data-target="#managerNotice" aria-expanded="true" aria-controls="managerNotice"> 
							<span class="mainCategory">공지사항</span>
						</a>
						<div id="managerNotice" class="collapse Ice" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/commonNotice/list?menuId=manNotIce">- 공지사항</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<!-- 관리자 일정관리 -->
					<li class="nav-item">
					<a class="nav-link collapsed Dul" href="#" data-toggle="collapse"
							data-target="#managerSM" aria-expanded="true" aria-controls="managerSM"> 
							<span class="mainCategory">일정관리</span>
						</a>
						<div id="managerSM" class="collapse Lis" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/manager/schduleList?menuId=manDulLis">- 일정 조회</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<!-- 관리자 문의사항 -->
					<li class="nav-item">
					<a class="nav-link collapsed Inq" href="#" data-toggle="collapse"
							data-target="#managerInquiry" aria-expanded="true" aria-controls="managerInquiry"> 
							<span class="mainCategory">문의사항</span>
						</a>
						<div id="managerInquiry" class="collapse Uir" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/notice/listAdmin?menuId=manInqUir">- 문의사항</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<!-- 관리자 채용정보 -->
					<li class="nav-item">
					<a class="nav-link collapsed Rec" href="#" data-toggle="collapse"
							data-target="#managerJobOpenings" aria-expanded="true" aria-controls="managerJobOpenings"> 
							<span class="mainCategory">채용정보</span>
						</a>
						<div id="managerJobOpenings" class="collapse Rui" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/employment/recruitment?menuId=manRecRui">- 채용정보</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<!-- 관리자 등록금 고지 -->
					<li class="nav-item">
					<a class="nav-link collapsed Tui" href="#" data-toggle="collapse"
							data-target="#managerTuitionNotice" aria-expanded="true" aria-controls="managerTuitionNotice"> 
							<span class="mainCategory">등록금 고지</span>
						</a>
						<div id="managerTuitionNotice" class="collapse Not" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/tution/tutionNotice?menuId=manTuiNot">- 등록금 고지</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
				</div><!-- 교직원 일반 tab end -->

				<!-- 교직원 교수/교직원tab start -->
				<div id="managerProfEmp" class="tab-pane pst">
					<li class="nav-item">
						<a class="nav-link collapsed Pro" href="#" data-toggle="collapse"
						   data-target="#managerProfInfoCk" aria-expanded="true" aria-controls="managerProfInfoCk"> 
							<span class="mainCategory">교수 정보 조회</span>
						</a>
						<div id="managerProfInfoCk" class="collapse Chk" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/manager/profList?menuId=pstProChk">- 교수 정보 조회</a> 
								<a class="collapse-item" href="/manager/profAdd?menuId=pstProChk">- 교수 정보 추가</a> 
							</div>
						</div>
					</li>
					
					<hr class="sidebar-divider">
					<!-- 관리자 교수/교직원 교직원 관리 -->
					<li class="nav-item">
					<a class="nav-link collapsed Emp" href="#" data-toggle="collapse"
							data-target="#managerEmpM" aria-expanded="true" aria-controls="managerEmpM"> 
							<span class="mainCategory">교직원 관리</span>
						</a>
						<div id="managerEmpM" class="collapse Man" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/manager/schEmployeeList?menuId=pstEmpMan">- 교직원 조회</a> 
								<a class="collapse-item" href="/manager/schEmployeeAdd?menuId=pstEmpMan">- 교직원 추가</a> 
								<a class="collapse-item" href="/manager/schEmployeeStat?menuId=pstEmpMan">- 교직원 통계</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
				</div><!-- 교직원 교수/교직원 tab end -->

				<!-- 관리자 학생 tab start -->
				<div id="managerStub" class="tab-pane stu">
					<li class="nav-item">
						<a class="nav-link collapsed Tui" href="#" data-toggle="collapse"
						   data-target="#manageTuiPayState" aria-expanded="true" aria-controls="manageTuiPayState"> 
							<span class="mainCategory">등록금 납부 현황</span>
						</a>
						<div id="manageTuiPayState" class="collapse Pay" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/tution/manConfirmation?menuId=stuTuiPay">- 납부 내역 조회</a> 
							</div>
						</div>
					</li>
					
					<hr class="sidebar-divider">
					<!-- 관리자 학생 -->
					<li class="nav-item">
					<a class="nav-link collapsed Emp" href="#" data-toggle="collapse"
							data-target="#managerStudentInfo" aria-expanded="true" aria-controls="managerStudentInfo"> 
							<span class="mainCategory">학생 정보 조회</span>
						</a>
						<div id="managerStudentInfo" class="collapse Lis" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/manager/stuList?menuId=stuEmpLis">- 학생 목록 조회</a> 
								<a class="collapse-item" href="/manager/stuAdd?menuId=stuEmpLis">- 신입생 추가</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					
				</div>
				<!-- 관리자 학생 tab end -->
				<!-- 관리자 통계  tab start -->
				<div id="managerStatistics" class="tab-pane rat">
					<!-- 관리자 통계 취업 -->
					<li class="nav-item">
						<a class="nav-link collapsed Emp" href="#" data-toggle="collapse"
							data-target="#manageEntrance" aria-expanded="true" aria-controls="manageEntrance"> 
							<span class="mainCategory">취업</span>
						</a>
						<div id="manageEntrance" class="collapse Man" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/manager/empRate?menuId=ratEmpMan">- 학과 별 취업률</a> 
							</div>
						</div>
					</li>
					
					<hr class="sidebar-divider">
					<!-- 관리자 통계 입학 -->
					<li class="nav-item">
					<a class="nav-link collapsed Man" href="#" data-toggle="collapse"
							data-target="#managerEntrance" aria-expanded="true" aria-controls="managerEntrance"> 
							<span class="mainCategory">입학</span>
						</a>
						<div id="managerEntrance" class="collapse Adm" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/manager/admRate?menuId=ratManAdm">- 학과 별 입학률</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<!-- 관리자 통계 학과 -->
					<li class="nav-item">
					<a class="nav-link collapsed Dep" href="#" data-toggle="collapse"
							data-target="#managerDepartment" aria-expanded="true" aria-controls="managerDepartment"> 
							<span class="mainCategory">학과</span>
						</a>
						<div id="managerDepartment" class="collapse Art" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/manager/sexRatio?menuId=ratDepArt">- 학과 별 남녀 성비</a> 
								<a class="collapse-item" href="/manager/stuStat?menuId=ratDepArt">- 학과 별 학생 상태</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
					<!-- 관리자 통계 학과 -->
					<li class="nav-item">
					<a class="nav-link collapsed Pro" href="#" data-toggle="collapse"
							data-target="#managerDMC" aria-expanded="true" aria-controls="managerDMC"> 
							<span class="mainCategory">학과별 유지비</span>
						</a>
						<div id="managerDMC" class="collapse Nun" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/manager/profSalary?menuId=ratProNun">- 교수 연봉</a> 
								<a class="collapse-item" href="/manager/supportCost?menuId=ratProNun">- 항목별 유지 비용</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">
				</div>
				<!-- 관리자 통계  tab end -->
				<!-- 관리자 인재타임 tab start -->
				<div id="managerInjaeTime" class="tab-pane jae">
					<li class="nav-item">
						<a class="nav-link collapsed Lec" href="#" data-toggle="collapse"
						   data-target="#managerTimeDeal" aria-expanded="true" aria-controls="managerTimeDeal"> 
							<span class="mainCategory">강의거래</span>
						</a>
						<div id="managerTimeDeal" class="collapse Dea" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/timePost/exchaBoardAdmin ?menuId=jaeLecDea">- 강의거래</a> 
							</div>
						</div>
					</li>
					
					<hr class="sidebar-divider">
					<li class="nav-item">
						<a class="nav-link collapsed Boa" href="#" data-toggle="collapse"
						   data-target="#managerLRB" aria-expanded="true" aria-controls="managerLRB"> 
							<span class="mainCategory">강의 추천 게시판</span>
						</a>
						<div id="managerLRB" class="collapse Ard" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/timePost/lecutreBoast?menuId=jaeBoaArd">- 강의자랑게시글</a> 
							</div>
						</div>
					</li>
					
					<hr class="sidebar-divider">

					<li class="nav-item">
						<a class="nav-link collapsed Fre" href="#" data-toggle="collapse"
						   data-target="#managerFreeBoard" aria-expanded="true" aria-controls="managerFreeBoard"> 
							<span class="mainCategory">자유게시판</span>
						</a>
						<div id="managerFreeBoard" class="collapse BoA" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/timePost/freeBoard?menuId=jaeFreBoA">- 자유게시판</a> 
							</div>
						</div>
					</li>
					
					<hr class="sidebar-divider">

					<li class="nav-item">
						<a class="nav-link collapsed Rep" href="#" data-toggle="collapse"
						   data-target="#managerDeclarationBoard" aria-expanded="true" aria-controls="managerDeclarationBoard"> 
							<span class="mainCategory">신고 내역 조회</span>
						</a>
						<div id="managerDeclarationBoard" class="collapse Det" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
							<div class="bg-white py-2 collapse-inner rounded">
								<a class="collapse-item" href="/timePost/reportDetails?menuId=jaeRepDet">- 신고 내역 조회</a> 
							</div>
						</div>
					</li>
					<hr class="sidebar-divider">

				</div>
				<!-- 관리자 인재타임 tab end -->
				</sec:authorize>
			</div><!-- tab content end -->
</ul>