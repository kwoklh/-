<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
h3 {
   color: black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 165px;
} 
.form-control{
  display:inline-block;
}
#modify {
  border: 3px solid #FFC107;
  background-color: white;	
  width: 100px;
  margin-top: 20px;
  margin-right: 10px;
}
#list {
  border: 3px solid #6C757D;
  background-color: white;
  width: 100px;
  margin-top: 20px;
  margin-left: 10px;
}
#cancel {
  border: 3px solid #6C757D;
  background-color: white;
  width: 100px;
  margin-top: 20px;
  margin-left: 10px;
}
.address {
	display: flex;
    flex-direction: row;
    align-items: baseline;
}
.img-fluid {
  width:240px;
  height:300px;
}
#save {
	margin-top: 20px;
	margin-left: auto;
	margin-right: auto;
}
.custom-file {
	margin-top: 20px;
	width: 240px;
}
p {
  margin-bottom: 25px;
}
</style>
<script>
$(function(){
	// 단과대학 코드를 통한 학과 select 불러오기
	let college = $('select[name="comCode"]');
	let dept;
	
	$('#stCollege').on('change', function(){
		let data = {
			"data":college.val()
		}
		
		$.ajax({
			url:"/manager/getDept",
			contentType:"application/json;charser='utf-8'",
			data:JSON.stringify(data),
			type:'post',
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log(result)
				
				let str = "";
				
				str += `<option class="dept" disabled selected>===== 선택  =====</option>`;
				$.each(result, function(idx, dept){
					str += "<option value="+dept.comDetCode+">"+dept.comDetCodeName+"</option>"
				});
				
				$("#stDept").html(str);

				dept = $('select[id="stDept"]')
			}
		})
	})
	
	$('#stDept').on('change', function(){
		
		let dept2 = {
			'dept':dept.val()
		}
		
		console.log(dept2)
		
		$.ajax({
			url:"/manager/getProfList",
			contentType:"application/json;charser='utf-8'",
			data:JSON.stringify(dept2),
			type:"POST",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log('result >>> ',result)
				
				let str = '';

				str += `<option disabled selected>--</option>`;
				$.each(result, function(idx, profVO){
					str += `<option value="\${profVO.userInfoVO.userNo}">\${profVO.userInfoVO.userName}</option>`
				})

				$('#proChaNo').html(str);
			}
		})
		
		let date = new Date();
		let year = date.getFullYear();
		
		let lastTwoDigits = year.toString().slice(-2);
		let deptTemp = '';
		
		console.log(lastTwoDigits)
		
		let firstPart = parseInt(dept.val().substring(1, 4), 10);  // D001 -> 1
	    let secondPart = parseInt(dept.val().substring(4, 7), 10); // 001 -> 1
	    deptTemp = lastTwoDigits+firstPart+secondPart
		
		let data = {
			'dept':deptTemp
		}
		
		console.log(data)
		
		$.ajax({
			url:"/manager/getStNo",
			contentType:"application/json;charser='utf-8'",
			data:JSON.stringify(data),
			type:"POST",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log('result >>> ',result)
				
				$('#stNo').val(result);
			}
		})
	})
	
	// 저장 버튼 클릭
	$('#save').on('click', function(){
		
		let formData = new FormData();
		
		let userName = $('#stName');
		let stDept = $('#stDept');
		let stNo = $('#stNo');
		let stGender = $('#stGender');
		let proChaNo = $('#proChaNo');
		let stTel = $('#stTel');
		let stEmail = $('#stEmail');
		let stPostNo = $('#stPostNo');
		let stPost = $('#stPost');
		let stPostDt = $('#stPostDt');
		let stBank = $('#stBank');
		let stAcount = $('#stAcount');

		console.log(userName.val(),', ',stDept.val(),', ',stNo.val(),', ',stGender.val(),', ',proChaNo.val(),', ',stTel.val(),
					', ',stEmail.val(),', ',stPostNo.val(),', ',stPost.val(),', ',stPostDt.val(),', ',stBank.val(),', ',stAcount.val())
		
		formData.append("stName", userName.val());
		formData.append("deptCode", stDept.val());
		formData.append("stNo", stNo.val());
		formData.append("stGender", stGender.val());
		formData.append("proChaNo", proChaNo.val());
		formData.append("stTel", stTel.val());
		formData.append("stEmail", stEmail.val());
		formData.append("stPostno", stPostNo.val());
		formData.append("stAddr", stPost.val());
		formData.append("stAddrDet", stPostDt.val());
		formData.append("stBank", stBank.val());
		formData.append("stAcount", stAcount.val());
					
		let inputFile = $("#uploadFile");
        let file = inputFile[0].files;
        console.log("file.length:" + file.length);
        for (let i = 0; i < file.length; i++) {
            formData.append("uploadFile", file[i]);
        }
        
//         for (const x of formData.entries()) {
//         	 console.log(x);
//        	};

		$.ajax({
			url:"/manager/stuAdd",
			processData: false,
            contentType: false,
            data: formData,
            type: "post",
            dataType: "text",
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success:function(result){
            	console.log(result)
            	
//             	Swal.fire({
//                     position: "center",
//                     icon: "success",
//                     title: "등록완료 되었습니다.",
//                     timer: 1800,
//                     showConfirmButton: false // 확인 버튼을 숨깁니다.
//                 }).then(() => {
//                     // Swal.fire의 타이머가 끝난 후 호출됩니다.
//                     location.href = "/employment/volunteer?menuId=cybJobHun";
//                 });
            }
			
		})
	})
	
	document.querySelector('#uploadFile').addEventListener('change', function (e) {
	    var fileName = document.getElementById("uploadFile").files[0].name;
	    var nextSibling = e.target.nextElementSibling;
	    nextSibling.innerText = fileName;
	});
	
    $("#uploadFile").on("change", handleImg);

    function handleImg(e) {
        let files = e.target.files;
        let fileArr = Array.prototype.slice.call(files);
        fileArr.forEach(function(f) {
            if (!f.type.match("image.*")) {
                alert("이미지 확장자만 가능합니다.");
                return;
            }
            let reader = new FileReader();
            $(".user-avatar").html("");
            reader.onload = function(e) {
//                 console.log(e.target.result);
                $(".user-avatar").attr("src", e.target.result);
            };
            reader.readAsDataURL(f);
        });
    } 
})

