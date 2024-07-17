package kr.or.ddit.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.vo.UserInfoVO;

// User : 스프링 시큐리티의 사용자 정보를 관리하는 사용자 최상위클래스
public class CustomUser extends User {
	
	/* User 클래스의 프로퍼티
	 private String password; // java(암호화)
  	 private final String username; // A004
	 private final Set<GrantedAuthority> authorities; // 권한
	 private final boolean accountNonExpired;
	 private final boolean accountNonLocked;
	 private final boolean credentialsNonExpired;
	 private final boolean enabled;OO
	 */
	UserInfoVO userInfoVO;
	// User의 생성자를 처리해줌
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		// TODO Auto-generated constructor stub
		// super : 현재 클래스의 부모 => User
		super(username, password, authorities);
	}

	public CustomUser(UserInfoVO userInfoVO) {
		//사용자가 정의한 (select한) EmployeeVO 타입의 객체 employeeVO
       //스프링 시큐리티에서 제공해주고 있는 UsersDetails 타입으로 변환
       //회원정보를 보내줄테니 관리해줘
		super(userInfoVO.getUserNo(), userInfoVO.getUserPass(),
				userInfoVO.getAuthorityVOList().stream()
			  .map(auth->new SimpleGrantedAuthority(auth.getAuthority()))
			  .collect(Collectors.toList())
				);
        this.userInfoVO = userInfoVO;
	}
    
    public UserInfoVO getUserInfoVO() {
		return userInfoVO;
	}

	public void setUserInfoVO(UserInfoVO userInfoVO) {
		this.userInfoVO = userInfoVO;
	}
}