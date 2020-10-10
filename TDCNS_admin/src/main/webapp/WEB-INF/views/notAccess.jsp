<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<div class="not-access-con">
	<div class="not-access">
		<c:choose>
			<c:when test="${!empty duplicatePlay}">
				<div class="not-access-message">[ ${duplicatePlay} ]</div>
			</c:when>
			<c:otherwise>
				<div class="not-access-message">[ <spring:message code="ux.notAccess.message.${message}"/> ]</div>
			</c:otherwise>
		</c:choose>
		<%-- <c:if test="${!empty sessionScope.loginUser}"> [${empty message?"잘못된 접근":message}]</c:if>
		<c:if test="${empty sessionScope.loginUser}"> [로그인 세션이 만료되었습니다. 새로고침하세요.]</c:if> --%>
		<div class="btn-con">
			<div class="b-btn" onclick="history.back()"><spring:message code="ux.button.back"/></div>
			<div class="b-btn" onclick="location.reload()"><spring:message code="ux.button.refresh"/></div>
			<div class="b-focus" onclick='location.href="#"'><spring:message code="ux.button.home"/></div>
		</div>
	</div>
</div>
<script>
NProgress.done();
</script>