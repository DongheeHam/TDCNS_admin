/*
2020-10-08 add road.pos
*/
alter table ROAD add POS POINT 	COMMENT "교차로위치";

DROP TABLE IF EXISTS INTERSECTIONS;
CREATE TABLE INTERSECTIONS(
	INO 	int(11) not null AUTO_INCREMENT COMMENT "교차로 고유번호",
	NAME 	varchar(256) COMMENT "교차로 이름",
	POS 	POINT 	COMMENT "교차로위치",
	
	primary key (INO),
	index INTER_NAME (NAME)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS ROAD;
CREATE TABLE ROAD(
	RNO 	int(11) not null AUTO_INCREMENT COMMENT "진입로 고유번호",
	INO 	int(11) not null COMMENT "진입로가 소속된 교차로 고유번호",
	NAME 	varchar(256) COMMENT "진입로 이름",
	IP 	varchar(64) not null COMMENT "모듈 ip",
	STREAM 	varchar(512) COMMENT "진입로 모듈의 stream url",
	PW 	varchar(512) COMMENT "stream url의 접속 비밀번호 (예상)",
	CNO 	varchar(64) COMMENT "카메라 고유번호",
	POS 	POINT 	COMMENT "교차로위치",
	
	primary key (RNO),
	index ROAD_INO (INO),
	index ROAD_CAM (CNO),
	index ROAD_NAME (NAME)
) ENGINE=InnoDB;




