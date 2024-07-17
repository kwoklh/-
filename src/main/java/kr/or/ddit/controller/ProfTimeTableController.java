package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.ProfTimeTableService;
import kr.or.ddit.vo.LectureVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author PC-11
 * 교수 - 강의시간표
 */
@Controller
@Slf4j
@RequestMapping("/profLecture")
public class ProfTimeTableController {
	@Autowired
	ProfTimeTableService profTimeTableService;
	
	String userNo = "";
	
	@GetMapping("/list")
	public String timeTeble() {
		
		return "profLecture/list";
	}
	
	@ResponseBody
	@GetMapping("/listAjax")
	public List<LectureVO> listAjax(){
		userNo = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("교수 - 강의시간표");
		
		List<LectureVO> profLecList = this.profTimeTableService.profLecList(userNo);
		return profLecList;
	}
}
