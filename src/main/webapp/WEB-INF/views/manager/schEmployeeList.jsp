<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
<html>
<head>
<style>
* {
   font-family: 'NanumSquareNeo'; 
}
.trBackground {
    background-color: #ebf1e9;
}
.wkrtjdBut {
    width: 105px;
    float: right;
}
.selectSearch{
    width: 130px;
    height: 30px;
    float: left;
    margin: 0px 5px 0px 0px;
    font-size: 0.8rem;
}
.divCard {
    margin: auto;
}
.divCardHeader {
    background-color: #fff;
}
.divSearch {
    width: 280px;
    float: left;
}
.textCenter {
    text-align:center;
}
.clsPagingArea {
   margin-top: 20px;
   justify-content: flex-end;
}
#btnSearch {
   border: 1px solid #D1D3E2;
   background-color: #F8F9FA;
}
h3 {
    margin-bottom: 30px;
    margin-top: 40px;
    color:black;
} 

</style>
<script type="text/javascript">
let locationHref = window.location.href;
$(function () {
   console.log("locationHref >> ", locationHref);
//    let temp = document.getElementsByName("trHref").href;
//     console.log("temp >> ", temp);
   
    $('#btnSearch').on('click', function () {
        let keyword = $("input[name='table_search']").val();
        console.log("table_search: " + keyword);

        let searchCnd = document.getElementById("searchCnd").value;
        console.log("searchCnd >> ", searchCnd);
        
        getList(keyword, 1, searchCnd);
    })

    
});

// 목록
function getList(keyword, currentPage, queGubun) {
   let queGubunTemp = "";
   if(queGubun != null) {
      queGubunTemp = queGubun;
   }
   
   // JSON 오브젝트
   let data = {
      "keyword":keyword,
      "currentPage":currentPage,
      "queGubun":queGubunTemp //구분 추가
   };
   
   console.log("data : ", data);
   
   //아작나써유..(피)씨다타써...
   $.ajax({
      url: "/manager/emplistAjax", //ajax용 url 변경
      contentType:"application/json;charset=utf-8",
      data:JSON.stringify(data),
      type:"post",
      dataType:"json",
      beforeSend:function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
      success:function(result){
         console.log("result.content : ", result.content);
         
         let str = "";
         
         if(result.content.length == 0) {
            str += `<tr>`;
            str += `<td colspan="6" style="text-align:center;">검색 결과가 없습니다.</td>`;
            str += `</tr>`;
         }
         
         $.each(result.content, function(idx, schEmployeeVO){
	       	 console.log(schEmployeeVO)
        	 str += `<tr name="trHref">`
        	 str += `<td>\${schEmployeeVO.schEmNo}</td>`
        	 str += `<td>\${schEmployeeVO.schEmName}</td>`
        	 str += `<td>\${schEmployeeVO.comCodeVO.comCodeName}</td>`
        	 str += `<td>\${schEmployeeVO.schEmStart}</td>`
        	 str += `<td>\${schEmployeeVO.schEmEnd}</td>`
        	 str += `<td>\${schEmployeeVO.schEmSalary}</td>`
        	 str += `</tr>`
         });
         
         $(".clsPagingArea").html(result.pagingArea);
         
         $("#trShow").html(str);
      }
   });
}
</script>
</head>

<body>
    <h3>교직원 조회</h3>
    <br>
    <div class="card" class="divCard">
        <div class="card-header" class="divCardHeader" style="background-color: #fff;">
            <div class="brd-search">
                <select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
                    <option disabled selected>검색 조건</option>
                    <option value="1">근로자번호</option>
                    <option value="2">근로자명</option>
                    <option value="3">단과대학</option>
                    <option value="4">입사일</option>
                    <option value="5">종료(예정)일</option>
                    <option value="6">연봉</option>
                </select>

                <div class="input-group input-group-sm divSearch">
                    <input type="text" name="table_search" class="form-control float-left" placeholder="검색어를 입력하세요">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-default" id="btnSearch">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
                <button type="button" class="btn btn-block btn-outline-primary wkrtjdBut" onclick="location.href='/manager/schEmployeeAdd?menuId=pstEmpMan'">작성</button>
            </div>
        </div>

        <div class="card-body table-responsive p-0">
            <table class="table table-hover text-nowrap">
                <thead>
                    <tr class="trBackground textCenter">
                    	<th>교직원번호</th>
                    	<th>교직원명</th>
                    	<th>단과대학</th>
                    	<th>입사일</th>
                    	<th>종료(예정)일</th>
                    	<th>연봉</th>
                    </tr>
                </thead>
                <tbody id="trShow" class="text-center">
                    <c:forEach var="employee" items="${articlePage.content}" varStatus="stat">
 		                <tr name="trHref" style="cursor:pointer">
                            <td>${employee.schEmNo}</td>
                            <td>${employee.schEmName}</td>
                            <td>${employee.comCodeVO.comCodeName}</td>
                            <td>${employee.schEmStart}</td>
                            <td>${employee.schEmEnd}</td>
                            <td>${employee.schEmSalary}</td>
	                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row clsPagingArea">
        ${articlePage.pagingArea}
    </div>
    <!-- 페이징 처리 -->
</body>
</html>