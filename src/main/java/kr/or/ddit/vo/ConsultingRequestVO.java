package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 상담 신청 현황 VO
 */
@Data
public class ConsultingRequestVO {
	private String consulReqNo;				// 상담 신청 번호
	private String stNo;					// 학번
	private Date consulReqDate;				// 상담 신청 작성 날짜
	private String consulReqCondition;		// 상담 신청 상태
	private String consulTitle;				// 상담 신청 제목
	private String consulCon;				// 상담 신청 내용
	private String consulReqTime;			// 상담 예약 날짜
	private String consulCateg;				// 상담 카테고리
}
