<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- Custom fonts for this template-->
    <link href="/resources/sbadmin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/sbadmin/css/sb-admin-2.min.css" rel="stylesheet">
    <!-- sweetalert2 js -->
    <script type="text/javascript" src="/resources/	js/sweetalert2.min.js"></script>
    <!-- sweetalert2 css -->
    <link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<body>
<div style="margin:100px 300px 100px 300px;">
	<h3><img src="resources/images/emblem2.png" style="margin-right:10px; width:40px; height: 40px;">
	대덕인재대학교 | 학사관리시스템</h3>
</div>
<div class="login-box">
	<%
	String errorAlert = request.getParameter("error")==null?"1":"0";
	%>
<%-- 	<c:set var="error" value="<%=error%>" /> --%>
	<c:set var="errorAlert" value="<%=errorAlert%>" />
   <div class="card" style="margin:200px 300px 200px 300px;">
      <div class="card-body login-card-body" style="margin:0 auto;">
      	<div style="float:left;border-right: 3px #a1a9a0 solid;padding-right: 50px;">
         <p class="login-box-msg">Sign in to start your session</p>
         <form action="/login" method="post">
            <div class="input-group mb-3">
            <!-- 아이디 -->
               <input type="text" name="username" id="username" class="form-control" placeholder="아이디">
               <div class="input-group-append">
                  <div class="input-group-text">
                     <span class="fas fa-envelope"></span>
                  </div>
               </div>
            </div>
            <div class="input-group mb-3">
            <!-- 비밀번호 -->
               <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호">
               <div class="input-group-append">
                  <div class="input-group-text">
                     <span class="fas fa-lock"></span>
                  </div>
               </div>
            </div>
           <div class="row">
               <div class="col-8">
               </div>
               <div class="col-4">
                  <button type="submit" class="btn btn-success">SignIn</button>
               </div>
            </div>
        
            <!--  csrf : Cross Site Request Forgery -->
           <sec:csrfInput/>
           </form>
          </div>
         <div style="float:left;margin:50px;">
         	<p style="cursor: pointer;">학번/사번찾기
         		<i class="fas fa-search"></i>
         	</p>
         	<p style="cursor: pointer;">비밀번호 찾기
         		<i class="fas fa-lock"></i>
         	</p>
         </div>
      </div>
   </div>
</div>
<div style="background-color:#053828; height:185px;">
	<p style="margin:0 auto;" class="text-center">시스템 문의 : 042-272-2727</p>
</div>
<script type="text/javascript">
let error = "${errorAlert}";//0이면 로그인실패

if(error=="0"){
	const Toast = Swal.mixin({
		  toast: true,
		  position: "center",
		  showConfirmButton: false,
		  timer: 1300,
		  timerProgressBar: true,
		  didOpen: (toast) => {
		    toast.onmouseenter = Swal.stopTimer;
		    toast.onmouseleave = Swal.resumeTimer;
		  }
		});
		Toast.fire({
		  icon: "error",
		  title: "아이디 혹은 비밀번호를 잘못 입력하셨습니다."
		});
}
</script>
</body>