package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 분할 납부 기간 관리 VO
 */
@Data
public class DivPayTermVO {
	private int year;				// 년도
	private String semester;		// 학기
	private int divPaySq;			// 분할 차수
	private Date divPayStDate;		// 분할 납부 시작 일시
	private Date divPayEnDate;		// 분할 납부 종료 일시
}
