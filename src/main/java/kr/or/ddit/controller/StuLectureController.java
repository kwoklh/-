package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.service.StuLectureService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.QuestionVO;
import kr.or.ddit.vo.StuLectureVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.TimeExchangeManageVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author PC-10
 * 학생의 수강신청시스템 > 수강조회 페이지
 */
@RequestMapping("/stuLecture") 
@Slf4j
@Controller
public class StuLectureController {
	
	@Autowired
	StuLectureService stuLectureService; 
	
	//수강 조회
	@GetMapping("/list")
	public ModelAndView myLecture(Authentication auth, ModelAndView mav){
		log.info("수강조회 페이지");
		log.info("myLecture > list : " + mav);
		
		String stNo = auth.getName();
		System.out.println("myLecture >> stNo : " + stNo);
		
		StudentVO studentVO = stuLectureService.studentVO(stNo);
		mav.addObject("studentVO", studentVO);
		
		//forwarding : jsp
		mav.setViewName("stuLecture/list");
		
		return mav;
	}
	
	//수강 조회 ajax
	@ResponseBody
	@GetMapping("/listAjax")
	public List<StuLectureVO> myLectureAjax(Authentication auth){
		log.info("수강조회 페이지");
		
		String stNo = auth.getName();
		System.out.println("myLecture >> stNo : " + stNo);
		
		//수강 중인 강의 목록
		List<StuLectureVO> myLecture = stuLectureService.myLecture(stNo);
		log.info("list > myLecture : " + myLecture);
		
		//forwarding : jsp
		return myLecture;
	}
	
	//강의 거래 
	@GetMapping("/exchange")
	public ModelAndView lectureExchange(Authentication auth, ModelAndView mav) {
		log.info("수강조회 페이지");
		log.info("myLecture > list : " + mav);
		
		String stNo = auth.getName();
		System.out.println("myLecture >> stNo : " + stNo);
		
		//수강 중인 강의 상세 정보 출력
		List<StuLectureVO> myLectureDetail = stuLectureService.myLectureDetail(stNo);
		log.info("exchange > myLectureDetail : " + myLectureDetail);
		mav.addObject("myLectureDetail", myLectureDetail);
		
		//forwarding : jsp
		mav.setViewName("stuLecture/exchange");
		
		return mav;
	}
	
	//학번 관련 데이터 조회
	@ResponseBody
	@PostMapping("/stNoFindAjax")
	public StudentVO exchangeGet(@RequestBody String stNoFind) {
		log.info("학번 조회 페이지");
		log.info("myLecture > stNoFindAjax : " + stNoFind);
		String stNo = stNoFind.substring(9);
		log.info("stNo : " + stNo);
		
		
		//학생 정보 데이터 찾기
		StudentVO stNoFindAjax = stuLectureService.stNoFindAjax(stNo);
		log.info("stNoFindAjax > stNoFind : " + stNoFindAjax);
		
		return stNoFindAjax;
	}
	
	// 강의 거래
	@ResponseBody
	@PostMapping("/lectureTransferAjax")
	public String lectureTransferAjax(Authentication auth, @RequestBody StuLectureVO stuLectureVO) {
		log.info("강의 거래 페이지");
		log.info("lectureTransferAjax > stuLectureVO : " + stuLectureVO);
		
		String loginStNo = auth.getName(); // 로그인한 사람 학번
		log.info("myLecture >> loginStNo : " + loginStNo);
		
		String stuLecNo = stuLectureVO.getStuLecNo(); // 수강 번호
		String stNo = stuLectureVO.getStNo(); // 보낼 학번
		log.info("myLecture >> stuLecNo : " + stuLecNo);
		log.info("myLecture >> stNo : " + stNo);
		
//		if()
		
		Map<String, Object> map = new HashedMap();
		map.put("loginStNo", loginStNo); // 보낸 사람
		map.put("stuLecNo", stuLecNo); // 수강 번호
		map.put("stNo", stNo); // 받는 사람
		
		// 강의 거래 내역에 추가
		int result = stuLectureService.timeExchangeManageInsert(map);
		log.info("result : " + result);
		if(result > 0) {
			System.out.println("강의 거래 내역 추가 성공!");
			return "success";
		}else {
			System.out.println("강의 거래 내역 추가 실패!");
			return "failed";
		}
	}
	
