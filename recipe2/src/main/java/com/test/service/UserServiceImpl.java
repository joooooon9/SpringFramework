package com.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.dao.UserDAO;
import com.test.model.UserVO;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserDAO dao;
    
    @Override
    public void Join(UserVO vo) 
    {
        dao.insertUser(vo);
    }
	@Override
	public int selectById(String id)
	{
		return dao.selectById(id);
	}
	@Override
	public int selectByNick(String nick)
	{
		return dao.selectByNick(nick);
	}
	@Override
	public UserVO selectLogin(UserVO vo) 
	{
		return dao.selectLogin(vo);
	}
	@Override
	public void Profile(UserVO vo) 
	{
		dao.Profile(vo);
	}
	@Override
	public int selectByUser(String id, String email) 
	{
		return dao.selectByUser(id,email);
	}
	@Override
	public void newpwOK(String pw, String id) 
	{
		dao.newpwOK(pw,id);
	}

}
