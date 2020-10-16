<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@
	taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%
%>
<div class="modal-header">
	<h5 class="modal-title" id="exampleModalLabel">
		<c:choose>
			<c:when test="${empty road}">진입로 등록</c:when>
			<c:otherwise>진입로 수정</c:otherwise>
		</c:choose>
	</h5>
	<button class="close" type="button" data-dismiss="modal" aria-label="Close">
		<span aria-hidden="true">×</span>
	</button>
</div>
<div class="modal-body">
		<form>
			<div class="form-group">
				<label for="road-ino">소속 교차로 번호</label>
				<input type="text" class="form-control road-ino" id="road-ino" aria-describedby="emailHelp" placeholder="교차로번호를 입력하세요." value="${road.ino}">
				<small id="road-ino-help" class="form-text text-muted">진입로가 소속된 교차로의 고유번호를 입력하세요.</small>
			</div>
			<div class="form-group">
				<label for="road-name">진입로 이름</label>
				<input type="text" class="form-control road-name" id="road-name" placeholder="진입로명을 입력하세요." value="${road.name}">
			</div>
			<div class="form-group">
				<label for="road-ip">ip:port</label>
				<input type="text" class="form-control road-ip" id="road-ip" placeholder="모듈의  아이피와 포트를 입력하세요." value="${road.ip}">
				<small id="road-ino-help" class="form-text text-muted">모듈 서버의 ip와 port를 입력하세요 (ex - 10.10.10.10:8081)</small>
			</div>
			<div class="form-group">
				<label for="road-stream">스트리밍URL</label>
				<input type="text" class="form-control road-stream" id="road-stream" placeholder="스트리밍 URL을 입력하세요." value="${road.stream}">
			</div>
			<div class="form-group">
				<label for="exampleInputPassword1">좌표를 입력하세요</label>
				<div class=" d-flex flex-row">
					<input type="text" class="form-control mr-1 road-lat" placeholder="위도" value="${road.lat}">
					<input type="text" class="form-control ml-1 road-lng" placeholder="경도" value="${road.lng}">
				</div>
			</div>
			<div class="map_wrap_form" id="road-form-map"></div>
		</form>
</div>
<div class="modal-footer">
	<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
	<a class="btn btn-primary" href="javascript:saveInter()">저장</a>
</div>
<script>
$(document).ready(function() {
	setTimeout(function(){
		var roadFormMap
		if('${road.rno}'!='')
			roadFormMap=new KakaoMap('road-form-map',{search:true,lat:'${road.lat}',lng:'${road.lng}'});
		else
			roadFormMap=new KakaoMap('road-form-map',{search:true});
		
		var marker=new kakao.maps.Marker({
				position: roadFormMap.map.getCenter() // 마커의 위치 
			});
		marker.setMap(roadFormMap.map);
		kakao.maps.event.addListener(roadFormMap.map, 'click', function(mouseEvent) {
			var latlng = mouseEvent.latLng;
			
			$('.road-lat').val(latlng.getLat());
			$('.road-lng').val(latlng.getLng());
			
			marker.setPosition(latlng)
		});
	},1000);
});
function saveInter(){
	if($('.road-ino').val()==""){
		alert("소속 교차로 번호를 입력하세요.");
		return;
	}
	if($('.road-name').val()==""){
		alert("진입로 이름을 입력하세요.");
		return;
	}
	if($('.road-ip').val()==""){
		alert("진입로 ip를 입력하세요.");
		return;
	}
	if($('.road-stream').val()==""){
		alert("진입로 스트리밍 URL을 입력하세요.");
		return;
	}
	if($('.road-lat').val()=="" || $('.road-lng').val()==""){
		alert("진입로 좌표를 입력하세요.");
		return;
	}
	var params={
		ino:$('.road-ino').val(),
		name:$('.road-name').val(),
		ip:$('.road-ip').val(),
		stream:$('.road-stream').val(),
		lat:$('.road-lat').val(),
		lng:$('.road-lng').val()
	}
	if('${road.rno}'!='') params.rno='${road.rno}';
	app.get("/insertRoad",params,function(res){
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