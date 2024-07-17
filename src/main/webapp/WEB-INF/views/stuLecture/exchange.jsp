<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의거래 전송</title>
<style>
.hearderH3 {
	color: black;
	margin-top: 65px;
	margin-left: 200px;
}
.hearderH5 {
	margin-top: 15px;
	margin-left: 200px;
}
.mainbd {
	padding-top: 42px;
	margin: auto;
	width: 80%;
}
.hearderH5Detail{
	margin-top: 60px;
	margin-left: 10px;
	color: black;
}
.seacherBtn {
	width: 165px;
    margin: auto;
    margin-left: 10px;
}
.rkddmlrjfoBut {
	width: 165px;
    margin: auto;
}
.inLineDiv {
    display: inline;
}
.divTop{
    margin-top: 60px;
}
.userImage{
   width: 260px;
   height: 230px;
}
.flex-fill {
    width: 500px;
}
.flex-column {
   margin-top: 30px;
   margin-bottom: 30px;
}
.backgroundCol{
    background-color: white;
}
.card-footer {
    width: 500px;
    border: 1px solid #e3e6f0;
}
.divCenter {
    display: flex;
    justify-content: center;
}
.rkddmlwjsthdDiv {
    display: flex;
    justify-content: center;
	margin-bottom: 35px;
}
.textCenter {
    text-align:center;
}
</style>
<script type="text/javascript">
$(function () {
	$("input[name='stuLecNo']").click(function(e){
		$("#search-trShow-temp").empty();
		
		let tr = this.closest("tr");
		let trClone = tr.cloneNode(true);
		trClone.children[0].remove();
		
		$("#search-trShow-temp").append(trClone);
	});
	
});

function stNoFind() {
	let stNoFind = $("#stNoFind").val();
	console.log("stNoFind >> ", stNoFind);
	
	if(stNoFind == "") {
		Swal.fire("학번을 입력해주세요.");
		return;
	}

	let data = {
		"stNoFind":stNoFind
	}
	
	$.ajax({
		url:"/stuLecture/stNoFindAjax",
		contentType:"application/json;charset=utf-8",
		data:data,
		type:"post",
		beforeSend:function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success:function(result) {
			document.getElementsByName("searchStNo")[0].style.display = 'block'; 

        	console.log("data : ", result);
			if(result == null) {
				Swal.fire("받는 사람을 입력해주세요.");
				return;
			}

        	let userName = `\${result.userInfoVO.userName}`; // 이름
        	let comDetCodeName = `\${result.comDetCodeVO.comDetCodeName}`; //학과
        	let stGrade = `\${result.stGrade}`;
        	let userNo = `\${result.userInfoVO.userNo}`;
        	let userTel = `\${result.userInfoVO.userTel}`;
        	let stEmail = `\${result.stEmail}`;
        	let stuFilePath = `\${result.stuAttachFileVO.stuFilePath}`;
        	
			console.log("stGrade >> ", stGrade);
			console.log("stEmail >> ", stEmail);
			console.log("stuFilePath >> ", stuFilePath);

        	$("#userName").text(userName);
        	$("#comDetCodeName").text(comDetCodeName);
        	$("#stGrade").text(stGrade);
        	$("#userNo").text(userNo);
        	$("#userTel").text(userTel);
        	$("#stEmail").text(stEmail);
        	document.getElementById("stuFilePath").src = stuFilePath;
			
        },
	    error: function (request, status, error) {
	        console.log("code: " + request.status)
	        console.log("message: " + request.responseText)
	        console.log("error: " + error);
	    }
	});
}

