package kr.or.ddit.vo;


import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 일반공지사항VO
 */
@Data
public class CommonNoticeVO {
	private String rn;           		// 화면에 보여주는 용 번호
	private String comNotNo;			// 일반공지번호
	private String userNo;				// 공지사항작성자
	private String comNotName;			// 일반공지제목
	private String comNotCon;			// 일반공지내용
	private int comNotViews;			// 일반공지조회수
	private String comFirstDate;		// 일반공지최초작성일시
	private String comEndDate;			// 일반공지최종작성일시
	private String comNotDelYn;			// 일반공지삭제여부
	private MultipartFile[] comAttFile;	// 일반공지첨부파일
	private String comAttFileId;		// 일반공지첨부파일ID
	private String comGubun;        	// 일반공지구분
	
	private UserInfoVO userInfoVOList;  // 사용자 관리
	private ComAttachFileVO comAttachFileVOList; //첨부파일
	private ComAttachDetVO comAttachDetVOList; //첨부파일 상세
	
}
