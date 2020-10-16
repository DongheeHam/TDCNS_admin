<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@
		taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%
%>
<!-- Page Heading -->
<h1 class="h3 mb-4 text-gray-800">교차로 데이터 분석</h1>
<div class="row">
	<div class="col-lg-8">
		<!-- Collapsable Card Example -->
		<div class="card shadow mb-10">
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
		<div class="card mb-5">
			<div class="card-header detect-info-header">
				교차로 정보
			</div>
			<div class="card-body detect-info-body">
				진입로 핀을 클릭하면 이곳에 교차로 정보가 나타납니다.
			</div>
		</div>
		<div class="card mb-5">
			<div class="card-header detect-monitor-header">
				실시간 교차로 인식 화면
			</div>
			<div class="card-body detect-monitor-body">
				진입로 핀을 클릭하면 이곳에 실시간 교차로 인식 화면이 나타납니다.
			</div>
		</div>
	</div>
</div>
<div class="row mt-3">
	<div class="col-xl-8 col-lg-7">

		<!-- Area Chart -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">일자별 통계</h6>
			</div>
			<div class="card-body">
				<div class="form-group row">
				  <label for="dayStat-date" class="col-2 col-form-label">날짜 : </label>
				  <div class="col-10">
					<input type="date" class="start-datetime form-control"  id="dayStat-date">
				  </div>
				</div>
				<div class="chart-area">
					<canvas id="dayStatistics"></canvas>
				</div>
				<hr>
				Styling for the area chart can be found in the <code>/js/demo/chart-area-demo.js</code> file.
			</div>
		</div>

		<!-- Bar Chart -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">주간 통계</h6>
			</div>
			<div class="card-body">
				<div class="chart-bar">
					<div class="form-group row">
					  <label for="weekStat-date" class="col-2 col-form-label">날짜 : </label>
					  <div class="col-10">
						<input type="date" class="start-datetime form-control"  id="weekStat-date" >
					  </div>
					</div>
					<canvas id="weekStatistics"></canvas>
				</div>
				<hr>
				Styling for the bar chart can be found in the <code>/js/demo/chart-bar-demo.js</code> file.
			</div>
		</div>

	</div>

	<!-- Donut Chart -->
	<div class="col-xl-4 col-lg-5">
		<div class="card shadow mb-4">
			<!-- Card Header - Dropdown -->
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">차선별 통계</h6>
			</div>
			<!-- Card Body -->
			<div class="card-body">
				<div class="chart-pie pt-4">
					<canvas id="laneStatistics"></canvas>
				</div>
				<hr>
				Styling for the donut chart can be found in the <code>/js/demo/chart-pie-demo.js</code> file.
			</div>
		</div>
		<div class="card shadow mb-4">
			<!-- Card Header - Dropdown -->
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">차량 크기</h6>
			</div>
			<!-- Card Body -->
			<div class="card-body">
				<div class="chart-pie pt-4">
					<canvas id="sizeStatistics"></canvas>
				</div>
				<hr>
				Styling for the donut chart can be found in the <code>/js/demo/chart-pie-demo.js</code> file.
			</div>
		</div>
	</div>
