package kr.or.ddit.service;

import java.util.List;
import java.util.Map;


import kr.or.ddit.vo.CommonNoticeVO;

public interface CommonNoticeService {

	public int getTotal(Map<String, Object> map);
	
	//목록
	public List<CommonNoticeVO> list(Map<String, Object> map);

	//등록
	public int createPost(CommonNoticeVO commonNoticeVO);
	
	// 수정 실행
	public int updatePost(CommonNoticeVO commonNoticeVO);

	// 삭제 실행
	public int deletePost(String comNotNo);

	// 조회수
	public int ViewCnt(String comNotNo);

	// 상세
	public CommonNoticeVO detail(String comNotNo);

	// 첨부파일
	public List<Map<String, Object>> selectFileList(String comNotNo);

	// 첨부파일 다운
//	public List<Map<String, Object>> fileDown(List<Map<String, Object>> list);

	

	


	


	
	
}
