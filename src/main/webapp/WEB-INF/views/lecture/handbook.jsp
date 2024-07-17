<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<style>
* {
	font-family: 'NanumSquareNeo'; 
}
h3 {
   color: black;
   margin-bottom: 30px;
   margin-top: 40px;
   margin-left: 135px;
} 
.card-body {
    display: flex;
    align-items: baseline;
}
.first {
  padding-left: 30px;
  padding-top: 30px;
  padding-bottom: 10px;
  margin-left: 70px;
}
.second {
  padding-top: 10px;
  padding-left: 30px;
  padding-bottom: 30px;
  margin-left: 70px;
}
.trBackground {
  background-color: #ebf1e9;
}
.table-disp {
  margin: auto;
  padding: 0;
  text-align: center;
}
</style>
<script type="text/javascript">
$(function(){
    $('#univ').on('change', function(){
        let univ = $('#univ')
        
        let data = {
        	'univ':univ.val()
        }
        
        $.ajax({
        	url:"/manager/deptAjax",
        	contentType:"application/json;charset='utf-8'",
        	data:JSON.stringify(data),
        	type:"POST",
        	dataType:"JSON",
        	beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log(result)
				
				let str = '';
				
				str += `<option selected disabled class="basic">학과</option>`;
				$.each(result, function(idx, deptList){
	               str += `<option value="\${deptList.comDetCode}">\${deptList.comDetCodeName}</option>`;
	            });
	            $('#dept').html(str);
			}
        })
    })
	
	let dept = $('select[name="dept"]');
    let year = $('select[name="year"]');
	let div= $('select[name="type"]');
	let grade= $('select[name="grade"]');
	let semester= $('select[name="semester"]');
	let lecName = $('#lecName');
    
    $('#search').on('click', function(){
//         console.log('검색 ㄱㄱ')
        
		let deptTemp = dept.val() != null ? dept.val() : "";
		let yearTemp = year.val() != null ? year.val() : "";
		let divTemp = div.val() != null ? div.val() : "";
		let gradeTemp = grade.val() != null ? grade.val() : "";
		let semesterTemp = semester.val() != null ? semester.val() : "";
		let lecNameTemp = lecName.val() != null ? lecName.val() : "";
		
		if(deptTemp === '' && yearTemp === '' && divTemp === '' && gradeTemp === '' && semesterTemp === '' && lecNameTemp === ''){
            // 경고 메시지 표시
            Swal.fire({
                icon: "error",
                html: "1개 이상의 검색 키워드를 선택해주세요 <br><br> (단과대학과 학과는 합쳐서 1개 취급합니다.)",
                });
            return;
        }
		
		let data = {
			'dept':deptTemp,
			'year':yearTemp,
			'div':divTemp,
			'grade':gradeTemp,
			'semester':semesterTemp,
			'lecName':lecNameTemp
		}
		
		console.log(data);

        $.ajax({
            url:"/lecture/searchHandbook",
            contentType:"application/json;charset=utf-8",
            data:JSON.stringify(data),
            type:"post",
            dataType:"json",
            beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
            success:function(result){
                let str = '';

                if(result.length == 0){
                    str += `<tr>
                                <td colspan="12" style="border-bottom: none; font-size: 30px;">조회 결과가 존재하지 않습니다. </td>
                            </tr>`;
                }
                
                $.each(result, function(idx, searchHandbookVO){
                	console.log(searchHandbookVO)
	                str += `
	                	<tr onclick="fSyllabus()">
	                    <td>\${idx+1}</td>
	                    <td>\${searchHandbookVO.lecDiv}</td>
	                    <td>\${searchHandbookVO.lecType}</td>
	                    <td>\${searchHandbookVO.lecYear}</td>
	                    <td>\${searchHandbookVO.lecSemester}</td>
	                    <td>\${searchHandbookVO.lecScore}</td>
	                    <td>\${searchHandbookVO.comDetCodeVO.comDetCodeName}</td>
	                    <td>\${searchHandbookVO.userInfoVO.userName}</td>
	                    <td>\${searchHandbookVO.lecPer}</td>
	                    <td>\${searchHandbookVO.lecName}</td>
	                    <td>\${searchHandbookVO.lecDay}</td>
	                    <td>\${searchHandbookVO.lectureRoomVO.lecRoName}</td>
	                	</tr>
	                `;
                })
                $('#search-trShow').html(str);
            }
        })
    
    })

    $('#reset').on('click', function(){
        console.log('검색 키워드 초기화')
        
        document.querySelector('#univ').selectedIndex = 0;
        document.querySelector('#dept').selectedIndex = 0;
        document.querySelector('#year').selectedIndex = 0;
        document.querySelector('#div').selectedIndex = 0;
        document.querySelector('#grade').selectedIndex = 0;
        document.querySelector('#semester').selectedIndex = 0;
        lecName.val('');
    })
})

