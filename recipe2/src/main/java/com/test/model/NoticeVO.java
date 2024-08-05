package com.test.model;

public class NoticeVO 
{
	private int notinum;		//공지사항번호
	private String userno;			//관리자번호
	private String ntitle;		//공지사항제목
	private String ncontent;	//공지사항내용
	private String nwdate;
	private int nhit;
	
	public int getNotinum() {return notinum;}
	public String getUserno() {return userno;}
	public String getNtitle() {return ntitle;}
	public String getNcontent() {return ncontent;}
	public String getNwdate() {return nwdate;}
	public int getNhit() {return nhit;}
	
	public void setNotinum(int notinum) {this.notinum = notinum;}
	public void setUserno(String userno) {this.userno = userno;}
	public void setNtitle(String ntitle) {this.ntitle = ntitle;}
	public void setNcontent(String ncontent) {this.ncontent = ncontent;}
	public void setNwdate(String nwdate) {this.nwdate = nwdate;}
	public void setNhit(int nhit) {this.nhit = nhit;}
	@Override
	public String toString() {
		return "NoticeVO [notinum=" + notinum + ", userno=" + userno + ", ntitle=" + ntitle + ", ncontent=" + ncontent
				+ ", nwdate=" + nwdate + ", nhit=" + nhit + "]";
	}

	
}
