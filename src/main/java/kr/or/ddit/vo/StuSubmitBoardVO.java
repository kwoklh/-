package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 졸업 자료 제출 게시판
 */
@Data
public class StuSubmitBoardVO {
	private int stSubNo;				// 게시글 번호
	private String stNo;				// 최초 작성자 학번
	private String stSubTitle;			// 게시판 제목
	private String stSubCon;			// 게시판 내용
	private String stSubGubun;			// 게시글 구분
	private Date stSubDate;				// 최초 작성 일자
	private MultipartFile stuAttNo;		// 첨부파일 번호
	private Date stSubFUpdDate;			// 최종 수정일시
	private String stSubFUpdId;			// 최종 수정자
}
