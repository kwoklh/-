package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 타임 게시글 VO
 */
@Data
public class TimeBoardVO {
	private String timeBNo;					// 게시글 번호	
	private String timeBGubun;				// 게시글 구분
	private String timeBFUserId;			// 타임게시글작성ID
	private String timeBTitle;				// 게시글 제목
	private String timeBocontent;			// 게시글 내용
	private int timeBohits;					// 게시글 조회수
	private Date timeDate;					// 게시글 작성일자
	private String timeBYn;					// 블라인드 여부
	private String timeDYn;					// 게시글 삭제 여부
	private MultipartFile timeAttFile;		// 게시글 첨부파일
	private Date timeBUpdDate;				// 타임 게시글 수정일자
}
