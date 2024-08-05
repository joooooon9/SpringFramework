package com.test.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.model.UserVO;

@Repository
public class UserDAO {
    @Autowired
    private SqlSession sqlSession;

    private static final String Namespace = "com.test.mapper.UserMapper";

    public void insertUser(UserVO vo) 
    {
        sqlSession.insert(Namespace + ".insertUser", vo);
    }
    
    public int selectById(String id)
    {
    	return sqlSession.selectOne(Namespace + ".selectById", id);
    }
    
    public int selectByNick(String nick)
    {
    	return sqlSession.selectOne(Namespace + ".selectByNick", nick);
    }

	public UserVO selectLogin(UserVO vo) 
	{
		return sqlSession.selectOne(Namespace + ".selectLogin", vo);
	}

	public void Profile(UserVO vo) 
	{
		sqlSession.selectOne(Namespace + ".profile", vo);		
	}

	public int selectByUser(String id, String email) 
	{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("email", email);
		return sqlSession.selectOne(Namespace + ".selectByUser",map);
	}

	public void newpwOK(String pw,String id) 
	{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("pw", pw);
		sqlSession.selectOne(Namespace +".newpwOK", map);
	}

}
