<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<html>
<head>
<style>

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

</style>
<script type="text/javascript">
let locationHref = window.location.href;
$(function () {
   console.log("locationHref >> ", locationHref);
   let temp = document.getElementsByName("trHref").href;
    console.log("temp >> ", temp);
   
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
      url: "/employment/recruitmentAjax", //ajax용 url 변경
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
            str += `<td colspan="5" style="text-align:center;">검색 결과가 없습니다.</td>`;
            str += `</tr>`;
         }
         
         $.each(result.content, function(idx, RecruitmentVO){
            str += `<tr name="trHref" onclick="location.href='#'" style="cursor:pointer">`;
            str += `<td class="textCenter">\${RecruitmentVO.recuNo}</td>`;
            str += `<td class="textCenter">\${RecruitmentVO.recuTitle}</td>`;
            str += `<td>\${RecruitmentVO.recuEndWriter}</td>`;
            str += `<td class="textCenter">\${RecruitmentVO.recuEndDateDisplay}</td>`; 
            str += `<td class="textCenter">\${RecruitmentVO.recuViews}</td>`;
            str += `</tr>`;
         });
         
         $(".clsPagingArea").html(result.pagingArea);
         
         $("#trShow").html(str);
      }
   });
}
</script>
</head>

<body>
    <h3 style="margin-bottom: 30px;margin-top: 40px;color:black;">채용정보</h3>
    <br>
    <div class="card" class="divCard">
        <div class="card-header" class="divCardHeader" style="background-color: #fff;">
            <div class="brd-search">
                <select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
                    <option value="1">번호</option>
                    <option value="2">제목</option>
                    <option value="3">작성자</option>
                    <option value="4">작성일자</option>
                    <option value="5">조회수</option>
                </select>

                <div class="input-group input-group-sm divSearch">
                    <input type="text" name="table_search" class="form-control float-left" placeholder="검색어를 입력하세요">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-default" id="btnSearch">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="card-body table-responsive p-0">
            <table class="table table-hover text-nowrap">
                <thead>
                    <tr class="trBackground textCenter">
                        <th style="width: 5%;">번호</th>
                        <th style="width: 15%;">제목</th>
                        <th>작성자</th>
                        <th style="width: 10%;">작성일자</th>
                        <th style="width: 15%;">조회수</th>
                    </tr>
                </thead>
                <tbody id="trShow">
                    <c:forEach var="RecruitmentVO" items="${articlePage.content}" varStatus="stat">
                        <!-- ${RecruitmentVO} -->
                            <tr name="trHref" onclick="location.href='#'" style="cursor:pointer">
                                <td class="textCenter">${RecruitmentVO.recuNo}</td>
                                <td class="textCenter">${RecruitmentVO.recuTitle}</td>
                                <td>${RecruitmentVO.recuEndWriter}</td>
                                <td class="textCenter">${RecruitmentVO.recuEndDateDisplay}</td>
                                <td class="textCenter">${RecruitmentVO.recuViews}</td>
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