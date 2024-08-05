SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS breport;
DROP TABLE IF EXISTS file;
DROP TABLE IF EXISTS rreport;
DROP TABLE IF EXISTS reply;
DROP TABLE IF EXISTS board;
DROP TABLE IF EXISTS notice;
DROP TABLE IF EXISTS user;




/* Create Tables */

-- 레시피기록
CREATE TABLE board
(
	bno int NOT NULL AUTO_INCREMENT COMMENT '게시물번호',
	title varchar(50) COMMENT '레시피이름',
	subtitle varchar(50) COMMENT '레시피설명',
	serving varchar(30) COMMENT '인원 수',
	cooktime varchar(50) COMMENT 'cooktime',
	ingredient text COMMENT '재료',
	content text COMMENT '조리방법',
	isshare varchar(15) COMMENT '공개여부',
	wdate datetime DEFAULT now() COMMENT '작성일',
	bhit int DEFAULT 0 COMMENT '조회수',
	delete_flag int DEFAULT 0 COMMENT '삭제여부',
	userno int NOT NULL COMMENT '회원번호',
	PRIMARY KEY (bno)
) COMMENT = '레시피기록';


-- 게시물 신고관리
CREATE TABLE breport
(
	reportdate datetime DEFAULT now() COMMENT '신고날짜',
	userno int NOT NULL COMMENT '회원번호',
	bno int NOT NULL COMMENT '게시물번호'
) COMMENT = '게시물 신고관리';


-- 첨부파일
CREATE TABLE file
(
	bfname varchar(255) COMMENT '원본파일명',
	bpname varchar(255) COMMENT '저장된파일명',
	bno int NOT NULL COMMENT '게시물번호'
) COMMENT = '첨부파일';


-- 공지사항
CREATE TABLE notice
(
	notinum int NOT NULL AUTO_INCREMENT COMMENT '공지사항번호',
	ntitle varchar(100) COMMENT '공지사항제목',
	ncontent varchar(300) COMMENT '공지사항내용',
	nwdate datetime DEFAULT now() COMMENT '작성일',
	nhit int DEFAULT 0 COMMENT '조회수',
	userno int NOT NULL COMMENT '회원번호',
	PRIMARY KEY (notinum)
) COMMENT = '공지사항';


-- 요리후기
CREATE TABLE reply
(
	rno int NOT NULL AUTO_INCREMENT COMMENT '요리후기번호',
	score varchar(40) COMMENT '평점',
	rnote varchar(150) COMMENT '후기내용',
	rdate datetime DEFAULT now() COMMENT '작성일',
	userno int NOT NULL COMMENT '회원번호',
	bno int NOT NULL COMMENT '게시물번호',
	PRIMARY KEY (rno)
) COMMENT = '요리후기';


-- 요리후기 신고관리
CREATE TABLE rreport
(
	reportdate datetime DEFAULT now() COMMENT '신고일',
	userno int NOT NULL COMMENT '회원번호',
	rno int NOT NULL COMMENT '요리후기번호'
) COMMENT = '요리후기 신고관리';


-- 회원정보
CREATE TABLE user
(
	userno int NOT NULL AUTO_INCREMENT COMMENT '회원번호',
	id varchar(30) COMMENT '아이디',
	nick varchar(30) COMMENT '닉네임',
	pw varchar(30) COMMENT '비밀번호',
	name varchar(30) COMMENT '이름',
	email varchar(50) COMMENT '이메일',
	joindate datetime DEFAULT now() COMMENT '가입일',
	isretire varchar(20) DEFAULT 'N' COMMENT '탈퇴여부',
	isadmin varchar(20) DEFAULT 'N' COMMENT '관리자여부',
	bfname varchar(255) DEFAULT 'user.png' COMMENT '원본이름',
	bpname varchar(255) COMMENT '저장된이름',
	PRIMARY KEY (userno)
) COMMENT = '회원정보';



/* Create Foreign Keys */

ALTER TABLE breport
	ADD FOREIGN KEY (bno)
	REFERENCES board (bno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE file
	ADD FOREIGN KEY (bno)
	REFERENCES board (bno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE reply
	ADD FOREIGN KEY (bno)
	REFERENCES board (bno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE rreport
	ADD FOREIGN KEY (rno)
	REFERENCES reply (rno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE board
	ADD FOREIGN KEY (userno)
	REFERENCES user (userno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE breport
	ADD FOREIGN KEY (userno)
	REFERENCES user (userno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE notice
	ADD FOREIGN KEY (userno)
	REFERENCES user (userno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE reply
	ADD FOREIGN KEY (userno)
	REFERENCES user (userno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE rreport
	ADD FOREIGN KEY (userno)
	REFERENCES user (userno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



