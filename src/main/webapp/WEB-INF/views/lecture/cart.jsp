<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
* {
  font-family: 'NanumSquareNeo'; 
}
.row {
  text-align: center;
}
h3{
    margin-bottom: 50px;
    margin-top: 60px;
    color: black;
} 
h4 {
  margin-bottom: 12px;		
  margin-top: 40px;
  margin-left: 20px;
} 
h6 {
  margin-bottom: 10px;
  margin-left: 20px;
} 
.table {
  margin: auto;
}
.trBackground {
  background-color: #ebf1e9;
  position: sticky;
  top: -1px;
  z-index: 1;
}
.card {
  display: flex;
  align-items: center;
}
.card-body {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
label {
  margin-bottom: 0px;
}
.rhkahrtn {
  display:flex;
  margin-top: 30px;
  margin-bottom: 10px;
  margin-left: 0px;
}
.search-table {
  overflow-y: scroll;
  width: 100%;
  height: 350px;
  display: block;
}
.hearderH5 {
 	float: left;
 	margin-top: 40px;
 	margin-bottom: 30px;
	display: inline-block;
	margin-right: 1020px;
	margin-left: 173px;
}
.rkddmlrjfoBut {
	width: 165px;
    margin-top: 34px;
}
.tbe {
	height: 80vh;
	width: 100%;
	table-layout: fixed;
	text-align: center;
	margin-bottom: 30px;
	background-color: white;
	border-color: #d2d8d0;
}
.heardTr {
	background-color: #ebf1e9;
	height: 41px;
}
.h5Button {
	display: inline-block;
}
.timeTableShow td {
	height: 70px;
}
</style>
<script>
let locationHref = window.location.href;
let lecNo = '';
$(function(){
	
	// 강의목록 출력 함수 호출
	lecList();
	
	// 장바구니 출력 함수 호출
	cartList();
	
	// 시간표 테이블 호출
	timeTable()
	
	let gubun = $('select[name="gubun"]');
	let type= $('select[name="type"]');
	let lecName = $('#lecName');
	let profName = $('#profName');
	let lecScore = $('#lecScore');
	let dept = $('select[name="dept"]');
	
	console.log("locationHref >> ", locationHref);

	$('.search').on('click', function(){
		let gubunTemp = gubun.val() != null ? gubun.val() : "";
		let typeTemp = type.val() != null ? type.val() : "";
		let lecNameTemp = lecName.val() != null ? lecName.val() : "";
		let profNameTemp = profName.val() != null ? profName.val() : "";
		let lecScoreTemp = lecScore.val() != null ? lecScore.val() : "";
		let deptTemp = dept.val() != null ? dept.val() : "";
		
		
		if(isNaN(lecScoreTemp)){
			Swal.fire({
				  icon: "error",
				  text: "학점에 숫자만 입력해주세요",
				  timer:'1500'
				});
			return;
		}
		
		let data = {
			'lecDiv':gubunTemp,
			'lecType':typeTemp,
			'lecName':lecNameTemp,
			'userName':profNameTemp,
			'lecScore':lecScoreTemp,
			'comDetCode':deptTemp
		}
		
		console.log(data);
		
		$.ajax({
			url:"/lecture/searchLecAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
// 				console.log(result.lectureSearchList)
				
				let str = "";
				
				if(result.lectureSearchList.length == 0) {
					str += `<tr>`;
					str += `<td colspan="11" style="text-align:center; font-size:30px; color:#8C9090;">검색 결과가 없습니다.</td>`;
					str += `</tr>`;
				}
				
				$.each(result.lectureSearchList, function(idx, lecture){
					console.log("lecture >>> ",lecture)
					console.log("lecture.userInfoVO >>> ", lecture.userInfoVO)
					str += `
							<tr onclick="fSyllabus()">
							<td onclick='event.stopPropagation()'>\${idx+1}</td>
							<td onclick="event.stopPropagation()">`;

					// result.cartList에 해당 lecture가 있는지 확인
				    let inCart = false;
				    for (let i = 0; i < result.cartList.length; i++) {
				        if (result.cartList[i].lecNo === lecture.lecNo) {
				            inCart = true;
				            break;
				        }
				    }
				    
				 	// 조건에 따라 다른 버튼 추가
				    if (inCart) {
				        str += `<button type="button" class="btn btn-outline-danger btn-xs col-12 cart-in" disabled>담김</button>`;
				    } else {
				        str += `<button type="button" class="btn btn-outline-primary btn-xs col-12 cart-in" value="\${lecture.lecNo}"
				        onclick="cartIn(this)">담기</button>`;
				    }
							    
					str += `</td>
							<td>\${lecture.lecDiv}</td>
							<td>\${lecture.lecType}</td>
							<td>\${lecture.lecGrade}</td>
							<td>\${lecture.lecScore}</td>
							<td>\${lecture.comDetCodeVO.comDetCodeName}</td>
							<td>\${lecture.userInfoVO.userName}</td>
							<td>\${lecture.lecPer}</td>
							<td class="text-left">\${lecture.lecName}</td>
							<td>\${lecture.lecDay}</td>
							<td>\${lecture.lectureRoomVO.lecRoName}</td>
							</tr>
						`;
				});
				$("#search-trShow").html(str);
			}
		})
	})
	
	
});
function fSyllabus(){
	console.log('강의계획서 출력')
}

