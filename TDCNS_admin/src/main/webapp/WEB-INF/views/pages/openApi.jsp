<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@
		taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%
%>
<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-1 text-gray-800" >Open API</h1>
        <a href="javascript:app.loadDialog('/getApiKey',{})" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i>API키 발급받기</a>
</div>
<div class="row">
<div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          <table class="table table-bordered">
            <tr>
              <td style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">서비스명</td>
              <td>교통량 조회</td>
            </tr>
            <tr>
              <td style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">서비스 설명</td>
              <td>교차로 진입로별 기본 정보와 5분 단위의 교통량을 조회하는 서비스</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">요청 주소(Request URL)</h2>
    <div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          &nbsp;&nbsp;&nbsp;http://tdcns.com/dc/getDataRow.json
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">요청 변수(Request Parameter)</h2>
    <div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          <table class="table table-bordered">
            <tr style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">
              <td >항목명(국문)</td>
              <td>항목명(영문)</td>
              <td>항목구분</td>
              <td>샘플데이터</td>
              <td>항목설명</td>
            </tr>
            <tr>
              <td>서비스키</td>
              <td>Service key</td>
              <td>필수</td>
              <td>-</td>
              <td>TDCNS Open API 인증키</td>
            </tr>
            <tr>
              <td>진입로 번호</td>
              <td>rno</td>
              <td>필수</td>
              <td>10</td>
              <td>진입로 번호</td>
            </tr>
            <tr>
              <td>날짜</td>
              <td>date</td>
              <td>필수</td>
              <td>20201016</td>
              <td>검색한 날짜('YYYYMMDD')</td>
            </tr>
            <tr>
              <td>시간</td>
              <td>time</td>
              <td>필수</td>
              <td>1545</td>
              <td>검색할 시간('HHmm') 분은 5분 단위</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">출력 결과(Response Element)</h2><div class="col-lg-8"></div>
    <div class="col-lg-4">
      <div class="card shadow mr-4 border-left-primary row">  
        <div class= "card-body row ">
          <textarea readonly class="form-control" rows="24" >
{
	rc: 1,
	resMessage: "success!",
	result: [
		{
			rno: 1,
			date: "20201011",
			time: "1545",
			lane: 1,
			large: 2,
			small: 7,
			dt: 1602398948000
		},
		{ }, { }
	]
}   
          </textarea> 
        </div>               
      </div>
    </div>
    <div class="col-lg-8">
      <div class="card shadow mb-4 row"> 
        <div class= "card-body row ">
          <table class="table table-bordered ">
            <tr style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">
              <td >항목명(국문)</td>
              <td>항목명(영문)</td>
              <td>데이터형</td>
              <td>샘플데이터</td>
              <td>항목설명</td>
            </tr>
            <tr>                   
              <td>결과 코드</td>
              <td>rc</td>
              <td>number</td>
              <td>1</td>
              <td>결과 코드</td>
            </tr>
            <tr>                   
              <td>결과 메시지</td>
              <td>resMessage</td>
              <td>String</td>
              <td>success!</td>
              <td>결과 메시지</td>
            </tr>
            <tr>                   
              <td>요청 결과 데이터</td>
              <td>result</td>
              <td>List[Object]</td>
              <td>[{}]</td>
              <td>반환된 결과</td>
            </tr>
            <tr>                   
              <td>교차로번호</td>
              <td>result.ino</td>
              <td>number</td>
              <td>1</td>
              <td>교차로번호</td>                    
            </tr>
            <tr>                   
              <td>교차로명</td>
              <td>result.intersectionName</td>
              <td>String</td>
              <td>목동오거리</td>
              <td>진입로가 포함된 교차로 이름</td>                    
            </tr>
            <tr>                   
              <td>진입로번호</td>
              <td>result.rno</td>
              <td>number</td>
              <td>1</td>
              <td>진입로번호</td>                    
            </tr>
            <tr>                   
              <td>진입로명</td>
              <td>result.roadName</td>
              <td>String</td>
              <td>목동방향</td>
              <td>진입로이름</td>
            </tr>
            <tr>                   
              <td>교통량 측정일</td>
              <td>result.date</td>
              <td>number</td>
              <td>20201011</td>
              <td>교통량 측정 날짜</td>
            </tr>
            <tr>                   
              <td>교통량 측정 시간</td>
              <td>result.time</td>
              <td>number</td>
              <td>1545</td>
              <td>교통량 측정 시간</td>
            </tr>
            <tr>                   
              <td>차선</td>
              <td>result.lane</td>
              <td>number</td>
              <td>1</td>
              <td>교통량 측정 차선</td>
            </tr>
            <tr>                   
              <td>대형차량수</td>
              <td>result.large</td>
              <td>number</td>
              <td>14</td>
              <td>5분간 통행한 대형차량수</td>
            </tr>
            <tr>                   
              <td>소형차량수</td>
              <td>result.small</td>
              <td>number</td>
              <td>43</td>
              <td>5분간 통행한 소형차량수</td>
            </tr>                  
          </table>
        </div>
      </div>
    </div>
