package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

/**
 * @author PC-11
 * 수강 신청 장바구니 VO
 */
@Data
public class StuLecCartVO {
	private String stuLecCartCode;		// 장바구니 번호
	private String lecNo;				// 강의 번호
	private String stNo;				// 학번
	private String stuLecDay;			// 강의 요일/교시
	
	private List<LectureVO> lectureVOList;
	private List<LectureRoomVO> lectureRoomVOList;
	private List<UserInfoVO> userInfoVOList;
	private List<LecTimeVO> lecTimeVOList;
	private List<ComDetCodeVO> comDetCodeVOList;
}
