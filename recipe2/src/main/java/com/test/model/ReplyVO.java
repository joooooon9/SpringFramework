package com.test.model;

public class ReplyVO {
    private String rno;        // 후기 번호
    private String bno;        // 게시물 번호
    private String userno;     // 사용자 번호
    private String rnote;      // 후기 내용
    private String rdate;      // 작성일
    private String score;      // 평점
    private String nick;	   // 닉네임
    private String bpname;     // 저장된 프로필사진

    // Getters and Setters
    public String getRno()    { return rno;    }
    public String getBno()    { return bno;    }
    public String getUserno() { return userno; }
    public String getRnote()  { return rnote;  }
    public String getRdate()  { return rdate;  }
    public String getScore()  { return score;  }
    public String getNick()   { return nick;   }
    public String getBpname() { return bpname; }

    public void setRno(String rno)       { this.rno = rno;       }
    public void setBno(String bno)       { this.bno = bno;       }
    public void setUserno(String userno) { this.userno = userno; }
    public void setRnote(String rnote)   { this.rnote = rnote;   }
    public void setRdate(String rdate)   { this.rdate = rdate;   }
    public void setScore(String score)   { this.score = score;   }
    public void setNick(String nick)     { this.nick = nick;     }
    public void setBpname(String bpname) { this.bpname = bpname; }
}