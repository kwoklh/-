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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.AdminStudentService;
import kr.or.ddit.service.DeptMaintenanceService;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.ProfessorVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author PC-11
 * 관리자 - 학과 별 유지비
 */
@Controller
@Slf4j
@RequestMapping("manager")
public class DeptMaintenanceController {
	
	@Autowired
	AdminStudentService adminStudentService;
	
	@Autowired
	DeptMaintenanceService deptMaintenanceService;

	@GetMapping("/profSalary")
	public String profSalary(Model model) {
//		log.info("학과 별 교수 연봉");
		
		List<ComCodeVO> univList = this.adminStudentService.getCollege();
//		log.info("univList >>>>>> " + univList);
		
		model.addAttribute("univList",univList);
		
		return "manager/profSalary";
	}
	
	@ResponseBody
	@PostMapping("/deptAjax")
	public List<ComDetCodeVO> deptAjax(@RequestBody Map<String, Object> map){
		log.info("deptAjax" + map);
		
		List<ComDetCodeVO> deptList = this.deptMaintenanceService.getDeptList(map);
		log.info("deptList" + deptList);
		
		return deptList;
	}
	
	@ResponseBody
	@PostMapping("/dataAjax")
	public List<ProfessorVO> dataAjax(@RequestBody Map<String, Object> map){
		log.info("dataAjax" + map);
		
		List<ProfessorVO> dataList = this.deptMaintenanceService.getDataList(map);
		log.info("dataList >>> " + dataList);
		
		return dataList;
	}
	
	@GetMapping("/supportCost")
	public String supportCost(Model model) {
		log.info("항목 별 시설 지원 비용(유지비용)");
		
		List<ComCodeVO> univList = this.adminStudentService.getCollege();
		log.info("univList >>> " + univList);
		
		model.addAttribute("univList",univList);
		
		return "manager/supportCost";
	}
}
