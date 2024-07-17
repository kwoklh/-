package kr.or.ddit.util;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.slf4j.Slf4j;

//스프링 컨트롤러에서 발생하는 예외를 처리하는 핸들러 클래스임을 명시함
@Slf4j
@ControllerAdvice
public class CommonExceptionHandler {
	
	//괄호 안에 설정한 예외 타입을 해당 메서드가 처리한다는 의미
	//IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException,
	//ArtimeticException(0으로 나눌경우)
//	@ExceptionHandler(Exception.class)
//	public String handle(Exception e, Model model) {
//		log.error("CommonExceptionHandler->handle : " + e.toString());
//		
//		model.addAttribute("exception", e);
		
//		forwarding : jsp
//		return "error/errorCommon";
//	}
	//404 오류 처리
//	@ExceptionHandler(NoHandlerFoundException.class)
//	@ResponseStatus(HttpStatus.NOT_FOUND)
//	public String handle404(Exception e) {
//		log.error("CommonExceptionHandler->handle : " + e.toString());
		//forwarding
//		return "error/error404";
//	}
}