</div>
<script>
var roadList,interList;
var monitorMap;
$(document).ready(function(){
	$('input[type=date]').each(function(){$(this).val(moment().format('YYYY-MM-DD'))});
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
var currentRno=-1;
function makeClickListener(road){
	return function() {
				console.log(road);
				currentRno=road.rno;
				var html='<img class="img-fluid" src="http://'+road.ip+'/tdcns_monitor">'
				$('.detect-monitor-body').html(html);
				var date=moment().format('YYYYMMDD');
				var time=Number(moment().format('HHmm'));
				time=time-time%5-5;
				html='';
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
				$('.detect-info-body').html(html);
				
				var now=moment().format('YYYYMMDD');
				//통계 함수 실행
				drowWeekStat(road.rno,now);
				drowDayStat(road.rno,now);
				drowSizeStat(road.rno);
				drowLaneStat(road.rno);
				
		};
}

Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

function number_format(number, decimals, dec_point, thousands_sep) {
  // *     example: number_format(1234.56, 2, ',', ' ');
  // *     return: '1 234,56'
  number = (number + '').replace(',', '').replace(' ', '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function(n, prec) {
      var k = Math.pow(10, prec);
      return '' + Math.round(n * k) / k;
    };
  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '').length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1).join('0');
  }
  return s.join(dec);
}
$('#dayStat-date').change(function(){
	var now=$(this).val().replaceAll('-','');

	currentRno==-1?alert('먼저 진입로를 선택해주세요.'):drowDayStat(currentRno,now);
})
$('#weekStat-date').change(function(){
	var now=$(this).val().replaceAll('-','');

	currentRno==-1?alert('먼저 진입로를 선택해주세요.'):drowDayStat(currentRno,now);
})
function drowDayStat(rno,date){
	app.get('http://35.224.46.11//dc/getDayStat',{serviceKey:'a',date:date,rno:rno},function(res){
		var dayStatistics = document.getElementById("dayStatistics");
		var labels=["00시","01시","02시","03시","04시","05시","06시","07시","08시","09시","10시","11시","12시",
	    	"13시","14시","15시","16시","17시","18시","19시","20시","21시","22시","23시"];
		var datas=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
		for(var i=0;i<labels.length;i++){
			for(var j=0;j<res.result.length;j++){
				if(Number(res.result[j].time_)==i*100){
					datas[i]=res.result[j].large+res.result[j].small;
				}
			}
		}
		var dayStatisticsChart = new Chart(dayStatistics, {
			  type: 'line',
			  data: {
			    labels: labels,
			    datasets: [{
			      label: "Earnings",
			      lineTension: 0.3,
			      backgroundColor: "rgba(78, 115, 223, 0.05)",
			      borderColor: "rgba(78, 115, 223, 1)",
			      pointRadius: 3,
			      pointBackgroundColor: "rgba(78, 115, 223, 1)",
			      pointBorderColor: "rgba(78, 115, 223, 1)",
			      pointHoverRadius: 3,
			      pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
			      pointHoverBorderColor: "rgba(78, 115, 223, 1)",
			      pointHitRadius: 10,
			      pointBorderWidth: 2,
			      data: datas,
			    }],
			  },
			  options: {
			    maintainAspectRatio: false,
			    layout: {
			      padding: {
			        left: 10,
			        right: 25,
			        top: 25,
			        bottom: 0
			      }
			    },
			    scales: {
			      xAxes: [{
			        time: {
			          unit: 'date'
			        },
			        gridLines: {
			          display: false,
			          drawBorder: false
			        },
			        ticks: {
			          maxTicksLimit: 7
			        }
			      }],
			      yAxes: [{
			        ticks: {
			          maxTicksLimit: 5,
			          padding: 10,
			          // Include a dollar sign in the ticks
			          callback: function(value, index, values) {
			            return  number_format(value) +'대';
			          }
			        },
			        gridLines: {
			          color: "rgb(234, 236, 244)",
			          zeroLineColor: "rgb(234, 236, 244)",
			          drawBorder: false,
			          borderDash: [2],
			          zeroLineBorderDash: [2]
			        }
			      }],
			    },
			    legend: {
			      display: false
			    },
			    tooltips: {
			      backgroundColor: "rgb(255,255,255)",
			      bodyFontColor: "#858796",
			      titleMarginBottom: 10,
			      titleFontColor: '#6e707e',
			      titleFontSize: 14,
			      borderColor: '#dddfeb',
			      borderWidth: 1,
			      xPadding: 15,
			      yPadding: 15,
			      displayColors: false,
			      intersect: false,
			      mode: 'index',
			      caretPadding: 10,
			      callbacks: {
			        label: function(tooltipItem, chart) {
			          var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
			          return datasetLabel + ': $' + number_format(tooltipItem.yLabel);
			        }
			      }
			    }
			  }
			});
	});
}

