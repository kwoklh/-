package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/studstat")
@Slf4j
@Controller
public class StudentStatController {

	
	@GetMapping("/rest")
	public String tutionall() {
		//forwarding
		return "studentstat/rest";
	}
	

	
}
