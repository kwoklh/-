package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.NoticeMapper;
import kr.or.ddit.service.NoticeService;
import kr.or.ddit.vo.QuestionVO;

/**
 * @author PC-10
 * 문의사항
 */
@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeMapper noticeMapper;
	
	// 총 행의 개수
	@Override
	public int getTotal(Map<String,Object> map) {
		System.out.println("getTotal >> NoticeServiceImpl : " + map);
		return this.noticeMapper.getTotal(map);
	}
	
	//문의사항 리스트
	@Override
	public List<QuestionVO> noticeList(Map<String,Object> map) {
		return this.noticeMapper.noticeList(map);
	}

}
