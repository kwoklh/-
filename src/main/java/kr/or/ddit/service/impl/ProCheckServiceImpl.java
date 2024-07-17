package kr.or.ddit.service.impl;


import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.ProCheckMapper;
import kr.or.ddit.service.ProCheckService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.ProfessorVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProCheckServiceImpl implements ProCheckService {

	@Autowired
	ProCheckMapper proCheckMapper;

	@Autowired
	UploadController UploadUtils;
	   
	
	@Override
	public List<ProfessorVO> searchList(Map<String, Object> map) {
		log.info("condition >>>>>>>> " + map);
		return this.proCheckMapper.searchList(map);
	}

	@Override
	public ProfessorVO profDetail(ProfessorVO professorVO) {
		return this.proCheckMapper.profDetail(professorVO);
	}
	
	@Transactional
	   @Override
	   public int profAddAjax(ProfessorVO professorVO) {
	      int result=0;
	      //파일 확인 
	      MultipartFile uploadFile = professorVO.getComAttDetFile();
	      String id =SecurityContextHolder.getContext().getAuthentication().getName();
	      String attachId = id+"Profeesor"+professorVO.getProNo()+"";  // 메소드를 하나 만들어서 +1씩 증가하는 메소드 [만들기]? 
	  //  String userNo = SecurityContextHolder.getContext().getAuthentication().getName();
	      professorVO.setProNo(id);//교수 ID
	      professorVO.setComAttMId(attachId);//첨부파일 ID
	      //교수정보 등록
	      result+= proCheckMapper.profAddAjax(professorVO);
	      //교수상세 정보
	      result+= proCheckMapper.userInfoAdd(professorVO);
	      //학과정보 
	      result+= proCheckMapper.comDetCodeAdd(professorVO);
	      //교수 부모 첨부파일
	      result+= proCheckMapper.comAttachFileAdd(professorVO);
	      //교수 청부파일 정보
	      result+= proCheckMapper.comAttachDetAdd(professorVO);
	      //파일첨부 insert
	      result+= this.UploadUtils.uploadOne(uploadFile, attachId);
	   
	      return result;
	   }
}
