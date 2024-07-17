package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ProfessorVO;

public interface ProCheckService {

	public List<ProfessorVO> searchList(Map<String, Object> map);

	public ProfessorVO profDetail(ProfessorVO professorVO);

	public int profAddAjax(ProfessorVO professorVO);
	
}
