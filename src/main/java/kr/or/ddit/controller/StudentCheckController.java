package kr.or.ddit.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.service.StudentCheckService;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;



/**
 * 
 * @author PC-06
 * 교수 > 학생 > 담당 학생 관리 > 담당 학생 정보 조회 or 디테일까지 	
 *
 */
@Controller
@RequestMapping("/student")
@Slf4j
public class StudentCheckController {
	
	@Autowired
	StudentCheckService StudentCheckService;
	
	
	//교수 - 학생 조회 페이지  
	@GetMapping("/stuList")
	public String stdlist(Map<String,Object> map, Model model) {
		// map = 교수번호(담당 학생)
		log.info("map >>>>>>> " + map);
		List<StudentVO> studentVOList 
		= this.StudentCheckService.list(map);
		log.info("list-> studentVOList : " + studentVOList);
		
		model.addAttribute("studentVOList" , studentVOList);
		//forwarding
		return "stdcheck/stdchk";
	}
	
	//요청URI : /stdcheck/stdDetail?stNo=A002
	//요청파라미터 :  stNo=A002
	//요청방식 : get
	//정보 조회 
	
	// 교수 - 학생 상세 정보 확인 페이지 
	@GetMapping("/stdDetail")
	public String stdDetail(StudentVO studentVO, Model model) {
		// studentVO.stNo = 학번
		//studentVO >>>>>>> StudentVO(stNo=A002, stGender=null, stPostno=0, stAddr=null, stAddrDet=null, stAcount=null, stBank=null, militaryService=null, stEmail=null, proChaNo=null, admissionDate=null, stGradDate=null, deptCode=null, stGrade=0, userInfoVO=null, comDetCodeVO=null, stuAttachFileVO=null)
		log.info("학번 : studentVO >>>>>>> " + studentVO);
		
		studentVO = this.StudentCheckService.stdDetail(studentVO);
		log.info("학번 : studentVO(후) >>>>>>> " + studentVO);
		
		model.addAttribute("studentVO" , studentVO);
		
		//forwarding
		return "stdcheck/stdDetail";
	}
	
	// 교수 - 정렬조건 [이름순 , 학년순] 서순 학생 정보 출력 
	@ResponseBody
	@PostMapping("/listAjax")
	public List<StudentVO> listAjax(@RequestBody Map<String, Object> map){
		log.info("listAjax >>> " + map);
		
		List<StudentVO> searchList = this.StudentCheckService.searchList(map);
		log.info("listAjax searchList >>>>>>> " + searchList);
		return searchList;
	}
	
	
}
	
	

