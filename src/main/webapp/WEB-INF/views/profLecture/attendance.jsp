<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
        h3 {
            margin-bottom: 30px;
            margin-top: 40px;
            color: black;
        }
        .textCenter {
            text-align:center;
        }
        .selectSearch{
            width: 60px;
            height: 30px;
            float: left;
            margin: 0px 5px 0px 0px;
            font-size: 0.7rem;
        }
        #btnSearch {
            border: 1px solid #D1D3E2;
            background-color: #F8F9FA;
        }
        .divSearch {
            width: 280px;
            float: left;
        }
        .wkrtjdBut {
            width: 130px;
            /* float: right; */
            margin: auto;
        }
    </style>
    <script>
        //강의 클릭시
        function lectInfo(pThis){
            console.log(pThis);
            let lecNo = pThis.cells[1].innerText;
            let lecSemester = pThis.cells[2].innerText;
            let lecYear = pThis.cells[3].innerText;
            let lecName = pThis.cells[4].innerText;
            let lecRoNo = pThis.cells[5].innerText;
            let data = {
                lecNo,
                lecSemester,
                lecYear,
                lecName,
                lecRoNo
            }
            console.log(data);
                $.ajax({
                    url: "/profLecture/stuList", //ajax용 url 변경
                    contentType:"application/json;charset=utf-8",
                    data:JSON.stringify(data),
                    type:"post",
                    dataType:"json",
                    beforeSend:function(xhr){
                    xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                    },
                    success:function(result){
                        console.log("result개똥이 : ",result)
                        let disp=""
                        let listDisp = "";
                        let frequency="";
                        $.each(result, function (idx, stuLectureVO) {
                            // console.log("idx", idx);
                            // console.log("stuLectureVO", stuLectureVO);
                            // console.log("--------------------")
                            // console.log("stuLectureVO.lecNo", stuLectureVO.lecNo);
                            // console.log("stuLectureVO.stuLecNo", stuLectureVO.stuLecNo);
                            // console.log("stuLectureVO.stNo", stuLectureVO.stNo);
                            // console.log("stuLectureVO.comDetCodeVO.comDetCodeName", stuLectureVO.comDetCodeVO.comDetCodeName);
                            // console.log("stuLectureVO.studentVO.stGrade", stuLectureVO.studentVO.stGrade);
                            // console.log("stuLectureVO.userInfoVO.userName", stuLectureVO.userInfoVO.userName);
                            // console.log("stuLectureVO.lectureDetailVO.lecNum", stuLectureVO.lectureDetailVO.lecNum);
                            // console.log("--------------------")
                            frequency = stuLectureVO.lectureDetailVO.lecNum;
                            
                            disp+=`
                            <input type="hidden" name="lecNo" value="\${stuLectureVO.lecNo}">
                            <input type="hidden" name="stuLecNo" value="\${stuLectureVO.stuLecNo}">
                            <tr class="trBackground">
                                    <td>\${idx+1}</td>
                                    <td>\${stuLectureVO.stNo}</td>
                                    <td class="userName">\${stuLectureVO.userInfoVO.userName}</td>
                                    <td>\${stuLectureVO.comDetCodeVO.comDetCodeName}</td>
                                    <td>\${stuLectureVO.studentVO.stGrade}</td>
                                    
                                `;
                            for (let i = 1; i <= frequency; i++) { 
                                disp+=`

                                    <td class="textCenter">
                                        <div class="col-sm-2">
                                            <select name="attCode" id="searchCnd" class="form-control selectSearch" onchange="onChange(this)">
                                                <option value="AD00101"></option>
                                                <option value="AD00102">◯</option>
                                                <option value="AD00103">△</option>
                                                <option value="AD00104">✕</option>
                                                <option value="AD00105">◎</option>
                                            </select>
                                        </div>
                                    </td>
                                `;
                            };
                        });//each end

                        listDisp+=`
                                    <th class="textCenter" style="width: 100px;">번호</th>
                                    <th class="textCenter">학번</th>
                                    <th class="textCenter">이름</th>
                                    <th class="textCenter">학과</th>
                                    <th class="textCenter">학년</th>
                        `;
                        for (let i = 1; i <= frequency; i++) {
                            
                            listDisp += `<th class="textCenter">\${i}</th>`;
                        };
                        disp+=`</tr>`;

                        // console.log("listDisp : ",listDisp); //행출력
                        // console.log("disp : ",disp); // 목록 출력
                        $("#freqList").html(listDisp);
                        $("#stuList").html(disp);
                    }
                });//ajax end
            }
            ///////////////////////////

            function onChange(e){
                let columnIndex = $(e).closest("td").index();
                console.log("columnIndex",columnIndex);

                let attCode = e.value; //출결코드
                let stuLecNo = $(e).closest("table").find("input[name='stuLecNo']").val(); //수강번호
                let stNo= e.closest("tr").cells[1].innerText; //학번
                let lecNum = $(e).closest("table").find("thead th").eq(columnIndex).text(); //강의회차
                console.log('$(e).closest("table").find("thead th")',$(e).closest("table").find("thead th"))
                // let lecDate= "";
                let lecNo2 = $(e).closest("tr").find("input[name='lecNo']").val(); //강의번호
                // console.log('체킁 >>> ', e.parentElement)
                console.log("attCode>>",attCode);
                console.log("stuLecNo>>",stuLecNo);
                console.log("stNo>>",stNo);
                console.log("lecNum: " , lecNum);//열 강의 회차
                console.log("lecNo2>>",lecNo2);
                
                let data ={
                    attCode,
                    stuLecNo,
                    stNo,
                    lecNum,
                    lecNo2
                }
                console.log(data);





            }

            function btnSave(pThis){
                // let searchCnd = document.querySelectorAll('.selectSearch')
                // let userName = document.querySelectorAll('.userName')
                // let textCenter = document.querySelectorAll('textCenter')
                
                // for(let i = 0; i<userName.length; i++){
                //     console.log('userName >>> ',userName[i].innerText)
                // }
                // for(let i = 0; i<searchCnd.length; i++){
                //     // 회차 별 출결 현황
                //     console.log('searchCnd >> ', searchCnd[i].value); 
                // }

            //    console.log('selected', $('#searchCnd'))
            //    console.log("pThis",pThis);
            }  
    </script>
    <h3>학생 출결</h3>
    <hr>
