<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@
	taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%
%>
<div class="modal-header">
	<h5 class="modal-title" id="exampleModalLabel">API Key가 발급되었습니다.</h5>
	<button class="close" type="button" data-dismiss="modal" aria-label="Close">
		<span aria-hidden="true">×</span>
	</button>
</div>
<div class="modal-body text-center">
		<div>
			${key}
		</div>
		<hr>
		api요청시 이 키를 serviceKey파라미터에 입력하세요.
</div>
<div class="modal-footer">
	<button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
</div>
<script>


</script>