	// 강의 거래 내역 목록
	@GetMapping("/exchangeHistory")
	public ModelAndView exchangeHistory(Authentication auth, 
			ModelAndView mav,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("강의 거래 내역 페이지");
		log.info("exchangeHistory->keyword : " + keyword);
			
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		String stNo = auth.getName(); // 로그인한 사람 학번
		log.info("exchangeHistory >> stNo : " + stNo);
		map.put("stNo", stNo);
		
		//전체 행수
		int total = this.stuLectureService.getTotal(map);
		log.info("list->total : " + total);
		
		//목록
		List<TimeExchangeManageVO> timeExcManVOList = stuLectureService.exchangeHistory(map);
		log.info("exchangeHistory >> timeExcManVOList : " + timeExcManVOList);
		
		mav.addObject("articlePage", new ArticlePage<TimeExchangeManageVO>(total, currentPage, 10, timeExcManVOList, keyword, queGubun));
		
		//forwarding : jsp
		mav.setViewName("stuLecture/exchangeHistory");
		
		return mav;
	}
	
	// 강의 거래 내역 목록 Ajax
	@ResponseBody
	@PostMapping("/exchangeHistoryAjax")
	public ArticlePage<TimeExchangeManageVO> exchangeHistoryAjax(@RequestBody Map<String,Object> map, Authentication auth) {
		log.info("강의 거래 내역 Ajax 페이지");
		log.info("exchangeHistoryAjax->map : {}", map);
		
		String stNo = auth.getName();
		map.put("stNo", stNo);
		
		//전체 행수
		int total = this.stuLectureService.getTotal(map);
		log.info("list->total : " + total);
		
		//목록
		List<TimeExchangeManageVO> timeExcManVOList = this.stuLectureService.exchangeHistory(map);
		log.info("exchangeHistory >> timeExcManVOList : " + timeExcManVOList);
		
		return new ArticlePage<TimeExchangeManageVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, timeExcManVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	// 강의 거래 승인&취소 Ajax
	@ResponseBody
	@PostMapping("/excHisOkAjax")
	public String excHisOkAjax(@RequestBody TimeExchangeManageVO timeExchangeManageVO) {
		log.info("강의 거래 승인&취소 Ajax");
		log.info("excHisOkAjax > timeExchangeManageVO : {}", timeExchangeManageVO);
		
		// 강의 거래 내역 update
		int excHisOkAjaxUpdate = stuLectureService.excHisOkAjaxUpdate(timeExchangeManageVO);
		log.info("excHisOkAjax >> excHisOkAjaxUpdate : {}", excHisOkAjaxUpdate);
		
		if(excHisOkAjaxUpdate > 0) {
			// 강의 거래 완료 내 수강 내역 수정
			int lectureExchangeUpdate = stuLectureService.lectureExchangeUpdate(timeExchangeManageVO);
			log.info("excHisOkAjax >> lectureExchangeUpdate : {}", lectureExchangeUpdate);
			
			return "success";
		} else {
			return "false";
		}
	}
	
	//강의 거래 내역 상세
	@GetMapping("/excHisDetail")
	public ModelAndView excHisDetail(Authentication auth,
				ModelAndView mav,
				@RequestParam("timeExNo") String timeExNo) {
		log.info("강의 거래 내역 상세 페이지");
		log.info("excHisDetail >> timeExNo : {}", timeExNo);
		
		//거래한 강의 정보 출력
		StuLectureVO stuLectureVO = stuLectureService.excHisDetail(timeExNo);
		log.info("excHisDetail > stuLectureVO : {}", stuLectureVO);
		
		mav.addObject("stuLectureVO", stuLectureVO);
		
		
		String stNo = auth.getName(); // 로그인한 사람 학번
		log.info("excHisDetail >> stNo : {}", stNo);
		
		// 보낸 사람 학번 가져옴
		String timeSendId = stuLectureService.timeSendIdComparison(timeExNo);
		
		// 받는 사람 학번 가져옴
		String timeTakeId = stuLectureService.timeTakeIdComparison(timeExNo);
		log.info("timeSendId : {}, timeTakeId : {}", timeSendId, timeTakeId);
		
		String searchStNo = "";
		// 보낸 사람과 로그인한 사람이 같은지 확인
		if(stNo.equals(timeSendId)) { // 보낸 사람과 학번이 같을 시
			searchStNo = timeTakeId;
		} else { // 받는 사람과 학번이 같을 시
			searchStNo = timeSendId;
		}
		
		//거래한 사람 정보 출력
		StudentVO student  = stuLectureService.timeStudent(searchStNo);
		log.info("student : {}", student);
		mav.addObject("student", student);
		
		mav.setViewName("stuLecture/excHisDetail");
		
		return mav;
	}
}
