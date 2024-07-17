<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">


h3 {
	color: black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 165px;
} 

td {
	padding: 0px;
}

.table {
	padding: 0px;
	margin: 0;
}

.btnbtn {
	text-align: center;
}

.btncli {
	width: 105px;
	display: inline-block;
	margin-right: 10px;
}

.btn-block+.btn-block {
	margin-top: 0;
}

.mainbd {
	padding-top: 40px;
	margin: auto;
	width: 80%;
}

.mainbdol {
	border-radius: .25em;
}

.mailbox-read-time {
	margin: 10px 0px 0px 0px;
	
}

h4 {
	margin-bottom: 20px;
}

.cardFooterDiv {
	border-top: 0px solid #e3e6f0;
	background-color: transparent;
}

.clearfix {
	margin-top: 16px;
}

.attname {
	font-size: 13px;
}

input:focus {outline: none;}



</style>
<script type="text/javascript">
let comNotName = "${commonNoticeVO.comNotName}";
let comAttFile = "${commonNoticeVO.comAttFile}";
let comNotCon = "${commonNoticeVO.comNotCon}";

$(function(){
	$('#list').on('click', function(){
		location.href = "/commonNotice/list?menuId=annNotIce";	
	});
	
// 	$('#update').on('click', function(){
// 		$("#p1").css("display", "none");
// 		$("#p2").css("display", "block");
// 		//readonly 속성을 제거하는건데 readonly를 안씀
// 		$("#formdata").removeAttr("readonly");
// 		//action속성의 값이 /commonNotice/updatePost
// 		$("#frm").attr("action","/commonNotice/updatePost");
// 	});
	
	$('#update').on('click', function(){
		location.href = "/commonNotice/update?menuId=annNotIce&comNotNo="+"${commonNoticeVO.getComNotNo()}";
	});
	
// 	$("#delete").on('click', function(){
// 		//action속성의 값이 /commonNotice/deletePost
// 		$("#frm").attr("action", "/commonNotice/deletePost");
		
// 		let result = confirm("삭제하시겠습니까?");
// 		if(result > 0){
// 			$("#frm").submit();
// 		}else{
// 			alert("삭제가 취소되었습니다.");
// 		}
// 	});

// 	$("#delete").on('click', function(){
// 		//action속성의 값이 /commonNotice/deletePost
// 		$("#frm").attr("action", "/commonNotice/deletePost");
		
// 		let result = confirm("삭제하시겠습니까?");
// 		if(result > 0){
// 			$("#frm").submit();
// 		}else{
// 			alert("삭제가 취소되었습니다.");
// 		}
// 	});
	
	$("#delete").on("click", function(){
		$("#frm").attr("action", "/commonNotice/deletePost");
		$("#frm").attr("method", "post");
		$("#frm").submit();
	})
	
	$('#cancel').on('click', function(){
		$("#p1").css("display", "block");
		$("#p2").css("display", "none");
		//readonly 속성을 추가하는건데 readonly 속성이 없음
		//$("#formdata").attr("readonly", true);
		//입력란 초기화
		
		$('#comNotName').val(comNotName);
		$('#comAttFile').val(comAttFile);
		$('#comNotCon').val(comNotCon);
// 		document.getElementsByName("tdtitle")[0].innerHTML = ;
		
		console.log(
				"comNotName : " + comNotName
				+ ", comAttFile : " + comAttFile
				+ ", comNotCon : " + comNotCon
		)
	});
		
	});
	
</script>
</head>

<body>
	<div>
		<h3 class="card-title">공지사항</h3>

		<form id="frm" name="frm" action="/commonNotice/updatePost" method="post">

			<div class="mainbd">
				<div class="card card-primary card-outline mainbdol">
					<div class="card-header"
						style="background-color: #fff; margin-top: 12px;">
						 <table>
							 <tr>
						 		<td><input type="text" style="border: none; background: transparent; width: 1000px;" 
						 		name="comNotName" value="${commonNoticeVO.comNotName}" readonly></td>
							</tr>
						</table>
						<div class="card-body p-0">
							<div class="mailbox-read-time attname" id="formdata">
							<table class="table">
							<tr>
								<td>작성일 &nbsp; ${commonNoticeVO.comFirstDate} &nbsp;|&nbsp; 수정일 &nbsp; ${commonNoticeVO.comEndDate} &nbsp;|&nbsp; 작성자 &nbsp; ${commonNoticeVO.userInfoVOList.userName} &nbsp;|&nbsp; 조회수 &nbsp; ${commonNoticeVO.comNotViews} &nbsp;|&nbsp; 구분 &nbsp; ${commonNoticeVO.comGubun}</td>
							</tr>
							</table>
							</div>
						</div>
					</div>



					<div class="card-header bg-white">
						<div class="mailbox-attachment-info">
<%-- 						<p> ${fileList} </p> --%>
							<span>첨부파일</span>
								<div class="form-group">
									<input type="hidden" id="COM_ATT_M_ID" name="comAttMId" value=""> 
									<c:forEach var="file" items="${fileList}">
										<a href="/upload/prof/${file.comAttachDetVOList.phyFileName}" download="${file.comAttachDetVOList.phyFileName}">
										<i class="fas fa-paperclip"></i>${file.comAttachDetVOList.logiFileName}</a><br>
									</c:forEach>
								</div>
						</div>
					</div>


					 <div class="mailbox-read-message" style="min-height: 460px; margin: 18px 28px 18px 28px;">
						<p>${commonNoticeVO.comNotCon}</p>
               		 </div>


				</div>




				<div class="card-footer cardFooterDiv">
					<div class="btnbtn">
						<!-- <div class="float-right"> -->
						<p id="p1">
							<button type="button"
								class="btn btn-block btn-outline-warning btncli" id="update">수정</button>
							<button type="button"
								class="btn btn-block btn-outline-secondary btncli" id="list">목록</button>
							<button type="button"
								class="btn btn-block btn-outline-danger btncli" id="delete">삭제</button>
						</p>
<!-- 						<p id="p2" style="display: none;"> -->
<!-- 							<button type="submit" -->
<!-- 								class="btn btn-block btn-outline-primary btncli" id="confirm">저장</button> -->
<!-- 							<button type="button" -->
<!-- 								class="btn btn-block btn-outline-secondary btncli" id="cancel">취소</button> -->
<!-- 						</p> -->
						<!-- </div> -->
					</div>
				</div>


			</div>
			 <sec:csrfInput />
		</form>
	</div>

</body>
</html>
