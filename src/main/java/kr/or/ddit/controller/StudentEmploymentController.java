package kr.or.ddit.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.StudentEmploymentService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.CertificateVO;
import kr.or.ddit.vo.QuestionVO;
import kr.or.ddit.vo.RecruitmentVO;
import kr.or.ddit.vo.VolunteerVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/employment")
public class StudentEmploymentController {
	@Autowired
	StudentEmploymentService studentEmploymentService;
	
	@GetMapping("/volunteer")
	public ModelAndView volunteer(ModelAndView mav,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("봉사활동 내역 목록 조회");
		log.info("list->keyword : " + keyword);
		//학번/사번
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("stNo:"+stNo);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		map.put("stNo", stNo);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		int total =this.studentEmploymentService.getTotal(map);
		log.info("list > total:" +total);
		
		//목록
		List<VolunteerVO> vVOList = this.studentEmploymentService.volunteerList(map);
		log.info("vVOList:"+vVOList);
		mav.addObject("articlePage", new ArticlePage<VolunteerVO>(total, currentPage, 10, vVOList, keyword, queGubun));
		
		//봉사 총 시간
		int volTotalTime=studentEmploymentService.volTotalTime(stNo);
		log.debug("volTotalTime{}",volTotalTime);
		mav.addObject("volTotalTime", volTotalTime);
		
		mav.setViewName("employment/volunteer");
		return mav;
	}
	
