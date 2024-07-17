package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 포틀릿 VO
 */
@Data
public class PortletVO {
	private String userId;		// 사용자 ID
	private int width;			// 영역 너비
	private int hight;			// 영역 높이
	private int xCoor;			// X 좌표
	private int yCoor;			// Y 좌표
}
