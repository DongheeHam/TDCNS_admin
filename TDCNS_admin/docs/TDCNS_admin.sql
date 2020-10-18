use tdcns_admin;

DROP TABLE IF EXISTS INTERSECTIONS;
CREATE TABLE INTERSECTIONS(
	INO 		int(11) not null AUTO_INCREMENT COMMENT "교차로 고유번호",
	NAME 		varchar(256) COMMENT "교차로 이름",
	POS 		POINT 	COMMENT "교차로위치",
	
	primary key (INO),
	index INTER_NAME (NAME)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS ROAD;
CREATE TABLE ROAD(
	RNO 		int(11) not null AUTO_INCREMENT COMMENT "진입로 고유번호",
	INO 		int(11) not null COMMENT "진입로가 소속된 교차로 고유번호",
	NAME 		varchar(256) COMMENT "진입로 이름",
	IP 			varchar(64) not null COMMENT "모듈 ip",
	STREAM 		varchar(512) COMMENT "진입로 모듈의 stream url",
	PW 			varchar(512) COMMENT "stream url의 접속 비밀번호 (예상)",
	CNO 		varchar(64) COMMENT "카메라 고유번호",
	POS 		POINT 	COMMENT "교차로위치",
	
	primary key (RNO),
	index ROAD_INO (INO),
	index ROAD_CAM (CNO),
	index ROAD_NAME (NAME)
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
	LX 		int(11) COMMENT "x좌표",
	LY 			int(11) COMMENT "y좌표",
	
	primary key (RNO, LANE, POINT)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS COUNTER;
CREATE TABLE COUNTER(
	RNO 		int(11) not null COMMENT "ROAD 고유번호",
	LANE 		int(11) not null COMMENT "차선(1~n)",
	POINT 		int(11) not null COMMENT "몇번째 점인지 0~n",
	LX 		int(11) COMMENT "x좌표",
	LY 			int(11) COMMENT "y좌표",
	
	primary key (RNO, LANE, POINT)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS TRAFFIC;
CREATE TABLE TRAFFIC(
	RNO 	int(11) not null COMMENT "ROAD 고유번호",
	DATE 	varchar(10) not null COMMENT "데이터 수집 날짜 (형식:20201005)",
	TIME 	varchar(10) not null COMMENT "데이터 수집 시간",
	LANE 	int(11) not null COMMENT "차선(1~n)",
	LARGE 	int(11) default 0 COMMENT "대형차수",
	SMALL 	int(11) default 0 COMMENT "소형차수",
	DT 	datetime default now() COMMENT "데이터 생성 시간",
	
	primary key (RNO, DATE, TIME, LANE)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS API_KEY;
CREATE TABLE API_KEY(
	API_KEY varchar(1024) not null COMMENT "API_KEY",

	primary key (API_KEY)
) ENGINE=InnoDB;
