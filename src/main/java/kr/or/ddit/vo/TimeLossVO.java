package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 타임분실물게시판 VO
 */
@Data
public class TimeLossVO {
	private String timeLoNo;				// 분실게시글번호
	private String stNo;                    // 학번
	private String timeLoTitle;             // 분실게시글제목
	private String timeLoCon;               // 분실게시글내용
	private int timeLoViews;                // 분실게시글조회수
	private String timeLoYn;                // 분실물회수여부
	private MultipartFile timeLoFile;       // 첨부파일
	private Date timeLoDate;                // 분실게시글작성일자
	private String timeLoDelYn;             // 분실게시글삭제여부
	private String timeLoItem;              // 분실물등록
	private String timeLoStat;              // 유실물상태
	private Date timeLoUpdDate;             // 분실게시글최종수정일자
}
