package kr.or.ddit.controller;

import java.security.Principal;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.CommonNoticeService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.UploadUtils;
import kr.or.ddit.vo.CommonNoticeVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author PC-31
 * 교수, 학생 공지사항
 */

@Slf4j
@RequestMapping("/commonNotice")
@Controller
public class CommonNoticeController {
	
	@Autowired
	CommonNoticeService commonNoticeService;
	
	@Autowired
	UploadUtils  uploadUtils;
	
	//관리자 공지사항
	@GetMapping("/listAdm")
	public String listAdm() {
		
		return "commonNotice/listAdm";
	}
	
	
	//학생 공지사항
	@GetMapping("/listStu")    
	public String listStu() {
		
		return "commonNotice/listStu";
	}
	
	
	//등록예비
	@GetMapping(value="/create")
	public String create(Principal principal) {
		if(principal == null) {
			return "redirect:/login";
		}
		
		//forwarding
		return "commonNotice/create";
	}
	
	
	//등록
	@PostMapping("/createPost")
	public String createPost(CommonNoticeVO commonNoticeVO) {
		/*
		 CommonNoticeVO(rn=null, comNotNo=null, userNo=null, comNotName=제목23, comNotCon=<p>asfd</p>
		 , comNotViews=0, comFirstDate=null, comEndDate=null, comNotDelYn=null, 
		 comAttFile=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@7b4b0024], 
		 comAttFileId=null, comGubun=2, userInfoVOList=null, comAttachDetVOList=null)
		 */
		log.info("createPost->commonNoticeVO : " + commonNoticeVO);
		
		int result = this.commonNoticeService.createPost(commonNoticeVO);
//		log.info("createPost->result : " + result);
		
		return "redirect:/commonNotice/list?menuId=annNotIce";
	}
	
	
//	// 게시판 수정뷰
//	@GetMapping("/update")
//	public String updateView(CommonNoticeVO commonNoticeVO) {
//		log.info("updateView->commonNoticeVO: " + commonNoticeVO);
//		
//		int result = this.commonNoticeService.detail(commonNoticeVO.getComNotNo()));
//		
//		return "commonNotice/update";
//	}
	
	/*
	// 게시판 수정화면
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String update(@RequestParam("comNotNo") CommonNoticeVO commonNoticeVO, Model model) {
		log.info("update");
		
		model.addAttribute("update", commonNoticeService.detail(commonNoticeVO.getComNotNo()));
		
		return "commonNotice/update";
	}
	
	// 게시판 수정
	@RequestMapping(value="/updatePost", method=RequestMethod.POST)
	public String updatePost(CommonNoticeVO commonNoticeVO) {
		log.info("updatePost->commonNoticeVO : " + commonNoticeVO);
		
		commonNoticeService.updatePost(commonNoticeVO);
//		log.info("updatePost->result : " + result);
		
//		mav.setViewName("redirect:/commonNotice/detail?menuId=annNotIce&comNotNo="+commonNoticeVO.getComNotNo());
		
		return "redirect:/commonNotice/list";
	}
	*/
	