function timeTable(){
	console.log("timeTable 호출")
	console.log($('.timeTableShow').html(`
											<tr>
								            <td>1교시</td>
								            <td class="lectureMon1"></td>
								            <td class="lectureTue1"></td>
								            <td class="lectureWed1"></td>
								            <td class="lectureThu1"></td>
								            <td class="lectureFri1"></td>
								        </tr>
								        <tr>
								            <td>2교시</td>
								            <td class="lectureMon2"></td>
								            <td class="lectureTue2"></td>
								            <td class="lectureWed2"></td>
								            <td class="lectureThu2"></td>
								            <td class="lectureFri2"></td>
								        </tr>
								        <tr>
								            <td>3교시</td>
								            <td class="lectureMon3"></td>
								            <td class="lectureTue3"></td>
								            <td class="lectureWed3"></td>
								            <td class="lectureThu3"></td>
								            <td class="lectureFri3"></td>
								        </tr>
								        <tr>
								            <td>4교시</td>
								            <td class="lectureMon4"></td>
								            <td class="lectureTue4"></td>
								            <td class="lectureWed4"></td>
								            <td class="lectureThu4"></td>
								            <td class="lectureFri4"></td>
								        </tr>
								        <tr>
								            <td>5교시</td>
								            <td class="lectureMon5"></td>
								            <td class="lectureTue5"></td>
								            <td class="lectureWed5"></td>
								            <td class="lectureThu5"></td>
								            <td class="lectureFri5"></td>
								        </tr>
								        <tr>
								            <td>6교시</td>
								            <td class="lectureMon6"></td>
								            <td class="lectureTue6"></td>
								            <td class="lectureWed6"></td>
								            <td class="lectureThu6"></td>
								            <td class="lectureFri6"></td>
								        </tr>
								        <tr>
								            <td>7교시</td>
								            <td class="lectureMon7"></td>
								            <td class="lectureTue7"></td>
								            <td class="lectureWed7"></td>
								            <td class="lectureThu7"></td>
								            <td class="lectureFri7"></td>
								        </tr>
								        <tr>
								            <td>8교시</td>
								            <td class="lectureMon8"></td>
								            <td class="lectureTue8"></td>
								            <td class="lectureWed8"></td>
								            <td class="lectureThu8"></td>
								            <td class="lectureFri8"></td>
								        </tr>
								        <tr>
								            <td>9교시</td>
								            <td class="lectureMon9"></td>
								            <td class="lectureTue9"></td>
								            <td class="lectureWed9"></td>
								            <td class="lectureThu9"></td>
								            <td class="lectureFri9"></td>
								        </tr>`
        ))
	
	//아작나써유..(피)씨다타써...
	$.ajax({
		url: "/lecture/timeTableListAjax", //ajax용 url 변경
		type:"get",
		dataType:"json",
		success:function(result){
			console.log("result.length : ",result.length);
// 			console.log("result : ", result[0].lecTimeVOList.length);
// 			console.log("result[0].lecNo : ", result[0].lecNo);
// 			console.log("result[0].lectureVOList[0].lecName : ", result[0].lectureVOList[0].lecName);
// 			console.log("result[0].lectureVOList[0].lecCol : ", result[0].lectureVOList[0].lecCol);
// 			console.log("result[0].lectureRoomVOList[0].lecRoName : ", result[0].lectureRoomVOList[0].lecRoName);
// 			console.log("result[0].lecTimeVOList.lecSt) : ", result[0].lecTimeVOList.lecDay);
// 			console.log("result[0].lecTimeVOList.lecSt) : ", result[0].lecTimeVOList.lecSt);
// 			console.log("result[0].lecTimeVOList.lecSt) : ", result[0].lecTimeVOList.lecEnd);
			
			for(let i=0; i<result.length; i++) {	
				let lecNo = result[i].lecNo; //강의 번호
				let lecName = result[i].lectureVOList[0].lecName; //강의명
				let lecRoName = result[i].lectureRoomVOList[0].lecRoName; //강의실명
				let lecCol = result[i].lectureVOList[0].lecCol; //색상 코드
				for(let j = 0; j<result[i].lecTimeVOList.length; j++){
				
					let lecDay = result[i].lecTimeVOList[j].lecDay; //강의 요일
					let lecSt = result[i].lecTimeVOList[j].lecSt; //강의 시작 교시
					let lecEnd = result[i].lecTimeVOList[j].lecEnd; //강의 종료 교시
					
					console.log(lecNo,', ',lecName,', ',lecRoName,', ',lecCol,', ',lecDay,', ',lecSt,', ',lecEnd);
					weekCheck(lecNo, lecName, lecRoName, lecCol, lecDay, lecSt, lecEnd);
				}
			}
			
		},
	    error: function (request, status, error) {
	        console.log("code: " + request.status)
	        console.log("message: " + request.responseText)
	        console.log("error: " + error);
	    }
	});
	
	// 요일 확인
	function weekCheck(lecNo, lecName, lecRoName, lecCol, lecDay, lecSt, lecEnd) {
//	 	console.log("lecDay : ", lecDay);
		
		if(lecDay == "월"){
			lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureMon", lecSt, lecEnd);
		} else if(lecDay == "화"){
			lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureTue", lecSt, lecEnd);
		} else if(lecDay == "수"){
			lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureWed", lecSt, lecEnd);
		} else if(lecDay == "목"){
			lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureThu", lecSt, lecEnd);
		} else if(lecDay == "금"){
			lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureFri", lecSt, lecEnd);
		}
	}

	// 교시 확인 & 값 넣기
	function lecCheck(lecNo, lecName, lecRoName, lecCol, classTemp, lecSt, lecEnd) {
//	 	console.log("교시 확인! : ", classTemp, lecSt, lecEnd);

		
		
		for(let i=lecSt; i<=lecEnd; i++) {
			let classNum = classTemp + i;
			document.getElementsByClassName(classNum)[0].style.backgroundColor = lecCol;
			let str = "";
			str += lecName + "<br>";
			str += lecRoName;
			
			document.getElementsByClassName(classNum)[0].style.color = "white"; // 회의해보기
			document.getElementsByClassName(classNum)[0].innerHTML = str;
		}
	}
}

