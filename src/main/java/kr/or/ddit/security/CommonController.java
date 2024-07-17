package kr.or.ddit.security;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommonController {
	//접근 거부 처리
	//요청URI : /accessError
	//요청방식 : get
	@GetMapping("/accessError")
	public String accessError(Authentication auth, Model model) {
		log.info("accessError->auth : " + auth);
		model.addAttribute("msg", "Access Denied");
		
		//forwarding : jsp
		return "security/accessError";
	}
	
	/*사용자 정의 로그인 페이지 사용
	요청URL : /login
			 /login?error=error
			 /login?logout=logout
	요청방식 : get
	*/
//	@GetMapping("/login")
//	public String login(String error, String logout, Model model) {
//		//오류 발생 시
//		if(error!=null) {
//			model.addAttribute("error", "Login Error!!");
//		}
//		
//		if(logout!=null) {
//			model.addAttribute("logout", "Logout!!!");
//		}
//		
//		//forwarding : jsp
//		return "security/loginForm";
//	}
}





