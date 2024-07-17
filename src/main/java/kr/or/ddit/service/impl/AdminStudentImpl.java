package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.dao.AdminStudentDao;
import kr.or.ddit.service.AdminStudentService;
import kr.or.ddit.vo.AuthorityVO;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserInfoVO;

@Service
public class AdminStudentImpl implements AdminStudentService{

	@Autowired
	AdminStudentDao adminStudentDao;

	@Override
	public List<ComDetCodeVO> deptList() {
		return this.adminStudentDao.deptList();
	}

	@Override
	public List<StudentVO> stdList(Map<String, Object> map) {
		return this.adminStudentDao.stdList(map);
	}

	@Override
	public int getTotal() {
		return this.adminStudentDao.getTotal();
	}

	@Override
	public StudentVO detail(String stNo) {
		return this.adminStudentDao.detail(stNo);
	}

	@Override
	public int updateStd(Map<String, Object> map) {
		return this.adminStudentDao.updateStd(map);
	}

	@Override
	public int updateStdStat(Map<String, Object> map) {
		return this.adminStudentDao.updateStdStat(map);
	}

	@Override
	public List<ComCodeVO> getCollege() {
		return this.adminStudentDao.getCollege();
	}

	@Override
	public List<ComDetCodeVO> getDept(Map<String, Object> map) {
		return this.adminStudentDao.getDept(map);
	}

	@Override
	public String getStNo(Map<String, Object> map) {
		return this.adminStudentDao.getStNo(map);
	}

	@Override
	public List<ProfessorVO> getProfList(Map<String, Object> map) {
		return this.adminStudentDao.getProfList(map);
	}

	@Override
	public int stuAdd(StudentVO studentVO) {
		
		// 사용자 관리 VO
		UserInfoVO userInfoVO = new UserInfoVO();
		userInfoVO.setUserNo(studentVO.getStNo());
		userInfoVO.setUserName(studentVO.getStName());
		userInfoVO.setUserTel(studentVO.getStTel());
		userInfoVO.setUserGubun("01"); // 학생 구분 
		userInfoVO.setEnabled(1);
		
		// 권한 VO
		AuthorityVO authorityVO = new AuthorityVO();
		authorityVO.setAuthority("ROLE_STUDENT");
		authorityVO.setUserNo(studentVO.getStNo());
		
		MultipartFile ajaxDetailFile = studentVO.getUploadFile();
		
		return 0;
	}

}
