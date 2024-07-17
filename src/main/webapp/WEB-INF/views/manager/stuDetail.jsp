<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel='stylesheet' href='/stylesheets/style.css' />
    <!-- jquery -->
    <script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
    <script src="/javascript/popup_2.js"></script>
<style>
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
#save {
  border: 3px solid #28A745;
  background-color: white;
  width: 100px;
  margin-top: 20px;
  margin-right: 10px;
}
#cancel {
  border: 3px solid #6C757D;
  background-color: white;
  width: 100px;
  margin-top: 20px;
  margin-left: 10px;
}
</style>
<script>
$(function(){
	console.log('집 ㄱ?????????????????')
	let stNo = $('input[name="stNo"]').val();
	// 군필 여부
	let militaryService = $('select[name="militaryService"]');
	let militaryStat;
	// 학적 상태(재학, 휴학 등..)
	let stStat = $('input[name="stStat"]').val();
	// 학년
	let stGrade = $('input[name="stGrade"]').val();
	// 입학일
	let admissionDate = $('input[name="admissionDate"]').val();
	// 졸업일
	let stGradDate = $('input[name="stGradDate"]').val();
			
	if(militaryService.val() == 'unfulfilled'){
			militaryStat = '미필';
		} else {
			militaryStat = '군필';
		}
	
	// 수정 버튼 클릭
	$('#modify').on('click', function(){
		$('.formdata').removeAttr('readonly')
		$('.custom-select').removeAttr('disabled')

		$('#p1').css('display','none');
		$('#p2').css('display','block');
	})
	
	// 취소 버튼 클릭
	$('#cancel').on('click', function(){
		$('.formdata').attr('readonly', true)
		$('.custom-select').attr('disabled', true)
		
		console.log(militaryStat)

		$('#p1').css('display','block');
		$('#p2').css('display','none');
		
		$("input[name='stNo']").val(stNo);
		$("select[name='militaryService']").val(militaryStat);
		$('input[name="stStat"]').val(stStat)
		$('input[name="stGrade"]').val(stGrade);
		$('input[name="admissionDate"]').val(admissionDate);
		$('input[name="stGradDate"]').val(stGradDate);
	})

	// 저장 버튼 클릭
	$('#save').on('click', function(){
		let data = {
			stNo,
			militaryService : militaryStat,
			stStat,
			stGrade,
			admissionDate,
			stGradDate
		};

		console.log(data);
		
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
                	url:"/admin/updateAjax",
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
	        				$('.formdata').attr('readonly', true)
	        				$('.custom-select').attr('disabled', true)
	
	        				$('#p1').css('display','block');
	        				$('#p2').css('display','none');
						}        				
        			}                	
                });
                Swal.fire({
                    title: "수정되었습니다!",
                    icon: "info"
                });
            }
        });
		
		
		
	})
})
</script>
<h3>학생 상세 정보 조회</h3>
<div class="container-fluid">
	<div class="card card-solid">
		<div class="card-body pb-0"
			style="overflow: auto; width: 1639px; height: 400px;">
			<div class="row">
				<div class="col-12 col-6 d-flex align-items-stretch flex-column">

					<div class="card-body pt-6">
						<div class="row">
							<div class="col-3 text-center">
								<img src="../../../resources/images/mm.jpg"
									alt="user-avatar" class="img-square img-fluid">
							</div>
								<div class="col-9">
									<p class="text-muted text-sm">
										<label for="stNo">학번 :&nbsp;</label>
										<input class="col-2 form-control" name="stNo" id="stNo" type="text" value="${studentDetail.stNo}" readonly>
										<label for="stName">&nbsp;학생명 :&nbsp;</label>
										<input class="col-1 form-control" id="stName" type="text" value="${studentDetail.userInfoVO.userName}" readonly>
										<label for="stTel">&nbsp;연락처 :&nbsp;</label>
										<input class="col-2 form-control" id="stTel" type="text" value="${studentDetail.userInfoVO.userTel}" readonly>
										<label for="custon-select">&nbsp;군필 여부&nbsp;</label>
										<select class="custom-select col-2 form-control" name="militaryService" disabled>
											<option value="unfulfilled" <c:if test="${studentDetail.militaryService eq '군필'}">selected="selected"</c:if> >미필</option>
											<option value="fulfilled" <c:if test="${studentDetail.militaryService eq '군필'}">selected="selected"</c:if> >군필</option>
										</select>
									</p>
									<p class="text-muted text-sm">
										<label for="stPostNo">&nbsp;우편번호 :&nbsp;</label>
										<input class="col-1 form-control" id="stPostNo" type="text" value="${studentDetail.stPostno}" readonly>
										<label for="stPost">&nbsp;주소 :&nbsp;</label>
										<input class="col-6 form-control" id="stPost" type="text" value="${studentDetail.stAddr}" readonly>
									</p>
									<p class="text-muted text-sm">
										<label for="stPostDt">&nbsp;상세 주소 :&nbsp;</label>
										<input class="col-8 form-control" id="stPostDt" type="text" value="${studentDetail.stAddrDet}" readonly>
									</p>
									<p class="text-muted text-sm">
										<label for="stUniv">&nbsp;소속 대학 :&nbsp;</label>
										<input class="col-2 form-control" id="stUniv" type="text" value="대덕인재대학교" readonly>
										<label for="stCollege">&nbsp;단과대학 :&nbsp;</label>
										<input class="col-2 form-control" name="comCodeName" id="comCodeName" type="text" value="${studentDetail.comCodeVO.comCodeName}" readonly>
										<label for="stDept">&nbsp;학과 :&nbsp;</label>
										<input class="col-3 form-control" name="comDetCodeName" id="comDetCodeName" type="text" value="${studentDetail.comDetCodeVO.comDetCodeName}" readonly>
									</p>
									<p class="text-muted text-sm">
										<label for="stStat">&nbsp;학적 상태 :&nbsp;</label>
										<input class="col-1 form-control formdata" name="stStat" id="stStat" type="text" value="${studentDetail.studentStatVO.stStat}" readonly>
										<label for="stGrade">&nbsp;학년 :&nbsp;</label>
										<input class="col-1 form-control formdata" name="stGrade" id="stGrade" type="text" value="${studentDetail.stGrade}" readonly>
										<label for="stAddmDate">&nbsp;입학일 :&nbsp;</label>
										<input class="col-3 form-control formdata" name="admissionDate" id="admissionDate" type="date" value="${studentDetail.admissionDate}" readonly>
										<label for="stGradDate">&nbsp;졸업일 :&nbsp;</label>
										<input class="col-3 form-control formdata" name="stGradDate" id="stGradDate" type="date" value="${studentDetail.admissionDate}" readonly>
									</p>
									<p class="text-muted text-sm">
										<label for="stBank">&nbsp;은행명 :&nbsp;</label>
										<input class="col-2 form-control" id="stBank" type="text" value="${studentDetail.stBank}" readonly>
										<label for="stDeposit">&nbsp;예금자 :&nbsp;</label>
										<input class="col-2 form-control" id="stDeposit" type="text" value="${studentDetail.userInfoVO.userName}" readonly>
										<label for="stAccountNm">&nbsp;계좌번호 :&nbsp;</label>
										<input class="col-3 form-control" id="stAcount" type="text" value="${studentDetail.stAcount}" readonly>
									</p>
								</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="text-center">
	<p id="p1">
		<button type="button" class="btn" id="modify">수정</button>
		<button type="button" class="btn" id="list" onclick="location.href='/admin/stdList'">목록</button>
	</p>
	<p id="p2" style="display: none;">
		<button type="button" class="btn" id="save">저장</button>
		<button type="button" class="btn" id="cancel">취소</button>
	</p>
</div>