function drowWeekStat(rno,endDate){
	app.get('http://35.224.46.11//dc/getWeekStat',{serviceKey:'a',endDate:endDate,rno:rno},function(res){
		var labels=[];
		var dates=[];
		var datas=[0,0,0,0,0,0,0];
		var d=-6;
		for(var i=0;i<7;i++){
			dates[i]=moment(endDate).add(d,'d').format('YYYYMMDD');
			labels[i]=moment(endDate).add(d,'d').format('M/D');
			d++;
		}
		for(var i=0;i<labels.length;i++){
			for(var j=0;j<res.result.length;j++){
				if(res.result[j].date==dates[i]){
					datas[i]=res.result[j].large+res.result[j].small;
				}
			}
		}
		var weekStatistics = document.getElementById("weekStatistics");
		var weekStatisticsChart = new Chart(weekStatistics, {
		type: 'bar',
		data: {
		 labels: labels,
		 datasets: [{
		   label: "Revenue",
		   backgroundColor: "#4e73df",
		   hoverBackgroundColor: "#2e59d9",
		   borderColor: "#4e73df",
		   data: datas,
		 }],
		},
		options: {
		 maintainAspectRatio: false,
		 layout: {
		   padding: {
		     left: 10,
		     right: 25,
		     top: 25,
		     bottom: 0
		   }
		 },
		 scales: {
		   xAxes: [{
		     time: {
		       unit: 'month'
		     },
		     gridLines: {
		       display: false,
		       drawBorder: false
		     },
		     ticks: {
		       maxTicksLimit: 6
		     },
		     maxBarThickness: 25,
		   }],
		   yAxes: [{
		     ticks: {
		       min: 0,
		       max: 15000,
		       maxTicksLimit: 5,
		       padding: 10,
		       // Include a dollar sign in the ticks
		       callback: function(value, index, values) {
		         return number_format(value)+"대";
		       }
		     },
		     gridLines: {
		       color: "rgb(234, 236, 244)",
		       zeroLineColor: "rgb(234, 236, 244)",
		       drawBorder: false,
		       borderDash: [2],
		       zeroLineBorderDash: [2]
		     }
		   }],
		 },
		 legend: {
		   display: false
		 },
		 tooltips: {
		   titleMarginBottom: 10,
		   titleFontColor: '#6e707e',
		   titleFontSize: 14,
		   backgroundColor: "rgb(255,255,255)",
		   bodyFontColor: "#858796",
		   borderColor: '#dddfeb',
		   borderWidth: 1,
		   xPadding: 15,
		   yPadding: 15,
		   displayColors: false,
		   caretPadding: 10,
		   callbacks: {
		     label: function(tooltipItem, chart) {
		       var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
		       return datasetLabel + ': $' + number_format(tooltipItem.yLabel);
		     }
		   }
		 },
		}
		});
	});
}
var colors=['#4e73df', '#1cc88a', '#36b9cc','#ffc6a8','#ff8949','#b7d7d8','#204e5f','#f3e7db','#ffdf65','#7fffd4','#ffa500','#d3ffce']
var colorsHo=['#2e59d9', '#17a673', '#2c9faf','#efc0a0','#f08040','#b0d0d0','#124752','#e3e0d2','#e8d360','#73f0d0','#f4a000','#caffce']
function drowLaneStat(rno){
	app.get('http://35.224.46.11//dc/getLaneStat',{serviceKey:'a',rno:rno},function(res){
		var labels=new Array(res.result.length);
		var datas=new Array(res.result.length);
		for(var i=0;i<res.result.length;i++){
			labels[i]=res.result[i].lane;
			datas[i]=res.result[i].large+res.result[i].small;
		}
		var laneStatistics = document.getElementById("laneStatistics");
		var laneStatisticsChart = new Chart(laneStatistics, {
		type: 'doughnut',
		data: {
		 labels: labels,
		 datasets: [{
		   data: datas,
		   backgroundColor: colors.splice(0,res.result.length),
		   hoverBackgroundColor: colorsHo.splice(0,res.result.length),
		   hoverBorderColor: "rgba(234, 236, 244, 1)",
		 }],
		},
		options: {
		 maintainAspectRatio: false,
		 tooltips: {
		   backgroundColor: "rgb(255,255,255)",
		   bodyFontColor: "#858796",
		   borderColor: '#dddfeb',
		   borderWidth: 1,
		   xPadding: 15,
		   yPadding: 15,
		   displayColors: false,
		   caretPadding: 10,
		 },
		 legend: {
		   display: false
		 },
		 cutoutPercentage: 80,
		},
		});
	});
}

function drowSizeStat(rno){
	app.get('http://35.224.46.11//dc/getSizeStat',{serviceKey:'a',rno:rno},function(res){
		var labels=["대형차", "소형차"];
		var datas=[res.result.large,res.result.small];
		var sizeStatistics = document.getElementById("sizeStatistics");
		var sizeStatisticsChart = new Chart(sizeStatistics, {
		type: 'doughnut',
		data: {
		 labels: labels,
		 datasets: [{
		   data: datas,
		   backgroundColor: ['#4e73df', '#1cc88a'],
		   hoverBackgroundColor: ['#2e59d9', '#17a673'],
		   hoverBorderColor: "rgba(234, 236, 244, 1)",
		 }],
		},
		options: {
		 maintainAspectRatio: false,
		 tooltips: {
		   backgroundColor: "rgb(255,255,255)",
		   bodyFontColor: "#858796",
		   borderColor: '#dddfeb',
		   borderWidth: 1,
		   xPadding: 15,
		   yPadding: 15,
		   displayColors: false,
		   caretPadding: 10,
		 },
		 legend: {
		   display: false
		 },
		 cutoutPercentage: 80,
		},
		});
	});
}

</script>