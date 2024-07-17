package kr.or.ddit.vo;


import java.sql.Date;
import java.text.SimpleDateFormat;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.util.Defind;
import lombok.Data;

/**
 * @author PC-11
 * 봉사활동 VO
 */
@Data
public class VolunteerVO {
	private String volNo;			  // 활동번호
	private String stNo;      		  // 학번
	private String volPlace;  		  // 봉사장소
	private Date volStart;    		  // 봉사시작날짜
	private Date volEnd;      		  // 봉사종료날짜
	private int volTime;      		  // 봉사시간
	private String volCon;      	  // 봉사내역
	private String volFileStr;    // 첨부파일ID
	private String volFileName;    // 첨부파일이름
	private MultipartFile vonFile;    // 첨부파일
//	private MultipartFile[] vonFile;    // 첨부파일들 예시
	
	private ComAttachFileVO comAttachFileVO;
	private ComAttachDetVO comAttachDetVO;
	
	public String getVolStartDisplay() {
		String result = "";
		if(volStart != null) {
			result = new SimpleDateFormat(Defind.DATE_PATTERN).format(volStart);
		}
		return result;
	}
	public String getVolEndDisplay() {
		String result = "";
		if(volEnd != null) {
			result = new SimpleDateFormat(Defind.DATE_PATTERN).format(volEnd);
		}
		return result;
	}
	public String getVolConDisplay() {
		String result = "";
		int volConLength = volCon.length();
		if(volCon == null || volConLength <=Defind.substringEnd ) {
			return volCon;
		}
		return volCon.substring(0,Defind.substringEnd)+"...";
	}
}
