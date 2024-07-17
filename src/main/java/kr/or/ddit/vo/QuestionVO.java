package kr.or.ddit.vo;


import java.sql.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 문의 관리 VO
 */
@Data
public class QuestionVO {
	private String rn;					// 화면에 보여주는 용 번호
	private String queNo;				// 문의글 번호
	private String queTitle;			// 문의글 제목
	private String queContent;			// 문의글 내용
	private String queGubun;			// 문의글 구분
	
	private String queDate;				// 문의 최초 작성 일자
	private String queUserId;			// 문의 최초 작성 ID
	
	private String queFDate;			// 문의 최종 작성 일자
	private String queFUserId;			// 문의 최종 작성 ID
	private String queYn;				// 답변 상태
	private String queDelYn;			// 문의 삭제 여부	
	private String queAttFile;			// 문의 첨부파일 Url (DB에 값이 들어감)
	private MultipartFile queAttFileUrl;	// 문의 첨부파일
	
	private UserInfoVO userInfoVOList; // 사용자 관리
}
