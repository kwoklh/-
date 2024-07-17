package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 타임 강의 거래 게시판
 */
@Data
public class TimeExchangeBoardVO {
	private String timeExBNo;		       // 거래게시글번호      
	private String timeExDiv;              // 거래게시글구분      
	private String stNo;                   // 학번           
	private String timeExName;             // 거래게시글제목      
	private String timeExCon;              // 거래게시글내용      
	private int timeExViews;               // 거래게시글조회수     
	private Date timeExDate;               // 거래게시글작성일자    
	private String timeExStat;             // 거래상태         
	private MultipartFile timeExFile;      // 첨부파일
	private String stuLecNo;               // 수강번호      
	private String timeExDelYn;            // 거래게시글삭제여부 
}
