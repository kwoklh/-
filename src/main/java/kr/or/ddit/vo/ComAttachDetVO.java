package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

/**
 * @author PC-11 공통첨부파일 상세 VO
 */
@Data
@SuppressWarnings("serial")
public class ComAttachDetVO implements Serializable {
	private int comAttDetNo; // 상세 일련 번호
	private String comAttMId; // 첨부파일 마스터 ID
	private String logiFileName; // 논리 파일명
	private String phyFileName; // 물리 파일명
	private String phySaveRoute; // 물리 파일 경로
	private Date phyRegDate; // 물리 등록 일시
	private long comAttDetSize; // 파일 사이즈
	private String comAttDetType; // 파일 확장자
	private String comAttDetDelYn; // 삭제 여부

}