function lecList(){
	console.log("강의목록")
	
	$.ajax({
			url:"/lecture/listAjax",
			contentType:"application/json;charset=utf-8",
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
// 				console.log("result.cartList",result.cartList)
				
				let str = "";
				
				
				$.each(result.lectureList, function(idx, lecture){
// 					console.log("lecture >>> ",lecture)
// 					console.log("lecture.userInfoVO >>> ", lecture.userInfoVO)
					str += `
							<tr onclick="fSyllabus()">
							<td onclick='event.stopPropagation()'>\${idx+1}</td>
							<td onclick="event.stopPropagation()">`;

					// result.cartList에 해당 lecture가 있는지 확인
				    let inCart = false;
				    for (let i = 0; i < result.cartList.length; i++) {
				        if (result.cartList[i].lecNo === lecture.lecNo) {
				            inCart = true;
				            break;
				        }
				    }
				    
				 	// 조건에 따라 다른 버튼 추가
				    if (inCart) {
				        str += `<button type="button" class="btn btn-outline-danger btn-xs col-12 cart-in" disabled>담김</button>`;
				    } else {
				        str += `<button type="button" class="btn btn-outline-primary btn-xs col-12 cart-in" value="\${lecture.lecNo}"
				        onclick="cartIn(this)">담기</button>`;
				    }
							    
					str += `</td>
							<td>\${lecture.lecDiv}</td>
							<td>\${lecture.lecType}</td>
							<td>\${lecture.lecGrade}</td>
							<td>\${lecture.lecScore}</td>
							<td>\${lecture.comDetCodeVO.comDetCodeName}</td>
							<td>\${lecture.userInfoVO.userName}</td>
							<td>\${lecture.lecPer}</td>
							<td class="text-left">\${lecture.lecName}</td>
							<td>\${lecture.lecDay}</td>
							<td>\${lecture.lectureRoomVO.lecRoName}</td>
							</tr>
						`;
				});
				$("#search-trShow").html(str);
			}
		})
	
}

