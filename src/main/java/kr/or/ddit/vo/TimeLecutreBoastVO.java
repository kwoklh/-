package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 강의자랑게시판 VO
 */
@Data
public class TimeLecutreBoastVO {
	private String timeLecBoNo;                 // 강의자랑게시글번호
	private String stNo;                        // 작성자아이디
	private String timeLecBoName;               // 강의자랑게시글제목
	private String timeLecBoCon;                // 강의자랑게시글내용
	private int timeViews;                      // 강의자랑조회수
	private Date timeLecDate;                   // 강의자랑작성일자
	private int timeLecLike;                    // 강의자랑추천
	private MultipartFile timeLecAttFile;       // 강의자랑첨부파일
	private Date timeLecUpdDate;				// 강의자랑수정일자
}
