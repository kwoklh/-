<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
* {
   font-family: 'NanumSquareNeo'; 
}
h3 {
    margin-bottom: 30px;
    margin-top: 40px;
    color:black;
} 
.card {
  margin:auto;
}
.headline{
  margin-top: 40px;
  margin-bottom: 0px;
}
.chart-disp {
  display:inline-flex;
}

</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script type="text/javascript">
$(function(){
 	// JSP에서 모델 데이터를 JSON 문자열로 가져오기
    let salaryListJson = '${salaryListJson}';
    let salaryData = JSON.parse(salaryListJson);
    let univListJson = '${univListJson}';
    let univData = JSON.parse(univListJson);
    console.log("Salary Data: ", salaryData);
    
	 // 각 값을 개별 변수에 할당
    let range1 = salaryData[0].RANGE1;
    let range2 = salaryData[0].RANGE2;
    let range3 = salaryData[0].RANGE3;
    let range4 = salaryData[0].RANGE4;
    
    let univ1 = univData[0].D001;
    let univ2 = univData[0].D002;
    let univ3 = univData[0].D003;
    let univ4 = univData[0].D004;
    let univ5 = univData[0].D005;
    let univ6 = univData[0].D006;

 	// 플러그인 등록
    Chart.register(ChartDataLabels);
	
	let myCt1 = document.getElementById('myChart1');
	
	let myChart1 = new Chart(myCt1,
		{
			type : 'doughnut',
			data : {
				labels : ['2000~2500', '2500~3000', '3000~3500', '3500~4000'],
				datasets : [{
					label : '평균 연봉 수',
					data : [range1, range2, range3, range4]
				}]
			},
			options: {
	            plugins: {
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
	let myCt2 = document.getElementById('myChart2');
	
	let myChart2 = new Chart(myCt2,
		{
			type : 'doughnut',
			data : {
				labels : ['공과대학','예술대학','자연과학대학','사범대학','경상대학','인문사회대학'],
				datasets : [{
					label : '고용 평균 수',
					data : [univ1, univ2, univ3, univ4, univ5, univ6]
				}]
			},
			options: {
	            plugins: {
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
	})
</script>
<h3>교직원 고용 비용 통계</h3>
<div class="chart-disp col-12">
	<div class="card col-4">
		<h4 class="headline text-center">교직원 평균 연봉 [단위 : 만]</h4>
		<div class="card-body col-12">
			<canvas id="myChart1"></canvas>
		</div>
	</div>
	<div class="card col-4">
		<h4 class="headline text-center">교직원 고용 평균 수 [대학별]</h4>
		<div class="card-body col-12">
			<canvas id="myChart2"></canvas>
		</div>
	</div>
</div>
