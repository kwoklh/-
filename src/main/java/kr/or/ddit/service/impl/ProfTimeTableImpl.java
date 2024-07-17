package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.ProfTimeTableDao;
import kr.or.ddit.service.ProfTimeTableService;
import kr.or.ddit.vo.LectureVO;

@Service
public class ProfTimeTableImpl implements ProfTimeTableService {

	@Autowired
	ProfTimeTableDao profTimeTableDao;	
	@Override
	public List<LectureVO> profLecList(String userNo) {
		return profTimeTableDao.profLecList(userNo);
	}
}
