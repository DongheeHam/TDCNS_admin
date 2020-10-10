<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@
		taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%
%>
<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 text-gray-800">교차로 등록 현황</h1>
	<div class='d-flex flex-row'>
		<a href="javascript:app.loadDialog('/interForm',{},'modal-lg')" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i>교차로 등록</a>
		<a href="javascript:app.loadDialog('/roadForm',{},'modal-lg')" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm ml-1"><i class="fas fa-download fa-sm text-white-50"></i>진입로 등록</a>
	</div>
</div>

<!-- Content Row -->
<div class="row">

	<div class="col-lg-12">

		<!-- Collapsable Card Example -->
		<div class="card shadow mb-4">
			<!-- Card Header - Accordion -->
			<a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">
				<h6 class="m-0 font-weight-bold text-primary">지도 뷰</h6>
			</a>
			<!-- Card Content - Collapse -->
			<div class="collapse show" id="collapseCardExample">
				<div class="card-body">
					<div id="inter-mgmt-map-wrap" class="map_wrap_mgmt">
						<!-- <div id="inter-mgmt-map" style="width:100%;height:100%"></div>
						<div id="menu_wrap" class="bg_white">
							<div class="option">
								<div>
										키워드 : <input type="text" value="" class="inter-mgmt-search-keyword" size="15"> 
										<button type="button" class="btn btn-primary px-2 mb-1" onclick="kakaoMap.searchPlaces('.inter-mgmt-search-keyword');">검색</button> 
								</div>
							</div>
							<hr>
							<ul id="placesList"></ul>
							<div id="pagination"></div>
						</div> -->
					</div>
				</div>
			</div>
		</div>
	
		<!-- Collapsable Card Example -->
		<div class="card shadow mb-4">
			<!-- Card Header - Accordion -->
			<a href="#collapseCardExample2" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">
				<h6 class="m-0 font-weight-bold text-primary">리스트 뷰</h6>
			</a>
			<!-- Card Content - Collapse -->
			<div class="collapse show" id="collapseCardExample2">
				<div class="card-body">
					<h1 class="h3 mb-3 text-gray-800">교차로 리스트</h1>
					<div class="card">
					  <div class="card-body">
							<table id="inter-table" class="table table-bordered">
								<thead>
									<tr>
										<th>교차로명</th>
										<th>교차로번호</th>
										<th>좌표(위도 경도)</th>
									</tr>
								</thead>
								<tbody class='inter-table-body'></tbody>
							</table>
					  </div>
					</div>
					<h1 class="h3 my-3 text-gray-800">진입로 리스트</h1>
					<div class="card mt-3">
					  <div class="card-body">
					  		
							<table id="road-table" class="table table-bordered">
								<thead>
									<tr>
										<th>교차로명(교차로번호)</th>
										<th>진입로명(진입로번호)</th>
										<th>스트리밍 URL</th>
										<th>카메라</th>
										<th>좌표</th>
									</tr>
								</thead>
								<tbody class='road-table-body'></tbody>
							</table>
					  </div>
					</div>
				</div>
			</div>
		</div>
	
	</div>

</div>
<!-- /.container-fluid -->

<script>
var roadList,interList;
var mgmtMap;
$(document).ready(function(){
	app.get('/getRoadList',{},function(res){
		console.log('/getRoadList - res : ',res);
		if(res.rc<0){
			alert("error:"+res.resMessage);
		}else{
			roadList=res.result;
			drowRoadTable();
			drowRoadMarker();
		}
	});
	app.get('/getInterList',{},function(res){
		console.log('/getInterList - res : ',res);
		if(res.rc<0){
			alert("error:"+res.resMessage);
		}else{
			interList=res.result;
			drowInterTable();
			drowInterMarker();
		}
	});
	//mgmtMap=kakaoMap.createMap('inter-mgmt-map-wrap');
	mgmtMap=new KakaoMap('inter-mgmt-map-wrap',{search:true});
});
function drowRoadTable(){
	var html='';
	for(var i=0;i<roadList.length;i++){
		html+='<tr>';
		var road=roadList[i];
		html+=	'<td>'+road.iname+'('+road.ino+')</td>';
		html+=	'<td>'+road.name+'('+road.rno+')</td>';
		html+=	'<td>'+road.stream+'</td>';
		html+=	'<td> </td>';
		html+=	'<td>'+road.lat+' '+road.lng+'</td>';
		html+='</tr>';
	}
	$('.road-table-body').html(html);
	setDataTable('#road-table');
}
function drowInterTable(){
	var html='';
	for(var i=0;i<interList.length;i++){
		var inter=interList[i];
		html+='<tr>';
		html+=	'<td>'+inter.ino+'</td>';
		html+=	'<td>'+inter.name+'</td>';
		html+=	'<td>'+inter.lat+' '+inter.lng+'</td>';
		html+='</tr>';
	}
	$('.inter-table-body').html(html);
	setDataTable('#inter-table');
}
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
		marker.setMap(mgmtMap.map);
		var html='';
		html+='<div style="padding:5px; color:#555; font-weight:600">'+inter.name+'('+inter.ino+')</div>';
		var infowindow = new kakao.maps.InfoWindow({
		    content : html
		});
		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(mgmtMap.map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	}
	mgmtMap.map.setBounds(bounds);
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
		marker.setMap(mgmtMap.map);
		var html='';
		html+='<div style="padding:5px; color:#555; font-weight:600">'+road.name+'('+road.rno+')</div>';
		var infowindow = new kakao.maps.InfoWindow({
		    content : html
		});
		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(mgmtMap.map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
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
function setDataTable(selector){
	$(selector).DataTable({language:lang_kor});
}
</script>