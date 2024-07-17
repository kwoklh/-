package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 학생 첨부파일 VO
 */
@Data
public class StuAttachFileVO {
	private String stuAttNo;		// 첨부파일 번호
	private String stNo;			// 학번
	private String stuGubun;		// 첨부파일 구분
	private String stuAttType;		// 첨부파일 타입
	private String stuOrigin;		// 원본명
	private String stuName;			// 저장명
	private String stuFileName;			// 저장명(채연)
	private long stuFileSize;		// 파일 크기
	private Date stuFileDate;		// 업로드 날짜
	private String stuFilePath;		// 파일 저장 경로
}
