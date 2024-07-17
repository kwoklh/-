package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

/**
 * @author PC-11
 * 관리자 - 학과 별 취업률
 */
@Controller
@Slf4j
@RequestMapping("/manager")
public class DeptEmpRateController {
	
	@GetMapping("empRate")
	public String empRate() {
		log.info("학과 별 취업률 페이지");
		
		return "manager/empRate";
	}
}
