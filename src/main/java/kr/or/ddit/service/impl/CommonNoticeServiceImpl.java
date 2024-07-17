package kr.or.ddit.service.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.CommonNoticeMapper;
import kr.or.ddit.service.CommonNoticeService;
import kr.or.ddit.service.dao.AttachDao;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.util.UploadUtils;
import kr.or.ddit.vo.CommonNoticeVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CommonNoticeServiceImpl implements CommonNoticeService, Serializable {

	@Autowired
	CommonNoticeMapper commonNoticeMapper;
	
	@Autowired
	UploadUtils  uploadUtils;
	
//	@Autowired
//	AttachDao attachDao;
	
	
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.commonNoticeMapper.getTotal(map);
	}

	//목록
	@Override
	public List<CommonNoticeVO> list(Map<String, Object> map) {
		return this.commonNoticeMapper.list(map);
	}

	//등록
	@Transactional
	@Override
	public int createPost(CommonNoticeVO commonNoticeVO) {
		/*
		 CommonNoticeVO(rn=null, comNotNo=null, userNo=null, comNotName=제목23, comNotCon=<p>asfd</p>
		 , comNotViews=0, comFirstDate=null, comEndDate=null, comNotDelYn=null, 
		 comAttFile=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@7b4b0024], 
		 comAttFileId=null, comGubun=2, userInfoVOList=null, comAttachDetVOList=null)
		 */
		int result=0;
		//로그인 아이디
		String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("stNo>"+stNo);//stNo>A001
		
		//파일업로드 마지막번호 + 1
		String attEndId = this.commonNoticeMapper.attEndId(stNo);
		log.info("attEndId>"+attEndId);//attEndId>95
		
		//일반공지첨부파일
		MultipartFile[] comAttFile= commonNoticeVO.getComAttFile();
		log.info("comAttFile : {}", comAttFile);
		
		//첨부파일마스터ID
		String attachId=stNo+"CommonNotice"+attEndId;  //메소드를 하나 만들어서 +1
		commonNoticeVO.setUserNo(stNo);//학번
		commonNoticeVO.setComAttFileId(attachId);//첨부파일 ID
		
		//기본정보 insert
		result+= commonNoticeMapper.createPost(commonNoticeVO);
		log.info("result(2)>"+result);//result(2)>1
		
		//파일첨부 insert
		result+= this.uploadUtils.uploadMulti(comAttFile, attachId);
		log.info("result(3)>"+result);
		
		return result;
	}

	//수정
	@Transactional
	@Override
	public int updatePost(CommonNoticeVO commonNoticeVO) {
		int result =0; //결과값
		//commonNoticeMapper.updatePost(commonNoticeVO);
		
	    // 로그인 아이디
	    String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
	    log.info("stNo>" + stNo); // stNo>A001
	    
	    // 파일업로드 마지막번호 + 1
	    String attEndId = this.commonNoticeMapper.attEndId(stNo);
	    log.info("attEndId>" + attEndId); // attEndId>95
	    
	    //일반공지첨부파일
	    MultipartFile[] comAttFile = commonNoticeVO.getComAttFile();
	    log.info("comAttFile : {}", comAttFile);
	    
		// 사용자가 아무파일도 선택하지 않았을 때, 이름도 없고, 사이즈도 0인 파일이 넘어옴
	    // 지금 VO와 DB 컬럼명의 매칭이 이상함(파일 자체랑, 파일URL이랑 구분이 안되고 있음)
		if(commonNoticeVO.getComAttFile()[0].getOriginalFilename().equals("")) {
			log.debug("사용자가 아무 파일도 선택하지 않았어용");
		    commonNoticeVO.setComAttFileId("ttbang"); // 첨부파일 ID			
		    // 기본정보 update
		    commonNoticeMapper.updatePost(commonNoticeVO);
		    log.info("updatePost 성공");
		
		}else {
			// 사용자가 파일을 선택 추가 했어용
		    String attachId = stNo + "CommonNotice" + attEndId; // 메소드를 하나 만들어서 +1
		    commonNoticeVO.setUserNo(stNo); // 학번
		    commonNoticeVO.setComAttFileId(attachId); // 첨부파일 ID
		    
		    // 기본정보 update
		    result=commonNoticeMapper.updatePost(commonNoticeVO);
		    log.info("updatePost 성공");
		    
		    //파일 수정
		    	//1) 기존 파일 삭제
			 this.commonNoticeMapper.uploadFileDelete(attachId);
		    	//2) 파일 등록 
			result += this.uploadUtils.uploadMulti(comAttFile, attachId);
	        log.info("파일 업로드 성공");
		}
		return result;
	    
	}

	//삭제
	@Override
	public int deletePost(String comNotNo) {
		return commonNoticeMapper.deletePost(comNotNo);
	}

	//조회수
	@Override
	public int ViewCnt(String comNotNo) {
		return commonNoticeMapper.ViewCnt(comNotNo);
	}

	//상세
	@Override
	public CommonNoticeVO detail(String comNotNo) {
		return this.commonNoticeMapper.detail(comNotNo);
	}

	//첨부파일
	@Override
	public List<Map<String, Object>> selectFileList(String comNotNo) {
		return this.commonNoticeMapper.selectFileList(comNotNo);
	}
	
	//첨부파일 다운
//	@Override
//	public List<Map<String, Object>> fileDown(List<Map<String, Object>> list)  {
//		
//		return this.commonNoticeMapper.fileDown(list);
//	}

}
