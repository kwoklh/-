package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 학사 일정 VO
 */
@Data
public class ScheduleVO {
	private String scheNo;			// 일정 번호
	private String scheName;		// 일정명
	private Date scheStrDate;		// 일정 시작 일시
	private Date scheEndDate;		// 일정 종료 일시
	private Date scheFDate;			// 학사 최종 작성 일시
	private String scheFWriter;		// 학사 최종 작성자
	private String scheDelYn;		// 학사 일정 삭제 여부
}
