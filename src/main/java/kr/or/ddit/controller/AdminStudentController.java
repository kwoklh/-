package kr.or.ddit.controller;

import java.util.HashMap;
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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.service.AdminStudentService;
import kr.or.ddit.service.ManagerEmpService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.SchoolEmployeeVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.VolunteerVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author PC-11
 * 관리자 - 학생 조회
 */
@Controller
@Slf4j
@RequestMapping("/manager")
public class AdminStudentController {
	
	@Autowired
	AdminStudentService adminStudentService;
	
	@Autowired
	ManagerEmpService managerEmpService;
	
	// 관리자 - 학생 조회
	@GetMapping("/stuList")
	public String stuList(Model model
			, @RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage) {
		log.info("관리자 - 학생 관리 " + currentPage);
		Map<String,Object> map = new HashMap<String, Object>(); 
		map.put("currentPage", currentPage);
		
		List<ComDetCodeVO> deptList = this.adminStudentService.deptList();
//		log.info("deptList >>> " + deptList);
		model.addAttribute("deptList", deptList);
		
		return "manager/stuList";
	}
	
	// 학과 선택 후 학생 리스트 출력 AJAX
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<StudentVO> listAjax(Model model
			, @RequestBody Map<String, Object> map) {
		log.info("학과 별 학생 Ajax >>>>>>> " + map);
		
		int total = this.adminStudentService.getTotal();
//		log.info("total >> " + total);
		
		List<StudentVO> stdList = this.adminStudentService.stdList(map);
//		log.info("stdList >>> " + stdList);
		
		return new ArticlePage<StudentVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, stdList, null, null);
	}
	
	// 학생 상세 정보 조회
	@GetMapping("/stuDetail")
	public String detail(Model model, String stNo) {
		//detail 페이지 : 1651001
		log.info("detail 페이지 : " + stNo);
		
		StudentVO studentDetail = this.adminStudentService.detail(stNo);
//		log.info("학생 상세 정보 >>> " + studentDetail);
		
		model.addAttribute("studentDetail", studentDetail);
		
		return "manager/stuDetail";
	}
	
	// 학생 정보 수정
	@ResponseBody
	@PostMapping("/updateAjax")
	public int updateAjax(@RequestBody Map<String, Object> map) {
		log.info("updateAjax >> " + map);
		
		int result = this.adminStudentService.updateStd(map);
//		log.info("result1 >> : " + result);
		result += this.adminStudentService.updateStdStat(map);
//		log.info("result2 >>>> : " + result);
		
		return result;
	}
	
	// 신입생 추가
	@GetMapping("/stuAdd")
	public String stdAdd(Map<String, Object> map, Model model) {
		log.info("신입생 추가 페이지");
		
		// 단과대학 불러오기
		List<ComCodeVO> comCodeVOList = this.adminStudentService.getCollege();
		model.addAttribute("comCodeVOList",comCodeVOList);
		
		return "manager/stuAdd";
	}
	
	// 학과 교수 목록
	@ResponseBody
	@PostMapping("/getProfList")
	public List<ProfessorVO> getProfList(@RequestBody Map<String, Object> map) {
		log.info("학과 교수 목록 >>> " + map);
		
		List<ProfessorVO> profList = this.adminStudentService.getProfList(map);
		return profList;
	}
	
	// 학번 자동 생성
	@ResponseBody
	@PostMapping("/getStNo")
	public String getStNo(@RequestBody Map<String, Object> map) {
		
		String stNo = this.adminStudentService.getStNo(map);
		
		return stNo;
	}
	
	// 단과대학 코드를 통해 학과 출력
	@ResponseBody
	@PostMapping("/getDept")
	public List<ComDetCodeVO> getDept(@RequestBody Map<String, Object> map){
		log.info("getDept >>> " + map);
		
		List<ComDetCodeVO> deptList = this.adminStudentService.getDept(map);
//		log.info("deptList >>>>>> " + deptList);
		
		return deptList;
	}
	
	@ResponseBody
	@PostMapping("/stuAdd")
	public String stuAdd(StudentVO studentVO) {
		log.info("stuAdd >>>>> " + studentVO);
		
		int result = this.adminStudentService.stuAdd(studentVO);
		log.info("신입생 추가 성공??? >>> " + result);
		
		return "result";
	}
	
	// 교직원 조회
	@GetMapping("/schEmployeeList")
	public String schEmployeeList(Model model
			, @RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage
			, @RequestParam(value="keyword",required=false,defaultValue="") String keyword
			, @RequestParam(value="searchCnd", required = false, defaultValue = "") String searchCnd) {
		log.info("교직원 조회 페이지 >>>>> ");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		map.put("searchCnd", searchCnd);
		
//		log.info("schEmpList - Map >> " + map);
		
		List<SchoolEmployeeVO> empList = this.managerEmpService.empList(map);
		int getTotal = this.managerEmpService.getTotal(map);
//		log.info("empList >>> " + empList);
//		log.info("getTotal >>> " + getTotal);
		
		model.addAttribute("articlePage", new ArticlePage<SchoolEmployeeVO>(getTotal, currentPage, 10, empList, keyword, searchCnd));
		
		return "manager/schEmployeeList";
	}
	
	@ResponseBody
	@PostMapping("/emplistAjax")
	public ArticlePage<SchoolEmployeeVO> emplistAjax(@RequestBody Map<String,Object> map) {
		log.info("listAjax");
		log.info("list->map : " + map);
		
		//전체 행수
		int getTotal = this.managerEmpService.getTotal(map);
//		log.info("listAjax->total : " + getTotal);
		
		//목록
		List<SchoolEmployeeVO> empList = this.managerEmpService.empList(map);
//		log.info("nVOList : " + empList);
		
		return new ArticlePage<SchoolEmployeeVO>(getTotal, Integer.parseInt(map.get("currentPage").toString()), 10, empList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	// 교직원 추가
	@GetMapping("/schEmployeeAdd")
	public String schEmployeeAdd(Model model) {
		log.info("교직원 추가 페이지");
		
		List<ComCodeVO> univList = this.adminStudentService.getCollege();
//		log.info("univList >>>>>> " + univList);
		
		model.addAttribute("univList",univList);
		
		return "manager/schEmployeeAdd";
	}
	
	// 교직원 번호 자동 입력
	@ResponseBody
	@PostMapping("/schEmNo")
	public String schEmNo(@RequestBody Map<String, Object> map) {
		log.info("교직원 번호 자동 완성" + map);
		
		String schEmNo = this.managerEmpService.schEmNo(map);
//		log.info("교직원 번호 자동 완성 : " + schEmNo);
		
		return schEmNo;
	}
	
	// 교직원 추가
	@ResponseBody
	@PostMapping("/createSchEmAjax")
	public int createSchEmAjax(@RequestBody Map<String, Object> map) {
		log.info("교직원 추가" + map);
		
		int result = this.managerEmpService.createAjax(map);
//		log.info("교직원 추가 : " + result);
		
		return result;
	}
	
	// 교직원 통계
	@GetMapping("/schEmployeeStat")
	public String schEmployeeStat(Model model) throws JsonProcessingException {
		log.info("교직원 통계 페이지");
		
		List<Map<String, Object>> salaryList = this.managerEmpService.salaryList();
//		log.info("salaryList >>>>>>>>>> " + salaryList);
		
		List<Map<String, Object>> univList = this.managerEmpService.univList();
//		log.info("univList >>>>>>>>>> " + univList);
		
		ObjectMapper objectMapper = new ObjectMapper();
        String salaryListJson = objectMapper.writeValueAsString(salaryList);
        String univListJson = objectMapper.writeValueAsString(univList);
//        log.info("salaryListJson >>>>>>>>>> " + salaryListJson);
//        log.info("univListJson >>>>>>>>>> " + univListJson);

        model.addAttribute("salaryListJson", salaryListJson);
        model.addAttribute("univListJson", univListJson);
		
		return "manager/schEmployeeStat";
	}
}
