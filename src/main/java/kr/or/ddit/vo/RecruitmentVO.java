package kr.or.ddit.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.util.Defind;
import lombok.Data;

/**
 * @author PC-11
 * 채용 정보 VO
 */
@Data
public class RecruitmentVO {
	private String recuNo;					// 채용 글 번호
	private String userNo;					// 채용 최초 작성자
	private String recuTitle;				// 채용 글 제목
	private String recuContent;				// 채용 글 내용
	private int recuViews;					// 채용 글 조회수
	private Date recuFirstDate;				// 채용 최초 작성일
	private Date recuEndDate;				// 채용 최종 작성일
	private String recuEndWriter;			// 채용 최종 작성자
	private String recuDelYn;				// 채용 정보 삭제여부
	private MultipartFile[] recuAttFile;		// 첨부파일
	private String recuAttFileId;		// 첨부파일Id
	private String recuAttFileName;		// 첨부파일name
	
	private UserInfoVO userInfoVOList; // 사용자 관리 
	
	public String getRecuEndDateDisplay() {
		String result = "";
		if(recuEndDate != null) {
			result = new SimpleDateFormat(Defind.DATE_PATTERN).format(recuEndDate);
		}
		return result;
	}
	
}
