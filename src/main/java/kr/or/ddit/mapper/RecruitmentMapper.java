package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.RecruitmentVO;

public interface RecruitmentMapper {
	public int recruitmentTotal(Map<String, Object> map);

	public List<RecruitmentVO> recruitmentVOList(Map<String, Object> map);
}
