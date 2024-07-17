package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.AdminStudentService;
import kr.or.ddit.service.LectureService;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StuLecCartVO;
import kr.or.ddit.vo.StuLectureVO;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author PC-11
 * 학생 - 수강신청 / 장바구니 / 강의편람
 */
@Controller
@Slf4j
@RequestMapping("/lecture")
public class LectureController {
	@Autowired
	LectureService lectureService;
	
	@Autowired
	AdminStudentService adminStudentService;
	
	String stNo = "";
	
	@GetMapping("/enrolment")
	public String enrolment(Authentication auth, Model model) {
		log.info("수강신청 페이지");
		
		stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		
		int junpil = this.lectureService.junpil(stNo);
		int junsun = this.lectureService.junsun(stNo);
		int gyopil = this.lectureService.gyopil(stNo);
		int gyosun = this.lectureService.gyosun(stNo);
		List<ComDetCodeVO> deptList = this.adminStudentService.deptList();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("junpil", junpil);
		map.put("junsun", junsun);
		map.put("gyopil", gyopil);
		map.put("gyosun", gyosun);

		
		model.addAttribute("hakjum",map);
		model.addAttribute("deptList",deptList);
		
		return "lecture/enrolment";
	}
	
	@ResponseBody
	@PostMapping("/searchLecEnrolment")
	public Map<String, Object> searchLecEnrolment(Model model, @RequestBody Map<String, Object> map){
		log.info("강의 검색 >>> " + map);
		
		Map<String, Object> map1 = new HashMap<String, Object>();
		
		// 신청 여부에 따른 버튼 출력 용도
		List<StuLecCartVO> cartList = this.lectureService.cartList(stNo);
		List<StuLectureVO> myLecList = this.lectureService.myLecList(stNo);
		
		List<LectureVO> lectureSearchList = this.lectureService.searchList(map); 
		map1.put("cartList", cartList);
		map1.put("lectureSearchList", lectureSearchList);
		map1.put("myLecList", myLecList);
//		log.info("searchLecAjax map1 >>> " + map1);
		
		return map1;
	}
	
