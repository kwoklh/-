package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * @author PC-11
 * 공통첨부파일(마스터) VO
 */
@Data
public class ComAttachFileVO {
	private String comAttMId;		// 첨부파일 마스터 ID
	private String attFileName;		// 파일 이름
	private long attFileSize;		// 전체 파일 사이즈
	private Date attRegDate;		// 최초 등록 일시
	
	private List<ComAttachDetVO> ComAttachDetVOList;
	private ComAttachDetVO comAttachDetVO;
	
}
