package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StuLecCartVO;
import kr.or.ddit.vo.StuLectureVO;
import kr.or.ddit.vo.StudentVO;

public interface LectureService {

	public List<LectureVO> list();

	public List<LectureVO> searchList(Map<String, Object> map);

	public List<StuLecCartVO> cartList(String stNo);

	public int countLec(String stNo);

	public int sumLecScore(String stNo);

	public int insertCart(Map<String, Object> map);

	public int deleteCart(Map<String, Object> map);

	public int junpil(String stNo);

	public int junsun(String stNo);

	public int gyopil(String stNo);

	public int gyosun(String stNo);

	public List<StuLecCartVO> myLecCart(String stNo);

	public List<StuLectureVO> myLecList(String stNo);

	public int lecSum(String stNo);

	public int lecCount(String stNo);

	public int insertMyLec(Map<String, Object> map);

	public int delectMyLec(Map<String, Object> map);

	public List<LectureVO> lecInfo(Map<String, Object> map);

	public StudentVO myInfo(String stNo);

	public List<LectureVO> searchHandbookList(Map<String, Object> map);

}
