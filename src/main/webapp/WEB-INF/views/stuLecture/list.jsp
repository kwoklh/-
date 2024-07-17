<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js'></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<head>
<meta charset="UTF-8">
<title>수강조회</title>
<style>
h5 {
    margin-bottom: 30px;
    margin-top: 40px;
} 
.hearderH5 {
 	float: left;
 	margin-top: 40px;
 	margin-bottom: 30px;
	display: inline-block;
	margin-right: 1195px;
	margin-left: 173px;
}
.rkddmlrjfoBut {
	width: 165px;
    margin-top: 34px;
}
.tbe {
	height: 80vh;
	width: 80%;
	table-layout: fixed;
	text-align: center;
 	margin: 50px 170px 10px 170px;
	background-color: white;
	border-color: #d2d8d0;
}
.heardTr {
	height: 41px;
}
.h5Button {
	display: inline-block;
}
</style>
<script>
$(function(){
	
	//아작나써유..(피)씨다타써...
	$.ajax({
		url: "/stuLecture/listAjax", //ajax용 url 변경
// 		contentType:"application/json;charset=utf-8",
// 		data:"",
		type:"get",
		dataType:"json",
		success:function(result){
// 			console.log("result.length : ",result.length);
// 			console.log("result : ", result);
// 			console.log("result[0].lecNo : ", result[0].lecNo);
// 			console.log("result[0].lectureVOList.lecCol : ", result[0].lectureVOList.lecCol);
// 			console.log("result[0].lectureVOList.lectureDetailVOList[0].lectureRoomVO.lecRoName : ", result[0].lectureVOList.lectureDetailVOList[0].lectureRoomVO.lecRoName);
			
			for(let i=0; i<result.length; i++) {
				let lecNo = result[i].lecNo; //강의 번호
				let lecName = result[i].lectureVOList.lecName; //강의명
				let lecRoName = result[i].lectureVOList.lectureRoomVO.lecRoName; //강의실명
				let lecCol = result[i].lectureVOList.lecCol; //색상 코드
				let lecDay = result[i].lectureVOList.lecTimeVO.lecDay; //강의 요일
				let lecSt = result[i].lectureVOList.lecTimeVO.lecSt; //강의 시작 교시
				let lecEnd = result[i].lectureVOList.lecTimeVO.lecEnd; //강의 종료 교시
				
				weekCheck(lecNo, lecName, lecRoName, lecCol, lecDay, lecSt, lecEnd);
			}
			
		},
	    error: function (request, status, error) {
	        console.log("code: " + request.status)
	        console.log("message: " + request.responseText)
	        console.log("error: " + error);
	    }
	});
});

// 요일 확인
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
		str += lecName + "&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;";
		str += lecRoName;
		
		document.getElementsByClassName(classNum)[0].style.color = "white";
		document.getElementsByClassName(classNum)[0].innerHTML = str;
	}
}
function lectureTransfer() {
	let today = new Date();   

	let year = today.getFullYear(); // 년도
	let month = today.getMonth() + 1;  // 월
	let date = today.getDate();  // 날짜
	let day = today.getDay();  // 요일

	let todayDate = year + '/' + month + '/' + date;
	console.log("todayDate : ", todayDate);
	
	if((date <= 19) && (month <= 7)) { // 7월 19일까지 수강신청 거래 가능
		location.href="/stuLecture/exchange?menuId=couRegChk";
	}
}
</script>
</head>
<body>
    <div class="h5Button">
        <h4 class="hearderH5">${studentVO.stGrade}학년 ${studentVO.stSemester}학기</h4>
        <button type="button" class="btn btn-block btn-outline-success rkddmlrjfoBut" onclick="lectureTransfer()">강의거래전송</button>
    </div>
    <div>
	    <table border="1" class="tbe">
	        <thead>
	            <tr class="heardTr">
	                <th>교시</th>
	                <th>시간</th>
	                <th>월</th>
	                <th>화</th>
	                <th>수</th>
	                <th>목</th>
	                <th>금</th>
	            </tr>
	        </thead>
	        <tbody>
	            <tr>
	                <td>1교시</td>
	                <td>09:00 ~ 09:50</td>
	                <td class="lectureMon1"></td>
	                <td class="lectureTue1"></td>
	                <td class="lectureWed1"></td>
	                <td class="lectureThu1"></td>
	                <td class="lectureFri1"></td>
	            </tr>
	            <tr>
	                <td>2교시</td>
	                <td>10:00 ~ 10:50</td>
	                <td class="lectureMon2"></td>
	                <td class="lectureTue2"></td>
	                <td class="lectureWed2"></td>
	                <td class="lectureThu2"></td>
	                <td class="lectureFri2"></td>
	            </tr>
	            <tr>
	                <td>3교시</td>
	                <td>11:00 ~ 11:50</td>
	                <td class="lectureMon3"></td>
	                <td class="lectureTue3"></td>
	                <td class="lectureWed3"></td>
	                <td class="lectureThu3"></td>
	                <td class="lectureFri3"></td>
	            </tr>
	            <tr>
	                <td>4교시</td>
	                <td>12:00 ~ 12:50</td>
	                <td class="lectureMon4"></td>
	                <td class="lectureTue4"></td>
	                <td class="lectureWed4"></td>
	                <td class="lectureThu4"></td>
	                <td class="lectureFri4"></td>
	            </tr>
	            <tr>
	                <td>5교시</td>
	                <td>13:00 ~ 13:50</td>
	                <td class="lectureMon5"></td>
	                <td class="lectureTue5"></td>
	                <td class="lectureWed5"></td>
	                <td class="lectureThu5"></td>
	                <td class="lectureFri5"></td>
	            </tr>
	            <tr>
	                <td>6교시</td>
	                <td>14:00 ~ 14:50</td>
	                <td class="lectureMon6"></td>
	                <td class="lectureTue6"></td>
	                <td class="lectureWed6"></td>
	                <td class="lectureThu6"></td>
	                <td class="lectureFri6"></td>
	            </tr>
	            <tr>
	                <td>7교시</td>
	                <td>15:00 ~ 15:50</td>
	                <td class="lectureMon7"></td>
	                <td class="lectureTue7"></td>
	                <td class="lectureWed7"></td>
	                <td class="lectureThu7"></td>
	                <td class="lectureFri7"></td>
	            </tr>
	            <tr>
	                <td>8교시</td>
	                <td>16:00 ~ 16:50</td>
	                <td class="lectureMon8"></td>
	                <td class="lectureTue8"></td>
	                <td class="lectureWed8"></td>
	                <td class="lectureThu8"></td>
	                <td class="lectureFri8"></td>
	            </tr>
	            <tr>
	                <td>9교시</td>
	                <td>17:00 ~ 17:50</td>
	                <td class="lectureMon9"></td>
	                <td class="lectureTue9"></td>
	                <td class="lectureWed9"></td>
	                <td class="lectureThu9"></td>
	                <td class="lectureFri9"></td>
	            </tr>
	        </tbody>
	    </table>
    </div>
</body>
</html>