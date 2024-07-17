<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
h3 {
    margin-bottom: 30px;
    margin-top: 40px;
    color:black;
}
</style>
<%-- <p>${studentVOList}</p> --%>
<h3>담당 학생 정보 조회</h3>
	<div class="card card-solid">
		<div class="card-body pb-0"
			style="overflow: auto; width: auto; height: auto;">
			<div class="brd-search">
				<select title="검색 조건 선택" id="searchCnd" name="searchCnd" class="form-control rjatorwhrjs"
					style="width: 130px; height: 33px; float: left; margin: 24px 5px 0px 0px;">
					    <option selected disabled>정렬조건</option>
					    <option value="userName">이름순</option>
					    <option value="stGrade">학년순</option>
				</select>
			</div>
		</div>
			
		<div class="card-body pb-0"
			style="overflow: auto; width: auto; height: auto;">
			<div class="row searchResult">
				<c:forEach var="studentVO" items="${studentVOList}" varStatus="stat">
					<div
						class="col-12 col-sm-6 col-md-4 d-flex align-items-stretch flex-column">
						<div class="card bg-light d-flex flex-fill"
							onclick="location.href='/student/stdDetail?menuId=proChaMan&stNo=${studentVO.stNo}'">
							<div class="card-header text-muted border-bottom-0">
								<br>
							</div>
							<div class="card-body pt-0">
								<div class="row">
									<div class="col-7 ">
										<h2 class="lead" align="center"
											style="font-weight: bold; font-size: x-large;">
											<b>${studentVO.userInfoVO.userName}</b>
										</h2>
										<p class="text-muted text-sm">
											<b>학과 : ${studentVO.comDetCodeVO.comDetCodeName}</b>
										</p>
										<p class="text-muted text-sm">
											<b>학년 : ${studentVO.stGrade}학년</b>
										</p>
										<p class="text-muted text-sm">
											<b>학번 : ${studentVO.stNo}</b>
										</p>
										<p class="text-muted text-sm">
											<b>연락처 : ${studentVO.userInfoVO.userTel}</b>
										</p>
										<p class="text-muted text-sm">
											<b>이메일 : ${studentVO.stEmail}</b>
										</p>
									</div>
									<div class="col-5 text-center">
										<!-- 사진 불러오기, 적용 안함 -->
									<%-- 	<img src="../../../resources/images/${studentVO.stuAttachFileVO.stuName}.${studentVO.stuAttachFileVO.stuAttType}" --%>
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
					</div>
			</c:forEach>
				</div>
		</div>
	</div>
<script type="text/javascript">
$(document).ready(function() {
    $("#searchCnd").change(function() {
        let searchCnd = $('select[name=searchCnd]').val()
        console.log(searchCnd)
		
        let data = {
        	searchCnd
        };
        
        $.ajax({
        	url:"/student/listAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log("result : ", result);
// 				updateStudentList(result);
				
				let str = ""
					$.each(result, function(idx, studentVO){
					    str += "<div class='col-12 col-sm-6 col-md-4 d-flex align-items-stretch flex-column'>";
					    str += "<div class='card bg-light d-flex flex-fill' onclick=\"location.href='/student/stdDetail?menuId=proChaMan&stNo=" + studentVO.stNo + "'\">";
						str += "<div class='card-header text-muted border-bottom-0'>";
					    str += "<br>";
					    str += "</div>";
					    str += "<div class='card-body pt-0'>";
					    str += "<div class='row'>";
					    str += "<div class='col-7'>";
					    str += "<h2 class='lead' align='center' style='font-weight: bold; font-size: x-large;'>";
					    str += "<b>"+studentVO.userInfoVO.userName+"</b>";
					    str += "</h2>";
					    str += "<p class='text-muted text-sm'>";
					    str += "<b>학과 : "+studentVO.comDetCodeVO.comDetCodeName+"</b>";
					    str += "</p>";
					    str += "<p class='text-muted text-sm'>";
					    str += "<b>학년 : "+studentVO.stGrade+"학년</b>";
					    str += "</p>";
					    str += "<p class='text-muted text-sm'>";
					    str += "<b>학번 : "+studentVO.stNo+"</b>";
					    str += "</p>";
					    str += "<p class='text-muted text-sm'>";
					    str += "<b>연락처 : "+studentVO.userInfoVO.userTel+"</b>";
					    str += "</p>";
					    str += "<p class='text-muted text-sm'>";
					    str += "<b>이메일 : "+studentVO.stEmail+"</b>";
					    str += "</p>";
					    str += "</div>";
					    str += "<div class='col-5 text-center'>";
					    str += "<img src='" + studentVO.stuAttachFileVO.stuFilePath + "' alt='user-avatar' class='img-square img-fluid userImage'>";
					    str += "</div>";
					    str += "</div>";
					    str += "</div>";
					    str += "<div class='card-footer'>";
					    str += "<div class='text-center' style='font-weight: bold'>";
						str += "<p style='margin: 0px 0px 0px 0px;'>";
					    str += "   대덕인재대학교 <img src='../../../resources/images/emblem2.png' alt='user-avatar' class='img-circle img-fluid' width='40' height='40'>";
					    str += "</p>";
					    str += "</div>";
					    str += "</div>";
					    str += "</div>";
					    str += "</div>";
					});
				
				    $('.searchResult').html(str)
			}
        });
        
    });

});
        
</script>
