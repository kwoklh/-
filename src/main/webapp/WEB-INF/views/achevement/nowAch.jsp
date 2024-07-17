<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
//<form action="/achieve/lecEvaluation">
$(function(){
	$(".evBtn").on("click",function(){
		console.log("버튼클릭");
		$("form").submit();
	});
});
</script>

<div class="h3Box" style="height:100px;">
	<h3 style="color:black;">현재 성적 조회</h3>
</div>
<div class="row" style="margin-top:40px; margin-bottom:50px;">
	<div class="col-12">
		<h5 style="color:black;">2023년도 1학기(4학년-정시학기)</h5>
	</div>
	<div class="col-12">
		<div class="card">
			<div class="card-body table-responsive p-0">
				<table class="table text-nowrap text-center">
					<thead style="background-color:#f6f9f6"> 
						<tr style="color:black;">
							<th>신청학점</th>
							<th>취득학점</th>
							<th>평점계</th>
							<th>평점평균</th>
							<th>재수강후평점평균</th>
							<th>백분위</th>
							<th>석차</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>21</td>
							<td>21</td>
							<td>72.5</td>
							<td>3.3</td>
							<td>3.3</td>
							<td>90.0</td>
							<td>12/28</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-12">
		<div class="card">
			<div class="card-body table-responsive p-0" style="height: 300px;">
				<form action="/achieve/lecEvaluation">
					<table class="table table-head-fixed text-nowrap text-center">
						<thead style="background-color:#f6f9f6;">
							<tr>
								<th>수강코드</th>
								<th>과목명</th>
								<th>학점</th>
								<th>이수구분</th>
								<th>등급</th>
								<th>이의신청</th>
								<th>강의평가</th>
							</tr>
						</thead>
						<tbody>
							<input type="hidden" name="stuLecNo" value="23123" />
							<tr>
								<td>23123</td>
								<td>모몽가의 이론</td>
								<td>3</td>
								<td>전공</td>
								<td>A+</td>
								<td><button type="button" class="btn btn-outline-warning exBtn">이의신청</button></td>
								<td><button type="button" class="btn btn-outline-primary evBtn">강의평가</button></td>
							</tr>
							<tr>
								<td>23123</td>
								<td>모몽가의 이론</td>
								<td>3</td>
								<td>전공</td>
								<td>A+</td>
								<td><button type="button" class="btn btn-outline-warning exBtn">이의신청</button></td>
								<td><button type="button" class="btn btn-outline-primary evBtn">강의평가</button></td>
							</tr>
							<tr>
								<td>23123</td>
								<td>모몽가의 이론</td>
								<td>3</td>
								<td>전공</td>
								<td>A+</td>
								<td><button type="button" class="btn btn-outline-warning exBtn">이의신청</button></td>
								<td><button type="button" class="btn btn-outline-primary evBtn">강의평가</button></td>
							</tr>
							<tr>
								<td>23123</td>
								<td>모몽가의 이론</td>
								<td>3</td>
								<td>전공</td>
								<td>A+</td>
								<td><button type="button" class="btn btn-outline-warning exBtn">이의신청</button></td>
								<td><button type="button" class="btn btn-outline-primary evBtn">강의평가</button></td>
							</tr>
							<tr>
								<td>23123</td>
								<td>모몽가의 이론</td>
								<td>3</td>
								<td>전공</td>
								<td>A+</td>
								<td><button type="button" class="btn btn-outline-warning exBtn">이의신청</button></td>
								<td><button type="button" class="btn btn-outline-primary evBtn">강의평가</button></td>
							</tr>
							<tr>
								<td>23123</td>
								<td>모몽가의 이론</td>
								<td>3</td>
								<td>전공</td>
								<td>A+</td>
								<td><button type="button" class="btn btn-outline-warning exBtn">이의신청</button></td>
								<td><button type="button" class="btn btn-outline-primary evBtn">강의평가</button></td>
							</tr>
							<tr>
								<td>23123</td>
								<td>모몽가의 이론</td>
								<td>3</td>
								<td>전공</td>
								<td>A+</td>
								<td><button type="button" class="btn btn-outline-warning exBtn">이의신청</button></td>
								<td><button type="button" class="btn btn-outline-primary evBtn">강의평가</button></td>
							</tr>
							<tr>
								<td>23123</td>
								<td>모몽가의 이론</td>
								<td>3</td>
								<td>전공</td>
								<td>A+</td>
								<td><button type="button" class="btn btn-outline-warning exBtn">이의신청</button></td>
								<td><button type="button" class="btn btn-outline-primary evBtn">강의평가</button></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="h3Box" style="margin-top:40px;">
	<h3>학적이의신청 목록</h3>
</div>
<div class="row">
	
	<div class="col-12">
		<div class="card timeline">
			<div style="padding:10px;">
				<i class="fas fa-check bg-green" 
				   style="
						color: #fff !important;
						background-color: #28a745 !important;
					    background-color: #adb5bd;
					    border-radius: 50%;
					    font-size: 16px;
					    height: 30px;
					    line-height: 30px;
					    text-align: center;
					    top: 0;
					    width: 30px;
					  	"
				></i>
				상세보기를 볼 경우 아래 과목을 선택하세요
			</div>
			<div class="card-body table-responsive p-0">
				<table class="table table-head-fixed text-nowrap text-center">
					<thead style="background-color:#f6f9f6;">
						<tr>
							<th>수강코드</th>
							<th>과목명</th>
							<th>학점</th>
							<th>이수구분</th>
							<th>등급</th>
							<th>이의신청</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>23123</td>
							<td>모몽가의 이론</td>
							<td>3</td>
							<td>전공</td>
							<td>A+</td>
							<td>대기</td>
						</tr>
						<tr>
							<td>23123</td>
							<td>모몽가의 이론</td>
							<td>3</td>
							<td>전공</td>
							<td>A+</td>
							<td style="color:blue;">승인</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>