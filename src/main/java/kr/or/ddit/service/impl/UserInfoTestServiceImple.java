package kr.or.ddit.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.UserInfoMapper;
import kr.or.ddit.service.UserInfoTestService;
import kr.or.ddit.vo.UserInfoVO;

@Service
public class UserInfoTestServiceImple implements UserInfoTestService{
	
	@Autowired
	UserInfoMapper userInfoMapper;
	
	public UserInfoVO detail(String userNo) {
		return userInfoMapper.detail(userNo);
	}
}
