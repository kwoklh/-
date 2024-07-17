package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/main")
@Slf4j
@Controller
public class MainController {

	
	// 학번/사번 찾기
	@GetMapping("/findId")
	public String tutionall() {
		//forwarding
		return "user/findid";
	}
	
	// 비번 찾기
	@GetMapping("/findPw")
	public String tutionpart() {
		return "user/findpw";
	}
	
	// 마이페이지 
	@GetMapping("/mypageDetail")
	public String tutionlist() {
		return "user/mypagedetail";
	}
	
	// 비밀번호 변경
	@GetMapping("/passwordChange")
	public String scolarship() {
		return "user/passwordchange";
	}
	

	
	
}
