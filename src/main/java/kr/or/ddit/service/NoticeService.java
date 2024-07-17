package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.QuestionVO;

/**
 * @author PC-10
 * 문의사항 리스트
 */
public interface NoticeService {
	//총 행의 개수
	public int getTotal(Map<String,Object> map);
	
	//문의사항 리스트
	public List<QuestionVO> noticeList(Map<String,Object> map);
}