function cartList(){
	console.log('내 강의목록 출력')
	let mySumGrade = $('.rhkahrtn');
	
	$.ajax({
		url:"/lecture/cartList",
		contentType:"application/json;charset=utf-8",
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
// 			console.log(result.cartList)
			mySumGrade.text(`과목 수 : \${result.
				countLec}건, 총 학점 : \${result.sumLecScore}`);
			
			let str = '';
			
			if(result.cartList.length == 0) {
				str += `<tr>`;
				str += `<td colspan="7" style="text-align:center;">장바구니가 비어있습니다.</td>`;
				str += `</tr>`;
			}
			
			
			$.each(result.cartList, function(idx, cartVO){
				$.each(cartVO.lectureVOList, function(index, lectureVO){
					$.each(cartVO.userInfoVOList, function(index, userInfoVO){
						$.each(cartVO.lectureRoomVOList, function(index, lectureRoomVO){
								str += `<tr class="myCart">`;
								str += `<td>`;
								str += `\${idx+1}`;
								str += `<input name="cartLecNo" class="cartLecNo" type="hidden" value="\${lectureVO.lecNo}">`;
								str += `</td>`;
								str += `<td>\${lectureVO.lecDiv}</td>`;
								str += `<td>\${lectureVO.lecGrade}</td>`;
								str += `<td>\${lectureVO.lecScore}</td>`;
								str += `<td>\${userInfoVO.userName}</td>`;
								str += `<td>\${lectureVO.lecPer}</td>`;
								str += `<td  class="text-left">`;
								str += `\${lectureVO.lecName} / `;
								str += `\${cartVO.stuLecDay} / `;
								str += `\${lectureRoomVO.lecRoName}`;
								str += `</td>`;
								str += `<td>`;
								str += `<button type="button" class="btn btn-outline-danger btn-xs col-12 cart-in" value="\${lectureVO.lecNo}"`;
								str += `onclick="cartOut(this)">취소</button>`;
								str += `</td>`;
								str += `</tr>`;
						})
					})
				})
			})
			$('#card-trShow').html(str);
		}
	})
}
function cartIn(e){
	lecNo = e.value;
	let btn = $('.cartIn')
	
	let data = {
		lecNo
	}
	
	$.ajax ({
		url:"/lecture/insertCart",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
// 			console.log(result)
			if(result > 0){
// 				Swal.fire({
// 					  title: "장바구니에 담겼습니다.",
// 					  icon: "success",
// 					  timer: 1500
// 					});
				cartList();
				lecList();
				timeTable();
			}
		}
	})
}
function cartOut(e){
	lecNo = e.value;
	console.log(lecNo)
	
	let data = {
		lecNo
	}
	
	$.ajax ({
		url:"/lecture/deleteCart",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log(result)
			if(result > 0){
// 				Swal.fire({
// 					  title: "장바구니에 담겼습니다.",
// 					  icon: "success",
// 					  timer: 1500
// 					});
				cartList();
				lecList();
				timeTable();
			}
		}
	})
}
//요일 확인
function weekCheck(lecNo, lecName, lecRoName, lecCol, lecDay, lecSt, lecEnd) {
// 	console.log("lecDay : ", lecDay);
	
	if(lecDay == "월"){
		lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureMon", lecSt, lecEnd);
	} else if(lecDay == "화"){
		lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureTue", lecSt, lecEnd);
	} else if(lecDay == "수"){
		lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureWed", lecSt, lecEnd);
	} else if(lecDay == "목"){
		lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureThu", lecSt, lecEnd);
	} else if(lecDay == "금"){
		lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureFri", lecSt, lecEnd);
	}
}

