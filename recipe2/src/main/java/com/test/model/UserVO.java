package com.test.model;

public class UserVO 
{
	private String userno;		//회원번호
	private String id;			//아이디
	private String nick;		//닉네임
	private String pw;			//비밀번호
	private String name;		//이름
	private String email;		//이메일
	private String joindate;	//가입일자
	private String isretire;	//탈퇴여부
	private String isadmin;		//관리자여부
	private String bfname;		//원본이름
	private String bpname;		//저장된이름
	
	
	public String getUserno()		{return userno;		}
	public String getId() 		{return id;		 }
	public String getNick() 	{return nick;	 }
	public String getPw() 		{return pw;		 }
	public String getName() 	{return name;	 }
	public String getEmail() 	{return email;	 }
	public String getJoindate() {return joindate;}
	public String getIsretire() {return isretire;}
	public String getIsadmin()  {return isadmin; }
	public String getBfname() {		return bfname;	}
	public String getBpname() {		return bpname;	}
	
	
	public void setUserno(String userno) 			{this.userno = userno;			}
	public void setId(String id) 			 {this.id = id;			   }
	public void setNick(String nick) 		 {this.nick = nick;		   }
	public void setPw(String pw) 			 {this.pw = pw;			   }
	public void setName(String name) 		 {this.name = name;		   }
	public void setEmail(String email) 		 {this.email = email;	   }
	public void setJoindate(String joindate) {this.joindate = joindate;}
	public void setIsretire(String isretire) {this.isretire = isretire;}
	public void setIsadmin(String isadmin) 	 {this.isadmin = isadmin;  }
	public void setBfname(String bfname) {		this.bfname = bfname;	}
	public void setBpname(String bpname) {		this.bpname = bpname;	}
	
	
}