	// 게시판 수정화면
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView update(@RequestParam String comNotNo, ModelAndView mav) {
		log.info("update");
		log.info("comNotNo : " + comNotNo);
//		mav.getAttribute(comNotNo);
//		model.addAttribute("update", commonNoticeService.detail(comNotNo));
		
		CommonNoticeVO commonNoticeVO = this.commonNoticeService.detail(comNotNo);
//		log.info("update->commonNoticeVO : " + commonNoticeVO);
		
		mav.addObject("commonNoticeVO",commonNoticeVO);
		
		mav.setViewName("commonNotice/update");
		
		return mav;
	}
	
	
	// 게시판 수정
	@RequestMapping(value="/updatePost", method=RequestMethod.POST)
	public String updatePost(CommonNoticeVO commonNoticeVO, Model model) {
		log.info("updatePost->commonNoticeVO : " + commonNoticeVO);
		
        // insert, update, delete를 쓰는 맵퍼, 서비스는 기본적으로 return 타입을 int로 해야 함!			
		commonNoticeService.updatePost(commonNoticeVO);		
		model.addAttribute("comNotNo",commonNoticeVO.getComNotNo());
		
		return "redirect:/commonNotice/list";
	}
	
	
	//삭제
	@PostMapping("/deletePost")
	public String deletePost(CommonNoticeVO commonNoticeVO) {
		log.info("deletePost->commonNoticeVO: " + commonNoticeVO);
		
		commonNoticeService.deletePost(commonNoticeVO.getComNotNo());
//		log.info("deletePost->result: " + result);
		//삭제 후 목록으로 이동
		return "redirect:/commonNotice/list";
	}
	
	
	//목록
	@GetMapping("/list")
	public ModelAndView list(ModelAndView mav,
			@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue = "") String keyword, 
			@RequestParam(value="queGubun", required=false, defaultValue = "") String queGubun) {
		log.info("list에 왔다");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
//		log.info("keyword >> " + keyword);
//		log.info("currentPage >> " + currentPage);
//		log.info("queGubun >> " + queGubun);
		
		//행의 수
		int total = this.commonNoticeService.getTotal(map);
//		log.info("list->total: " + total);
		
		List<CommonNoticeVO> commonNoticeVOList = this.commonNoticeService.list(map);
//		log.info("list->commonNoticeVO: " + commonNoticeVOList);
		
		mav.addObject("articlePage", new ArticlePage<CommonNoticeVO>(total, currentPage, 10, commonNoticeVOList, keyword, queGubun));
		
		//jsp
		mav.setViewName("commonNotice/list");
		
		return mav;
	}
	
	
	//목록아작
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<CommonNoticeVO> commonNoticeListAjax(@RequestBody Map<String,Object> map) {
		log.info("listAjax 페이지");
		log.info("list->map : " + map);
		
		//전체 행수
		int total = this.commonNoticeService.getTotal(map);
//		log.info("listAjax->total : " + total);
		
		//목록
		List<CommonNoticeVO> commonNoticeVOList = this.commonNoticeService.list(map);
//		log.info("commonNoticeVOList : " + commonNoticeVOList);
		
		return new ArticlePage<CommonNoticeVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, commonNoticeVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	
	// 상세 보기 페이지
	@GetMapping("/detail")
	public String detail(@RequestParam("comNotNo") String comNotNo, Model model) {
		//detail->comNotNo : 110
		log.info("detail->comNotNo : " + comNotNo);
		
	    // 조회수 업데이트
	    commonNoticeService.ViewCnt(comNotNo);
	    
	    // 공지사항 상세 정보 가져오기
	    CommonNoticeVO commonNoticeVO = this.commonNoticeService.detail(comNotNo);
	    /*
	     * CommonNoticeVO(rn=null, comNotNo=110, userNo=null, comNotName=제바하라라아아아아, comNotCon=<p>ㅇㄹㅇㄴㄴㅇㄹㅇㄴㄹㄴㅇㄹㄴㅇ</p>, comNotViews=37
	     * , comFirstDate=2024-06-18, comEndDate=2024-06-18, comNotDelYn=null, comAttFile=null, comAttFileId=null, comGubun=2
	     * , userInfoVOList=UserInfoVO(userNo=null, userName=이창섭, userPass=null, userTel=null, userGubun=null, enabled=0
	     * , authorityVOList=null, url=null, deptName=null), comAttachDetVOList=null)
	     * */
//	    log.info("detail->commonNoticeVO : " + commonNoticeVO);
	    
	    // Model에 데이터를 담아서 뷰로 전달
	    model.addAttribute("commonNoticeVO", commonNoticeVO);
	    model.addAttribute("detail", commonNoticeService.detail(commonNoticeVO.getComNotNo()));
	    
	    //일반공지첨부파일ID
//	    String comAttFileId = commonNoticeVO.getComAttFileId();
	    String comAttFileId = commonNoticeVO.getComNotNo();
	    
	    // 첨부파일
//	    List<Map<String, Object>> fileList = commonNoticeService.selectFileList(comAttFileId);
	    List<Map<String, Object>> fileList = commonNoticeService.selectFileList(commonNoticeVO.getComNotNo());
//	    log.debug("fileList {}", fileList);
	    
		model.addAttribute("fileList", fileList);
//		log.info("detail->fileList : " + fileList);
	    
	    // 상세 페이지의 뷰 이름 반환
	    return "commonNotice/detail";
	}
	
	/*
	// 첨부파일 다운
	@RequestMapping(value="/fileDown")
	public void fileDown(@RequestParam List<Map<String, Object>> list, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> result = commonNoticeService.fileDown(list);
		String comAttMId = (String) resu
		String logiFileName = (String) result.get("LOGI_FILE_NAME");
		
		log.info("comAttMId" + comAttMId);
		log.info("logiFileName" + logiFileName);
		
		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\upload\\file\\"+comAttMId));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(logiFileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
		
	}
	*/
	

}
