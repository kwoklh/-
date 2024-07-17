package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.CertificateMapper;
import kr.or.ddit.mapper.RecruitmentMapper;
import kr.or.ddit.mapper.StudentEmploymentMapper;
import kr.or.ddit.service.StudentEmploymentService;
import kr.or.ddit.service.dao.AttachDao;
import kr.or.ddit.util.UploadUtils;
import kr.or.ddit.vo.CertificateVO;
import kr.or.ddit.vo.RecruitmentVO;
import kr.or.ddit.vo.VolunteerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StudentEmploymentServiceImpl implements StudentEmploymentService{

	@Autowired
	StudentEmploymentMapper studentEmploymentMapper;
	@Autowired
	RecruitmentMapper recruitmentMapper;
	@Autowired
	CertificateMapper certificateMapper;
	@Autowired
	AttachDao attachDao;
	@Autowired
	UploadUtils uploadUtils;
	
	@Override
	public List<VolunteerVO> volunteerList(Map<String, Object> map) {
		return this.studentEmploymentMapper.volunteerList(map);
	}
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.studentEmploymentMapper.getTotal(map);
	}
	@Override
	public int volTotalTime(String stNo) {
		return this.studentEmploymentMapper.volTotalTime(stNo);
				
	}
	@Transactional
	@Override
	public int volAddAjax(VolunteerVO volunteerVO) {
		

		//1)volunteer insert
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		String volNo = this.studentEmploymentMapper.mainNumber();
		volunteerVO.setStNo(stNo);
		volunteerVO.setVolNo(volNo);
		String vonFileStr= stNo+"Volunteer"+volNo;
		volunteerVO.setVolFileStr(vonFileStr);
//		log.info("volunteerVO"+volunteerVO);
		int result = this.studentEmploymentMapper.insertVolunteer(volunteerVO);
		
		//2)attach insert
		 MultipartFile uploadFile=volunteerVO.getVonFile();
		result+=this.uploadUtils.uploadOne(uploadFile, vonFileStr);
		
		return result;
	}
	@Override
	public VolunteerVO volDetail(Map<String, Object> map) {
		return this.studentEmploymentMapper.volDetail(map);
	}
	@Transactional
	@Override
	public int volDetailAjax(VolunteerVO volunteerVO) {
		int result=0;
		//학번/사번
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		volunteerVO.setStNo(stNo);
		log.info("volDetailAjax>volunteerVO:{}",volunteerVO);
		
		MultipartFile ajaxDetailFile = volunteerVO.getVonFile();
		log.info("ajaxDetailFile: {}", ajaxDetailFile);

		if (ajaxDetailFile == null) {
		    // 파일이 없는 경우
			log.info("파일없는경우");
		    return this.studentEmploymentMapper.volUpdateAjax(volunteerVO);
		} else {
			log.info("파일있는경우");
		    // 파일이 있는 경우
			//정보 등록
			result+=this.studentEmploymentMapper.volUpdateAjax(volunteerVO);
			//파일삭제
			result+=this.studentEmploymentMapper.volAttachDetDelAjax(volunteerVO);
			result+=this.studentEmploymentMapper.volAttachFileDelAjax(volunteerVO);
			//파일 등록
			MultipartFile uploadFile=volunteerVO.getVonFile();
//			log.info("attaciId:{}",volunteerVO.getVolFileStr());
			result+=uploadUtils.uploadOne(uploadFile, volunteerVO.getVolFileStr());
			return result;
		}

	}
	/**
	 * 채용정보게시판 총개수
	 */
	@Override
	public int recruitmentTotal(Map<String, Object> map) {
		return this.recruitmentMapper.recruitmentTotal(map);
	}
	@Override
	public List<RecruitmentVO> recruitmentVOList(Map<String, Object> map) {
		return this.recruitmentMapper.recruitmentVOList(map);
	}
	/**
	 * 학번에 대한 자격증 총개수
	 */
	@Override
	public int certificateCount(String stNo) {
		return this.certificateMapper.certificateCount(stNo);
	}
	/**
	 * 자격증 총개수
	 */
	@Override
	public int certificateTotal(Map<String, Object> map) {
		return this.certificateMapper.certificateTotal(map);
	}
	@Override
	public List<CertificateVO> certificateVOList(Map<String, Object> map) {
		return this.certificateMapper.certificateVOList(map);
	}
	@Override
	public int cerCreateAjax(CertificateVO certificateVO) {
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		certificateVO.setStNo(stNo);
		return this.certificateMapper.cerCreateAjax(certificateVO);
	}
	@Override
	public int cerDeleteAjax(Map<String, Object> map) {
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		return this.certificateMapper.cerDeleteAjax(map);
	}
	@Override
	public int cerUpdateAjax(Map<String, Object> map) {
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		return this.certificateMapper.cerUpdateAjax(map);
	}
	
	
	
}