<div id="allDisp">
    <!-- 강의선택 start -->
     
    <div class="col-12">
        <div class="card">
            <div class="card-body table-responsive p-0 search-table" style="overflow-y: scroll;width: 100%;height: 300px;">
                <table class="table table-hover text-nowrap lectureList">
                    <thead style="background-color: #ebf1e9;position: sticky;top: -1px;">
                        <tr class="trBackground">
                            <th class="textCenter">번호</th>
                            <th class="textCenter">강의번호</th>
                            <th class="textCenter">강의학기</th>
                            <th class="textCenter">강의연도</th>
                            <th class="textCenter">강의명</th>
                            <th class="textCenter">강의실번호</th>
                            <th class="textCenter">수강인원</th>
                        </tr>
                    </thead>
                    <tbody id="search-trShow" class="text-center scroll">
                        <!-- 강의 리스트 출력 영역 -->
                        <!-- <hr> -->
                        <!-- ${stuLectureVOCount.lecNo} -->
                        <!-- <hr> -->
                        <!-- ${lectureVO.lecNo} -->
                        <c:forEach var="lectureVO" items="${lectureVOList}" varStatus="stat">
                            <!-- ${lectureVO} -->
                            <tr class="trBackground" onclick="lectInfo(this)">
                                <th>1</th>
                                <th>${lectureVO.lecNo}</th> 
                                <th>${lectureVO.lecSemester}</th>
                                <th>${lectureVO.lecYear}</th>
                                <th>${lectureVO.lecName}</th>
                                <th>${lectureVO.lectureRoomVO.lecRoName}</th>
                                <th>
                                    <c:set var="matchFound" value="false" />
                                    <c:forEach var="stuLectureVOCount" items="${stuLectureVOCountList}" varStatus="countStat">
                                        <c:if test="${lectureVO.lecNo eq stuLectureVOCount.lecNo}">
                                            ${stuLectureVOCount.stuLecCount}
                                            <c:set var="matchFound" value="true" />
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${!matchFound}">
                                        0
                                    </c:if>
                                </th>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <br>
    <!-- 강의선택 end -->
    <!-- 출결시스템 안내 start -->
    <div class="col-md-12">
        <div class="card card-default">
            <div class="card-header" style="background-color: #ebf1e9;text-align: center;">
                <h5 class="card-title" style="padding-top: 5px;" >출결시스템안내</h5>
            </div>
            <div class="card-body p-0">
                <div style=" margin-left: 20px;margin-top: 20px;">
                    <p>
                        (1) 출결 표시 방법 안내
                        <br>- 출결 : ◯ | 지각: △ | 결석: ✕ | 공결: ◎
                    </p>
                    <p>
                        (2) 출결표는 회차로 구분합니다.
                    </p>
                    <p>
                        (3) 출결을 등록 또는 변경하고 싶은 회차에 해당하는 간을 클릭하여 출결을 선택합니다.
                    </p>
                    <p>
                        (4) 다음 회차의 출결은 이전 회차의 출결을 등록해야만 선택 할 수 있습니다.
                    </p>
                </div>
            </div>
        </div>
    </div>
    <br>
    <!-- 출결시스템 안내 end -->
    <div >
        <div class="brd-search">
            <!-- <select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
                <option value="1">제목</option>
                <option value="2">구분</option>
            </select> -->

            <div class="input-group input-group-sm divSearch" style="margin-left: 13px;">
                <input type="text" name="table_search" class="form-control float-left" placeholder="이름 입력하세요">
                <div class="input-group-append">
                    <button type="button" class="btn btn-default" id="btnSearch">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
    <br>
    <br>
    <!-- 출결체크 -->
    <div class="col-12">
        <div class="card">
            <div class="card-body table-responsive p-0 search-table">
                <table class="table table-hover text-nowrap lectureList">
                    <thead style="background-color: #ebf1e9;">
                        <tr id="freqList" class="trBackground">
                            <th class="textCenter" style="width: 100px;">번호</th>
                            <th class="textCenter" style="width: 150px;">학번</th>
                            <th class="textCenter" style="width: 250px;">이름</th>
                            <th class="textCenter" style="width: 100px;">학과</th>
                            <th class="textCenter" style="width: 100px;">학년</th>                            
                        </tr>
                    </thead>
                    <tbody id="stuList" class="text-center scroll search-trShow">
                        <!-- 출결 체크 출력 영역 -->
                        <tr class="trBackground">
                                <!-- <td>1</td>
                                <th>123123123</th>
                                <th>qwer</th>
                                <th>asdf</th>
                                <th>2학년</th> -->
                            <!-- <th class="textCenter">
                                <div class ="col-sm-2">
                                    <select name="" id="searchCnd" class="form-control selectSearch">
                                        <option value="">◯</option>
                                        <option value="">△</option>
                                        <option value="">✕</option>
                                        <option value="">◎</option>
                                    </select>
                                </div>
                            </th>
                            <th>2</th>
                            <th>3</th>
                            <th>4</th>
                            <th>5</th>
                            <th>6</th>
                            <th>7</th>
                            <th>8</th>
                            <th>9</th>
                            <th>10</th>
                            <th>11</th>
                            <th>12</th>
                            <th>13</th>
                            <th>14</th> -->
                            </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <br>
    <button type="button" id="btnSave" class="btn btn-block btn-outline-primary wkrtjdBut" onclick="btnSave(this)">저장</button>
</div>