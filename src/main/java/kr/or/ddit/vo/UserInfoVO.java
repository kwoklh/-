package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

/**
 * @author PC-11
 * 사용자관리 VO
 */
@Data
public class UserInfoVO {
	private String userNo;			// 전사적아이디
	private String userName;        // 이름
	private String userPass;        // 비밀번호
	private String userTel;         // 연락처
	private String userGubun;       // 사용자구분
	private int enabled;            // 사용여부
	private List<AuthorityVO> authorityVOList; // 권한
	private String pwd; // 임시비밀번호 (비밀번호 찾기 사용)
	private String url;				// 사용자 프로필사진 경로
	private String deptName;		// 학과이름
}
