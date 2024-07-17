package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 
 */
@Data
public class GraduateVO {
	private String stNo;		// 학번
	private int stHakjum;		// 전체 이수 학점
	private int stVolunter;		// 봉사 활동
	private int stToeic;		// 토익
	private String stThesis;	// 논문
	private String stWork;		// 졸업 작품
	private Date stGradDate;	// 졸업 예정일
}
