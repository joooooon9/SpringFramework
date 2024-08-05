package com.test.service;


public interface MailService 
{
	String AuthCode(int max);
	String send(String email);
}