// 카카오 주소 api
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('stPostNo').value = data.zonecode;
            document.getElementById("stPost").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("stPostDt").focus();
        }
    }).open();
}
</script>
<h3>신입생 추가</h3>
<div class="container-fluid col-10">
	<div class="card card-solid">
		<div class="card-body pb-0 col-12">
			<div class="row">
				<div class="col-12 col-6 d-flex align-items-stretch flex-column">
					<div class="card-body pt-6">
						<form action="#" id="add">
							<div class="row">
								<div class="col-3 user-picture text-center">
									<img src="../../../resources/images/basic-profilePhoto.jpg"
										alt="user-avatar" class="img-square img-fluid user-avatar">
								    <div class="form-group text-center">
									    <div class="custom-file text-left">
									        <input type="file" name="stuAttaFile" class="custom-file-input" id="uploadFile">
									        <label class="custom-file-label" for="uploadFile">Choose file</label>
									    </div>
									 </div>
								</div>
								<div class="col-9">
									<p class="text-muted text-sm">
										<label for="stUniv">소속 대학 :&nbsp;</label>
										<input class="col-2 form-control" id="stUniv" type="text" value="대덕인재대학교" readonly>
										<label for="stCollege">&nbsp;단과대학 :&nbsp;</label>
										<select class="custon-select col-2 form-control" name="comCode" id="stCollege">
												<option disabled selected>=== 선택 ===</option>
											<c:forEach var="comCodeVO" items="${comCodeVOList}" varStatus="stat">
												<option value="${comCodeVO.comCode}">${comCodeVO.comCodeName}</option>
											</c:forEach>
										</select>
										<label for="stDept">&nbsp;학과 :&nbsp;</label>
										<select class="custon-select col-3 form-control" name="comDetCode" id="stDept">
											<option class="dept" disabled selected>===== 선택 =====</option>
										</select>
									</p>
									<p class="text-muted text-sm">
										<label for="stNo">학번 :&nbsp;</label>
										<input class="col-2 form-control" name="stNo" id="stNo" type="text" disabled>
										<label for="stName">&nbsp;학생명 :&nbsp;</label>
										<input class="col-2 form-control" name="userName" id="stName" type="text">
										<label for="stGender">&nbsp;성별 :&nbsp;</label>
										<select class="form-control col-2" name="stGender" id="stGender">
											<option disabled selected>--</option>
											<option value="male">남성</option>
											<option value="female">여성</option>
										</select>
										<label for="proChaNo">&nbsp;담당 교수 :&nbsp;</label>
										<select class="form-control col-2" name="proChaNo" id="proChaNo">
											<option disabled selected>--</option>
										</select>
									</p>
									<p class="text-muted text-sm">
										<label for="stTel">&nbsp;연락처 :&nbsp;</label>
										<input class="col-3 form-control" name="userTel" id="stTel" type="text">
										<label for="stEmail">이메일 :&nbsp;</label>
										<input class="col-4 form-control" name="stEmail" id="stEmail" type="email">
										
									</p>
									<p class="text-muted text-sm address">
										<label for="stPostNo">우편번호 :&nbsp;</label>
										<input type="text" class="col-2 form-control" name="stPostno" id="stPostNo" readonly style="margin-right:10px;">
										<input type="button" class="btn btn-block btn-outline-success col-2" value="우편번호 찾기" onclick="sample6_execDaumPostcode()">
									</p>
									<p class="text-muted text-sm">
									    <label for="stPost">주소 :&nbsp;</label>
									    <input type="text" class="col-4 form-control" name="stAddt" id="stPost">
										<label for="stPostDt">&nbsp;상세 주소 :&nbsp;</label>
									    <input type="text" class="col-5 form-control" name="stAddtDet" id="stPostDt">
									</p>
									<p class="text-muted text-sm">
									</p>
									<p class="text-muted text-sm">
										<label for="stBank">은행명 :&nbsp;</label>
										<input class="col-2 form-control" name="stBank" id="stBank" type="text">
										<label for="stDeposit">&nbsp;예금자 :&nbsp;</label>
										<input class="col-2 form-control" id="stDeposit" type="text">
										<label for="stAccountNm">&nbsp;계좌번호 :&nbsp;</label>
										<input class="col-3 form-control" name="stAcount" id="stAcount" type="text">
									</p>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="text-center">
	<p id="p1">
		<button type="button" class="btn btn-block btn-outline-success col-1" id="save">저장</button>
	</p>
</div>