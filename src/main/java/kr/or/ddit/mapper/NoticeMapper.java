package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.QuestionVO;

public interface NoticeMapper {
	
	//전체 행의 수
	public int getTotal(Map<String,Object> map);
		
	// 목록 뷰
	public List<QuestionVO> noticeList(Map<String,Object> map);
}
