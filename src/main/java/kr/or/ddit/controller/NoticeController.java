package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.NoticeService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.QuestionVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/notice") 
@Slf4j
@Controller
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	@GetMapping("/list")
	public ModelAndView noticeList(ModelAndView mav,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("문의사항 조회 페이지");
//		log.info("list->keyword : " + keyword);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
//		log.info("keyword >> " + keyword);
//		log.info("currentPage >> " + currentPage);
//		log.info("queGubun >> " + queGubun);
		
		//전체 행수
		int total = this.noticeService.getTotal(map);
//		log.info("list->total : " + total);
		
		//목록
		List<QuestionVO> nVOList = this.noticeService.noticeList(map);
//		log.info("nVOList : " + nVOList);
		
		mav.addObject("articlePage", new ArticlePage<QuestionVO>(total, currentPage, 10, nVOList, keyword, queGubun));
		
		//forwarding : jsp
		mav.setViewName("notice/list");
		
		return mav;
	}
	
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<QuestionVO> noticeListAjax(@RequestBody Map<String,Object> map) {
		log.info("listAjax 페이지");
//		log.info("list->map : " + map);
		
		//전체 행수
		int total = this.noticeService.getTotal(map);
//		log.info("listAjax->total : " + total);
		
		//목록
		List<QuestionVO> nVOList = this.noticeService.noticeList(map);
//		log.info("nVOList : " + nVOList);
		
		return new ArticlePage<QuestionVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, nVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	@GetMapping("/detail")
	public ModelAndView noticeDetail(ModelAndView mav) {
		
		mav.setViewName("notice/detail");
		
		return mav;
	}
}