</div>
<hr><hr>
<div class="row">
<div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          <table class="table table-bordered">
            <tr>
              <td style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">서비스명</td>
              <td>일자별 교통량 통계</td>
            </tr>
            <tr>
              <td style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">서비스 설명</td>
              <td>교차로 진입로별 일자별 교통량 통계를 제공하는 서비스</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">요청 주소(Request URL)</h2>
    <div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          &nbsp;&nbsp;&nbsp;http://tdcns.com/dc/getDayStat.json
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">요청 변수(Request Parameter)</h2>
    <div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          <table class="table table-bordered">
            <tr style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">
              <td >항목명(국문)</td>
              <td>항목명(영문)</td>
              <td>항목구분</td>
              <td>샘플데이터</td>
              <td>항목설명</td>
            </tr>
            <tr>
              <td>서비스키</td>
              <td>Service key</td>
              <td>필수</td>
              <td>-</td>
              <td>TDCNS Open API 인증키</td>
            </tr>
            <tr>
              <td>진입로 번호</td>
              <td>rno</td>
              <td>필수</td>
              <td>10</td>
              <td>진입로 번호</td>
            </tr>
            <tr>
              <td>날짜</td>
              <td>date</td>
              <td>필수</td>
              <td>20201016</td>
              <td>검색한 날짜('YYYYMMDD')</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">출력 결과(Response Element)</h2><div class="col-lg-8"></div>
    <div class="col-lg-4">
      <div class="card shadow mr-4 border-left-primary row">  
        <div class= "card-body row ">
          <textarea readonly class="form-control" rows="24" >
{
	rc: 1,
	resMessage: "success!",
	result: [
		{
			rno: 1,
			date: "20201011",
			time_: "0300",
			large: 2,
			small: 134,
			roadName: "목동방향",
			ino: 1,
			intersectionName: "목동오거리"
		}, { }, { }
	]
}   
          </textarea> 
        </div>               
      </div>
    </div>
    <div class="col-lg-8">
      <div class="card shadow mb-4 row"> 
        <div class= "card-body row ">
          <table class="table table-bordered ">
            <tr style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">
              <td >항목명(국문)</td>
              <td>항목명(영문)</td>
              <td>데이터형</td>
              <td>샘플데이터</td>
              <td>항목설명</td>
            </tr>
            <tr>                   
              <td>결과 코드</td>
              <td>rc</td>
              <td>number</td>
              <td>1</td>
              <td>결과 코드</td>
            </tr>
            <tr>                   
              <td>결과 메시지</td>
              <td>resMessage</td>
              <td>String</td>
              <td>success!</td>
              <td>결과 메시지</td>
            </tr>
            <tr>                   
              <td>요청 결과 데이터</td>
              <td>result</td>
              <td>List[Object]</td>
              <td>[{}]</td>
              <td>반환된 결과</td>
            </tr>
            <tr>                   
              <td>교차로번호</td>
              <td>result.ino</td>
              <td>number</td>
              <td>1</td>
              <td>교차로번호</td>                    
            </tr>
            <tr>                   
              <td>교차로명</td>
              <td>result.intersectionName</td>
              <td>String</td>
              <td>목동오거리</td>
              <td>진입로가 포함된 교차로 이름</td>                    
            </tr>
            <tr>                   
              <td>진입로번호</td>
              <td>result.rno</td>
              <td>number</td>
              <td>1</td>
              <td>진입로번호</td>                    
            </tr>
            <tr>                   
              <td>진입로명</td>
              <td>result.roadName</td>
              <td>String</td>
              <td>목동방향</td>
              <td>진입로이름</td>
            </tr>
            <tr>                   
              <td>교통량 측정일</td>
              <td>result.date</td>
              <td>number</td>
              <td>20201011</td>
              <td>교통량 측정 날짜</td>
            </tr>
            <tr>                   
              <td>교통량 측정 시간</td>
              <td>result.time_</td>
              <td>number</td>
              <td>1545</td>
              <td>교통량 측정 시간</td>
            </tr>
            <tr>                   
              <td>대형차량수</td>
              <td>result.large</td>
              <td>number</td>
              <td>14</td>
              <td>5분간 통행한 대형차량수</td>
            </tr>
            <tr>                   
              <td>소형차량수</td>
              <td>result.small</td>
              <td>number</td>
              <td>43</td>
              <td>5분간 통행한 소형차량수</td>
            </tr>                  
          </table>
        </div>
      </div>
    </div>
