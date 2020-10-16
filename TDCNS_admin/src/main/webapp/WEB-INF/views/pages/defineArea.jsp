<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@
		taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%
%>
<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-1 text-gray-800" >교차로 인식존 설정</h1>
        <p class="mb-4">하단의 <span style="color: deeppink">다운로드 버튼</span>을 클릭후 <span style="color: deeppink">Step1,2,3</span>를 순서 대로 진행합니다</p>
</div>
          <!-- Content Row -->
          <div class="row">

            <!-- 이미지 -->
            <div class="col-lg-8">
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Step1.   저장할 진입로 설정</h6>
                </div>
                <div class="card-body">
                  <img src="/res/img/defineArea.png" alt="교차로 정보 등록 프로그램" style="float: left;">
                   <p style="font-size: small;margin-top: 30px;">다운로드한 define_area.exe 파일을 실행 후 저장할 진입로의 <span style="color: deeppink">고유번호(rno)</span>를 입력합니다</p>
                  <img src="/res/img/wrightRno.PNG" alt="교차로 정보 등록 프로그램" style="max-width: 100%;">
                </div>
              </div>
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h7 class="m-0 font-weight-bold text-primary">교차로 정보 등록 프로그램</h7>            
                </div>
                <div class= card-body>
                  <img src="/res/img/define.png" alt="교차로 정보 등록 프로그램" style="max-width: 100%;">                              
                </div>
              </div>              
            </div>
            <!-- Step1,2,3 -->
            <div class="col-lg-4">
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Step2.   DTC 구역 설정</h6>
                </div>
                <div class="card-body">
                   <p style="font-size: small;"><b>차량을 인식할 구역 설정</b>
                   <br>좌측 <span style="color: deeppink">DTC 버튼</span>을 클릭후 마우스 좌클릭으로 구역을 그린후 마지막 클릭은 우클릭을 하여 구역을 설정합니다.
                   이후 <span style="color: deeppink">SEND 버튼</span>을 클릭해 서버에 DTC좌표값을 전송합니다</p>
                </div>
              </div>
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Step3.   LDTC 구역 설정</h6>
                </div>          
                <div class="card-body">
                  <p style="font-size: small;"><b>차선별 구역 설정</b>
                  <br>좌측 <span style="color: deeppink">LDTC 버튼</span>을 클릭 후 1차선부터 좌클릭으로  차선별 구역을 설정해줍니다.<br>
                   1차선이 끝나면 우클릭으로 현재 차선을 마감하고 같은 방법으로 마지막 차선까지 설정한 후 <br>
                   모든 차선정보 입력이 끝나면  <span style="color: deeppink">SEND 버튼</span>을 클릭해 서버에 LDTC좌표값을 전송합니다</p>
                </div>               
              </div>
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Step4.   COUNTER 구역 설정</h6>
                </div>  
                <div class="card-body">
                  <p style="font-size: small;"><b>차량을 카운트할 구역 설정</b><br>
                  좌측 <span style="color: deeppink">COUNTER 버튼</span>을 클릭후 LDTC와 같은 방식으로 차선별 통행량을 카운트 하기 위한 카운팅존을 설정해준 후 모든 차선 정보 입력이 끝나면 <span style="color: deeppink">SEND 버튼</span>을 클릭해 서버에 DTC좌표값을 전송합니다</p>           
                </div>                             
              </div>
            </div>
            <div class="col-lg-12">
              <div class="card shadow mb-5">
                <div class="card-body" style="text-align: center;">
                  <a href="javascript:window.open('https://drive.google.com/uc?id=1-L5DcwrlPDR5pUEMrbXBVAM6cVqdcjmR&export=download', '_blank')" class="btn btn-primary btn-icon-split" >
                    <span class="icon text-white-50">
                      <i class="fas fa-check"></i>
                    </span>
                    <span class="text"> 파일 다운로드</span>
                  </a>
                </div>         
            </div> 
          </div>
</div>
<script>

</script>