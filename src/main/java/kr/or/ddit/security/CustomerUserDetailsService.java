package kr.or.ddit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.UserInfoMapper;
import kr.or.ddit.vo.UserInfoVO;
import lombok.extern.slf4j.Slf4j;

/*
UserDetailsService : 스프링 시큐리티에서 제공해주고 있는
사용자 상세 정보를 갖고 있는 인터페이스
 */
@Slf4j
public class CustomerUserDetailsService implements UserDetailsService {
	
	//EMPLOYEE 테이블을 위한 매퍼 인터페이스
	//DI(Dependency Injection) : 의존성 주입
	//IoC(Inversion of Control) : 제어의 역전
	@Autowired
	private UserInfoMapper userInfoMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//1) 사용자 정보를 검색
	    //username : 로그인 시 입력 받은 회원의 아이디. <input type="text" name="username"
		log.info("CustomerUserDetailsService->username: " + username);
		
		UserInfoVO userInfoVO = this.userInfoMapper.detail(username);
		log.info("CustomerUserDetailsService->userInfoVO :  " + userInfoVO);
		
		//MVC에서는 Controller로 리턴하지 않고, CustomUser로 리턴함
		//CustomUser : 사용자 정의 유저 정보. extends User를 상속받고 있음
		//2) 스프링 시큐리티의 User 객체의 정보로 넣어줌 => 프링이가 이제부터 해당 유저를 관리
		//User : 스프링 시큐리에서 제공해주는 사용자 정보 클래스
		/*
	 	employeeVO(우리) -> user(시큐리티)
		------------------------------
		empNo        		-> username
		empPwd        		-> password
		enabled       		-> enabled
		employeeAuthVOList	-> authorities
		 */
		return userInfoVO==null?null:new CustomUser(userInfoVO);
	}

}
