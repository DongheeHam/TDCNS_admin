<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@
		taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%
%>
<!-- Page Heading -->
<h1 class="h3 mb-4 text-gray-800">교차로 모니터링</h1>
<div class="row">
	<div class="col-lg-8">
		<!-- Collapsable Card Example -->
		<div class="card shadow mb-8">
			<!-- Card Header - Accordion -->
			<a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">
				<h6 class="m-0 font-weight-bold text-primary">지도 뷰</h6>
			</a>
			<!-- Card Content - Collapse -->
			<div class="collapse show" id="collapseCardExample">
				<div class="card-body">
					<div id="monitoring-map" class="map_wrap_mgmt"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-4">
		<!-- Collapsable Card Example -->
		<div class="card mb-8">
			<div class="card-header detect-info-header">
				교차로 정보
			</div>
			<div class="card-body detect-info-body">
				진입로 핀을 클릭하면 이곳에 교차로 정보가 나타납니다.
			</div>
		</div>
	</div>
</div>
<div class="row mt-3">
	<div class="col-lg-12">
		<div class="card mb-4">
			<div class="card-header detect-monitor-header">
				실시간 교차로 인식 화면
			</div>
			<div class="card-body detect-monitor-body">
				진입로 핀을 클릭하면 이곳에 실시간 교차로 인식 화면이 나타납니다.
			</div>
		</div>
	</div>
</div>
<script>
var roadList,interList;
var monitorMap;
$(document).ready(function(){
	setTimeout(function(){
		app.get('/getRoadList',{},function(res){
			console.log('/getRoadList - res : ',res);
			if(res.rc<0){
				alert("error:"+res.resMessage);
			}else{
				roadList=res.result;
				drowRoadMarker();
			}
		});
		app.get('/getInterList',{},function(res){
			console.log('/getInterList - res : ',res);
			if(res.rc<0){
				alert("error:"+res.resMessage);
			}else{
				interList=res.result;
				drowInterMarker();
			}
		});
		//monitorMap=kakaoMap.createMap('inter-mgmt-map-wrap');
		monitorMap=new KakaoMap('monitoring-map',{});
	},300);
});
function drowInterMarker(){
	var imageSrc='/res/img/inter2.png';
	var imageSize = new kakao.maps.Size(40, 50);
	var imageOption = {offset: new kakao.maps.Point(20, 50)};
	var bounds = new kakao.maps.LatLngBounds()
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	for(var i=0;i<interList.length;i++){
		var inter=interList[i];
		var markerPosition = new kakao.maps.LatLng(inter.lat, inter.lng);
		bounds.extend(markerPosition);
		var marker = new kakao.maps.Marker({
		    position: markerPosition, 
		    image: markerImage // 마커이미지 설정 
		});
		marker.setMap(monitorMap.map);
		var html='';
		html+='<div style="padding:5px; color:#555; font-weight:600">'+inter.name+'('+inter.ino+')</div>';
		var infowindow = new kakao.maps.InfoWindow({
		    content : html
		});
		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(monitorMap.map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	}
	if(interList.length)
		monitorMap.map.setBounds(bounds);
}
function drowRoadMarker(){
	var imageSrc='/res/img/road2.png';
	var imageSize = new kakao.maps.Size(40, 50);
	var imageOption = {offset: new kakao.maps.Point(20, 50)};
	
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	for(var i=0;i<roadList.length;i++){
		var road=roadList[i];
		var markerPosition = new kakao.maps.LatLng(road.lat, road.lng);
		var marker = new kakao.maps.Marker({
		    position: markerPosition, 
		    image: markerImage // 마커이미지 설정 
		});
		marker.setMap(monitorMap.map);
		var html='';
		html+='<div style="padding:5px; color:#555; font-weight:600">'+road.name+'('+road.rno+')</div>';
		var infowindow = new kakao.maps.InfoWindow({
		    content : html
		});
		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(monitorMap.map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	    kakao.maps.event.addListener(marker, 'click', makeClickListener(road));
	}
}
//인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}

function makeClickListener(road){
	return function() {
        console.log(road);
        var html='<img class="img-fluid" src="http://'+road.ip+'/tdcns_monitor">'
        $('.detect-monitor-body').html(html);
        var date=moment().format('YYYYMMDD');
        var time=Number(moment().format('HHmm'));
        time=time-time%5-5;
        html='';
        html+='<h5>교차로 기본정보</h5>';
        html+='<table class="table table-sm table-bordered">';
        html+=	'<tbody>';
        html+=		'<tr>';
        html+=			'<th>교차로명(교차로번호)</th>';
        html+=			'<td>'+road.iname+'('+road.ino+')</td>';
        html+=		'</tr>';
        html+=		'<tr>';
        html+=			'<th>진입로명(진입로번호)</th>';
        html+=				'<td>'+road.name+'('+road.rno+')</td>';
        html+=		'</tr>';
        html+=		'<tr>';
        html+=			'<th>위치</th>';
        html+=			'<td>'+road.lat+' '+road.lng+'</td>';
        html+=		'</tr>';
        html+=	'</tbody>';
        html+='</table>';
        app.get('/dc/getDataRow',{rno:road.rno,date:date,time:time},function(res){
        	if(res.rc<0){
        		alert("error"+error);
        	}else{
                html+='<h5>최근 5분 통행량</h5>';
                html+='<table class="table table-sm table-bordered">';
                html+=	'<tbody>';
        		if(res.result){
            		var small=0, large=0;
            		for(var i=0;i<res.result.length;i++){
            			var lane=res.result[i];
            			small=lane.small;
            			large+=lane.large;
            		}
                    html+=	'<tr>';
                    html+=		'<th>대형</th>';
                    html+=		'<td>'+large+'</td>';
                    html+=	'</tr>';
                    html+=	'<tr>';
                    html+=		'<th>소형</th>';
                    html+=		'<td>'+small+'</td>';
                    html+=	'</tr>';
        		}else{
        			html+=	'<tr><th>수집된 데이터가 없습니다.</th></tr>';
        		}
                html+=	'</tbody>';
                html+='</table>';
        	}
        	$('.detect-info-body').html(html);
        });
    };
}
</script>