</div>
<hr><hr>
<div class="row">
<div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          <table class="table table-bordered">
            <tr>
              <td style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">서비스명</td>
              <td>주간별 교통량 통계</td>
            </tr>
            <tr>
              <td style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">서비스 설명</td>
              <td>교차로 진입로별 주간별 교통량 통계를 제공하는 서비스</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">요청 주소(Request URL)</h2>
    <div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          &nbsp;&nbsp;&nbsp;http://tdcns.com/dc/getWeekStat.json
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">요청 변수(Request Parameter)</h2>
    <div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          <table class="table table-bordered">
            <tr style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">
              <td >항목명(국문)</td>
              <td>항목명(영문)</td>
              <td>항목구분</td>
              <td>샘플데이터</td>
              <td>항목설명</td>
            </tr>
            <tr>
              <td>서비스키</td>
              <td>Service key</td>
              <td>필수</td>
              <td>-</td>
              <td>TDCNS Open API 인증키</td>
            </tr>
            <tr>
              <td>진입로 번호</td>
              <td>rno</td>
              <td>필수</td>
              <td>10</td>
              <td>진입로 번호</td>
            </tr>
            <tr>
              <td>마지막 날짜</td>
              <td>endDate</td>
              <td>필수</td>
              <td>20201016</td>
              <td>검색할 주차의 마지막 날짜('YYYYMMDD')</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">출력 결과(Response Element)</h2><div class="col-lg-8"></div>
    <div class="col-lg-4">
      <div class="card shadow mr-4 border-left-primary row">  
        <div class= "card-body row ">
          <textarea readonly class="form-control" rows="24" >
{
	rc: 1,
	resMessage: "success!",
	result: [
		{
			rno: 1,
			date: "20201010",
			large: 3,
			small: 59,
			roadName: "목동방향",
			ino: 1,
			intersectionName: "목동오거리"
		}
	]
}   
          </textarea> 
        </div>               
      </div>
    </div>
    <div class="col-lg-8">
      <div class="card shadow mb-4 row"> 
        <div class= "card-body row ">
          <table class="table table-bordered ">
            <tr style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">
              <td >항목명(국문)</td>
              <td>항목명(영문)</td>
              <td>데이터형</td>
              <td>샘플데이터</td>
              <td>항목설명</td>
            </tr>
            <tr>                   
              <td>결과 코드</td>
              <td>rc</td>
              <td>number</td>
              <td>1</td>
              <td>결과 코드</td>
            </tr>
            <tr>                   
              <td>결과 메시지</td>
              <td>resMessage</td>
              <td>String</td>
              <td>success!</td>
              <td>결과 메시지</td>
            </tr>
            <tr>                   
              <td>요청 결과 데이터</td>
              <td>result</td>
              <td>List[Object]</td>
              <td>[{}]</td>
              <td>반환된 결과</td>
            </tr>
            <tr>                   
              <td>교차로번호</td>
              <td>result.ino</td>
              <td>number</td>
              <td>1</td>
              <td>교차로번호</td>                    
            </tr>
            <tr>                   
              <td>교차로명</td>
              <td>result.intersectionName</td>
              <td>String</td>
              <td>목동오거리</td>
              <td>진입로가 포함된 교차로 이름</td>                    
            </tr>
            <tr>                   
              <td>진입로번호</td>
              <td>result.rno</td>
              <td>number</td>
              <td>1</td>
              <td>진입로번호</td>                    
            </tr>
            <tr>                   
              <td>진입로명</td>
              <td>result.roadName</td>
              <td>String</td>
              <td>목동방향</td>
              <td>진입로이름</td>
            </tr>
            <tr>                   
              <td>교통량 측정일</td>
              <td>result.date</td>
              <td>number</td>
              <td>20201011</td>
              <td>교통량 측정 날짜</td>
            </tr>
            <tr>                   
              <td>대형차량수</td>
              <td>result.large</td>
              <td>number</td>
              <td>14</td>
              <td>5분간 통행한 대형차량수</td>
            </tr>
            <tr>                   
              <td>소형차량수</td>
              <td>result.small</td>
              <td>number</td>
              <td>43</td>
              <td>5분간 통행한 소형차량수</td>
            </tr>                  
          </table>
        </div>
      </div>
    </div>
