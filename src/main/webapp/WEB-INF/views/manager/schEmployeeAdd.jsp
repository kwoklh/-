<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
h3 {
	color:black;
    margin-bottom: 30px;
    margin-top: 40px;
} 
.trBackground {
    background-color: #ebf1e9;
    text-align: center;
}
#save {
	margin-top: 20px;
	margin-left: auto;
	margin-right: auto;
}
</style>
<script>
$(function(){
    $('#univ').on('change',function(){
    	univ = $('#univ').val();
        console.log(univ)
	    let data = {
        	univ
	    };
	
	    $.ajax({
	        url:"/manager/schEmNo",
	        contentType:"application/json;charset='utf-8'",
	        data:JSON.stringify(data),
	        type:"post",
	        dataType:"text",
	        beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
	        success:function(result){
	            console.log(result)
	            $('#schEmNo').val(result)
	        }
	    })
    })

    $('#save').on('click', function(){
    	const form = document.getElementById('form');
        const formData = new FormData(form);
        const data = {};
        formData.forEach((value, key) => {
            data[key] = value;
        });
        
        console.log(data);
        
        $.ajax({
        	url:"/manager/createSchEmAjax",
	        contentType:"application/json;charset='utf-8'",
	        data:JSON.stringify(data),
	        type:"post",
	        dataType:"text",
	        beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
	        success:function(result){
	            console.log(result)
	            if(result > 0){
	            	
		            Swal.fire({
	                    position: "center",
	                    icon: "success",
	                    title: "등록완료 되었습니다.",
	                    timer: 1800,
	                    showConfirmButton: false // 확인 버튼을 숨깁니다.
	                  }).then(() => {
	                    // Swal.fire의 타이머가 끝난 후 호출됩니다.
	                    location.href = "/manager/schEmployeeList?menuId=pstEmpMan";
	                  });
	            }
	        }
        })
    })
})    
</script>
<h3>교직원 추가</h3>
<div class="card" class="divCard">
    <div class="card-body table-responsive p-0">
        <table class="table table-hover text-nowrap">
            <thead>
                <tr class="trBackground textCenter">
                    <th>단과대학</th>
                    <th>교직원번호</th>
                    <th>교직원명</th>
                    <th>입사일</th>
                    <th>종료(예정)일</th>
                    <th>연봉</th>
                </tr>
            </thead>
            <tbody id="trShow" class="text-center">
                <form action="" id="form">
                     <tr name="trHref">
                        <td class="col-2">
                            <select class="form-control" name="schEmDept" id="univ">
								<option selected disabled>학과 선택</option>
								<c:forEach var="comCodeVO" items="${univList}" varStatus="stat">
                                    <option value="${comCodeVO.comCode}">${comCodeVO.comCodeName}</option>
								</c:forEach>
							  </select>
                        </td>
                        <td class="col-2">
                            <input type="text" class="form-control" id="schEmNo" name="schEmNo" readonly>
                        </td>
                        <td class="col-2">
                            <input type="text" class="form-control" id="schEmName" name="schEmName">
                        </td>
                        <td class="col-2">
                            <input type="date" class="form-control" id="schEmStart" name="schEmStart">
                        </td>
                        <td class="col-2">
                            <input type="date" class="form-control" id="schEmEnd" name="schEmEnd">
                        </td>
                        <td class="col-2">
                            <input type="text" class="form-control" id="schEmSalary" name="schEmSalary">
                        </td>
                    </tr>
                </form>
            </tbody>
        </table>
    </div>
</div>
<div class="text-center">
	<p id="p1">
		<button type="button" class="btn btn-block btn-outline-success col-1" id="save">저장</button>
	</p>
</div>