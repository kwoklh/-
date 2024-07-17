package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.StudentCheckMapper;
import kr.or.ddit.service.StudentCheckService;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StudentCheckServiceImpl implements StudentCheckService{
	
	@Autowired
	StudentCheckMapper studentCheckMapper; 
	
	// 목록 뷰 
	public List<StudentVO> list(Map<String, Object>map){
		return this.studentCheckMapper.list(map);
	}
	
	@Override
	public StudentVO stdDetail(StudentVO studentVO) {
		return this.studentCheckMapper.stdDetail(studentVO);

	}

	@Override
	public List<StudentVO> searchList(Map<String, Object> map) {
		log.info("condition >>>>>>>> " + map);
		return this.studentCheckMapper.searchList(map);
	}
}