function lectureTransfer() {
	let trLength = $('#search-trShow-temp').children("tr").length;
// 	console.log("trLength >> ", trLength);
	
	if(trLength == 0) {
		Swal.fire({
			title: "강의 전송 실패",
			text: "강의를 선택해주세요.",
			icon: "error"
		});
		return;
	}

	let lecNameLength = document.getElementsByName("lecName").length;
	console.log("length : ", lecNameLength);
	console.log("test : ", document.getElementsByName("lecName"));

	let lecName = document.getElementsByName("lecName")[(lecNameLength-1)].innerText; // 강의 이름
	console.log("lecName : ", lecName);

	Swal.fire({
		title: lecName,
		text: "강의 거래 하시겠습니까?",
		icon: "warning",
		showCancelButton: true,
		confirmButtonColor: "#3085d6",
		cancelButtonColor: "#d33",
		confirmButtonText: "예",
		cancelButtonText: "아니요"
	}).then((result) => {
		if (result.isConfirmed) {
			let stuLecNoLength = document.getElementsByName("stuLecNo").length;
			console.log("length : ", stuLecNoLength);
			
			let stuLecNo = document.getElementsByName("stuLecNo")[(stuLecNoLength-1)].value; // 수강번호
			console.log("stuLecNo : ", stuLecNo);
			
			let stNoFind = $("#stNoFind").val(); // 학번
			console.log("stNoFind >> ", stNoFind);
		
			let data = {
				"stuLecNo":stuLecNo,
				"stNo":stNoFind
			}

		 	$.ajax({
				url:"/stuLecture/lectureTransferAjax",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result) {
					//result 
					//success or failed
					console.log("result : ", result);
					
					if(result == "success"){
						Swal.fire({
							title: "OK",
							text: "거래완료되었습니다!",
							icon: "success"
						}).then((result) => {
							if (result.isConfirmed) {
								location.href="/stuLecture/exchange?menuId=couRegChk";
							}
						});
					}
				},
				error: function (request, status, error) {
					console.log("code: " + request.status)
					console.log("message: " + request.responseText)
					console.log("error: " + error);
				}
			});
		}else{
			return;
		}
	});


}
</script>
</head>
<body>
	<h3 class="hearderH3">강의거래 전송</h3>
	<h5 class="hearderH5">거래할 강의를 선택하시오.</h5>
	<div class="mainbd">
	    <div class="col-12">
	        <div class="card">
	            <div class="card-body table-responsive p-0 search-table">
	                <table class="table table-hover text-nowrap lectureList">
	                    <thead>
	                        <tr class="trBackground">
	                            <th></th>
	                            <th class="textCenter">이수구분</th>
	                            <th class="textCenter">강의영역</th>
	                            <th class="textCenter">학점</th>
	                            <th class="textCenter">개설학과</th>
	                            <th class="textCenter">교수</th>
	                            <th class="textCenter">최대인원</th>
	                            <th class="textCenter">강의명</th>
	                            <th class="textCenter">강의시간</th>
	                            <th class="textCenter">강의실</th>
	                        </tr>
	                    </thead>
	                    <tbody id="search-trShow" class="text-center scroll">
                            <c:forEach var="lectureVO" items="${myLectureDetail}" varStatus="stat">
                                <tr name="lectureVO">
									<td>
										<input type="radio" name="stuLecNo" id="${lectureVO.stuLecNo}">
                                    </td>
									<input type="hidden" name="stuLecNo" value="${lectureVO.stuLecNo}">
									<td class="textCenter" name="stuLecDiv">${lectureVO.stuLecDiv}</td>
									<td class="textCenter" name="lecType">${lectureVO.lectureVOList.lecType}</td>
									<td class="textCenter" name="lecScore">${lectureVO.lectureVOList.lecScore}</td>
									<td class="textCenter" name="comDetCodeName">${lectureVO.lectureVOList.comDetCodeVO.comDetCodeName}</td>
									<td class="textCenter" name="userName">${lectureVO.lectureVOList.userInfoVO.userName}</td>
									<td class="textCenter" name="lecPer">${lectureVO.lectureVOList.lecPer}</td>
									<td class="textCenter" name="lecName">${lectureVO.lectureVOList.lecName}</td>
									<td class="textCenter" name="stuLecDay">${lectureVO.stuLecDay}</td>
									<td class="textCenter" name="lecRoName">${lectureVO.lectureVOList.lectureRoomVO.lecRoName}</td>
                                </tr>
	                        </c:forEach>
	                    </tbody>
	                </table>
	            </div>
	        </div>
	    </div>
	    
		<h5 class="hearderH5Detail">전송할 거래</h5>
	    <div class="col-12">
	        <div class="card">
	            <div class="card-body table-responsive p-0 search-table">
	                <table class="table table-hover text-nowrap lectureList">
	                    <thead>
	                        <tr class="trBackground">
	                            <th class="textCenter">이수구분</th>
	                            <th class="textCenter">강의영역</th>
	                            <th class="textCenter">학점</th>
	                            <th class="textCenter">개설학과</th>
	                            <th class="textCenter">교수</th>
	                            <th class="textCenter">최대인원</th>
	                            <th class="textCenter">강의명</th>
	                            <th class="textCenter">강의시간</th>
	                            <th class="textCenter">강의실</th>
	                        </tr>
	                    </thead>
	                    <tbody id="search-trShow-temp" class="text-center scroll">
	                    </tbody>
	                </table>
	            </div>
	        </div>
	    </div>
		
        <div class="divTop">
            <h5 class="hearderH5Detail inLineDiv">받는 사람 : </h5>
            <input class="inLineDiv" type="text" id="stNoFind" value="" placeholder="학번"> 
            <button type="button" class="btn btn-block btn-outline-success seacherBtn inLineDiv" onClick="javascript:stNoFind()">조회</button>
        </div>
        <!-- <div> -->
        <div name="searchStNo" style="display:none;">
            <div class="card-body pb-0 divCenter" style="overflow: auto; width: auto; height: auto;">
                <div class="row searchResult">
	                <div class="col-12 col-sm-6 col-md-4 d-flex align-items-stretch flex-column">
	                    <div class="card bg-light d-flex flex-fill">
	                        <div class="card-header text-muted border-bottom-0 backgroundCol">
	                            <br>
	                        </div>
	                        <div class="card-body pt-0 backgroundCol">
	                            <div class="row">
	                                <div class="col-7 ">
	                                    <h2 class="lead" align="center" style="font-weight: bold; font-size: x-large;">
	                                        <b id="userName"></b>
	                                    </h2>
	                                    <p class="text-muted text-sm">
											학과 : <b id="comDetCodeName"></b>
	                                    </p>
	                                    <p class="text-muted text-sm">
											학년 : <b id="stGrade"></b>학년
	                                    </p>
	                                    <p class="text-muted text-sm">
											학번 : <b id="userNo"></b>
	                                    </p>
	                                    <p class="text-muted text-sm">
											연락처 : <b id="userTel"></b>
	                                    </p>
	                                    <p class="text-muted text-sm">
											이메일 : <b id="stEmail"></b>
	                                    </p>
	                                </div>
	                                <div class="col-5 text-center">
	                                    <!-- 사진 불러오기 -->
	                                    <img id="stuFilePath" src="" alt="user-avatar" class="img-square img-fluid userImage">
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="card-footer backgroundCol">
	                        <div class="text-center" style="font-weight: bold">
	                            <p style="margin: 0px 0px 0px 0px;">
	                               	 대덕인재대학교 
	                                <img src="../../../resources/images/emblem2.png" alt="user-avatar" class="img-circle img-fluid" width="40" height="40">
	                            </p>
	                        </div>
	                    </div>
	                </div>
                </div> 
            </div>
            <div class="rkddmlwjsthdDiv">
                <button class="btn btn-block btn-outline-success rkddmlrjfoBut inLineDiv" onclick="lectureTransfer()">강의거래 전송</button>
            </div>
        </div>
	</div>
</body>
</html>