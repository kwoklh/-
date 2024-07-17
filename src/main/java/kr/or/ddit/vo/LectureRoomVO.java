package kr.or.ddit.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 강의실 VO
 */
@Data
public class LectureRoomVO {
	private String lecRoNo;			// 강의실 번호
	private String lecRoName;		// 강의실 명
	private String bldNo;			// 건물 번호	
	private MultipartFile lecRoPic;	// 강의실 사진
	private int lecRPer;			// 강의실 수용 인원
}
