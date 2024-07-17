package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.UserInfoVO;

public interface ProCheckMapper {

	List<ProfessorVO> searchList(Map<String, Object> map);

	ProfessorVO profDetail(ProfessorVO professorVO);

	int profAddAjax(ProfessorVO professorVO);

	int userInfoAdd(ProfessorVO professorVO);

	int comDetCodeAdd(ProfessorVO professorVO);

	int comAttachFileAdd(ProfessorVO professorVO);

	int comAttachDetAdd(ProfessorVO professorVO);

}
