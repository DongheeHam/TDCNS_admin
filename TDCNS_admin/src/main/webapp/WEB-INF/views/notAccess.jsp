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
		<%-- <c:if test="${!empty sessionScope.loginUser}"> [${empty message?"�߸��� ����":message}]</c:if>
		<c:if test="${empty sessionScope.loginUser}"> [�α��� ������ ����Ǿ����ϴ�. ���ΰ�ħ�ϼ���.]</c:if> --%>
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