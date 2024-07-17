<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.flex-column {
   margin-top: 30px;
   margin-bottom: 30px;
}
/* 자격증 등록버튼 */
.wkrtjdBut {
    width: 121px;
    float: right;
}
/* 검색창 */
.divSearch {
    width: 280px;
    float: left;
}
.form-control {
   display: inline-block;
}

.flex-fill {
   cursor: pointer;
}
.rjatorwhrjs{
   font-size: 1.0rem;
}
.userImage{
   width: 260px;
   height: 320px;
}
h3 {
    margin-bottom: 30px;
    margin-top: 40px;
    color:black;
}
.clsPagingArea {
   margin-top: 20px;
   justify-content: flex-end;
}
</style>
<script>
   let locationHref = window.location.href;
   function editMode(pThis){
      console.log(pThis); // 
      // console.log(pThis.parentElement.lastElementChild); //this 부모 객체 맞음
      let btnEdit=pThis //수정버튼
      btnEdit.style.display='none'; 
      let btnSaveCalcel=pThis.parentElement.lastElementChild//확인버튼,취소버튼
      btnSaveCalcel.style.display='block';

      console.log(">",pThis.parentElement.parentElement.firstElementChild)//changeDisp
      let changeDisp =pThis.parentElement.parentElement.firstElementChild;
      changeDisp.style.display='none'; //읽기모드 
      console.log(">>", pThis.parentElement.parentElement.children[1]);
      let editModeDisp=pThis.parentElement.parentElement.children[1];
      editModeDisp.style.display='block';
   }
   function readonlyOnly(pThis){
      // console.log(pThis.parentElement); //this 부모 객체 맞음
      let btnSaveCalcel=pThis.parentElement;
      btnSaveCalcel.style.display='none';
      // console.log(pThis.parentElement.parentElement.firstElementChild); //this 부모 객체 맞음
      let btnEdit=pThis.parentElement.parentElement.firstElementChild;
      btnEdit.style.display='block';

      //disp readonlyModeDisp  editModeDisp
      let disp=pThis.parentElement.parentElement.parentElement;
      console.log("disp",disp)
      let readonlyModeDisp=disp.firstElementChild;
      console.log(readonlyModeDisp)
      readonlyModeDisp.style.display='block';
      let editModeDisp=disp.children[1];
      console.log(editModeDisp);
      editModeDisp.style.display='none';
   }
   function btnUpdateSubmit(pThis){
      console.log("ck");
      let keyword = $("input[name='table_search']").val();
      console.log("table_search: " + keyword);
      let searchCnd = document.getElementById("searchCnd").value;
      console.log("searchCnd >> ", searchCnd);   
      let queGubunTemp = "";
      if(searchCnd != null) {
         queGubunTemp = searchCnd;
      }
      let currentPage=1;
      
      let certCode = $(".certCode").val();
      let certNm = $(".certNm").val();
      let certDate = $(".certDate").val();
      let certDateExp = $(".certDateExp").val();

      let data= {
         "certCode":certCode,
         "certNm":certNm,
         "certDate":certDate,
         "certDateExp":certDateExp,
         "keyword":keyword,
         "currentPage":currentPage,
         "queGubun":queGubunTemp
      }
      console.log(">>>",data);
      const Toast = Swal.mixin({
                        toast: true,
                        position: 'center',
                        showConfirmButton: false,
                        timer: 300000,
                    });

      Swal.fire({
         title: "수정하겠습니까?",
         icon: "warning",
         showCancelButton: true,
         confirmButtonColor: "#FFC107",
         cancelButtonColor: "#6C757D",
         confirmButtonText: "수정",
         cancelButtonText: "취소"
      }).then((result) => {
         if (result.isConfirmed) {
               $.ajax({
                        url:"/employment/cerUpdateAjax",
                        contentType:"application/json;charset=utf-8",
                        data:JSON.stringify(data),
                        type:"post",
                        dataType:"json",
                        beforeSend:function(xhr){
                              xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                        },
                        success:function(result){
                           console.log("result",result);
                           let str = "";
                           
                           $.each(result.content, function(idx, certificateVO){
                              console.log("idx",idx);
                              console.log("CertificateVO",certificateVO);
                              str+=listDisp(certificateVO);
                           });
                           
                           $(".clsPagingArea").html(result.pagingArea);
                           
                           $(".searchResult").html(str);

                           Swal.fire({
                              title: "수정되었습니다!",
                              icon: "info"
                           });
                        },
                        error: function (xhr, status, error) {
                     console.log("code: " + xhr.status)
                     console.log("message: " + xhr.responseText)
                     console.log("error: " + error);
                     }
                     });//ajax end
               
            }
            
      });
      
   }
   function btnCertificateDelete(pThis){
      console.log("ck");
      // console.log(pThis);
      // console.log(pThis.closest("span"));
      // console.log(pThis.value);
      let certCode =pThis.value

      let keyword = $("input[name='table_search']").val();
      console.log("table_search: " + keyword);
      let searchCnd = document.getElementById("searchCnd").value;
      console.log("searchCnd >> ", searchCnd);   
      let queGubunTemp = "";
      if(searchCnd != null) {
         queGubunTemp = searchCnd;
      }
      let currentPage=1;

      let data={
         "certCode":certCode,
         "keyword":keyword,
         "currentPage":currentPage,
         "queGubun":queGubunTemp
      }
      console.log(data);

      const Toast = Swal.mixin({
                        toast: true,
                        position: 'center',
                        showConfirmButton: false,
                        timer: 300000,
                    });

                    Swal.fire({
                    	  title: "삭제하겠습니까?",
                    	  icon: "warning",
                    	  showCancelButton: true,
                    	  confirmButtonColor: "#3085d6",
                    	  cancelButtonColor: "#d33",
                    	  confirmButtonText: "삭제",
                    	  cancelButtonText:"취소"
                    	}).then((result) => {
                    	  if (result.isConfirmed) {
                           $.ajax({
                              url:"/employment/cerDeleteAjax",
                              contentType:"application/json;charset=utf-8",
                              data:JSON.stringify(data),
                              type:"post",
                              dataType:"json",
                              beforeSend:function(xhr){
                                    xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                              },
                              success:function(result){
                                 console.log("result>>>>",result);

                                 let str = "";
                                 
                                 if(result.content.length == 0) {
                                    str += `취득한 자격증이 없습니다`;
                                 }
                                 
                                 $.each(result.content, function(idx, certificateVO){
                                    console.log("idx",idx);
                                    console.log("CertificateVO",certificateVO);
                                    str+=listDisp(certificateVO);
                                 });
                                 
                                 $(".clsPagingArea").html(result.pagingArea);
                                 
                                 $(".searchResult").html(str);

                              },error: function (xhr, status, error) {
                              console.log("code: " + xhr.status)
                              console.log("message: " + xhr.responseText)
                              console.log("error: " + error);
                              }
                           });
                           Swal.fire({
                    	      title: "삭제되었습니다!",
                    	      icon: "success"
                    	      });

                        }
                    	});
   }
