package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/stats")
@Slf4j
@Controller
public class StatsController {

	
	// 학과 별 남녀 성비 조회(채연)
	@GetMapping("/gender")
	public String gender() {
		//forwarding
		return "stats/gender";
	}
	
	// 학과 별 학생 상태 조회(채연)
	@GetMapping("/studstat")
	public String studstat() {
		//forwarding
		return "stats/studstat";
	}
	
	
}
