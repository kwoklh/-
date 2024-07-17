package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.ProfLectureService;
import kr.or.ddit.vo.BuildingInfoVO;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.LectureRoomVO;
import kr.or.ddit.vo.LectureVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author PC-13
 * 교수의 강의 관리 페이지
 */
@Slf4j
@RequestMapping("/profLecture")
@Controller
public class ProfLectureController {
	
	@Autowired
	ProfLectureService profLectureService;
	
	@GetMapping("/lectureCreate")
	public String achievement(Model model) {
		
//		String proNo = SecurityContextHolder.getContext().getAuthentication().getName();
		
		List<ComCodeVO> collegeList = profLectureService.collegeList();
//		log.info("collegeList >>> {}", collegeList);
//		log.info("collegeList size : {}",collegeList.size());
		
		List<BuildingInfoVO> bulidList  = profLectureService.buildList();
//		log.info("bulidList >>> {}", bulidList);
//		log.info("bulidList size : {}",bulidList.size());
		
		model.addAttribute("collegeList",collegeList);
		model.addAttribute("bulidList",bulidList);
		
		return "profLecture/lectureCreate";
	}
	
	@ResponseBody
	@PostMapping("/deptList")
	public List<ComDetCodeVO> deptList(@RequestBody String collegeCode) {
		
		List<ComDetCodeVO> deptList = profLectureService.deptList(collegeCode);
		
//		log.info("deptList >>>>>>" + deptList);

//		for(ComDetCodeVO dept : deptList) {
//			log.info("dept >>>>>>" + dept);
//		}
		
		return deptList;
	}
	
	/**
	 * 강의 등록 페이지에서 강의 건물 검색
	 * @param buildSeaWord 검색 키워드
	 * @return
	 */
	@ResponseBody
	@PostMapping("/bulidSearch")
	public List<BuildingInfoVO> buildSearchList(@RequestBody String buildSeaWord){
		
		List<BuildingInfoVO> buildSearchList  = profLectureService.buildSearchList(buildSeaWord);
		
//		log.info("buildSearchList >>> {}", buildSearchList);
//		log.info("buildSearchList >>> {}", buildSearchList.size());
		
		return buildSearchList;
	}
	
	/**
	 * 강의등록 페이지에서 강의 건물 선택 했을때 해당 건물에 선택한 요일/교시에 사용 가능한
	 * 강의실 목록 출력
	 * @param param 강의 건물 코드, 선택한 강의 요일/교시 
	 * @return 건물에 해당하는 강의실 목록 반환
	 */
	@ResponseBody
	@PostMapping("/buildChoice")
	public List<LectureRoomVO> buildChoice(@RequestBody Map<String, Object> param){
        
		String bldNo = (String)param.get("bldNo");
		List<Map<String, Object>> lecTimeVOList = (List<Map<String, Object>>)param.get("lecTimeVOlist");
		
		String lecDay0 = (String)lecTimeVOList.get(0).get("lecDay");
		String lecSt0 = (String)lecTimeVOList.get(0).get("lecSt");
		String lecEnd0 = (String)lecTimeVOList.get(0).get("lecEnd");
		String lecDay1 = "";
		String lecSt1 = "";
		String lecEnd1 = "";
		
		if(lecTimeVOList.size()>1) {
			lecDay1 = (String)lecTimeVOList.get(1).get("lecDay");
			lecSt1 = (String)lecTimeVOList.get(1).get("lecSt");
			lecEnd1 = (String)lecTimeVOList.get(1).get("lecEnd");
		}
		
		//log.info("lecDay0>>>>>>>>>>>{}",lecDay0);
		//log.info("lecDay1 >>>>>>>>>{}",lecDay1);
		
		Map<String,Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("bldNo", bldNo);
		paramMap.put("lecDay0", lecDay0);
		paramMap.put("lecSt0", lecSt0);
		paramMap.put("lecEnd0", lecEnd0);
		paramMap.put("lecDay1", lecDay1);
		paramMap.put("lecSt1", lecSt1);
		paramMap.put("lecEnd1", lecEnd1);
		
		List<LectureRoomVO> lecRoomList = profLectureService.buildChoice(paramMap); 
		
		//profLectureService.buildChoice(param);
		//log.info("lecRoomList >>> {}", lecRoomList);
		
		return lecRoomList;
	}
	
	// 강의 등록
	@ResponseBody 
	@PostMapping("/lecCreate")
	public int lecCreate(LectureVO lectureVO) {
		log.info("lecCreate >>>>>>>lectureVO :"+ lectureVO);
		String fileName = lectureVO.getLecFile().getOriginalFilename();
		log.info("lecture>>파일이름 : {}",fileName);
		
		log.info("lectuerDet >>> {}",lectureVO.getLectureDetailVOList());
		int result = profLectureService.lecCreate(lectureVO);
		
		log.info("result>>>{}",result);
		
		return result;
	}
	
	// 강의등록 계획서 조회
	@GetMapping("/achList")
	public String achList(Model model) {
		
		String proNo = SecurityContextHolder.getContext().getAuthentication().getName();
		
		List<LectureVO> lectureVOList = profLectureService.lectureList(proNo);
		
		model.addAttribute("lectureVOList", lectureVOList);
		
		return "profLecture/achList";
	}
	
	/**
	 * 학생 성적을 등록하는 페이지로 연결
	 * @param model 
	 * @return 해당 학기의 내 강의 목록, 해당 강의의 수강생 목록, 출결 점수를 가지고 페이지 이동
	 */
	@GetMapping("/achievement")
	public String achievement() {
		return "profLecture/achievement";
	}
	
}