function fSyllabus(){
	console.log('강의계획서 출력')
}
</script>
<h3>수강 편람</h3>
<div class="col-10" style="margin: auto; padding:0px;">
    <div class="card">
        <form action="" id="form">
            <div class="card-body first">
                <label for="univ">단과대학 :&nbsp;</label>
                <select class="form-control col-2" name="univ" id="univ" style="margin-right: 30px;">
                    <option disabled selected class="basic" value="">단과 대학</option>
                    <c:forEach var="univ" items="${univList}" varStatus="stat">
                        <option value="${univ.comCode}">${univ.comCodeName}</option>
                    </c:forEach>
                </select>
                <label for="dept">학과 :&nbsp;</label>
                <select class="form-control col-2" name="dept" id="dept" style="margin-right: 30px;">
                    <option disabled selected class="basic">학과</option>
                </select>
                <label for="year">년도 :&nbsp;</label>
                <select class="form-control col-2" name="year" id="year" style="margin-right: 30px;">
                    <option disabled selected class="basic" value="">년도</option>
                    <option value="2024">2024</option>
                    <option value="2023">2023</option>
                    <option value="2022">2022</option>
                    <option value="2021">2021</option>
                    <option value="2020">2020</option>
                </select>
                <label for="div">이수 구분 :&nbsp;</label>
                <select class="form-control col-2" name="div" id="div" style="margin-right: 30px;">
                    <option disabled selected class="basic" value="">구분</option>
                    <option value="1">전필</option>
                    <option value="2">전선</option>
                    <option value="3">교필</option>
                    <option value="4">교선</option>
                </select>
            </div>
            <div class="card-body second">
                <label for="grade">학년 :&nbsp;</label>
                <select class="form-control col-1" name="grade" id="grade" style="margin-right: 30px;">
                    <option disabled selected class="basic" value="">학년</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                </select>
                <label for="semester">학기 :&nbsp;</label>
                <select class="form-control col-1" name="semester" id="semester" style="margin-right: 30px;">
                    <option disabled selected class="basic" value="">학기</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                </select>
                <label for="lecName">강의명 :&nbsp;</label>
                <input class="basic form-control col-3" id="lecName" value="">
                <input class="btn btn-primary" id="search" value="조 회" style="margin-left: 105px; width: 150px;">
                <input class="btn btn-secondary" id="reset" value="초기화" style="margin-left: 30px; width: 150px;">
            </div>
        </form>
    </div>
</div>
<br>
<div class="card col-10 table-disp" style="margin: auto;">
    <div class="card-body table-responsive p-0 search-table">
        <table class="table table-hover text-nowrap lectureList">
            <thead>
                <tr class="trBackground">
                    <th>번호</th>
                    <th>이수구분</th>
                    <th>강의영역</th>
                    <th>학년</th>
                    <th>학기</th>
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
                <tr>
                    <td colspan="12" style="border-bottom: none; font-size: 30px;">키워드를 선택해주세요 </td>
                </tr>
            </tbody>
        </table>
    </div>  
</div>