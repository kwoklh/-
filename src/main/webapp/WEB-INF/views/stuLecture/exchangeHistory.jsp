<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<html>
<head>
<style type="text/css">
h3 {
   color: black;
    margin-bottom: 30px;
    margin-top: 60px;
    margin-left: 180px;
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
<script type="text/javascript">
$(function () {
   
//    console.log("locationHref >> ", locationHref);
//    let temp = document.getElementsByName("trHref").href;
//     console.log("temp >> ", temp);
   
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
   
	if(queGubun == '5' && keyword == "거래대기") {
		keyword = "M";
	} else if(queGubun == '5' && keyword == "거래취소") {
		keyword = "N";
	} else if(queGubun == '5' && keyword == "거래완료") {
		keyword = "Y";
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
      url: "/stuLecture/exchangeHistoryAjax", //ajax용 url 변경
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
         
         $.each(result.content, function(idx, TimeExchangeManageVO){
        	let userNo = $('input[name=userNo]').val(); //로그인 사람 사번 정보
        	console.log("userNo : ", userNo);
        	
        	if((`\${TimeExchangeManageVO.exAppYn}` == 'M') && (userNo == `\${TimeExchangeManageVO.timeTakeId}`)) {
 				str += `<tr name="trHref" onclick="exAppYn('\${TimeExchangeManageVO.timeExNo}', '\${TimeExchangeManageVO.timeTakeId}', '\${TimeExchangeManageVO.stuLecNo}')" style="cursor: pointer">`;
 			} else {
 				str += `<tr name="trHref"
						onclick="location.href='/stuLecture/excHisDetail?menuId=couRegChk&timeExNo=\${TimeExchangeManageVO.timeExNo}'"
						style="cursor: pointer">`;
 			}
        	
            str += `<td class="textCenter">\${TimeExchangeManageVO.rn}</td>
		            <td class="textCenter">\${TimeExchangeManageVO.timeTakeId}</td>
		            <td class="textCenter">\${TimeExchangeManageVO.timeSendId}</td>
		            <td class="textCenter">\${TimeExchangeManageVO.exReqDate}&nbsp;&nbsp;\${TimeExchangeManageVO.exReqDateTime}</td>`;
		            
		   if(`\${TimeExchangeManageVO.exAppDate}` == 'null') {
				str += `<td></td>`;
			} else if(`\${TimeExchangeManageVO.exAppDate}` != 'null') {
				str += `<td class="textCenter">\${TimeExchangeManageVO.exAppDate}&nbsp;&nbsp;\${TimeExchangeManageVO.exAppDateTime}</td>`;
			}
		   
		    if(`\${TimeExchangeManageVO.exAppYn}` == 'N') {
				str += `<td class="textCenter" style="color: red;">거래취소</td>`;
			} else if(`\${TimeExchangeManageVO.exAppYn}` == 'Y') {
				str += `<td class="textCenter" style="color: blue;">거래완료</td>`;
			} else if(`\${TimeExchangeManageVO.exAppYn}` == 'M'){
				str += `<td class="textCenter">거래대기</td>`;
			}
		    
			str += `</tr>`;
         });
         
         $(".clsPagingArea").html(result.pagingArea);
         
         $("#trShow").html(str);
      },
		error: function (request, status, error) {
		    console.log("code: " + request.status)
		    console.log("message: " + request.responseText)
		    console.log("error: " + error);
		}
   });
}   