// 교시 확인 & 값 넣기
function lecCheck(lecNo, lecName, lecRoName, lecCol, classTemp, lecSt, lecEnd) {
// 	console.log("교시 확인! : ", classTemp, lecSt, lecEnd);
	
	for(let i=lecSt; i<=lecEnd; i++) {
		let classNum = classTemp + i;
		document.getElementsByClassName(classNum)[0].style.backgroundColor = lecCol;
		let str = "";
		str += lecName + "<br>";
		str += lecRoName;
		
		document.getElementsByClassName(classNum)[0].style.color = "white";
		document.getElementsByClassName(classNum)[0].innerHTML = str;
	}
}
</script>
<h3>관심 과목 등록</h3>
<h5>수강 학점 현황</h5>
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap">
                    <thead>
                        <tr class="trBackground">
                            <th colspan='3'>전공 영역</th>
                            <th colspan='3'>교양 영역</th>
                            <th rowspan='2'>총 취득 학점</th>
                        </tr>
                        <tr class="trBackground">
                            <th>전필</th>
                            <th>전선</th>
                            <th>소계</th>
                            <th>교필</th>
                            <th>교선</th>
                            <th>소계</th>
                        </tr>
                    </thead>
                    <tbody id="trShow" class="text-center">
                        <tr>
                            <td>${hakjum.junpil}</td>
                            <td>${hakjum.junsun}</td>
                            <td>${hakjum.junpil+hakjum.junsun}</td>
                            <td>${hakjum.gyopil}</td>
                            <td>${hakjum.gyosun}</td>
                            <td>${hakjum.gyopil+hakjum.gyosun}</td>
                            <td>${hakjum.junpil+hakjum.junsun+hakjum.gyopil+hakjum.gyosun}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
	<h4>강의 검색</h4>
    <div class="col-12">
        <div class="card">
			<form action="" id="form">
				<div class="card-body">
					<select class="form-control col-1" name="gubun" id="gubun" style="margin-right: 50px;">
						<option value="" selected>이수 구분</option>                    
						<option value="1">전필</option>                
						<option value="2">전선</option>                
						<option value="3">교필</option>                
						<option value="4">교선</option>                
					</select>
					<select class="form-control col-1" name="type" id="type" style="margin-right: 50px;">
						<option value="" selected>강의 영역</option>                    
						<option value="1">자연</option>                
						<option value="2">인문</option>                
						<option value="3">음악</option>                
						<option value="4">컴퓨터</option>                
						<option value="5">경영</option>                
					</select>
					<select class="form-control col-1 deptSelect" name="dept" id="dept" style="margin-right: 50px;">
						<option value="" selected>학과 선택</option>
                            <c:forEach var="comCodeVO" items="${deptList}" varStatus="stat">
                                <c:forEach var="dept" items="${comCodeVO.comDetCodeVOList}" varStatus="stat">
                                    <option value="${dept.comDetCode}">${dept.comDetCodeName}</option>
                                </c:forEach>	
                            </c:forEach>              
					</select>
                    <label for="profName">교수명 :&nbsp;</label>
                    <input type="text" class="form-control col-1" id="profName" name="profName" style="margin-right: 50px;">
                    <label for="lecScore">학점 :&nbsp;</label>
                    <input type="text" class="form-control col-1" id="lecScore" name="lecScore" style="margin-right: 50px;">
					<label for="lecName">강의명 :&nbsp;</label>
					<input type="text" class="form-control col-2" id="lecName" name="lecName" style="margin-right: 50px;">
					<button type="button" class="btn btn-outline-primary col-1 search">조&nbsp;&nbsp;&nbsp;회</button>
				</div>
			</form>
        </div>
    </div>
    <div class="text-left">
	    <h4>검색 결과</h4>
		<h6 style="margin-top:5px;">&lt;클릭하면 강의계획서를 열람하실 수 있습니다.&gt;</h6>
	</div>
    <div class="col-12">
		<div class="card">
            <div class="card-body table-responsive p-0 search-table">
                <table class="table table-hover text-nowrap lectureList">
                    <thead>
                        <tr class="trBackground">
                            <th>번호</th>
							<th>담기</th>
							<th>이수구분</th>
							<th>강의영역</th>
							<th>학년</th>
							<th>학점</th>
							<th>개설학과</th>
							<th>교수</th>
							<th>최대인원</th>
							<th>강의명</th>
							<th>강의시간</th>
							<th>강의실</th>
                        </tr>
                    </thead>
                    <tbody id="search-trShow" class="text-center scroll">
						<!-- 강의 리스트 출력 영역 -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
  	<h5 class="col-12 rhkahrtn"></h5>
  	<div class="col-12" style="display:flex;">
	    <div class="col-6" style="margin-bottom:50px;">
			<div class="card">
	            <div class="card-body table-responsive p-0">
	                <table class="table table-hover text-nowrap">
	                    <thead>
	                        <tr class="trBackground">
	                            <th>번호</th>
								<th>이수구분</th>
								<th>학년</th>
								<th>학점</th>
								<th>교수</th>
								<th>최대인원</th>
								<th>과목명/강의시간/강의실</th>
								<th>취소</th>
	                        </tr>
	                    </thead>
	                    <tbody id="card-trShow" class="text-center">
	                    	<!-- myCartList 함수 출력 위치 -->
	                    </tbody>
	                </table>
	            </div>
	        </div>
	    </div>
		<div class="col-6 timeTable">
		    <table border="1" class="tbe">
		        <thead>
		            <tr class="heardTr" style="height: 5.5vh;">
		                <th>교시</th>
		                <th>월</th>
		                <th>화</th>
		                <th>수</th>
		                <th>목</th>
		                <th>금</th>
		            </tr>
		        </thead>
		        <tbody class="timeTableShow">
		            <tr>
		                <td>1교시</td>
		                <td class="lectureMon1"></td>
		                <td class="lectureTue1"></td>
		                <td class="lectureWed1"></td>
		                <td class="lectureThu1"></td>
		                <td class="lectureFri1"></td>
		            </tr>
		            <tr>
		                <td>2교시</td>
		                <td class="lectureMon2"></td>
		                <td class="lectureTue2"></td>
		                <td class="lectureWed2"></td>
		                <td class="lectureThu2"></td>
		                <td class="lectureFri2"></td>
		            </tr>
		            <tr>
		                <td>3교시</td>
		                <td class="lectureMon3"></td>
		                <td class="lectureTue3"></td>
		                <td class="lectureWed3"></td>
		                <td class="lectureThu3"></td>
		                <td class="lectureFri3"></td>
		            </tr>
		            <tr>
		                <td>4교시</td>
		                <td class="lectureMon4"></td>
		                <td class="lectureTue4"></td>
		                <td class="lectureWed4"></td>
		                <td class="lectureThu4"></td>
		                <td class="lectureFri4"></td>
		            </tr>
		            <tr>
		                <td>5교시</td>
		                <td class="lectureMon5"></td>
		                <td class="lectureTue5"></td>
		                <td class="lectureWed5"></td>
		                <td class="lectureThu5"></td>
		                <td class="lectureFri5"></td>
		            </tr>
		            <tr>
		                <td>6교시</td>
		                <td class="lectureMon6"></td>
		                <td class="lectureTue6"></td>
		                <td class="lectureWed6"></td>
		                <td class="lectureThu6"></td>
		                <td class="lectureFri6"></td>
		            </tr>
		            <tr>
		                <td>7교시</td>
		                <td class="lectureMon7"></td>
		                <td class="lectureTue7"></td>
		                <td class="lectureWed7"></td>
		                <td class="lectureThu7"></td>
		                <td class="lectureFri7"></td>
		            </tr>
		            <tr>
		                <td>8교시</td>
		                <td class="lectureMon8"></td>
		                <td class="lectureTue8"></td>
		                <td class="lectureWed8"></td>
		                <td class="lectureThu8"></td>
		                <td class="lectureFri8"></td>
		            </tr>
		            <tr>
		                <td>9교시</td>
		                <td class="lectureMon9"></td>
		                <td class="lectureTue9"></td>
		                <td class="lectureWed9"></td>
		                <td class="lectureThu9"></td>
		                <td class="lectureFri9"></td>
		            </tr>
		        </tbody>
		    </table>
	    </div>
    </div>
</div>
