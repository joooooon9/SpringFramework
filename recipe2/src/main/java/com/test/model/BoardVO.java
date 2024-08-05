package com.test.model;

public class BoardVO 
{
	private String bno;			//게시물번호
	private String userno;		//회원번호
	private String title;		//게시물제목
	private String subtitle;	//게시물설명
	private String serving;		//인원 수
	private String cooktime;	//조리시간
	private String ingredient;	//재료
	private String content;		//조리방법
	private String isshare;		//공개여부
	private String wdate;		//작성일
	private String bhit;		//조회수
	private int rcount;         // 댓글 수 추가
	private FileVO fileVO;      // 파일 정보 추가
	private UserVO user;  		// 작성자 정보 추가
	
	
	
	
	public String getBno() 			{return bno;		}
	public String getUserno()		{return userno;		}
	public String getTitle() 		{return title;		}
	public String getSubtitle() 	{return subtitle;	}
	public String getServing() 		{return serving;	}
	public String getCooktime() 	{return cooktime;	}
	public String getIngredient() 	{return ingredient;	}
	public String getContent() 		{return content;	}
	public String getIsshare() 		{return isshare;	}
	public String getWdate() 		{return wdate;		}
	public String getBhit() 		{return bhit;		}
	public int getRcount()          {return rcount;     }
	public FileVO getFileVO()       {return fileVO;     }
	public UserVO getUser()         {return user;       }
	
	public void setBno(String bno) 					{this.bno = bno;				}
	public void setUserno(String userno) 			{this.userno = userno;			}
	public void setTitle(String title) 				{this.title = title;			}
	public void setSubtitle(String subtitle) 		{this.subtitle = subtitle;		}
	public void setServing(String serving) 			{this.serving = serving;		}
	public void setCooktime(String cooktime) 		{this.cooktime = cooktime;		}
	public void setIngredient(String ingredient) 	{this.ingredient = ingredient;	}
	public void setContent(String content) 			{this.content = content;		}
	public void setIsshare(String isshare) 			{this.isshare = isshare;		}
	public void setWdate(String wdate) 				{this.wdate = wdate;			}
	public void setBhit(String bhit) 				{this.bhit = bhit;				}
	public void setRcount(int rcount) 				{this.rcount = rcount;          }
	public void setFileVO(FileVO fileVO)            {this.fileVO = fileVO;          }
	public void setUser(UserVO user) 				{this.user = user;              }
}
