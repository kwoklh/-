<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
* {
  font-family: 'NanumSquareNeo'; 
}
.row {
  text-align: center;
}
.table {
  margin: auto;
}
.trBackground {
    background-color: #ebf1e9;
}
.clsPagingArea {
   margin-top: 20px;
   justify-content: flex-end;
}
</style>
<script>
let locationHref = window.location.href;
let dept = "";
$(function(){
	console.log("locationHref >> ", locationHref);
	
	$('#dept').on('change',function(){
		dept = $('#dept').val();
// 		console.log(dept)
		
		getList("", 1);
	})
})

function getList(keyword, currentPage) {
   dept = $('#dept').val();
   console.log(dept)

   let deptTemp = "";
   if(dept != null) {
	   deptTemp = dept;
   }
   
   console.log(deptTemp)
   
   // JSON 오브젝트
   let data = {
   	    "keyword":keyword,
        "currentPage":currentPage,
        "dept":deptTemp //구분 추가
   };
   
   console.log("data : ", data);
   
   //아작나써유..(피)씨다타써...
   $.ajax({
		url:"/manager/listAjax",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(data){
			console.log(data);
			
			let str = ""
			
			$.each(data.content, function(idx, studentVO){
				console.log(studentVO.comDetCodeVO)
				str += "<tr onclick=location.href='stuDetail?stNo="+studentVO.stNo+"'>";
				str += "<td>"+studentVO.stNo+"</td>";
				str += "<td>"+studentVO.comDetCodeVO.comDetCodeName+"</td>";
				str += "<td>"+studentVO.stGrade+"</td>";
				str += "<td>"+studentVO.userInfoVO.userName+"</td>";
				str += "<td>"+studentVO.stGender+"</td>";
				str += "<td>"+studentVO.userInfoVO.userTel+"</td>";
				str += "</tr>";
			});
			
			$(".clsPagingArea").html(data.pagingArea);
				
			$("#trShow").html(str);
		}
	})
}

</script>
<body>
	<h3>학생 정보 조회</h3>
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header">
					<div class="card-tools">
						<div class="input-group input-group-sm" style="width: 150px;">
							<select class="form-control" name="dept" id="dept">
								<option selected disabled>학과 선택</option>
								<c:forEach var="comCodeVO" items="${deptList}" varStatus="stat">
									<c:forEach var="dept" items="${comCodeVO.comDetCodeVOList}" varStatus="stat">
										<option value="${dept.comDetCode}">${dept.comDetCodeName}</option>
									</c:forEach>	
								</c:forEach>
							</select>
						</div>
					</div>
				</div>

				<div class="card-body table-responsive p-0">
					<table class="table table-hover text-nowrap">
						<thead>
							<tr class="trBackground">
								<th>학번</th>
								<th>학과</th>
								<th>학년</th>
								<th>학생명</th>
								<th>성별</th>
								<th>연락처</th>
							</tr>
						</thead>
						<tbody id="trShow" class="text-center">
							<tr>
								<td colspan="6">조회할 학과를 선택해주세요</td>
							</tr>
							<tr>
								<td colspan="6"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="clsPagingArea">
	   ${articlePage.pagingArea}
	</div>
	<!-- csrf 토큰 사용 -->
	<sec:csrfInput/>
</body>
