<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
.backgroundCol{
    background-color: white;
}
.hrWid {
	width: 1460px;
}
.marginAuto {
    margin: auto;
}
.card-footer {
    width: 500px;
    border: 1px solid #e3e6f0;
}
.flex-fill {
    width: 500px;
}
.searchResult {
	margin-top: 50px;
}
.listBut {
	width: 165px;
    margin: auto;
}
.marginBtm {
	margin-bottom: 30px;
}
.textCenter {
    text-align:center;
}
</style>
</head>
<body>
	<h3 class="hearderH3">강의거래 상세내역</h3>
	<hr class="hrWid" />
	<div class="mainbd">
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
						<tbody id="search-trShow" class="text-center scroll">
							<tr name="stuLectureVO">
								<td class="textCenter" name="stuLecDiv">${stuLectureVO.stuLecDiv}</td>
								<td class="textCenter" name="lecType">${stuLectureVO.lectureVOList.lecType}</td>
								<td class="textCenter" name="lecScore">${stuLectureVO.lectureVOList.lecScore}</td>
								<td class="textCenter" name="comDetCodeName">${stuLectureVO.lectureVOList.comDetCodeVO.comDetCodeName}</td>
								<td class="textCenter" name="userName">${stuLectureVO.lectureVOList.userInfoVO.userName}</td>
								<td class="textCenter" name="lecPer">${stuLectureVO.lectureVOList.lecPer}</td>
								<td class="textCenter" name="lecName">${stuLectureVO.lectureVOList.lecName}</td>
								<td class="textCenter" name="stuLecDay">${stuLectureVO.stuLecDay}</td>
								<td class="textCenter" name="lecRoName">${stuLectureVO.lectureVOList.lectureRoomVO.lecRoName}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		<div class="card-body pb-0 divCenter" style="overflow: auto; width: auto; height: auto;">
			<div class="row searchResult">
				<div class="col-12 col-sm-6 col-md-4 d-flex align-items-stretch flex-column marginAuto">
					<div class="card bg-light d-flex flex-fill">
						<div class="card-header text-muted border-bottom-0 backgroundCol">
							<br>
						</div>
						<div class="card-body pt-0 backgroundCol">
							<div class="row">
								<div class="col-7 ">
									<h2 class="lead" align="center" style="font-weight: bold; font-size: x-large;">
										<b id="userName">${student.userInfoVO.userName}</b>
									</h2>
									<p class="text-muted text-sm">
										학과 : <b id="comDetCodeName">${student.comDetCodeVO.comDetCodeName}</b>
									</p>
									<p class="text-muted text-sm">
										학년 : <b id="stGrade">${student.stGrade}</b>학년
									</p>
									<p class="text-muted text-sm">
										학번 : <b id="stNo">${student.stNo}</b>
									</p>
									<p class="text-muted text-sm">
										연락처 : <b id="userTel">${student.userInfoVO.userTel}</b>
									</p>
									<p class="text-muted text-sm">
										이메일 : <b id="stEmail">${student.stEmail}</b>
									</p>
								</div>
								<div class="col-5 text-center">
									<!-- 사진 불러오기 -->
									<img id="stuFilePath" src="${student.stuAttachFileVO.stuFilePath}" alt="user-avatar" class="img-square img-fluid userImage">
								</div>
							</div>
						</div>
					</div>
					<div class="card-footer backgroundCol marginBtm">
						<div class="text-center" style="font-weight: bold">
							<p style="margin: 0px 0px 0px 0px;">
								대덕인재대학교 
								<img src="../../../resources/images/emblem2.png" alt="user-avatar" class="img-circle img-fluid" width="40" height="40">
							</p>
						</div>
					</div>
					<button type="button" onclick="location.href='/stuLecture/exchangeHistory?menuId=couRegChk'" 
                        class="btn btn-block btn-outline-secondary listBut">목록</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>