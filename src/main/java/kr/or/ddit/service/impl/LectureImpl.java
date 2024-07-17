package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.LectureDao;
import kr.or.ddit.service.LectureService;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StuLecCartVO;
import kr.or.ddit.vo.StuLectureVO;
import kr.or.ddit.vo.StudentVO;

@Service
public class LectureImpl implements LectureService {
	
	@Autowired
	LectureDao lectureDao;

	@Override
	public List<LectureVO> searchList(Map<String, Object> map) {
		return this.lectureDao.searchList(map);
	}

	@Override
	public List<LectureVO> list() {
		return this.lectureDao.list();
	}

	@Override
	public List<StuLecCartVO> cartList(String stNo) {
		return this.lectureDao.cartList(stNo);
	}

	@Override
	public int countLec(String stNo) {
		return lectureDao.countLec(stNo);
	}

	@Override
	public int sumLecScore(String stNo) {
		return lectureDao.sumLecScore(stNo);
	}

	@Override
	public int insertCart(Map<String, Object> map) {
		return lectureDao.insertCart(map);
	}

	@Override
	public int deleteCart(Map<String, Object> map) {
		return lectureDao.deleteCart(map);
	}

	@Override
	public int junpil(String stNo) {
		return lectureDao.jumpil(stNo);
	}

	@Override
	public int junsun(String stNo) {
		return lectureDao.junsun(stNo);
	}

	@Override
	public int gyopil(String stNo) {
		return lectureDao.gyopil(stNo);
	}

	@Override
	public int gyosun(String stNo) {
		return lectureDao.gyosun(stNo);
	}

	@Override
	public List<StuLecCartVO> myLecCart(String stNo) {
		return lectureDao.myLecCart(stNo);
	}

	@Override
	public List<StuLectureVO> myLecList(String stNo) {
		return lectureDao.myLecList(stNo);
	}

	@Override
	public int lecSum(String stNo) {
		return lectureDao.lecSum(stNo);
	}

	@Override
	public int lecCount(String stNo) {
		return lectureDao.lecCount(stNo);
	}

	@Override
	public int insertMyLec(Map<String, Object> map) {
		return lectureDao.insertMyLec(map);
	}

	@Override
	public int delectMyLec(Map<String, Object> map) {
		return lectureDao.deleteMyLec(map);
	}

	@Override
	public List<LectureVO> lecInfo(Map<String, Object> map) {
		return lectureDao.lecInfo(map);
	}

	@Override
	public StudentVO myInfo(String stNo) {
		return lectureDao.myInfo(stNo);
	}

	@Override
	public List<LectureVO> searchHandbookList(Map<String, Object> map) {
		return lectureDao.searchHandbookList(map);
	}

	
}
