<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
.flex-column {
	margin-top: 30px;
	margin-bottom: 30px;
}

.form-control {
	display: inline-block;
}

.flex-fill {
	cursor: pointer;
}
.rjatorwhrjs{
	font-size: 1.0rem;
}
.userImage{
	width: 260px;
	height: 320px;
}
/* .row {
  text-align: center;
} */

.table {
  margin: auto;
}

h3 {
   color: black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 165px;
} 
#trShow{
  display:flex;
  flex-direction: row;
  flex-wrap: wrap;
}
.department{
	font-size: 25px;
	margin-left: 696px;
	
}
.card {
   width: 80%;  /*목록 넓이*/
}
</style>
<script>
let csrfHeader = "${_csrf.headerName}";
let csrfToken = "${_csrf.token}"; 

	$(function(){
		   console.log("locationHref >> ", location.href);

			$("#dept").change(function(){
			      let searchCnd = $('select[name=dept]').val();
			      console.log(searchCnd);

			      let data = {
			         searchCnd
			      };
			      
			      $.ajax({
			         url: "/manager/listAjaxs",
			         contentType: "application/json;charset=utf-8",
			         data: JSON.stringify(data),
			         type: "post",
			         dataType: "json",
			         beforeSend: function(xhr) {
			            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			         },
			         success: function(result) {
			            console.log("result : ", result);
			            
			            let str = "";
			            $.each(result, function(idx, professorVO) {
			            	str += "<div class='col-12 col-sm-6 col-md-4 d-flex align-items-stretch flex-column'>";
		                    str += "<div class='card bg-light d-flex flex-fill'  onclick=\"location.href='/manager/profDetail?menuId=pstProChk&proNo=" +professorVO.proNo + "'\">";
		                    str += "<div class='card-header text-muted border-bottom-0'>";
		                    str += "<br>";
		                    str += "</div>";
		                    str += "<div class='card-body pt-0' style='background-color:  #F0F1F2;'>";
		                    str += "<div class='row'>";
		                    str += "<div class='col-7'>";
		                    str += "<h2 class='lead' align='center' style='font-weight: bold; font-size: x-large;'>";
		                    str += "<b>" + professorVO.userInfoVO.userName + "</b>";
		                    str += "</h2>";
		                    str += "<br>";
		                    str += "<p class='text-muted text-sm'>";
		                    str += "<b>학과 : " + professorVO.comDetCodeVO.comDetCodeName + "</b>";
		                    str += "</p>";
		                    str += "<p class='text-muted text-sm'>";
		                    str += "<b>연구실 : " + professorVO.proStudy + "</b>";
		                    str += "</p>";
		                    str += "<p class='text-muted text-sm'>";
		                    str += "<b>연락처 : " + professorVO.userInfoVO.userTel + "</b>";
		                    str += "</p>";
		                    str += "<p class='text-muted text-sm'>";
		                    str += "<b>이메일 : " + professorVO.proEmail + "</b>";
		                    str += "</p>";
		                    str += "</div>";
		                    str += "<div class='col-5 text-center'>";
		                    str += "<img src='"+ professorVO.comAttachDetVO.phySaveRoute + "' alt='user-avatar' class='img-square img-fluid'>";
		                    str += "</div>";
		                    str += "</div>";
		                    str += "</div>";
		                    str += "<div class='card-footer'>";
		                    str += "<div class='text-center' style='font-weight: bold'>";
		                    str += "<p style='margin: 0px 0px 0px 0px;'>";
		                    str += " 대덕인재대학교 <img src='../../../resources/images/emblem2.png' alt='user-avatar' class='img-circle img-fluid' width='40' height='40'>";
		                    str += "</p>";
		                    str += "</div>";
		                    str += "</div>";
		                    str += "</div>";
		                    str += "</div>"; 
			            });
			            
			            $('#trShow').html(str);
			         }
			      });
			   });
		   
		  // $('#dept').on('change', function(){
		  //    dept = $('#dept').val();
		  //    getList("", 1);
		  // });
	});

	function getList(keyword, currentPage) {
	   dept = $('#dept').val();
	   console.log(dept);

	   let deptTemp = "";
	   if(dept != null) {
	      deptTemp = dept;
	   }
	   
	   console.log(deptTemp);
	   
	   // JSON 객체
	   let data = {
	        "keyword": keyword,
	        "currentPage": currentPage,
	        "dept": deptTemp // 구분 추가
	   };
	   
	   console.log("data => : ", data);
	   
	   
	}
	   

</script>
<body>
   <h3>교수 정보 조회</h3>
	<div class="row">
		<div class="col-12">
			<div class="card" style="margin-left: 162px;">
				<div class="card-header" style="background-color: white">
					<div class="card-tools">
						<div class="input-group input-group-sm" style="width: 150px;">
							<select class="form-control" name="dept" id="dept">
								<option selected disabled>학과 선택</option>
								<c:forEach var="comCodeVO" items="${deptList}" varStatus="stat">
									<c:forEach var="dept" items="${comCodeVO.comDetCodeVOList}"
										varStatus="stat">
										<option value="${dept.comDetCode}">${dept.comDetCodeName}</option>
									</c:forEach>
								</c:forEach>
							</select>
						</div>
					</div>
				</div>

				<!-- <div class="card-body pb-0"
			style="overflow: auto; width: auto; height: auto;"> -->
				<div class="table table-hover text-nowrap">
					<div id="trShow">
						<div class="row searchResult">
							<div class="col-12 department">
								<br>
								<br>
								<br>
								<br>
								<br>
								<br>
								<br>
								<br>
								<br>
								<br>
								<p>조회할 학과를 선택해주세요</p>
								<br>
								<br>
								<br>
								<br>
								<br>
								<br>
								<br>
								<br>
								<br>
							</div>
						</div>
						<div class="row">
							<div class="col-4 searchResuelt">
								<!-- 여기에 검색 결과를 동적으로 추가할 수 있습니다 -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row clsPagingArea">${articlePage.pagingArea}</div>
	<!-- csrf 토큰 사용 -->
   <sec:csrfInput/>
   
</body>
