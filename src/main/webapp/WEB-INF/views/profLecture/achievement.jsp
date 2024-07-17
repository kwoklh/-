<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
	.btn-xs {
	    padding: .125rem .25rem;
	    font-size: .75rem;
	    line-height: 1.5;
	    border-radius: .15rem;
	    border-top-left-radius: 0.15rem;
	    border-top-right-radius: 0.15rem;
	    border-bottom-right-radius: 0.15rem;
	    border-bottom-left-radius: 0.15rem;
	}
	.btn-default {
	    background-color: #a9bdad;
	    border-color: #ddd;
	    color: white;
	}
	.lecRo{
		cursor: pointer;
		padding:3px;
	}
	
	.bldNo{
		cursor: pointer;
		transition: transform 0.3s;
	}
	
	.bldNo:hover{
		transform: scale(1.1);
	}
	
	.buildList{
		height: 250px;
		overflow:scroll;
	}
	
	.lecRoList{
		height: 300px;
		overflow:scroll;
	}
	
	.padding12{
		padding: 12px;
	}
	
	.paddingZero{
		padding:0px;
	}
	
	.borderZero{
		border: 0px solid #d1d3e2;
	}
	
	.bordered{
	    border: 1px solid #d1d3e2;
	    border-radius: 5px;
	    margin: 10px;
	}
	
	.flex{
		display: flex;
	}
	
	.flexEnd{
		display: flex;
    	justify-content: flex-end;
	}
	.marginAuto{
		margin: 0px auto;
	}
	.table{
		background-color: white;
		margin: 20px auto;
	}
	#tableWrap{
		margin: 50px auto;
	}
	.btnWrap{
		display: flex;
    	justify-content: center;
   	    margin-bottom: 10px;
	}
	
/* 	#lecRoomModal{ */
/* 		position:absolute; */
/*         /*display:none;*/ */
            
/*         justify-content: center; */
/*         top:0; */
/*         left:0; */

/*         width:100%; */
/*         height:100%; */

/*         background-color: gray; */
/*     } */
    
</style>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script>

