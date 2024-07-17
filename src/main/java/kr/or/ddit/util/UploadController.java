package kr.or.ddit.util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.service.dao.AttachDao;
import kr.or.ddit.vo.ComAttachDetVO;
import kr.or.ddit.vo.ComAttachFileVO;
import kr.or.ddit.vo.StuAttachFileVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UploadController {
	@Autowired
	String uploadFolder;
	@Autowired
	String uploadPath;//c://upload
	@Autowired
	AttachDao attachDao;
	/**
	 * 프로필사진저장 
	 * @param uploadFile vo MultipartFile 프로퍼티명
	 * @param stuAttaNo 첨부파일번호
	 * @param stNo	학번/사번
	 * @param stuGubun 첨부파일구분
	 * @return
	 */
	public int stuAttachFile(MultipartFile uploadFile,String stuAttaNo,String stNo,String stuGubun) {
		
		int result = 0;
		File uploadPath =new File("/student");
		if(uploadPath.exists()==false){
			uploadPath.mkdirs();
		}
		log.info("-----------------");
		log.info("파일명:"+ uploadFile.getOriginalFilename());
		log.info("파일크기:"+ uploadFile.getSize());
		log.info("MIME: "+ uploadFile.getContentType());
		
		//원본명
		String uploadFileName = uploadFile.getOriginalFilename();
		//저장명(물리명)
		UUID uuid = UUID.randomUUID();
		String PFileName = uuid.toString()+"_"+ uploadFileName; //물리명
		//
		File saveFile = new File(uploadPath,PFileName);
		
		try {
			uploadFile.transferTo(saveFile);
			String filePath = "/upload/student"+PFileName;
			
			StuAttachFileVO stuAttachFileVO = new StuAttachFileVO();
			stuAttachFileVO.setStuAttNo(stuAttaNo);
			stuAttachFileVO.setStNo(stNo);
			stuAttachFileVO.setStuGubun(stuGubun);
			stuAttachFileVO.setStuOrigin(uploadFileName);
			stuAttachFileVO.setStuName(PFileName);
			stuAttachFileVO.setStuFileSize(uploadFile.getSize());
			stuAttachFileVO.setStuFileDate(null);//sysdate 로 함
			stuAttachFileVO.setStuFilePath(filePath);
			
			log.debug("stuAttachFileVO:{}",stuAttachFileVO);
			
			result+=attachDao.insertStuAttach(stuAttachFileVO);
			
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * 파일 첨부 하나 일 경우 사용하는 메소드
	 * @param uploadFile vo MultipartFile 프로퍼티명
	 * @param attachId 첨부파일마스터ID(학번/사번+테이블명+게시판번호)
	 * @return 등록 완료 숫자
	 */
	public int uploadOne(MultipartFile uploadFile,String attachId) {
		int result = 0;
		
		//권한
		Authentication auth= SecurityContextHolder.getContext().getAuthentication(); 
		
	    Collection<? extends GrantedAuthority> authorities=auth.getAuthorities();
		
		log.info("현재>>{}",auth);
	    log.info("현재>>{}",authorities);
	    log.info("test>"+authorities.contains(new SimpleGrantedAuthority("ROLE_ADMIN")));
	    log.info("test>"+authorities.contains(new SimpleGrantedAuthority("ROLE_STUDENT"))); //학생로그인일때 true
	    
	    File uploadPath = null;
	    //웹경로
	    String SelectPath=null;
	    
		if(authorities.contains(new SimpleGrantedAuthority("ROLE_STUDENT")) == true) {
			log.info("학생 권한!");
			uploadPath = new File("/student");
			SelectPath="/upload/student/";
		}
		if(authorities.contains(new SimpleGrantedAuthority("ROLE_PROFESSOR")) == true) {
			log.info("교수 권한!");
			uploadPath = new File("/prof");
			SelectPath="/upload/prof/";
		}
		if(authorities.contains(new SimpleGrantedAuthority("ROLE_ADMIN")) == true) {
			log.info("권리자 권한!");
			uploadPath = new File("/admin");
			SelectPath="/upload/admin/";
		}
		
		if(uploadPath.exists()==false){
			uploadPath.mkdirs();
		}
		log.info("-----------------");
		log.info("파일명:"+ uploadFile.getOriginalFilename());
		log.info("파일크기:"+ uploadFile.getSize());
		log.info("MIME: "+ uploadFile.getContentType());
		
		String uploadFileName = uploadFile.getOriginalFilename();
		
		//UUID : 랜덤값 생성
		UUID uuid = UUID.randomUUID();
		String PFileName = uuid.toString()+"_"+ uploadFileName; //물리명
//		String ComAttMId=globalCode+"_"+uuid.toString();
		//복사 설계
		File saveFile = new File(uploadPath,PFileName);
		try {
			uploadFile.transferTo(saveFile);
			
			//웹경로
			String filePath = SelectPath+PFileName;
			
			ComAttachFileVO comAttachFileVO = new ComAttachFileVO();
			comAttachFileVO.setComAttMId(attachId);//첨부파일 마스터 ID
			comAttachFileVO.setAttFileName(attachId);//파일이름
			comAttachFileVO.setAttFileSize(uploadFile.getSize());//전체 파일 사이즈
			comAttachFileVO.setAttRegDate(null); //쿼리문으로 sysdate 함
			log.info("upload comAttachFileVO>"+comAttachFileVO);
			
			result+=attachDao.insertFileAttach(comAttachFileVO);
			
			ComAttachDetVO comAttachDetVO = new ComAttachDetVO();
			comAttachDetVO.setComAttDetNo(1);// 상세 일렬 번호
			comAttachDetVO.setComAttMId(attachId); //첨부파일 마스터 ID
			comAttachDetVO.setLogiFileName(uploadFileName); // 논리 파일명
			comAttachDetVO.setPhyFileName(PFileName);//물리 파일명
			comAttachDetVO.setPhySaveRoute(filePath);//물리 파일경로
			comAttachDetVO.setPhyRegDate(null);//sysdate로 함
			comAttachDetVO.setComAttDetSize(uploadFile.getSize());
			comAttachDetVO.setComAttDetType(uploadFile.getContentType());
			comAttachDetVO.setComAttDetDelYn(null); //N
			log.info("upload comAttachDetVO:"+comAttachDetVO);
			
			result+=attachDao.insertDetAttach(comAttachDetVO);
			
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	/**
	 * 파일 여러개 첨부 메소드
	 * @param upload vo MultipartFile[] 프로퍼티명
	 * @param attachId 첨부파일마스터ID(학번/사번+테이블명+게시판번호)
	 * @return 등록 완료 숫자
	 */
	 public int uploadMulti(MultipartFile[] upload, String attachId) {
			int result = 0;
			
			//권한
			Authentication auth= SecurityContextHolder.getContext().getAuthentication(); 
			
		    Collection<? extends GrantedAuthority> authorities=auth.getAuthorities();
			
			//파일 저장 경로
			 File uploadPath = null;
			 //db용 웹경로
			 String SelectPath=null;
			
			if(authorities.contains(new SimpleGrantedAuthority("ROLE_STUDENT")) == true) {
				log.info("학생 권한!");
				uploadPath = new File("/student");
				SelectPath="/upload/student/";
			}
			if(authorities.contains(new SimpleGrantedAuthority("ROLE_PROFESSOR")) == true) {
				log.info("교수 권한!");
				uploadPath = new File("/prof");
				SelectPath="/upload/prof/";
			}
			if(authorities.contains(new SimpleGrantedAuthority("ROLE_ADMIN")) == true) {
				log.info("권리자 권한!");
				uploadPath = new File("/admin");
				SelectPath="/upload/admin/";
			}
			
			if(uploadPath.exists()==false){
				uploadPath.mkdirs();
			}
			 String uploadFileName =""; //업로드용
//			 String fileName=""; // DB용
			 int seq = 1;
			 long fullSize = 0;  //전체 파일 사이즈
			 UUID uuidComAttMId = UUID.randomUUID();
//			 String ComAttMId=globalCode+"_"+uuidComAttMId.toString();
			 
			 for(MultipartFile multipartFile:upload) {
				 fullSize += multipartFile.getSize();
			 }
			 
			 ComAttachFileVO comAttachFileVO = new ComAttachFileVO();
				comAttachFileVO.setComAttMId(attachId);//첨부파일 마스터 ID
				comAttachFileVO.setAttFileName(attachId);//파일이름
				comAttachFileVO.setAttFileSize(fullSize);//전체 파일 사이즈
				comAttachFileVO.setAttRegDate(null); //쿼리문으로 sysdate 함
				log.info("upload "+comAttachFileVO);
			result+=attachDao.insertFileAttach(comAttachFileVO);
				
			 for(MultipartFile multipartFile:upload) {
			 log.info("-----------------");
			 log.info("파일명:"+ multipartFile.getOriginalFilename());
			 log.info("파일크기:"+ multipartFile.getSize());
			 log.info("MIME: "+ multipartFile.getContentType());
			 uploadFileName = multipartFile.getOriginalFilename();
			
			//UUID : 랜덤값 생성
			UUID uuid = UUID.randomUUID();
			String PFileName = uuid.toString()+"_"+ uploadFileName;
			//복사 설계
			File saveFile = new File(uploadPath,PFileName);
			
			try {
				multipartFile.transferTo(saveFile);
				//db 저장용 경로
				String filePath = SelectPath+PFileName;
				
				ComAttachDetVO comAttachDetVO = new ComAttachDetVO();
				comAttachDetVO.setComAttDetNo(seq++);// 상세 일렬 번호
				comAttachDetVO.setComAttMId(attachId); //첨부파일 마스터 ID
				comAttachDetVO.setLogiFileName(multipartFile.getOriginalFilename()); // 논리 파일명
				comAttachDetVO.setPhyFileName(PFileName);//물리 파일명
				comAttachDetVO.setPhySaveRoute(filePath);//물리 파일경로
				comAttachDetVO.setPhyRegDate(null);//sysdate로 함
				comAttachDetVO.setComAttDetSize(multipartFile.getSize());
				comAttachDetVO.setComAttDetType(multipartFile.getContentType());
				comAttachDetVO.setComAttDetDelYn(null); //N
				log.info("upload comAttachDetVO:"+comAttachDetVO);
				
				result+=attachDao.insertDetAttach(comAttachDetVO);
				
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		 }
			return result;
	 }
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
		
	}
}
