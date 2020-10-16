<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@
		taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%
%>
<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-1 text-gray-800" >Open API</h1>
        <a href="javascript:app.loadDialog('/getApiKey',{})" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i>API키 발급받기</a>
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
          </div>
</div>
<script>

</script>