package kr.or.ddit.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import kr.or.ddit.util.Defind;
import lombok.Data;

/**
 * @author PC-11
 * 자격증 VO
 */
@Data
public class CertificateVO {
	private String certCode;		// 자격증 코드 
	private String stNo;			// 학번
	private String certNm;			// 자격증명
	private Date certDate;			// 자격증 취득일
	private Date certDateExp;		// 자격증 발급일
	
	private UserInfoVO userInfoVOList;
	
	public String getCertDateDisplay() {
		String result = "";
		if(certDate != null) {
			result = new SimpleDateFormat(Defind.DATE_PATTERN).format(certDate);
		}
		return result;
	}
	public String getCertDateExpDisplay() {
		String result = "";
		if(certDate != null) {
			result = new SimpleDateFormat(Defind.DATE_PATTERN).format(certDateExp);
		}
		return result;
	}
}
