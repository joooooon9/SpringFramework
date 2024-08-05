package com.test.service;

import com.test.model.UserVO;

public interface UserService {
    void Join(UserVO vo);
    int selectById(String id);
    int selectByNick(String nick);
	UserVO selectLogin(UserVO vo);
	void Profile(UserVO vo);
	int selectByUser(String id, String email);
	void newpwOK(String pw, String id);
	

}