$(function(){
   console.log("locationHref >> ", locationHref);
   // let temp = $("#changeDisp").attr("href");
   // console.log("temp >> ", temp);
   $('#btnSearch').on('click', function () {
        let keyword = $("input[name='table_search']").val();
        console.log("table_search: " + keyword);

        let searchCnd = document.getElementById("searchCnd").value;
        console.log("searchCnd >> ", searchCnd);
        
        getList(keyword, 1, searchCnd);
    })

   $("#btnCertificateAdd").on("click",function(){

      let certNm = $("#certNm").val();
      let certCode = $("#certCode").val();
      let certDate = $("#certDate").val();
      let certDateExp = $("#certDateExp").val();

      let data = {
         certNm: certNm,
         certCode: certCode,
         certDate: certDate,
         certDateExp: certDateExp
      };
      console.log("data",data);
      $.ajax({
         url:"/employment/cerCreateAjax",
         contentType:"application/json;charset=utf-8",
         data:JSON.stringify(data),
         type:"post",
         dataType:"text",
         beforeSend:function(xhr){
               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
         },
         success:function(result){
            console.log("result",result)
            Swal.fire({
                             position: "center",
                             icon: "success",
                             title: "등록완료 되었습니다.",
                             timer: 1800,
                             showConfirmButton: false // 확인 버튼을 숨깁니다.
                           }).then(() => {
                             // Swal.fire의 타이머가 끝난 후 호출됩니다.
                             location.href="/employment/certificate?menuId=cybJobHun";
                           });
         }
      });
   })
})
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
      url: "/employment/certificateAjax", //ajax용 url 변경
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
            str += `취득한 자격등이 없습니다`;
         }
         
         $.each(result.content, function(idx, certificateVO){
            console.log("idx",idx);
            console.log("CertificateVO",certificateVO);
            str+=listDisp(certificateVO);
         });
         
         $(".clsPagingArea").html(result.pagingArea);
         
         $(".searchResult").html(str);
      }
   });
}
function listDisp(certificateVO){
   const card=`<div class='col-12 col-sm-6 col-md-4 d-flex align-items-stretch flex-column'>
                     <div id='eachDisp' class='card bg-light d-flex flex-fill'>
                     <div id='changeDisp' style='display: block;'>
                     <div class='card-header text-muted border-bottom-0'>
                     <div class='row' style='margin-top: 10px;'>
                     <h2 class='lead' align='center'
                     style='font-weight: bold; font-size: x-large; margin: auto;justify-content: center;'>
                     <b>\${certificateVO.certNm}</b>
                     </h2>
                     <button type='button' class='btn-tool align-self-start text-muted'
                     style='background-color: white; border: none;' value='\${certificateVO.certCode}' onclick='btnCertificateDelete(this)'>
                     <i class='fas fa-times'></i>
                     </button>
                     </div>
                     </div>
                     <div class='card-body pt-0'>
                     <div class=''>
                     <div style='margin-top: 15px;'>
                     <p class='text-muted text-sm' class='certCode'>
                     <b>자격증 코드 :</b>\${certificateVO.certCode}
                     </p>
                     <p class='text-muted text-sm'>
                     <b>취&nbsp;&nbsp;&nbsp;&nbsp;득&nbsp;&nbsp;&nbsp;&nbsp;일&nbsp;&nbsp; :
                     &nbsp;&nbsp;</b>\${certificateVO.certDateDisplay}
                     </p>
                     <div style='text-align: center;'>
                     <p class='text-muted text-sm'>
                     위 자격을 취득 하였음을 증명합니다.
                     </p>
                     <p class='text-muted text-sm'>
                     \${certificateVO.certDateExpDisplay}
                     </p>
                     </div>
                     </div>
                     </div>
                     </div>
                     </div>
                     <div id='editModeDisp' style='display: none;'>
                     <form action='#' method='post'>
                     <div class='card-header text-muted border-bottom-0'>
                     <div class='row' style='margin-top: 10px;'>
                     <h2 class='lead' align='center'
                     style='font-weight: bold; font-size: x-large; margin: auto;justify-content: center;'>
                     <b><input type='text' class='form-control col-9 certNm' value='\${certificateVO.certNm}'></b>
                     </h2>
                     <button type='button' class='btn-tool align-self-start text-muted'
                     style='background-color: white; border: none;'>
                     <i class='fas fa-times'></i>
                     </button>
                     </div>
                     </div>
                     <div class='card-body pt-0'>
                     <div class=''>
                     <div style='margin-top: 15px;'>
                     <p class='text-muted text-sm'>
                     <b>자격증 코드 :</b><input type='text' class='form-control form-control-sm col-5 certCode'
                     value='\${certificateVO.certCode}' readonly>
                     </p>
                     <p class='text-muted text-sm'>
                     <b>취&nbsp;&nbsp;&nbsp;&nbsp;득&nbsp;&nbsp;&nbsp;&nbsp;일&nbsp;&nbsp; :
                     &nbsp;&nbsp;</b><input type='date' class='form-control form-control-sm col-7 certDate'
                     value='\${certificateVO.certDateDisplay}'>
                     </p>
                     <div style='text-align: center;'>
                     <p class='text-muted text-sm'>
                     위 자격을 취득 하였음을 증명합니다.
                     </p>
                     <p class='text-muted text-sm'>
                     <input type='date' class='form-control form-control-sm col-7 certDateExp'
                     name='certDateExp' value='\${certificateVO.certDateExpDisplay}'>
                     </p>
                     </div>
                     </div>
                     </div>
                     </div>
                     </form>
                     </div>
                     <div class='card-footer'>
                     <button class='btn btn-app btnEdit' id='btnEdit' style='border: none;float: right;'
                     onclick='editMode(this)'>
                     <i class='fas fa-edit'></i> 수정
                     </button>
                     <!-- 수정모드 -->
                     <div id='editMode' class='editMode' style='display: none;'>
                     <button class='btn btn-app' id='btnEditCalcel' style='border: none;float: right;'
                     onclick='readonlyOnly(this)'>
                     <!-- <i class='fas fa-edit'></i> 취소 -->
                     취소
                     </button>
                     <button type='button' class='btn btn-app' id='btnEditSave' style='border: none;float: right;'
                     onclick='btnUpdateSubmit(this)'>
                     <!-- <i class='fas fa-edit'></i> 확인 -->
                     확인
                     </button>
                     </div>
                     <!-- 수정모드end -->
                     </div>
                     </span>
                     </div>
                     </div>`;
   return card;
}

