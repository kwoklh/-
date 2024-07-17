package kr.or.ddit.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.LectureVO;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ProfTimeTableDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<LectureVO> profLecList(String userNo) {
		return this.sqlSessionTemplate.selectList("profTimeTable.profLecList", userNo);
	}

}