	@ResponseBody
	@PostMapping("/volunteerAjax")
	public ArticlePage<VolunteerVO> volunteerAjax(@RequestBody Map<String, Object> map) {
		log.info("ajax!");
		log.info("map>"+map);
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		int total =this.studentEmploymentService.getTotal(map);
		log.info("total>>"+total);
		
		//목록
		List<VolunteerVO> vVOList = this.studentEmploymentService.volunteerList(map);
		log.info("vVOList:"+vVOList);
		return new ArticlePage<VolunteerVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, vVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	@GetMapping("/volAdd")
	public String volAdd() {
		log.info("봉사활동 등록");
		return "employment/volAdd";
	}
	@ResponseBody
	@PostMapping("/volAddAjax")
	public String volAddAjax(VolunteerVO volunteerVO) {
		log.info("volAddAjax>volunteerVO>>"+volunteerVO);
		int result = this.studentEmploymentService.volAddAjax(volunteerVO);
		log.info("volAddAjax rslt"+result);
		return "result";
	}
	@GetMapping("/volDetail")
	public String volDetail(Model model
			,Map<String, Object> map
			,VolunteerVO volunteerVO
			,@RequestParam(value="volNo")String volNo) {
		log.info("봉사활동 내역상세 조회");
		map.put("volNo", volNo);
		//학번/사번
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		
		/*
		{volunteerVO=VolunteerVO(volNo=29, stNo=null, volPlace=null, volStart=null, volEnd=null, volTime=0
		, volCon=null, vonFileStr=null, vonFile=null, comAttachFileVO=null, comAttachDetVO=null)
		, org.springframework.validation.BindingResult.volunteerVO=org.springframework.validation.BeanPropertyBindingResult: 0 errors
		, volNo=29, stNo=1651004}
		 */
		log.info("map>"+map);
		
		volunteerVO = this.studentEmploymentService.volDetail(map);
		log.info("volunteerVO :{}",volunteerVO);
		model.addAttribute("volunteerVO",volunteerVO);
		return "employment/volDetail";
	}
	@ResponseBody
	@PostMapping("/volDetailAjax")
	public int volDetailAjax(VolunteerVO volunteerVO) {
		log.info("봉사활동  ajax");
//		volunteerVO.setVolNo(volNo);
		log.info("ajax>volunteerVO:{}",volunteerVO);
		
		int result = studentEmploymentService.volDetailAjax(volunteerVO);
		return result;
	}
	@GetMapping("/volunteerVO")
	public String volUpdate() {
		log.info("봉사활동 내역상세 조회");
		
		return "employment/volDetail";
	}
	
	@GetMapping("/recruitment")
	public ModelAndView recruitment(ModelAndView mav,
			 Map<String, Object> map,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("채용정보목록");
		log.info("list->keyword : " + keyword);
		//학번/사번
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("stNo:"+stNo);
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		map.put("stNo", stNo);
		
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		int recruitmentTotal =this.studentEmploymentService.recruitmentTotal(map);
		log.info("list > total:" +recruitmentTotal);
		
		List<RecruitmentVO> recruitmentVOList = this.studentEmploymentService.recruitmentVOList(map);
		log.info("recruitmentVOList:"+recruitmentVOList);
		mav.addObject("articlePage", new ArticlePage<RecruitmentVO>(recruitmentTotal, currentPage, 10, recruitmentVOList, keyword, queGubun));
		mav.setViewName("employment/recruitment");
		return mav;
	}
	@ResponseBody
	@PostMapping("/recruitmentAjax")
	public ArticlePage<RecruitmentVO> recruitmentAjax(@RequestBody Map<String, Object> map) {
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		int recruitmentTotal =this.studentEmploymentService.recruitmentTotal(map);
		
		List<RecruitmentVO> recruitmentVOList = this.studentEmploymentService.recruitmentVOList(map);
		log.info("recruitmentVOList:"+recruitmentVOList);
		
		return new ArticlePage<RecruitmentVO>(recruitmentTotal, Integer.parseInt(map.get("currentPage").toString()), 10, recruitmentVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	@GetMapping("/recDetail")
	public String recDetail(Model model
			,RecruitmentVO recruitmentVO
			,Map<String, Object> map
			,@RequestParam(value="volNo")String recDNo) {
		log.info("채용정보상세 조회");
		//학번/사번
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		map.put("recDNo", recDNo);
		
//		recruitmentVO = this.studentEmploymentService.recDetail(recDNo);
		
//		model.addAttribute("recruitmentVO",recruitmentVO);
		return "employment/recDetail";
	}
	
	@GetMapping("/certificate")
	public String certificate(
			Model model,
			 Map<String, Object> map,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("자격증 목록");
		//학번/사번
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		map.put("stNo", stNo);
		
		int certificateCount = this.studentEmploymentService.certificateCount(stNo);
		model.addAttribute("certificateCount", certificateCount);
		int certificateTotal =this.studentEmploymentService.certificateTotal(map);
		log.info("list > total:" +certificateTotal);
		
		//목록
		List<CertificateVO> certificateVOList = this.studentEmploymentService.certificateVOList(map);
		log.info("certificateVOList:"+certificateVOList);
		
		model.addAttribute("articlePage", new ArticlePage<CertificateVO>(certificateTotal, currentPage, 6, certificateVOList, keyword, queGubun));
		return "employment/certificate";
	}
	@ResponseBody
	@PostMapping("/certificateAjax")
	public ArticlePage<CertificateVO> certificateAjax(@RequestBody Map<String, Object> map) {
		log.info("ajax!");
		log.info("map>"+map);
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		int certificateTotal =this.studentEmploymentService.certificateTotal(map);
		log.info("certificateTotal>>"+certificateTotal);
		
		//목록
		List<CertificateVO> certificateVOList = this.studentEmploymentService.certificateVOList(map);
		log.info("certificateVOList:"+certificateVOList);
		return new ArticlePage<CertificateVO>(certificateTotal, Integer.parseInt(map.get("currentPage").toString()), 10, certificateVOList, map.get("keyword").toString(), map.get("queGubun").toString());		
	}
	
	@ResponseBody
	@PostMapping("/cerCreateAjax")
	public int cerCreateAjax(@RequestBody CertificateVO certificateVO) {
		log.info("certificateVO>>{}",certificateVO);
		int result = this.studentEmploymentService.cerCreateAjax(certificateVO);
		return result;
	}
	@ResponseBody
	@PostMapping("/cerDeleteAjax")
	public ArticlePage<CertificateVO> cerDeleteAjax(@RequestBody Map<String, Object> map) {
		log.info("delete");
		log.info("map>>"+map);
		int result = this.studentEmploymentService.cerDeleteAjax(map);
		log.info("result"+result);
		int certificateTotal =this.studentEmploymentService.certificateTotal(map);
		log.info("certificateTotal>>"+certificateTotal);
		
		//목록
		List<CertificateVO> certificateVOList = this.studentEmploymentService.certificateVOList(map);
		log.info("certificateVOList:"+certificateVOList);
		return new ArticlePage<CertificateVO>(certificateTotal, Integer.parseInt(map.get("currentPage").toString()), 10, certificateVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	@ResponseBody
	@PostMapping("/cerUpdateAjax")
	public ArticlePage<CertificateVO> cerUpdateAjax(@RequestBody Map<String, Object> map) {
		log.info("cerUpdateAjax>>"+map);
		int result =this.studentEmploymentService.cerUpdateAjax(map);
		log.info("result"+result);
		int certificateTotal =this.studentEmploymentService.certificateTotal(map);
		log.info("certificateTotal>>"+certificateTotal);
		
		//목록
		List<CertificateVO> certificateVOList = this.studentEmploymentService.certificateVOList(map);
		log.info("certificateVOList:"+certificateVOList);
		return new ArticlePage<CertificateVO>(certificateTotal, Integer.parseInt(map.get("currentPage").toString()), 10, certificateVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
}
