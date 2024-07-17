package kr.or.ddit.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("mainPage")
@Slf4j
@Controller
public class MainPageController {
	
	@GetMapping("/mainAdmin")
	public String mainAdmin() {
		return "mainPage/mainAdmin";
	}
	
	@GetMapping("/mainPro")
	public String mainPro() {
		return "mainPage/mainPro";
	}                                                                                                                                                                                                                                                                                                                                         
	
	@GetMapping("/mainStu")
	public String mainStu() {
		return "mainPage/mainStu";
	}
	
	@ResponseBody
	@GetMapping("/loginSessionPlus")
	public int loginSessionPlus(HttpSession session) {
		
		int sessionTime = session.getMaxInactiveInterval();
//		log.info("session 시간1 : ", sessionTime);
		
		session.setMaxInactiveInterval(1800);
		
		log.info("session 시간2 : ", sessionTime);
		
		return sessionTime;
	}
}