$(function(){
	// 모달 
	var myModal = document.getElementById('lecRoomModal')
	var buildSeaInput = document.getElementById('buildSeaWord')
	
	// 모달 켜졌을때 이벤트
	myModal.addEventListener('shown.bs.modal', function () {
		buildSeaInput.focus()
	});
	
	// 모달 - 건물 검색 키워드 입력후 검색 버튼 클릭
	$("#buildSearBtn").on("click",function(){
		console.log("검색 버튼 클릭");
		let buildSeaWord = $("#buildSeaWord").val();
		console.log("검색 키워드 :", buildSeaWord);
		
		$.ajax({
			url:"/profLecture/bulidSearch",
			contentType:"application/json;charset=utf-8",
			data:buildSeaWord,
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
	               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        success:function(result){
	        	let str = "";
	        	console.log("result : ",result);
	        	$.each(result, function(idx, building) {
	        		str += `<p id="\${building.bldNo}" class="bldNo">\${building.bldName}</p>`;
	        	});
	        	
	        	$("#buildList").html(str);
	        }
		});
	});
	
	// 건물 이름 클릭
	$(document).on("click",".bldNo",function(){ 
		let bldNo = $(this).attr("id");
		let lecDaysLan = $(".lecDays").length;
		console.log("lecDaysLan >>> ", lecDaysLan);
		
		let dhList = [];
		$(".lecDays").each(function(idx,data){
			let lecDay = $("#lecDay"+idx+" option:selected").val();
			
			let lecTimeVO = {
			    lecDay:$("#lecDay"+idx+" option:selected").val(),		
		        lecSt: $("#lecSt"+idx+" option:selected").val(),
		        lecEnd : $("#lecEnd"+idx+" option:selected").val()			
			}
			dhList.push(lecTimeVO);
		});
		
 		data = {
 			"bldNo":bldNo,
			"lecTimeVOlist":dhList
 		}

		console.log("체킁:",data);
		
		
		$.ajax({
			url:"/profLecture/buildChoice",
			contentType:"application/json;charset=utf-8",
			data: JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
	               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        success:function(result){
	        	let str = "";
	        	console.log("result : ",result);
	        	$.each(result, function(idx, lecRoom) {
	        		str += `<p><input type="radio" name="lecRo" class="lecRo"`;
	        		str += `id="\${lecRoom.lecRoNo}" value="\${lecRoom.lecRoName}">`;
        			str += `<label  style="padding-left: 5px;" for='\${lecRoom.lecRoNo}'>\${lecRoom.lecRoName} (정원 : \${lecRoom.lecRPer}명)</label></p>`;
        			
	        	});
	        	
	        	$("#lecRoList").html(str);
	        }
		});
		
	});
	
	// 모달창에서 강의실 선택 버튼 
	$("#lecRoChBtn").on("click",function(){
		console.log("체킁");
		
		let lecRoNo = $("input:radio[name='lecRo']:checked").attr("id");
		let lecRoName = $("input:radio[name='lecRo']:checked").val();
		
		console.log("lecRoNo>>>>>>>>>>",lecRoNo);
		console.log("lecRoName>>>>>>>>>>",lecRoName);
		
		$("#buildSeaWord").val("");
		$("#lecRoList").html("");
		$('#lecRoomModal').modal('hide');
		
		$("#lecRoNo").val(lecRoName);
		$("#lecRoNo").text(lecRoNo);
		
	});
	
	//단과대 리스트 선택했을 때 해당하는 학과 호출
	$("#collegeList").on("change",function(){
		collegeCode = $("#collegeList option:selected").val();
		
		/*
		data = {
				"collegeCode":collegeCode
		};
		*/
		
		$.ajax({
			url:"/profLecture/deptList",
			contentType:"application/json;charset=utf-8",
			data:collegeCode,
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
	               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        success:function(result){
	        	let str = `<option value=" ">-학과 선택</option>`;
	        	//console.log("result : ",result);
	        	$.each(result, function(idx, dept) {
	        		str += `<option value="\${dept.comDetCode}">\${dept.comDetCodeName}</option>`;
	        	});
	        	
	        	$("#deptList").html(str);
	        }
		});
	});
	
	// 학과 선택
	$("#deptList").on("change", function(){
		deptCode = $("#deptList option:selected").val();
		$("#deptCode").val(deptCode);
	});
	
	//파일 첨부 선택했을때 해당 영역에 파일 이름 출력
	$('#lecFile').on('change', function (e) {
	    var fileName = document.getElementById("lecFile").files[0].name;
	    var nextSibling = e.target.nextElementSibling;
	    nextSibling.innerText = fileName;
	});
	
	$("#lecTimePlus").on("click",function(){
		console.log("클릭");
		let lecDaysLen = $(".lecDays").length;
		
		if(lecDaysLen >=2){
			alert("요일은 최대 2개까지만 추가 가능합니다.")
			return;
		}
		
		let str = "";
		str += "<tr class='lecDays'>";
		str += "<td>강의요일</td>";
		str += "<td>";
		str += "<select id='lecDay1' name='lecTimeVOList[1].lecDay' class='form-control'>";
		str += "<option value='월'>월</option>";
		str += "<option value='화'>화</option>";
		str += "<option value='수'>수</option>";
		str += "<option value='목'>목</option>";
		str += "<option value='금'>금</option>";
		str += "</select>";
		str += "</td>";
		str += "<td>시작교시</td>";
		str += "<td>";
		str += "<select id='lecSt1' name='lecTimeVOList[1].lecSt' class='form-control'>";
		str += "<option value='1'>1교시(9:00 ~ 9:50)</option>";
		str += "<option value='2'>2교시(10:00 ~ 11:50)</option>";
		str += "<option value='3'>3교시(12:00 ~ 12:50)</option>";
		str += "<option value='4'>4교시(13:00 ~ 13:50)</option>";
		str += "<option value='5'>5교시(14:00 ~ 14:50)</option>";
		str += "<option value='6'>6교시(15:00 ~ 15:50)</option>";
		str += "<option value='7'>7교시(16:00 ~ 16:50)</option>";
		str += "<option value='8'>8교시(17:00 ~ 17:50)</option>";
		str += "<option value='9'>9교시(18:00 ~ 18:50)</option>";
		str += "</select>";
		str += "</td>";
		str += "<td>종료교시</td>";
		str += "<td>";
		str += "<select id='lecEnd1' name='lecTimeVOList[1].lecEnd' class='form-control'>";
		str += "<option value='1'>1교시(9:00 ~ 9:50)</option>";
		str += "<option value='2'>2교시(10:00 ~ 11:50)</option>";
		str += "<option value='3'>3교시(12:00 ~ 12:50)</option>";
		str += "<option value='4'>4교시(13:00 ~ 13:50)</option>";
		str += "<option value='5'>5교시(14:00 ~ 14:50)</option>";
		str += "<option value='6'>6교시(15:00 ~ 15:50)</option>";
		str += "<option value='7'>7교시(16:00 ~ 16:50)</option>";
		str += "<option value='8'>8교시(17:00 ~ 17:50)</option>";
		str += "<option value='9'>9교시(18:00 ~ 18:50)</option>";
		str += "</select>";
		str += "</td>";
		str += "</tr>";			
		$("#lecDays0").after(str);
	});
	
	$("#lecTimeMinus").on("click",function(){
		console.log("클릭");
		let lecDaysLen = $(".lecDays").length;
		
		if(lecDaysLen <= 1){
			alert("요일은 최소 한개 있어야 합니다.")
			return;
		}
		
		$(".lecDays").last().remove();
	});
	
	// 회차 추가 버튼 클릭 
	$("#detailPlusBtn").on("click",function(){
		let lectureDetailLan = $(".lectureDetail").length;

		let str = "";
		str += "<table class='table table-bordered text-center w-75 lectureDetail' style='margin-top:0; margin-bottom:3px;'>";
		str += "<tr>";
		str += "<td colspan='2'>";
		str += "<span>"+(lectureDetailLan+1)+"회차</span>";
		str += "<button type='button' class='close detailMinusBtn' aria-label='Close'>";
		str += "<span aria-hidden='true'>×</span>";
		str += "</button>";
		str += "</td>";
		str += "</tr>";
		str += "<tr>";
		str += "<td>날짜</td>";
		str += "<td><input id='lecDate"+lectureDetailLan+"' name='lecDate' class='form-control borderZero lecDate' type='date'></td>";
		str += "</tr>";
		str += "<tr>";
		str += "<td colspan='2'>주요강의내용</td>";
		str += "</tr>";
		str += "<tr>";
		str += "<td colspan='2'>";
		str += "<textarea  id='lecCon"+lectureDetailLan+"' name='lecCon' class='form-control' rows='10' cols=''></textarea>";
		str += "</td>";
		str += "</tr>";
		str += "</table>";
		
		$("#detailPlusBtn").parent().before(str);
		console.log("str >>>>>>> ",str);
	});
	
	// 회차 삭제 버튼 클릭
	$(document).on("click",".detailMinusBtn",function(){ 
		console.log("클릭");
		let lectureDetailLan = $(".lectureDetail").length;
		
		if(lectureDetailLan <= 1){
			alert("강의 회차는 최소 한 개 있어야 합니다.")
			return;
		}
		
		$(".lectureDetail").last().remove();
	});
	
	// 선택한 날짜가 강의 회차 요일인지 체크
	$(document).on("change",".lecDate",function(){
		let lecDaysLan = $(".lecDays").length;
		console.log("lecDaysLan >>> ", lecDaysLan);
		
		let selDate = $(this).val();
		console.log("selDate >>>>>>>> ",selDate);
		
		let selDay = new Date(selDate).getDay();
		
		if(selDay==1) selDay="월";		
		if(selDay==2) selDay="화";		
		if(selDay==3) selDay="수";		
		if(selDay==4) selDay="목";		
		if(selDay==5) selDay="금";		
		
		console.log("selDay >>>>>>>> ",selDay);
		
		let chk = true;
		let lecDays = [];
		$(".lecDays").each(function(idx,data){
			let lecDay = $("#lecDay"+idx+" option:selected").val(); // 요일 정보 ex) 월, 화
			lecDays.push(lecDay);
		});

		if(!lecDays.includes(selDay)){
			chk = false;
			const Toast = Swal.mixin({
		  		  toast: true,
		  		  position: "top-end",
		  		  showConfirmButton: false,
		  		  timer: 3000,
		  		  timerProgressBar: true,
		  		  didOpen: (toast) => {
		  		    toast.onmouseenter = Swal.stopTimer;
		  		    toast.onmouseleave = Swal.resumeTimer;
		  		  }
		  		});
		  		Toast.fire({
		  		  icon: "warning",
		  		  title: "강의요일과 선택한 일자가 일치하지 않습니다"
		  		});
			$(this).val("");
			return;
		}
	});
	
	//subBtn 클릭 -> 데이터 전송
	$("#subBtn").on("click",function(){
		
		//<form></form>
		let formData = new FormData();
		
		let proNo = $("#proNo").val();						// 교수번호
		let lecDiv = $("#lecDiv option:selected").val();	// 이수구분
		let lecScore = $("#lecScore option:selected").val(); // 학점
		let lecPer = $("#lecPer").val();					 // 수강최대인원
		let deptCode = $("#deptCode").val();				// 학과코드
		let lecName = $("#lecName").val();					// 강의명
		let lecCol = $("#lecCol").val();					// 강의칼라
		let lecType = $("#lecType").val();					// 강의영역
		let lecRoNo = $("#lecRoNo").text();					// 강의실번호
		let lecFile = $("#lecFile")[0].files;				// 강의계획서 첨부
		console.log("lecFile.length : " + lecFile.length);
		
		let nullChk = validateAjax();
		
		if(!nullChk){
			return;
		}
		
		formData.append("proNo",proNo);
		formData.append("lecDiv",lecDiv);
		formData.append("lecScore",lecScore);
		formData.append("lecPer",lecPer);
		formData.append("deptCode",deptCode);
		formData.append("lecName",lecName);
		formData.append("lecCol",lecCol);
		formData.append("lecType",lecType);
		formData.append("lecRoNo",lecRoNo);
		
		for(let i=0; i<lecFile.length;i++){
			formData.append("lecFile",lecFile[i])
		}
		
		$(".lectureDetail").each(function(idx,data){
		    let lecNum = idx+1;		
	        let lecDate = $("#lecDate"+idx).val();
	        let lecCon = $("#lecCon"+idx).val();	
			
	        console.log("lecNum>>>>>>>>>>>",lecNum);
	        console.log("lecDate>>>>>>>>>>>",lecDate);
	        console.log("lecCon>>>>>>>>>>>",lecCon);
			
			formData.append("lectureDetailVOList["+idx+"].lecNum",lecNum);
			formData.append("lectureDetailVOList["+idx+"].lecDate",lecDate);
			formData.append("lectureDetailVOList["+idx+"].lecCon",lecCon);
		});

		$(".lecDays").each(function(idx,data){
		    let lecDay = $("#lecDay"+idx+" option:selected").val();		
	        let lecSt = $("#lecSt"+idx+" option:selected").val();
	        let lecEnd = $("#lecEnd"+idx+" option:selected").val();	
			
// 	        console.log("lecDay>>>>>>>>>>>",lecDay);
// 	        console.log("lecSt>>>>>>>>>>>",lecSt);
// 	        console.log("lecEnd>>>>>>>>>>>",lecEnd);
			
			formData.append("lecTimeVOList["+idx+"].lecDay",lecDay);
			formData.append("lecTimeVOList["+idx+"].lecSt",lecSt);
			formData.append("lecTimeVOList["+idx+"].lecEnd",lecEnd);
		});
		
		$.ajax({
			url:"/profLecture/lecCreate",
			processData:false,
			contentType:false,
			data:formData,
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
	               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
			success:function(result){
				console.log("result : ",result);
				  Swal.fire({
                      position: "center",
                      icon: "success",
                      title: "등록완료 되었습니다.",
                      timer: 1800,
                      showConfirmButton: false // 확인 버튼을 숨깁니다.
                    }).then(() => {
                      // Swal.fire의 타이머가 끝난 후 호출됩니다.
                      location.href = "/profLecture/achList?menuId=lecLasSem";
                    });
			}
		});
	});
});

