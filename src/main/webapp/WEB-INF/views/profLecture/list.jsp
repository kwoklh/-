<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
* {
  font-family: 'NanumSquareNeo'; 
}
.hearderH5 {
 	float: left;
 	margin-top: 40px;
 	margin-bottom: 30px;
	display: inline-block;
	margin-right: 1020px;
	margin-left: 173px;
}
.h5Button {
	display: inline-block;
}
.heardTr {
	height: 41px;
}
.tbe {
	height: 80vh;
	width: 80%;
	table-layout: fixed;
	text-align: center;
 	margin: 43px 170px 10px 170px;
	background-color: white;
	border-color: #d2d8d0;
}
td {
  height:70px;
}
</style>
<script>
$(function(){
	
// 	console.log($('.hearderH5').val());
	
	//아작나써유..(피)씨다타써...
	$.ajax({
		url: "/profLecture/listAjax", //ajax용 url 변경
// 		contentType:"application/json;charset=utf-8",
// 		data:"",
		type:"get",
		dataType:"json",
		success:function(result){
// 			console.log("result.length : ",result.length);
// 			console.log("result : ", result);
// 			console.log("result[0].lecNo : ", result[0].lecNo);
// 			console.log("result[0].lecName : ", result[0].lecName);
// 			console.log("result[0].lectureRoomVO.lecRoName : ", result[0].lectureRoomVO.lecRoName);
// 			console.log("result[0].lecCol : ", result[0].lecCol);
// 			console.log("result[0].lecTimeVO.lecDay : ", result[0].lecTimeVO.lecDay);
// 			console.log("result[0].lecTimeVO.lecSt : ", result[0].lecTimeVO.lecSt);
// 			console.log("result[0].lecTimeVO.lecEnd : ", result[0].lecTimeVO.lecEnd);
			
			for(let i=0; i<result.length; i++) {
				
				let lecNo = result[i].lecNo; //강의 번호
				let lecName = result[i].lecName; //강의명
				let lecRoName = result[i].lectureRoomVO.lecRoName; //강의실명
				let lecCol = result[i].lecCol; //색상 코드
				let lecDay = result[i].lecTimeVO.lecDay; //강의 요일
				let lecSt = result[i].lecTimeVO.lecSt; //강의 시작 교시
				let lecEnd = result[i].lecTimeVO.lecEnd; //강의 종료 교시
				
				console.log(lecNo, lecName, lecRoName, lecCol, lecDay, lecSt, lecEnd);
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
</script>
<div class="h5Button">
    <h4 class="hearderH5">강의시간표</h4>
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