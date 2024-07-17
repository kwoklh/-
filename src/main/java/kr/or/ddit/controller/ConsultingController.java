package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 
 * @author PC-31
 * 학생의 사이버캠퍼스 > 상담내역
 */

@RequestMapping("/consulting")
@Controller
public class ConsultingController {
	
	@GetMapping("/list")
	public String list() {
		
		return "consulting/list";
	}
}