// 거래 승인, 취소할지 결정
function exAppYn(timeExNo, timeTakeId, stuLecNo) {
	console.log("timeExNo >>", timeExNo);
	console.log("timeTakeId >>", timeTakeId);
	console.log("stuLecNo >>", stuLecNo);
	
	let exAppSuFa;
	
	Swal.fire({
		text: "강의를 받으시겠습니까?",
		icon: "warning",
		showCancelButton: true,
		confirmButtonColor: "#3085d6",
		cancelButtonColor: "#d33",
		confirmButtonText: "예",
		cancelButtonText: "아니요"
	}).then((result) => { 
		
		if (result.isConfirmed) { // 강의 받는 경우
			exAppYn = 'Y';
			exAppSuFa = '거래 완료'; // 거래 승인했는지, 거래 취소하였는지 출력
		}else{ // 강의 취소하는 경우
			exAppYn = 'N';
			exAppSuFa = '거래 취소'; // 거래 승인했는지, 거래 취소하였는지 출력
		}
		
		// JSON 오브젝트
		let data = {
		   "timeExNo":timeExNo, // 거래번호
		   "exAppYn":exAppYn, // 거래승인여부
		   "timeTakeId":timeTakeId, // 받은사람 아이디
		   "stuLecNo":stuLecNo // 수강번호
		};
		
		$.ajax({
			url:"/stuLecture/excHisOkAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result) {
				console.log("result >> ", result);
				
				if(result == "success") {
					Swal.fire({
						text: exAppSuFa + "되었습니다.",
						icon: "success"
					}).then((result) => {
						location.href="/stuLecture/exchangeHistory?menuId=couRegChk";
					});
				} else {
					Swal.fire({
						text: "거래 실패",
						icon: "false"
					});
				}
			}
		});
	});
	
}
</script>
</head>
<body>
	<p style="display:none;"><sec:authentication property="principal"/></p>
	<p style="display:none;"><sec:authentication property="principal.userInfoVO"/></p>
	<p style="display:none;"><sec:authentication property="principal.userInfoVO.userName"/></p>
	<p style="display:none;"><sec:authentication property="principal.username"   var="merong"/></p>
	<p style="display:none;"><sec:authentication property="principal.userInfoVO.authorityVOList"  var="myAuths"/></p>
	<h3>강의거래 내역</h3>
	<br>
	<div class="card" style="margin: auto;">
		<div class="card-header" style="background-color: #fff;">
			<div class="brd-search">
				<select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
					<option value="1">받는 사람 학번</option>
					<option value="2">보낸 사람 학번</option>
					<option value="3">거래신청일시</option>
					<option value="4">거래승인일시</option>
					<option value="5">거래승인여부</option>
				</select>

				<div class="input-group input-group-sm" style="width: 280px; float: left;">
					<input type="text" name="table_search" class="form-control float-left" placeholder="검색어를 입력하세요">
					<div class="input-group-append">
						<button type="button" class="btn btn-default" id="btnSearch">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>
			</div>
		</div>

		<input type="hidden" name="userNo" value="${myAuths[0].userNo}">
		<div class="card-body table-responsive p-0">
			<table class="table table-hover text-nowrap">
				<thead>
					<tr class="trBackground textCenter">
						<th style="width:10%;">번호</th>
						<th style="width:15%;">받는 사람 학번</th>
						<th style="width:15%;">보낸 사람 학번</th>
						<th style="width:25%;">거래신청일시</th>
						<th style="width:25%;">거래승인일시</th>
						<th style="width:15%;">거래승인여부</th>
					</tr>
				</thead>
				<tbody id="trShow">
					<c:forEach var="TimeExchangeManageVO" items="${articlePage.content}" varStatus="stat">
						<c:choose>
                           	<c:when test="${TimeExchangeManageVO.exAppYn == 'M' && myAuths[0].userNo == TimeExchangeManageVO.timeTakeId}">
								<tr name="trHref" onclick="exAppYn('${TimeExchangeManageVO.timeExNo}', '${TimeExchangeManageVO.timeTakeId}', '${TimeExchangeManageVO.stuLecNo}')" style="cursor: pointer">
							</c:when>
							<c:otherwise>
								<tr name="trHref"
									onclick="location.href='/stuLecture/excHisDetail?menuId=couRegChk&timeExNo=${TimeExchangeManageVO.timeExNo}'"
									style="cursor: pointer">
							</c:otherwise>
						</c:choose>
							<td class="textCenter">${TimeExchangeManageVO.rn}</td>
							<td class="textCenter">${TimeExchangeManageVO.timeTakeId}</td>
							<td class="textCenter">${TimeExchangeManageVO.timeSendId}</td>
							<td class="textCenter">${TimeExchangeManageVO.exReqDate}&nbsp;&nbsp;${TimeExchangeManageVO.exReqDateTime}</td>
							<c:choose>
                            	<c:when test="${TimeExchangeManageVO.exAppDate == 'null'}">
									<td></td>
								</c:when>
                            	<c:when test="${TimeExchangeManageVO.exAppDate != 'null'}">
									<td class="textCenter">${TimeExchangeManageVO.exAppDate}&nbsp;&nbsp;${TimeExchangeManageVO.exAppDateTime}</td>
								</c:when>
							</c:choose>
							<c:choose>
                            	<c:when test="${TimeExchangeManageVO.exAppYn == 'N'}">
	                                <td class="textCenter" style="color: red;">거래취소</td>
	                            </c:when>
	                            <c:when test="${TimeExchangeManageVO.exAppYn == 'Y'}">
	                                <td class="textCenter" style="color: blue;">거래완료</td>
	                            </c:when>
	                            <c:when test="${TimeExchangeManageVO.exAppYn == 'M'}">
	                                <td class="textCenter">거래대기</td>
	                            </c:when>
	                        </c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<div class="row clsPagingArea">${articlePage.pagingArea}</div>

</body>
</html>