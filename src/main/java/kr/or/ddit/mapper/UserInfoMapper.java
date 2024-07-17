package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.UserInfoVO;

public interface UserInfoMapper {
	
	// 유저 전체 조회
	//public List<UserInfoVO> list();
	
	// 유저 상세 조회
	public UserInfoVO detail(String userNo);
}
