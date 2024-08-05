package com.test.model;

public class FileVO 
{
	private String filename;
	private String savename;
	
	public String getFilename() {	return filename;	}
	public String getSavename() {	return savename;	}
	
	public void setFilename(String filename) {	this.filename = filename;	}
	public void setSavename(String savename) {	this.savename = savename;	}
	
	
	private int fno;
    private String bfname;
    private String bpname;
    private int bno;

    public int getFno() { return fno; }
    public String getBfname() { return bfname; }
    public String getBpname() { return bpname; }
    public int getBno() { return bno; }
	
	public void setFno(int fno) { this.fno = fno; }
    public void setBfname(String bfname) { this.bfname = bfname; }
    public void setBpname(String bpname) { this.bpname = bpname; }
    public void setBno(int bno) { this.bno = bno; }
}