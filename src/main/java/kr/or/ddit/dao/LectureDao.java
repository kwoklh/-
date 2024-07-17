package kr.or.ddit.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StuLecCartVO;
import kr.or.ddit.vo.StuLectureVO;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class LectureDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public List<LectureVO> searchList(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("lecture.searchList",map);
	}

	public List<LectureVO> list() {
		return this.sqlSessionTemplate.selectList("lecture.list");
	}

	public List<StuLecCartVO> cartList(String stNo) {
		return this.sqlSessionTemplate.selectList("lecture.cartList",stNo);
	}

	public int countLec(String stNo) {
		return this.sqlSessionTemplate.selectOne("lecture.countLec",stNo);
	}

	public int sumLecScore(String stNo) {
		return this.sqlSessionTemplate.selectOne("lecture.sumLecScore", stNo);
	}

	public int insertCart(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("lecture.insertCart", map);
	}

	public int deleteCart(Map<String, Object> map) {
		return this.sqlSessionTemplate.delete("lecture.deleteCart", map);
	}

	public int jumpil(String stNo) {
		return this.sqlSessionTemplate.selectOne("lecture.junpil", stNo);
	}

	public int junsun(String stNo) {
		return this.sqlSessionTemplate.selectOne("lecture.junsun", stNo);
	}

	public int gyopil(String stNo) {
		return this.sqlSessionTemplate.selectOne("lecture.gyopil", stNo);
	}

	public int gyosun(String stNo) {
		return this.sqlSessionTemplate.selectOne("lecture.gyosun", stNo);
	}

	public List<StuLecCartVO> myLecCart(String stNo) {
		return this.sqlSessionTemplate.selectList("lecture.myLecCart", stNo);
	}

	public List<StuLectureVO> myLecList(String stNo) {
		return this.sqlSessionTemplate.selectList("lecture.myLecList", stNo);
	}

	public int lecSum(String stNo) {
		return this.sqlSessionTemplate.selectOne("lecture.lecSum", stNo);
	}

	public int lecCount(String stNo) {
		return this.sqlSessionTemplate.selectOne("lecture.lecCount", stNo);
	}

	public int insertMyLec(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("lecture.insertMyLec", map);
	}

	public int deleteMyLec(Map<String, Object> map) {
		return this.sqlSessionTemplate.update("lecture.deleteMyLec", map);
	}

	public List<LectureVO> lecInfo(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("lecture.lecInfo", map);
	}

	public StudentVO myInfo(String stNo) {
		return this.sqlSessionTemplate.selectOne("lecture.myInfo", stNo);
	}

	public List<LectureVO> searchHandbookList(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("lecture.searchHandbookList", map);
	}

}