</div>
<hr><hr>
<div class="row">
<div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          <table class="table table-bordered">
            <tr>
              <td style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">서비스명</td>
              <td>차량 크기별 교통량 통계</td>
            </tr>
            <tr>
              <td style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">서비스 설명</td>
              <td>교차로 진입로별 차량 크기별 교통량 통계를 제공하는 서비스</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">요청 주소(Request URL)</h2>
    <div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          &nbsp;&nbsp;&nbsp;http://tdcns.com/dc/getSizeStat.json
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">요청 변수(Request Parameter)</h2>
    <div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          <table class="table table-bordered">
            <tr style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">
              <td >항목명(국문)</td>
              <td>항목명(영문)</td>
              <td>항목구분</td>
              <td>샘플데이터</td>
              <td>항목설명</td>
            </tr>
            <tr>
              <td>서비스키</td>
              <td>Service key</td>
              <td>필수</td>
              <td>-</td>
              <td>TDCNS Open API 인증키</td>
            </tr>
            <tr>
              <td>진입로 번호</td>
              <td>rno</td>
              <td>필수</td>
              <td>10</td>
              <td>진입로 번호</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">출력 결과(Response Element)</h2><div class="col-lg-8"></div>
    <div class="col-lg-4">
      <div class="card shadow mr-4 border-left-primary row">  
        <div class= "card-body row ">
          <textarea readonly class="form-control" rows="24" >
{
	rc: 1,
	resMessage: "success!",
	result: {
			rno: 1,
			date: "20201010",
			large: 3,
			small: 59,
			roadName: "목동방향",
			ino: 1,
			intersectionName: "목동오거리"
		}
	
}   
          </textarea> 
        </div>               
      </div>
    </div>
    <div class="col-lg-8">
      <div class="card shadow mb-4 row"> 
        <div class= "card-body row ">
          <table class="table table-bordered ">
            <tr style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">
              <td >항목명(국문)</td>
              <td>항목명(영문)</td>
              <td>데이터형</td>
              <td>샘플데이터</td>
              <td>항목설명</td>
            </tr>
            <tr>                   
              <td>결과 코드</td>
              <td>rc</td>
              <td>number</td>
              <td>1</td>
              <td>결과 코드</td>
            </tr>
            <tr>                   
              <td>결과 메시지</td>
              <td>resMessage</td>
              <td>String</td>
              <td>success!</td>
              <td>결과 메시지</td>
            </tr>
            <tr>                   
              <td>요청 결과 데이터</td>
              <td>result</td>
              <td>Object</td>
              <td>{}</td>
              <td>반환된 결과</td>
            </tr>
            <tr>                   
              <td>교차로번호</td>
              <td>result.ino</td>
              <td>number</td>
              <td>1</td>
              <td>교차로번호</td>                    
            </tr>
            <tr>                   
              <td>교차로명</td>
              <td>result.intersectionName</td>
              <td>String</td>
              <td>목동오거리</td>
              <td>진입로가 포함된 교차로 이름</td>                    
            </tr>
            <tr>                   
              <td>진입로번호</td>
              <td>result.rno</td>
              <td>number</td>
              <td>1</td>
              <td>진입로번호</td>                    
            </tr>
            <tr>                   
              <td>진입로명</td>
              <td>result.roadName</td>
              <td>String</td>
              <td>목동방향</td>
              <td>진입로이름</td>
            </tr>
            <tr>                   
              <td>대형차량수</td>
              <td>result.large</td>
              <td>number</td>
              <td>14</td>
              <td>5분간 통행한 대형차량수</td>
            </tr>
            <tr>                   
              <td>소형차량수</td>
              <td>result.small</td>
              <td>number</td>
              <td>43</td>
              <td>5분간 통행한 소형차량수</td>
            </tr>                  
          </table>
        </div>
      </div>
    </div>
