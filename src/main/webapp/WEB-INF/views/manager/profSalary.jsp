<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
* {
	font-family: 'NanumSquareNeo';
}

.card {
	margin: auto;
	max-width: 1323px;
	height: 850px;
}

h3 {
	color: black;
	margin-bottom: 30px;
	margin-top: 40px;
	margin-left: 165px;
}
.selectForm {
	margin: 15px 15px 0px;
}
#myChart1 {
    margin:auto;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-colorschemes"></script>
<script type="text/javascript">
var myChart1;

$(function(){
   $('#univ').on('change', function(){
      let univ = $('#univ');
      console.log(univ.val());
      
      let data = {
         "univ": univ.val()
      };
      
      $.ajax({
         url: "/manager/deptAjax",
         contentType: "application/json;charset='utf-8'",
         data: JSON.stringify(data),
         type: "post",
         dataType: "json",
         beforeSend: function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
         success: function(result){
            console.log(result);
            
            let str = "";
            
            str += `<option selected disabled>학과</option>`;
            $.each(result, function(idx, deptList){
               str += `<option value="\${deptList.comDetCode}">\${deptList.comDetCodeName}</option>`;
            });
            $('#dept').html(str);
         }
      });
   });
   

   
   $('#dept').on('change', function(){
      let dept = $('#dept');
      
      let data = {
         "deptCode": dept.val()
      };
      
      console.log(data);
      
      $.ajax({
         url: "/manager/dataAjax",
         contentType: "application/json;charset='utf-8'",
         data: JSON.stringify(data),
         type: "post",
         dataType: "json",
         beforeSend: function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
         success: function(result){
            console.log(result);
            
            let salary = [];
            let userName = [];
            
            $.each(result, function(idx, infoVO){
            	console.log('infoVO',infoVO.salary)
            	console.log('infoVO',infoVO.userInfoVO.userName)
            	salary.push(infoVO.salary)
            	userName.push(infoVO.userInfoVO.userName)
            })
            
            console.log('salary', salary)
            console.log('userName', userName)
         	chart(salary, userName);
         }
      });
   });
});

function chart(salary, userName){
	
    // 플러그인 등록
    Chart.register(ChartDataLabels);

    // 이미 차트가 존재하면 파괴합니다.
    if (myChart1) {
        myChart1.destroy();
    }

    // 차트를 새로 생성합니다.
    myChart1 = new Chart(document.getElementById('myChart1'), {
        type: 'bar',
        data: {
            labels: userName,
            datasets: [{
                label: '교수 평균 연봉 단위 : [만원]',
                data: salary,
                borderWidth: 4, // 선 굵기
                maxBarThickness: 100
            }]
        },
        options: {
            plugins: {
                legend: {
                    labels: {
                        font: {
                            size: 16 // 범례 레이블의 글씨 크기 설정
                        }
                    }
                },
                datalabels: {
                    color: '#000000',
                    anchor: 'center',
                    align: 'center',
                    offset: -10,
                    font: {
                        size: 20,
                        weight: 'bold'
                    }
                }
            }
        }
    });
}
</script>
<h3>학과 별 교수 연봉 통계</h3>
<div class="card">
	<div class="selectForm" style="display: flex;">
		<select class="form-control col-2" name="univ" id="univ"
			style="margin-right: 30px;">
			<option selected disabled>단과대학</option>
			<c:forEach var="univ" items="${univList}" varStatus="stat">
				<option value="${univ.comCode}">${univ.comCodeName}</option>
			</c:forEach>
		</select> <select class="form-control col-2" name="dept" id="dept"
			style="margin-right: 30px;">
			<option selected disabled>학과</option>
		</select>
	</div>
	<hr>
	<canvas id="myChart1" width="1200" height="700"></canvas>
</div>

