use TDCNS_admin;

DROP TABLE IF EXISTS INTERSECTIONS;
CREATE TABLE INTERSECTIONS(
	INO 		int(11) not null COMMENT "교차로 고유번호",
	NAME 		varchar(256) COMMENT "교차로 이름",
	POS 		POINT 	COMMENT "교차로위치",
	
	primary key (INO)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS ROAD;
CREATE TABLE ROAD(
	RNO 		int(11) not null COMMENT "진입로 고유번호",
	INO 		int(11) not null COMMENT "진입로가 소속된 교차로 고유번호",
	NAME 		varchar(256) COMMENT "진입로 이름",
	DTC 		varchar(3000) COMMENT "진입로에서 카메라가 인식할 범위",
	LDTC 		varchar(3000) COMMENT "진입로에서 카메라가 인식할 범위",
	STREAM 		varchar(512) COMMENT "진입로 카메라의 stream url",
	PW 			varchar(512) COMMENT "stream url의 접속 비밀번호 (예상)",
	CNO 		varchar(64) COMMENT "카메라 고유번호",
	
	primary key (RNO),
	index ROAD_INO (INO),
	index ROAD_CAM (CNO)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS CAM;
CREATE TABLE CAM(
	CNO 		int(11) not null COMMENT "카메라 고유번호",
	WIDTH 		int(11) COMMENT "가로픽셀",
	HEIGHT 		int(11) COMMENT "세로픽셀",
	
	primary key (CNO)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS DTC;
CREATE TABLE DTC(
	RNO 		int(11) not null COMMENT "ROAD 고유번호",
	POINT 		int(11) not null COMMENT "몇번째 점인지 0~n",
	DX 			int(11) COMMENT "x좌표",
	DY 			int(11) COMMENT "y좌표",
	
	primary key (RNO, POINT)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS LDTC;
CREATE TABLE LDTC(
	RNO 		int(11) not null COMMENT "ROAD 고유번호",
	LANE 		int(11) not null COMMENT "차선(1~n)",
	POINT 		int(11) not null COMMENT "몇번째 점인지 0~n",
	DX 		int(11) COMMENT "x좌표",
	DY 			int(11) COMMENT "y좌표",
	
	primary key (RNO, LANE, POINT)
) ENGINE=InnoDB;

