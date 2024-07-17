<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-colorschemes"></script>
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
	      
	      chart(dept.val());
	   });
});

function chart(deptCode){
	
	console.log(deptCode)
	
	// 플러그인 등록
    Chart.register(ChartDataLabels);

    // 이미 차트가 존재하면 파괴합니다.
    if (myChart1) {
        myChart1.destroy();
    }

    if(deptCode == 'D001001') {
    	// 차트를 새로 생성합니다.
        myChart1 = new Chart(document.getElementById('myChart1'), {
            type: 'bar',
            data: {
                labels: ['시설 관리','인사 관리','조경 관리','행정 관리','연구 관리','환경 관리'],
                datasets: [{
                    label: '항목 별 유지비용 통계 단위 : [만원]',
                    data: ['1523','3219','2411','2286','4381','2004'],
                    backgroundColor : [
                    	'rgba(255,99,132,0.2)',
                    	'rgba(54,162,235,0.2)',
                    	'rgba(255,206,86,0.2)',
                    	'rgba(75,192,192,0.2)',
                    	'rgba(153,102,255,0.2)',
                    	'rgba(255,159,64,0.2)'
                    ],
                    borderColor : [
                    	'rgba(255,99,132,0.2)',
                    	'rgba(54,162,235,0.2)',
                    	'rgba(255,206,86,0.2)',
                    	'rgba(75,192,192,0.2)',
                    	'rgba(153,102,255,0.2)',
                    	'rgba(255,159,64,0.2)'
                    ],
                    borderWidth: 1, // 선 굵기
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
	} else if(deptCode == 'D001002') {
		myChart1 = new Chart(document.getElementById('myChart1'), {
            type: 'bar',
            data: {
                labels: ['시설 관리','인사 관리','조경 관리','행정 관리','연구 관리','환경 관리'],
                datasets: [{
                    label: '항목 별 유지비용 통계 단위 : [만원]',
                    data: ['1347','2249','3077','2791','3370','1980'],
                    backgroundColor : [
                    	'rgba(255,99,132,0.2)',
                    	'rgba(54,162,235,0.2)',
                    	'rgba(255,206,86,0.2)',
                    	'rgba(75,192,192,0.2)',
                    	'rgba(153,102,255,0.2)',
                    	'rgba(255,159,64,0.2)'
                    ],
                    borderColor : [
                    	'rgba(255,99,132,0.2)',
                    	'rgba(54,162,235,0.2)',
                    	'rgba(255,206,86,0.2)',
                    	'rgba(75,192,192,0.2)',
                    	'rgba(153,102,255,0.2)',
                    	'rgba(255,159,64,0.2)'
                    ],
                    borderWidth: 1, // 선 굵기
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
	} else if(deptCode == 'D001003') {
		myChart1 = new Chart(document.getElementById('myChart1'), {
            type: 'bar',
            data: {
                labels: ['시설 관리','인사 관리','조경 관리','행정 관리','연구 관리','환경 관리'],
                datasets: [{
                    label: '항목 별 유지비용 통계 단위 : [만원]',
                    data: ['2133','4049','2947','3238','3217','1681'],
                    backgroundColor : [
                    	'rgba(255,99,132,0.2)',
                    	'rgba(54,162,235,0.2)',
                    	'rgba(255,206,86,0.2)',
                    	'rgba(75,192,192,0.2)',
                    	'rgba(153,102,255,0.2)',
                    	'rgba(255,159,64,0.2)'
                    ],
                    borderColor : [
                    	'rgba(255,99,132,0.2)',
                    	'rgba(54,162,235,0.2)',
                    	'rgba(255,206,86,0.2)',
                    	'rgba(75,192,192,0.2)',
                    	'rgba(153,102,255,0.2)',
                    	'rgba(255,159,64,0.2)'
                    ],
                    borderWidth: 1, // 선 굵기
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
	} else if(deptCode == 'D001004') {
		myChart1 = new Chart(document.getElementById('myChart1'), {
            type: 'bar',
            data: {
                labels: ['시설 관리','인사 관리','조경 관리','행정 관리','연구 관리','환경 관리'],
                datasets: [{
                    label: '항목 별 유지비용 통계 단위 : [만원]',
                    data: ['2947','3249','3671','1991','3070','2180'],
                    backgroundColor : [
                    	'rgba(255,99,132,0.2)',
                    	'rgba(54,162,235,0.2)',
                    	'rgba(255,206,86,0.2)',
                    	'rgba(75,192,192,0.2)',
                    	'rgba(153,102,255,0.2)',
                    	'rgba(255,159,64,0.2)'
                    ],
                    borderColor : [
                    	'rgba(255,99,132,0.2)',
                    	'rgba(54,162,235,0.2)',
                    	'rgba(255,206,86,0.2)',
                    	'rgba(75,192,192,0.2)',
                    	'rgba(153,102,255,0.2)',
                    	'rgba(255,159,64,0.2)'
                    ],
                    borderWidth: 1, // 선 굵기
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
    
}
</script>
<h3>항목 별 유지비용 통계</h3>
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