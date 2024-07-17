package kr.or.ddit.mapper;

import java.util.Map;

import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StuAttachFileVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserInfoVO;

public interface MainMapper {

	// 학생 정보 상세 조회
	public StudentVO detail(String id);
	
	// 학생 사진 조회
	StuAttachFileVO filedetail(String id);
	
	
	// 학번/사번 찾기
	public UserInfoVO findid(UserInfoVO uservo);
	
	
	// 비밀번호 찾기
	public String findpw(Map<String, Object> map);
	
	
	// 인증번호로 비밀번호 업데이트
	public int updatepw(Map<String, Object> map2);


	// 마이페이지 회원 업데이트
	public void updatepage(StudentVO studentVO);


	// 마이페이지 사진 수정 업데이트
	public int updateAttach(StuAttachFileVO stuattVO);
	
	//비밀번호 검증
	//<select id="pwCheck" parameterType="String">
	public UserInfoVO pwCheck(String userNo);

	// 비밀번호 변경
	public int updatepw2(UserInfoVO userInfoVO);

	// 교수정보 상세조회
	public ProfessorVO detailpro(String proNo);

	// 교수정보 사진 상세조회
	public ProfessorVO detailProPhoto(String proNo);

	// 교수정보 업데이트 1
	public int updatepro(Map<String, Object> map);

	// 교수정보 업데이트 2
	public int updatepro2(ProfessorVO professerVO);
	
	// 교수 사진 업로드 1
	public int updatephoto1(Map<String, Object> map2);

	// 교수 사진 업로드 2
	public int updatephoto2(Map<String, Object> map2);

	// aside 사진 학생
	public StudentVO stuphoto(String name);

	// aisde 사진 교수
	public ProfessorVO prophoto(String name);
	
	
	
	
}