</script>
   
<h3>자격증 내역</h3>

<h5>자격증 총 <span style="color: red;">${certificateCount}</span>개 </h5>
<br>
   <div class="card card-solid">
      <div class="card-body pb-0"
         style="overflow: auto; width: auto; height: auto;">
         <div class="brd-search">
            <select title="검색 조건 선택" id="searchCnd" name="searchCnd" class="form-control rjatorwhrjs"
               style="width: 130px; height: 33px; float: left; margin: 0px 5px 0px 0px;">
                   <option value="" selected disabled>정렬조건</option>
                   <option value="1">자격증명</option>
                   <option value="2">취득일</option>
                   <option value="3">발급일</option>
            </select>
         </div>
         <div class="input-group input-group-sm divSearch">
            <input type="text" name="table_search" class="form-control float-left" placeholder="검색어를 입력하세요">
            <div class="input-group-append">
                <button type="button" class="btn btn-default" id="btnSearch">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
         <button type="button" id="btnVolAdd" class="btn btn-block btn-primary wkrtjdBut" data-toggle="modal" data-target="#modal-lg"onclick="userName()">자격증 등록</button>
      </div>
         
      <div class="card-body pb-0"
         style="overflow: auto; width: auto; height: auto;">
         <!-- <div class="row searchResult"> -->
         <div class="searchResult" style="display: flex;flex-wrap: wrap;">
            <c:forEach var="certificateVO" items="${articlePage.content}" varStatus="stat">
               <div class="col-12 col-sm-6 col-md-4 d-flex align-items-stretch flex-column">
                  <div id="eachDisp" class="card bg-light d-flex flex-fill">
                        <div id="changeDisp" style="display: block;">
                           <div class="card-header text-muted border-bottom-0">
                              <div class="row" style="margin-top: 10px;">
                                 <h2 class="lead" align="center"
                                    style="font-weight: bold; font-size: x-large; margin: auto;justify-content: center;">
                                    <b>${certificateVO.certNm}</b>
                                 </h2>
                                 <button type="button" class="btn-tool align-self-start text-muted"
                                    style="background-color: white; border: none;" value="${certificateVO.certCode}" onclick="btnCertificateDelete(this)">
                                    <i class="fas fa-times"></i>
                                 </button>
                              </div>
                           </div>
                           <div class="card-body pt-0">
                              <div class="">
                                 <div style="margin-top: 15px;">
                                    <p class="text-muted text-sm" class="certCode">
                                       <b>자격증 코드 :</b>${certificateVO.certCode}
                                    </p>
                                    <p class="text-muted text-sm">
                                       <b>취&nbsp;&nbsp;&nbsp;&nbsp;득&nbsp;&nbsp;&nbsp;&nbsp;일&nbsp;&nbsp; :
                                          &nbsp;&nbsp;</b>${certificateVO.certDateDisplay}
                                    </p>
                                    <div style="text-align: center;">
                                       <p class="text-muted text-sm">
                                          위 자격을 취득 하였음을 증명합니다.
                                       </p>
                                       <p class="text-muted text-sm">
                                          ${certificateVO.certDateExpDisplay}
                                       </p>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div id="editModeDisp" style="display: none;">
                           <form action="#" method="post">
                              <div class="card-header text-muted border-bottom-0">
                                 <div class="row" style="margin-top: 10px;">
                                    <h2 class="lead" align="center"
                                       style="font-weight: bold; font-size: x-large; margin: auto;justify-content: center;">
                                       <b><input type='text' class='form-control col-9 certNm' value='${certificateVO.certNm}'></b>
                                    </h2>
                                    <button type="button" class="btn-tool align-self-start text-muted"
                                       style="background-color: white; border: none;">
                                       <i class="fas fa-times"></i>
                                    </button>
                                 </div>
                              </div>
                              <div class="card-body pt-0">
                                 <div class="">
                                    <div style="margin-top: 15px;">
                                       <p class="text-muted text-sm">
                                          <b>자격증 코드 :</b><input type='text' class='form-control form-control-sm col-5 certCode'
                                             value='${certificateVO.certCode}' readonly>
                                       </p>
                                       <p class="text-muted text-sm">
                                          <b>취&nbsp;&nbsp;&nbsp;&nbsp;득&nbsp;&nbsp;&nbsp;&nbsp;일&nbsp;&nbsp; :
                                             &nbsp;&nbsp;</b><input type='date' class='form-control form-control-sm col-7 certDate'
                                             value='${certificateVO.certDateDisplay}'>
                                       </p>
                                       <div style="text-align: center;">
                                          <p class="text-muted text-sm">
                                             위 자격을 취득 하였음을 증명합니다.
                                          </p>
                                          <p class="text-muted text-sm">
                                             <input type='date' class='form-control form-control-sm col-7 certDateExp'
                                                name='certDateExp' value='${certificateVO.certDateExpDisplay}'>
                                          </p>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </form>
                        </div>
                        <div class="card-footer">
                           <button class="btn btn-app btnEdit" id="btnEdit" style="border: none;float: right;"
                              onclick="editMode(this)">
                              <i class="fas fa-edit"></i> 수정
                           </button>
                           <!-- 수정모드 -->
                           <div id="editMode" class="editMode" style="display: none;">
                              <button class="btn btn-app" id="btnEditCalcel" style="border: none;float: right;"
                                 onclick="readonlyOnly(this)">
                                 <!-- <i class="fas fa-edit"></i> 취소 -->
                                 취소
                              </button>
                              <button type="button" class="btn btn-app" id="btnEditSave" style="border: none;float: right;"
                                 onclick="btnUpdateSubmit(this)">
                                 <!-- <i class="fas fa-edit"></i> 확인 -->
                                 확인
                              </button>
                           </div>
                           <!-- 수정모드end -->
                        </div>
                     </span>
                  </div>
               </div>
         	</c:forEach>
         </div>
      </div>
      <p>
	<div class="modal fade" id="modal-lg">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">자격증 등록</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
            <form action="#" method="post">
               <div class="modal-body">
                  <p>자격증 이름 : <input type="text" id="certNm" name="certNm" class="form-control col-5" placeholder="자격증 이름"
                        required /></p>
                  <p>자격증 코드 : <input type="text" id="certCode" name="certCode" class="formdata form-control col-5"
                        placeholder="자격증 코드" required /></p>
                  <p>성&nbsp;&nbsp;&nbsp;&nbsp;명: <input type="text" id="userName" name="userName"
                        class="formdata form-control col-5" value="${articlePage.content[0].userInfoVOList.userName} " readonly />
                  </p>
                  <p>취&nbsp;&nbsp;득&nbsp;&nbsp;일 : <input type="date" id="certDate" name="certDate"
                        class="formdata form-control col-5" required /></p>
                  <p>발&nbsp;&nbsp;급&nbsp;&nbsp;일 : <input type="date" id="certDateExp" name="certDateExp"
                        class="formdata form-control col-5" required /></p>
               </div>
               <sec:csrfInput />
            </form>
				<div class="modal-footer justify-content-between">
					<button type="button" lass="btn btn-default" data-dismiss="modal" style="border: none;"></button>
					<button type="button" id="btnCertificateAdd" class="btn btn-primary">등록</button>
				</div>
			</div>
		</div>
	</div>
	</p>

   </div>
   <div class="row clsPagingArea">
      ${articlePage.pagingArea}
  </div>