// 나중에 시간 남으면 개강날짜 - 종강 날짜 사이에 선택한 요일대로 회차 자동 생성 하고싶다고 생각만 하기
// function date(){
// 	let stDate = new Date("2024-09-01");
// 	let endDate = new Date("2024-12-20");
// }

function validateAjax(){
	let proNo = $("#proNo").val();						// 교수번호
	let lecDiv = $("#lecDiv option:selected").val();	// 이수구분
	let lecScore = $("#lecScore option:selected").val(); // 학점
	let lecPer = $("#lecPer").val();					 // 수강최대인원
	let deptCode = $("#deptCode").val();				// 학과코드
	let lecName = $("#lecName").val();					// 강의명
	let lecCol = $("#lecCol").val();					// 강의칼라
	let lecType = $("#lecType").val();					// 강의영역
	let lecRoNo = $("#lecRoNo").text();					// 강의실번호
	let lecFile = $("#lecFile")[0].files;				// 강의계획서 첨부
	console.log("lecFile.length : " + lecFile.length);
	
	// 유효성 검사
    if (!lecPer) {
    	const Toast = Swal.mixin({
    		  toast: true,
    		  position: "top-end",
    		  showConfirmButton: false,
    		  timer: 3000,
    		  timerProgressBar: true,
    		  didOpen: (toast) => {
    		    toast.onmouseenter = Swal.stopTimer;
    		    toast.onmouseleave = Swal.resumeTimer;
    		  }
    		});
    		Toast.fire({
    		  icon: "warning",
    		  title: "수강최대인원을 입력해주세요."
    		});
    	$("#lecPer").focus();
        return false;
    }
    if (!deptCode) {
    	const Toast = Swal.mixin({
  		  toast: true,
  		  position: "top-end",
  		  showConfirmButton: false,
  		  timer: 3000,
  		  timerProgressBar: true,
  		  didOpen: (toast) => {
  		    toast.onmouseenter = Swal.stopTimer;
  		    toast.onmouseleave = Swal.resumeTimer;
  		  }
  		});
  		Toast.fire({
  		  icon: "warning",
  		  title: "학과코드를 입력해주세요."
  		});
        return false;
    }
    if (!lecName) {
    	const Toast = Swal.mixin({
    		  toast: true,
    		  position: "top-end",
    		  showConfirmButton: false,
    		  timer: 3000,
    		  timerProgressBar: true,
    		  didOpen: (toast) => {
    		    toast.onmouseenter = Swal.stopTimer;
    		    toast.onmouseleave = Swal.resumeTimer;
    		  }
    		});
    		Toast.fire({
    		  icon: "warning",
    		  title: "강의명을 입력해주세요."
    		});
   		$("#lecName").focus();
        return false;
    }

    if (!lecType) {
    	const Toast = Swal.mixin({
  		  toast: true,
  		  position: "top-end",
  		  showConfirmButton: false,
  		  timer: 3000,
  		  timerProgressBar: true,
  		  didOpen: (toast) => {
  		    toast.onmouseenter = Swal.stopTimer;
  		    toast.onmouseleave = Swal.resumeTimer;
  		  }
  		});
  		Toast.fire({
  		  icon: "warning",
  		  title: "강의영역을 입력해주세요."
  		});
 		$("#lecType").focus();
      	return false;
    }
   
    if (!lecRoNo) {
    	const Toast = Swal.mixin({
    		  toast: true,
    		  position: "top-end",
    		  showConfirmButton: false,
    		  timer: 3000,
    		  timerProgressBar: true,
    		  didOpen: (toast) => {
    		    toast.onmouseenter = Swal.stopTimer;
    		    toast.onmouseleave = Swal.resumeTimer;
    		  }
    		});
    		Toast.fire({
    		  icon: "warning",
    		  title: "강의실번호를 입력해주세요."
    		});
        return false;
    }
    if (lecFile.length === 0) {
    	const Toast = Swal.mixin({
  		  toast: true,
  		  position: "top-end",
  		  showConfirmButton: false,
  		  timer: 3000,
  		  timerProgressBar: true,
  		  didOpen: (toast) => {
  		    toast.onmouseenter = Swal.stopTimer;
  		    toast.onmouseleave = Swal.resumeTimer;
  		  }
  		});
  		Toast.fire({
  		  icon: "warning",
  		  title: "강의계획서를 첨부해주세요."
  		});
        return false;
    }
 	// 모든 필드가 유효한 경우 true 반환
    return true;
}