</div>
<hr><hr>
<div class="row">
<div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          <table class="table table-bordered">
            <tr>
              <td style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">서비스명</td>
              <td>차량 크기별 교통량 통계</td>
            </tr>
            <tr>
              <td style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">서비스 설명</td>
              <td>교차로 진입로별 차량 크기별 교통량 통계를 제공하는 서비스</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">요청 주소(Request URL)</h2>
    <div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          &nbsp;&nbsp;&nbsp;http://tdcns.com/dc/getSizeStat.json
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">요청 변수(Request Parameter)</h2>
    <div class="col-lg-12">
      <div class="card shadow mb-4 border-left-primary">
        <div class= "card-body row ">
          <table class="table table-bordered">
            <tr style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">
              <td >항목명(국문)</td>
              <td>항목명(영문)</td>
              <td>항목구분</td>
              <td>샘플데이터</td>
              <td>항목설명</td>
            </tr>
            <tr>
              <td>서비스키</td>
              <td>Service key</td>
              <td>필수</td>
              <td>-</td>
              <td>TDCNS Open API 인증키</td>
            </tr>
            <tr>
              <td>진입로 번호</td>
              <td>rno</td>
              <td>필수</td>
              <td>10</td>
              <td>진입로 번호</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <h2 class="h5 mb-4 text-gray-800">출력 결과(Response Element)</h2><div class="col-lg-8"></div>
    <div class="col-lg-4">
      <div class="card shadow mr-4 border-left-primary row">  
        <div class= "card-body row ">
          <textarea readonly class="form-control" rows="24" >
{
	rc: 1,
	resMessage: "success!",
	result: [
		{
			rno: 1,
			lane: 1,
			large: 1020,
			small: 24401,
			roadName: "목동방향",
			ino: 1,
			intersectionName: "목동오거리"
		}, { } ,{ }
	]
}   
          </textarea> 
        </div>               
      </div>
    </div>
    <div class="col-lg-8">
      <div class="card shadow mb-4 row"> 
        <div class= "card-body row ">
          <table class="table table-bordered ">
            <tr style="text-align: center; background-color: #ACD7F2; color: black; font-weight: bold;">
              <td >항목명(국문)</td>
              <td>항목명(영문)</td>
              <td>데이터형</td>
              <td>샘플데이터</td>
              <td>항목설명</td>
            </tr>
            <tr>                   
              <td>결과 코드</td>
              <td>rc</td>
              <td>number</td>
              <td>1</td>
              <td>결과 코드</td>
            </tr>
            <tr>                   
              <td>결과 메시지</td>
              <td>resMessage</td>
              <td>String</td>
              <td>success!</td>
              <td>결과 메시지</td>
            </tr>
            <tr>                   
              <td>요청 결과 데이터</td>
              <td>result</td>
              <td>List[Object]</td>
              <td>[{}]</td>
              <td>반환된 결과</td>
            </tr>
            <tr>                   
              <td>교차로번호</td>
              <td>result.ino</td>
              <td>number</td>
              <td>1</td>
              <td>교차로번호</td>                    
            </tr>
            <tr>                   
              <td>교차로명</td>
              <td>result.intersectionName</td>
              <td>String</td>
              <td>목동오거리</td>
              <td>진입로가 포함된 교차로 이름</td>                    
            </tr>
            <tr>                   
              <td>진입로번호</td>
              <td>result.rno</td>
              <td>number</td>
              <td>1</td>
              <td>진입로번호</td>                    
            </tr>
            <tr>                   
              <td>진입로명</td>
              <td>result.roadName</td>
              <td>String</td>
              <td>목동방향</td>
              <td>진입로이름</td>
            </tr>
            <tr>                   
              <td>차선</td>
              <td>result.lane</td>
              <td>number</td>
              <td>1</td>
              <td>교통량 측정 차선</td>
            </tr>
            <tr>                   
              <td>대형차량수</td>
              <td>result.large</td>
              <td>number</td>
              <td>14</td>
              <td>5분간 통행한 대형차량수</td>
            </tr>
            <tr>                   
              <td>소형차량수</td>
              <td>result.small</td>
              <td>number</td>
              <td>43</td>
              <td>5분간 통행한 소형차량수</td>
            </tr>                  
          </table>
        </div>
      </div>
    </div>
</div>
<hr><hr>
<script>

</script>