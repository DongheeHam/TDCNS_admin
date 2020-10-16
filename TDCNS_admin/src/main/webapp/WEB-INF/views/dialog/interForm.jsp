<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@
	taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%
%>
<div class="modal-header">
	<h5 class="modal-title" id="exampleModalLabel">
		<c:choose>
			<c:when test="${empty inter}">교차로 등록</c:when>
			<c:otherwise>교차로 수정</c:otherwise>
		</c:choose>
	</h5>
	<button class="close" type="button" data-dismiss="modal" aria-label="Close">
		<span aria-hidden="true">×</span>
	</button>
</div>
<div class="modal-body">
		<form>
			<div class="form-group">
				<label for="inter-name1">교차로 이름</label>
				<input type="text" class="form-control inter-name" id="inter-name1" aria-describedby="emailHelp" placeholder="교차로명을 입력하세요." value="${inter.name}">
			</div>
			<div class="form-group">
				<label for="exampleInputPassword1">좌표를 입력하세요</label>
				<div class=" d-flex flex-row">
					<input type="text" class="form-control mr-1 inter-lat" placeholder="위도" value="${inter.lat}">
					<input type="text" class="form-control ml-1 inter-lng" placeholder="경도" value="${inter.lng}">
				</div>
			</div>
			
			<div class="map_wrap_form" id="inter-form-map"></div>
		</form>
</div>
<div class="modal-footer">
	<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
	<a class="btn btn-primary" href="javascript:saveInter()">저장</a>
</div>
<script>
$(document).ready(function() {
	setTimeout(function(){
		var interFormMap;
		if('${inter.ino}'!='')
			interFormMap=new KakaoMap('inter-form-map',{search:true,lat:'${inter.lat}',lng:'${inter.lng}'});
		else
			interFormMap=new KakaoMap('inter-form-map',{search:true});
		
		var marker=new kakao.maps.Marker({
				position: interFormMap.map.getCenter() // 마커의 위치 
			});
		marker.setMap(interFormMap.map);
		kakao.maps.event.addListener(interFormMap.map, 'click', function(mouseEvent) {
			var latlng = mouseEvent.latLng;
			
			$('.inter-lat').val(latlng.getLat());
			$('.inter-lng').val(latlng.getLng());
			
			marker.setPosition(latlng)
		});
	},1000);
});
function saveInter(){
	if($('.inter-name').val()==""){
		alert("교차로 이름을 입력하세요.");
		return;
	}
	if($('.inter-lat').val()=="" || $('.inter-lng').val()==""){
		alert("교차로 좌표를 입력하세요.");
		return;
	}
	var params={
		name:$('.inter-name').val(),
		lat:$('.inter-lat').val(),
		lng:$('.inter-lng').val()
	}
	if('${inter.ino}'!='') params.ino='${inter.ino}'
	app.get("/insertInter",params,function(res){
		if(res.rc<0){
			alert("error:"+res.resMessage);
		}else{
			alert("성공적으로 저장되었습니다.");
			app.closeDialog();
			app.go('/roadMgmt');
		}
	})
}


</script>