</script>
<sec:authentication property="principal.userInfoVO" var="userInfoVO" />

	<!-- 모달 시작 -->
	<div class="modal fade" id="lecRoomModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">강의실 검색</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body flex">
	      	<div class="col-lg-5 paddingZero">
		        <div class="flex bordered"> 
			        <input type="text" id="buildSeaWord" name="buildSeaWord" class="form-control float-right borderZero" placeholder="건물명 검색">
					<div class="input-group-append">
						<button id="buildSearBtn" class="btn btn-default">
							<i class="fas fa-search"></i>
						</button>
					</div>
		        </div>
		        <div id="buildList" class="modalList bordered padding12 buildList">
		        	<c:forEach var="building" items="${bulidList}" varStatus="stat">
						<p id="${building.bldNo}" class="bldNo">${building.bldName}</p>
					</c:forEach>
		        </div>
		     </div>
		     <div class="col-lg-7 paddingZero">
		     	<div id="lecRoList" class="modalList bordered padding12 lecRoList">
		        	<p>강의실 목록</p>
		        </div>
		     </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	        <button type="button" id="lecRoChBtn" class="btn btn-primary">선택완료</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달 끝 -->
	
	
	
<h3 class="w-75 marginAuto">강의 등록</h3>
<div id="tableWrap">
	<div class="marginAuto w-75">
		<div style="padding:10px;">
				<i class="fas fa-check bg-green" 
				   style="
						color: #fff !important;
						background-color: #28a745 !important;
					    background-color: #adb5bd;
					    border-radius: 50%;
					    font-size: 16px;
					    height: 30px;
					    line-height: 30px;
					    text-align: center;
					    top: 0;
					    width: 30px;
					  	"
				></i>
				<b>빈 칸 없이 작성시 바로 강의가 등록됩니다</b>
			</div>
	</div>
	<form enctype="multipart/form-data">
		<table class="table table-bordered text-center w-75">
			<tr>
				<td>교수번호</td>
				<td colspan="2"><input name="proNo" type="text" class="form-control" id="proNo" value="${userInfoVO.userNo}" readonly></td>
				<td>교수명</td>
				<td colspan="2"><input name="proName" type="text" class="form-control" id="proName" value="${userInfoVO.userName}" readonly></td>
			</tr>
			<tr>
				<td>이수구분</td>
				<td>
					<select id="lecDiv" name="lecDiv" class="form-control">
						<option value="전필">전공필수</option>
						<option value="전선">전공선택</option>
						<option value="교필">교양필수</option>
						<option value="교선">교양선택</option>
					</select>
				</td>
				<td>학점</td>
				<td>
					<select id="lecScore" class="form-control" name="lecScore">
						<option value='1'>1학점</option>
						<option value='2'>2학점</option>
						<option value='3'>3학점</option>
					</select>
				</td>
				<td>수강최대인원</td>
				<td><input type="number" id="lecPer" class="form-control" name="lecPer" placeholder="" required="required"></td>
			</tr>
			<tr>
				<td>학과코드</td>
				<td><input type="text" class="form-control" id="deptCode" name="deptCode" placeholder="학과 선택 후 자동입력" readonly required="required"></td>
				<td colspan="2">
					<select id="collegeList" class="form-control">
						<option>-단과대학 선택</option>
						<c:forEach var="college" items="${collegeList}" varStatus="stat">
							<option value="${college.comCode}">${college.comCodeName}</option>
						</c:forEach>
					</select>
				</td>
				<td colspan="2">
					<select id="deptList" class="form-control">
						<option>-학과 선택</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>강의명</td>
				<td colspan="3"><input type="text" id="lecName" class="form-control" name="lecName" placeholder="" required="required"></td>
				<td>강의영역</td>
				<td><input type="text" class="form-control" id="lecType" name="lecType" placeholder="" required="required"></td>
			</tr>
		</table>
		
		<p class="w-75 marginAuto">* 강의 요일은 최소 1개 최대 2개까지 선택 가능합니다.</p>
		<table id="lecDayC" class="table table-bordered text-center w-75 marginTopZero" style="margin-top:0; margin-bottom: 0;">
			<tr id="lecDays0" class="lecDays" >
				<td>강의요일</td>
				<td>
					<select id="lecDay0" name="lecTimeVOList[0].lecDay" class="form-control">
						<option value="월">월</option>
						<option value="화">화</option>
						<option value="수">수</option>
						<option value="목">목</option>
						<option value="금">금</option>
					</select>
				</td>
				<td>시작교시</td>
				<td>
					<select id="lecSt0" name="lecTimeVOList[0].lecSt" class="form-control">
						<option value="1">1교시(9:00 ~ 9:50)</option>
						<option value="2">2교시(10:00 ~ 11:50)</option>
						<option value="3">3교시(12:00 ~ 12:50)</option>
						<option value="4">4교시(13:00 ~ 13:50)</option>
						<option value="5">5교시(14:00 ~ 14:50)</option>
						<option value="6">6교시(15:00 ~ 15:50)</option>
						<option value="7">7교시(16:00 ~ 16:50)</option>
						<option value="8">8교시(17:00 ~ 17:50)</option>
						<option value="9">9교시(18:00 ~ 18:50)</option>
					</select>
				</td>
				<td>종료교시</td>
				<td>
					<select id="lecEnd0" name="lecTimeVOList[0].lecEnd" class="form-control">
						<option value="1">1교시(9:00 ~ 9:50)</option>
						<option value="2">2교시(10:00 ~ 11:50)</option>
						<option value="3">3교시(12:00 ~ 12:50)</option>
						<option value="4">4교시(13:00 ~ 13:50)</option>
						<option value="5">5교시(14:00 ~ 14:50)</option>
						<option value="6">6교시(15:00 ~ 15:50)</option>
						<option value="7">7교시(16:00 ~ 16:50)</option>
						<option value="8">8교시(17:00 ~ 17:50)</option>
						<option value="9">9교시(18:00 ~ 18:50)</option>
					</select>
				</td>
			</tr>
		</table>
		<div class="w-75 marginAuto flexEnd">
			<button type="button" id="lecTimePlus" class="btn btn-outline-success col-md-1" style="margin:3px;">추가</button>
			<button type="button" id="lecTimeMinus" class="btn btn-outline-secondary col-md-1"  style="margin:3px;">삭제</button>
		</div>
		<p class="w-75 marginAuto">* 선택한 시간에 이용 가능한 강의실만 출력합니다.</p>
		<table class="table table-bordered text-center w-75" style="margin-top:0;">
			<tr>
				<td>강의실</td>
				<td>
					<div class="input-group input-group-sm">
						<input type="text" name="table_search" class="form-control float-right" placeholder="강의실 검색" readonly>
						<div class="input-group-append">
							<button type="button" class="btn btn-default" data-toggle="modal" data-target="#lecRoomModal">
								<i class="fas fa-search"></i>
							</button>
						</div>
					</div>
				</td>
				<td>강의실 번호</td>
				<td><input type="text" class="form-control" id="lecRoNo" name="lecRoNo" placeholder="" readonly required="required"></td>
				<td>시간표색상</td>
				<td><input type="color" class="form-control" name="lecCol" value="#e66465" id="lecCol"></td>
			</tr>
			<tr>
				<td>강의 계획서</td>
				<td colspan="5">
					<div class="form-group">
				        <div class="custom-file">
				            <input type="file" class="custom-file-input" id="lecFile" name="lecFile" required="required">
				            <label class="custom-file-label" for="customFile">파일 선택</label>
				        </div>
				    </div>
				</td>
			</tr>
		</table>
		<p class="w-75 marginAuto">* 개요 및 목표(모든 회차 내용을 작성해주세요)</p>
		<table class="table table-bordered text-center w-75 lectureDetail" style="margin-top:0; margin-bottom:3px;">
			<tr>
				<td colspan="2">
					<span>1회차</span>
					<button type="button" class="close detailMinusBtn" aria-label="Close">
			          <span aria-hidden="true">×</span>
			        </button>
				</td>
			</tr>
			<tr>
				<td>날짜</td>
				<td><input id="lecDate0" name="lecDate" class="form-control borderZero lecDate" type="date"></td>
			</tr>
			<tr>
				<td colspan="2">주요강의내용</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea id="lecCon0" name="lecCon" class="form-control" rows="10" cols=""></textarea>
				</td>
			</tr>
		</table>
		<div class="w-75 marginAuto btnWrap">
			<button type="button" id="detailPlusBtn" class="btn btn-block btn-default btn-xs"
				style=""><b>+</b>
			</button>
		</div>
	</form>
	<div class="w-75 marginAuto btnWrap">
		<button type="button" id="subBtn" class="btn btn-success col-md-1">등록</button>
	</div>
</div>
