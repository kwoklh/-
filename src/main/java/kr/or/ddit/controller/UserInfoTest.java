package kr.or.ddit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.service.UserInfoTestService;
import kr.or.ddit.vo.UserInfoVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/test")
@Slf4j
@Controller
public class UserInfoTest {
	
	@Autowired
	UserInfoTestService userInfoTestService;
	
	@GetMapping("/userInfo")
	public String userInfo(Model model) {
		
		log.info("userInfo에 왔다");
		UserInfoVO userInfoVO = userInfoTestService.detail("A001");
		log.info("userInfoVO : ", userInfoVO.getUserName());
		model.addAttribute("userInfoVO", userInfoVO);
		
		return "main/detail";
	}
}