	@ResponseBody
	@PostMapping("/lecList")
	public Map<String, Object> lecList (){
		log.info("강의 목록");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<ComDetCodeVO> deptList = this.adminStudentService.deptList();
		
		// 강의 목록
		List<LectureVO> lectureList = this.lectureService.list();
		
		List<StuLectureVO> myLecList = this.lectureService.myLecList(stNo);
		
		map.put("deptList", deptList);
		map.put("lectureList", lectureList);
		map.put("myLecList", myLecList);
		
//		log.info("강의목록 Map >>> " + map);
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/myCartList")
	public Map<String, Object> myCartList() {
		log.info("내 장바구니 조회");
		
		// 장바구니
		List<StuLecCartVO> cartList = this.lectureService.cartList(stNo);
//		log.info("cartList >>> " + cartList);
		
		List<StuLectureVO> myLecList = this.lectureService.myLecList(stNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cartList", cartList);
		map.put("myLecList", myLecList);
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/myStuLec")
	public Map<String, Object> myStuLec() {
		log.info("신청 강의 리스트");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<StuLectureVO> myLecList = this.lectureService.myLecList(stNo);
		
		int lecCount = this.lectureService.lecCount(stNo);
		int lecSum = this.lectureService.lecSum(stNo);
		
		map.put("myLecList", myLecList);
		map.put("lecCount", lecCount);
		map.put("lecSum", lecSum);
		
		log.info("myStuLec map >>> " + map);
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/insertMyLec")
	public int insertMyLec(@RequestBody Map<String, Object> map) {
		log.info("강의 신청 추가");
		
		map.put("stNo",stNo);
//		log.info("LecMap >> " + map);
		
		int result = 0;
		
		result += this.lectureService.insertMyLec(map);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/checkTime")
	public int checkTime(@RequestBody Map<String, Object> map) {
		log.info("강의 시간 중복 여부 체크");
		
		int result = 0;
		
		List<LectureVO> lecInfo = this.lectureService.lecInfo(map);
		
		// 내 학년 정보 가져오기
		StudentVO studentVO = this.lectureService.myInfo(stNo);
		int grade = studentVO.getStGrade();
		
		String insertDay = "";
		int insertStartTime = 0;
		int insertEndTime = 0;
		int insertGrade = 0;
		
		List<StuLectureVO> myLecList = this.lectureService.myLecList(stNo);
		
		for (int k = 0; k < lecInfo.size(); k++) {
			insertDay = lecInfo.get(k).getLecTimeVO().getLecDay();
			insertStartTime = lecInfo.get(k).getLecTimeVO().getLecSt();
			insertEndTime = lecInfo.get(k).getLecTimeVO().getLecEnd();
			insertGrade = lecInfo.get(k).getLecGrade();
		
			for (int i = 0; i < myLecList.size(); i++) {
				int start = myLecList.get(i).getLectureVOList().getLecTimeVO().getLecSt();
				int end = myLecList.get(i).getLectureVOList().getLecTimeVO().getLecEnd();
				String day = myLecList.get(i).getLectureVOList().getLecTimeVO().getLecDay();
				
				for (int j = insertStartTime; j <= insertEndTime; j++) {
					
					if(insertDay.equals(day)){
						if(j == start || j == end) {
							return 0;
						}
					} 
				}
			}
			if(grade < insertGrade) {
				return 2;
			}
		}
		result = 1;
//		log.info("중복이 아닐때 result" + result);
		return result;
	}
	
	@ResponseBody
	@PostMapping("/deleteMyLec")
	public int deleteMyLec(@RequestBody Map<String, Object> map) {
		log.info("강의 신청 취소");
		
		map.put("stNo",stNo);
//		log.info("LecMap >> " + map);
		
		int result = this.lectureService.delectMyLec(map);
		
		return result;
	}
	
	@ResponseBody
	@GetMapping("/timeTableList")
	public List<StuLectureVO> timeTableList() {
		log.info("timeTableList >>> " + stNo);
		
		//수강 중인 강의 목록
		List<StuLectureVO> myLecList = this.lectureService.myLecList(stNo);
//		log.info("list > myLecList : " + myLecList);
		
		return myLecList;
	}
	
	@GetMapping("/cart")
	public String lectureCart(Model model) {
		stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("수강 장바구니 페이지 + 수강한 전필/전선/교필/교선 학점 불러오기");
		
		int junpil = this.lectureService.junpil(stNo);
		int junsun = this.lectureService.junsun(stNo);
		int gyopil = this.lectureService.gyopil(stNo);
		int gyosun = this.lectureService.gyosun(stNo);
		List<ComDetCodeVO> deptList = this.adminStudentService.deptList();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("junpil", junpil);
		map.put("junsun", junsun);
		map.put("gyopil", gyopil);
		map.put("gyosun", gyosun);
		
		model.addAttribute("hakjum",map);
		model.addAttribute("deptList",deptList);
		
		return "lecture/cart";
	}
	
	@ResponseBody
	@PostMapping("/listAjax")
	public Map<String, Object> listAjax (){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<ComDetCodeVO> deptList = this.adminStudentService.deptList();
		
		// 강의 목록
		List<LectureVO> lectureList = this.lectureService.list();
		
		// 장바구니 - 강의목록 비교 용 
		List<StuLecCartVO> cartList = this.lectureService.cartList(stNo);
		
		map.put("deptList", deptList);
		map.put("lectureList", lectureList);
		map.put("cartList", cartList);
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/cartList")
	public Map<String, Object> cartList() {
		log.info("내 장바구니 조회");
		
		// 장바구니
		List<StuLecCartVO> cartList = this.lectureService.cartList(stNo);
//		log.info("cartList >>> " + cartList);
		
		// 장바구니에 담긴 강의 갯수
		int countLec = this.lectureService.countLec(stNo);
//		log.info("장바구니에 담긴 강의 갯수 >>> " + countLec);
		
		// 장바구니에 담긴 강의의 학점 합
		int sumLecScore = this.lectureService.sumLecScore(stNo);
//		log.info("sumLecScore >> " + sumLecScore);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cartList", cartList);
		map.put("countLec", countLec);
		map.put("sumLecScore", sumLecScore);
		
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/searchLecAjax")
	public Map<String, Object> searchLecAjax(Model model, @RequestBody Map<String, Object> map){
		log.info("강의 검색 >>> " + map);
		
		Map<String, Object> map1 = new HashMap<String, Object>();
		
		// 장바구니 - 강의목록 비교 용 
		List<StuLecCartVO> cartList = this.lectureService.cartList(stNo);
		
		List<LectureVO> lectureSearchList = this.lectureService.searchList(map); 
		map1.put("cartList", cartList);
		map1.put("lectureSearchList", lectureSearchList);
//		log.info("searchLecAjax map1 >>> " + map1);
		
		return map1;
	}
	
	@ResponseBody
	@PostMapping("/insertCart")
	public int insertCart(@RequestBody Map<String, Object> map) {
		log.info("장바구니 추가");
		
		String cartNo = "cart" + stNo;
		map.put("stNo", stNo);
		map.put("cartNo", cartNo);
		
		int result = this.lectureService.insertCart(map);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/deleteCart")
	public int deleteCart(@RequestBody Map<String, Object> map) {
		log.info("장바구니 삭제");
		
		String cartNo = "cart" + stNo;
		map.put("stNo", stNo);
		map.put("cartNo", cartNo);
		
		int result = this.lectureService.deleteCart(map);
		
		return result;
	}
	
	@ResponseBody
	@GetMapping("/timeTableListAjax")
	public List<StuLecCartVO> timeTableListAjax() {
		log.info("timeTableListAjax >>> " + stNo);
		
		//장바구니 강의 목록
		List<StuLecCartVO> myLecCart = lectureService.myLecCart(stNo);
//		log.info("list > myLecCart : " + myLecCart);
		
		return myLecCart;
	}
	
	@GetMapping("/handbook")
	public String handbook(Model model) {
		log.info("수강 편람 페이지");
		
		List<ComCodeVO> univList = this.adminStudentService.getCollege();
//		log.info("univList >>>>>> " + univList);
		
		model.addAttribute("univList",univList);
		
		return "lecture/handbook";
	}
	
	@ResponseBody
	@PostMapping("/searchHandbook")
	public List<LectureVO> searchLec(@RequestBody Map<String, Object> map) {
		log.info("강의편람 검색" + map);
		
		List<LectureVO> searchHandbookList = this.lectureService.searchHandbookList(map);
		log.info("searchHandbookList >>> " + searchHandbookList);
		
		return searchHandbookList;
	}
}
