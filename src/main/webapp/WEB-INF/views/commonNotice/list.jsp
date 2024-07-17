<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<html>
<head>
<script type="text/javascript">
let locationHref = window.location.href;
$(function () {
	
	let authority = document.getElementsByName("authority")[0].value;
	console.log("authority >> ", authority);
	if(authority == 'ROLE_STUDENT') {
	   document.getElementsByName("authorityBtn")[0].style.display = 'none'; 
	}
	
	$('#newwrite').on('click', function(){
		location.href = "/commonNotice/create?menuId=annNotIce";	
	});
	
	
	console.log("locationHref >> ", locationHref);
	let temp = document.getElementsByName("trHref").href;
    console.log("temp >> ", temp);
	
	$('#btnSearch').on('click', function() {
		let keyword = $("input[name='table_search']").val();
		console.log("table_search: " + keyword);
		
		let searchCnd = document.getElementById("searchCnd").value;
		console.log("searchCnd >> ", searchCnd);
		
		getList(keyword, 1, searchCnd);
	})
});

//목록
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
	
	console.log("data : " , data);
	
	//아작나써유..(피)씨다타써...
	$.ajax({
		url: "/commonNotice/listAjax", //ajax용 url 변경
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
			
			$.each(result.content, function(idx, CommonNoticeVO){
				str += `<tr name="trHref" onclick="location.href='/commonNotice/detail?menuId=annNotIce&comNotNo=\${CommonNoticeVO.comNotNo}'" style="cursor:pointer">`;
				str += `<td class="textCenter">\${CommonNoticeVO.rn}</td>`;
				str += `<td class="textCenter">\${CommonNoticeVO.comGubun}</td>`;
				str += `<td>\${CommonNoticeVO.comNotName}</td>`;
				str += `<td class="textCenter">\${CommonNoticeVO.userInfoVOList.userName}</td>`; 
				str += `<td class="textCenter">\${CommonNoticeVO.comEndDate}</td>`;
				str += `<td class="textCenter">\${CommonNoticeVO.comNotViews}</td>`;
			});
			
			$(".clsPagingArea").html(result.pagingArea);
			
			$("#trShow").html(str);
		}
	});
}	
	
// 		$("#newwrite").on("click",function(){
// 			console.log("클릭");
// 			$("form").submit();
// 		});


		
</script>
<style type="text/css">
h3 {
	color: black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 165px;
} 

.wkrtjdBut {
    width: 105px;
    float: right;
}
   
.trBackground {
    background-color: #ebf1e9;
}

#btnSearch {
	border: 1px solid #D1D3E2;
	background-color: #F8F9FA;
}

.selectSearch{
    width: 130px;
    height: 30px;
    float: left;
    margin: 0px 5px 0px 0px;
    font-size: 0.8rem;
}

.clsPagingArea {
	margin-top:  20px;
	justify-content: flex-end;
}

.card {
	width: 80%;  /*목록 넓이*/
}

.textCenter {
    text-align:center;
}

</style>

</head>
<body>
<p style="display:none;"><sec:authentication property="principal"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO.userName"/></p>
<p style="display:none;"><sec:authentication property="principal.username"   var="merong"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO.authorityVOList"  var="myAuths"/></p>
	<h3>공지사항</h3>
	<br>
	<div class="card" style="margin: auto;">
		<div class="card-header" style="background-color: #fff;">
<!-- 	<form> -->
			<div class="brd-search">
				<select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
					<option value="1" selected="selected">제목</option>
					<option value="2">구분</option>
<!-- 					<option value="3">작성자</option> -->
				</select>

				<div class="input-group input-group-sm"
					style="width: 280px; float: left;">
					<input type="text" name="table_search"
						class="form-control float-left" placeholder="검색어를 입력하세요">
					<div class="input-group-append">
						<button type="button" class="btn btn-default" id="btnSearch">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>
				<p><input type="hidden" name="authority" value="${myAuths[0].authority}"></p>
				<button type="button" name="authorityBtn" class="btn btn-block btn-outline-primary wkrtjdBut" id="newwrite">작성</button>
			</div>
<!-- 	</form> -->
		</div>

		<div class="card-body table-responsive p-0">
			<table class="table table-hover text-nowrap">
				<thead>
					<tr class="trBackground textCenter">
						<th style="width: 5%;">번호</th>
						<th style="width: 10%;">구분</th>
						<th>제목</th>
						<th style="width: 10%;">작성자</th>
						<th style="width: 15%;">게시일</th>
						<th style="width: 5%;">조회수</th>
					</tr>
				</thead>
				<tbody id="trShow">
					<c:forEach var="CommonNoticeVO" items="${articlePage.content}" varStatus="stat">
<%-- 					${CommonNoticeVO} --%>
					<tr name="trHref" onclick="location.href='/commonNotice/detail?menuId=annNotIce&comNotNo=${CommonNoticeVO.comNotNo}'" style="cursor:pointer">
						<td>${CommonNoticeVO.rn}</td>
						<td>${CommonNoticeVO.comGubun}</td>
						<td>${CommonNoticeVO.comNotName}</td>
						<td>${CommonNoticeVO.userInfoVOList.userName}</td>
						<td>${CommonNoticeVO.comEndDate}</td>
						<td>${CommonNoticeVO.comNotViews}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<div class="row clsPagingArea">
		${articlePage.pagingArea}
	</div>

</body>
</html>