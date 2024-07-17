package kr.or.ddit.vo;

import lombok.Data;

@Data
public class LecTimeVO {
	private String lecDay;		// 강의 요일
	private String lecNo;		// 강의 번호
	private int lecSt;			// 강의 시작 교시
	private int lecEnd;			// 강의 종료 교시
}
