package kr.or.ddit.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;

//인증(로그인) 전에 접근을 시도한 URL로 리다이렉트하는 기능을 가지고 있음
//스프링 시큐리티에서 기본적으로 사용되는 구현 클래스임
@Slf4j
public class CustomLoginSuccessHandler extends 
	SavedRequestAwareAuthenticationSuccessHandler {
	//요청파라미터 : {username=admin,password=java}
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request
			, HttpServletResponse response,
			Authentication auth) throws ServletException, IOException {
		//******
		User customUser = (User)auth.getPrincipal();
		log.info("username : " + customUser.getUsername());//admin
		
		//admin 아이디가 갖고 있는 권한(role) 목록
		List<String> roleNames = new ArrayList<String>();
		auth.getAuthorities().forEach(authority->{
			roleNames.add(authority.getAuthority());
		});
		
		log.info("roleNames : " + roleNames);
		
		if(roleNames.contains("ROLE_ADMIN")) {
			//관리자
			response.sendRedirect("/mainPage/mainAdmin");
			return;
		}
		
		if(roleNames.contains("ROLE_PROFESSOR")) {
			//회원 로그인
			response.sendRedirect("/mainPage/mainPro");
			return;
		}
		
		if(roleNames.contains("ROLE_STUDENT")) {
			//회원 로그인
			response.sendRedirect("/mainPage/mainStu");
			return;
		}
		
		//부모(super)에게 반납
		super.onAuthenticationSuccess(request, response, auth);
	}
}
