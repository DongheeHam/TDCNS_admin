

function KakaoMap(id,option){
	if(!option || typeof option!="object") option={};
	if(!option.lat) option.lat= 37.37992393181718;
	if(!option.lng) option.lng=126.92881366045285;
	
	this.markers=[];
	
	var container = $('#'+id); //지도를 담을 영역의 DOM 레퍼런스
	
	// container에 지도 담을 element 가져와서 추가하기
	var html=this.elString(id,option.search);
	container.html(html);

	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(option.lat, option.lng), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
	
	this.map = new kakao.maps.Map($('#'+id+'-map')[0], options); //지도 생성 및 객체 리턴
	

	if(option.search){
		// 장소 검색 객체를 생성합니다
		//container.find('.search-btn').click(this.keywordSearch);
		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		container.find('.search-btn').click((eee) => {
			var el=$(eee.currentTarget)
			var keyword = el.siblings('.search-text').val();
			if (!keyword.replace(/^\s+|\s+$/g, '')) {
				alert('키워드를 입력해주세요!');
				return false;
			}
			// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
			console.log("ps.keywordSearch:",this)
			this.ps.keywordSearch(keyword, (a,b,c)=>{this.placesSearchCB(a,b,c,el.data('id'))}); 
		});
	}
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	this.removeMarker= ()=> {
		for ( var i = 0; i < this.markers.length; i++ ) {
			this.markers[i].setMap(null);
		}   
	   this.markers = [];
	}
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	this.addKeywordMarker=(position, idx, title) => {
		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
			imgOptions = {
				spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
				spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
			},
			markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
				marker = new kakao.maps.Marker({
				position: position, // 마커의 위치
				image: markerImage 
			});
		marker.setMap(this.map); // 지도 위에 마커를 표출합니다
		this.markers.push(marker);  // 배열에 생성된 마커를 추가합니다
		return marker;
	}
	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
 	// 인포윈도우에 장소명을 표시합니다
 	this.displayInfowindow=(marker, title) => {
 		var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
 	   this.infowindow.setContent(content);
 	  this.infowindow.open(this.map, marker);
 	},

 	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
 	this.removeAllChildNods=function (el) {   
 		while (el.hasChildNodes()) {
 			el.removeChild (el.lastChild);
 		}
 	 }
 	this.displayPlaces=(places, id) => {
		var listEl = document.getElementById(id+'-placesList'), 
			menuEl = document.getElementById(id+'-menu_wrap'),
			fragment = document.createDocumentFragment(), 
			bounds = new kakao.maps.LatLngBounds(), 
			listStr = '';
		
		// 검색 결과 목록에 추가된 항목들을 제거합니다
	   this.removeAllChildNods(listEl);
		// 지도에 표시되고 있는 마커를 제거합니다
	   this.removeMarker();
		
		for ( var i=0; i<places.length; i++ ) {
			// 마커를 생성하고 지도에 표시합니다
			var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
				marker = this.addKeywordMarker(placePosition, i), 
				itemEl = this.getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
			// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			// LatLngBounds 객체에 좌표를 추가합니다
			bounds.extend(placePosition);
			// 마커와 검색결과 항목에 mouseover 했을때
			// 해당 장소에 인포윈도우에 장소명을 표시합니다
			// mouseout 했을 때는 인포윈도우를 닫습니다
			((marker, title) => {
				kakao.maps.event.addListener(marker, 'mouseover', () =>{
					this.displayInfowindow(marker, title);
				});
				kakao.maps.event.addListener(marker, 'mouseout', () =>{
					this.infowindow.close();
				});
				itemEl.onmouseover =  () =>{
					this.displayInfowindow(marker, title);
				};
				itemEl.onmouseout =  () =>{
					this.infowindow.close();
				};
			})(marker, places[i].place_name);

			fragment.appendChild(itemEl);
		}
		// 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
		listEl.appendChild(fragment);
		menuEl.scrollTop = 0;
		// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		this.map.setBounds(bounds);
	}
	
	
		
		
	this.displayPagination=(pagination,id) => {
			var paginationEl = document.getElementById(id+'-pagination'),
				fragment = document.createDocumentFragment(),
				i; 
			console.log(id+'-pagination')
			console.log(paginationEl)
			// 기존에 추가된 페이지번호를 삭제합니다
			while (paginationEl.hasChildNodes()) {
				paginationEl.removeChild (paginationEl.lastChild);
			}
			for (i=1; i<=pagination.last; i++) {
				var el = document.createElement('a');
				el.href = "#";
				el.innerHTML = i;
				if (i===pagination.current) {
					el.className = 'on';
				} else {
					el.onclick = (function(i) {
						return function() {
							pagination.gotoPage(i);
						}
					})(i);
				}
				fragment.appendChild(el);
			}
			paginationEl.appendChild(fragment);
		}
	this.placesSearchCB=(data, status, pagination,id) => {
		if (status === kakao.maps.services.Status.OK) {
			// 정상적으로 검색이 완료됐으면
			// 검색 목록과 마커를 표출합니다
			this.displayPlaces(data,id);
			// 페이지 번호를 표출합니다
			this.displayPagination(pagination);
		} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
			alert('검색 결과가 존재하지 않습니다.');
			return;
		} else if (status === kakao.maps.services.Status.ERROR) {
			alert('검색 결과 중 오류가 발생했습니다.');
			return;
		}
	}
}
KakaoMap.prototype.infowindow = new kakao.maps.InfoWindow({zIndex:1});
KakaoMap.prototype.ps=new kakao.maps.services.Places();
KakaoMap.prototype.elString= function(id,isSearch){
	var html='';
	html+='<div id="'+id+'-map" style="width:100%;height:100%"></div>';
	if(isSearch){
		html+='<div id="'+id+'-menu_wrap" class="menu_wrap bg_white">';
		html+=	'<div class="option">'
		html+=		'<div>';
		html+=			'키워드 : <input type="text" value="" class="search-text" size="15">'; 
		html+=			'<button type="button" class="btn btn-primary px-2 mb-1 search-btn" data-id="'+id+'">검색</button>';
		html+=		'</div>';
		html+=	'</div>';
		html+=	'<hr>';
		html+=	'<ul id="'+id+'-placesList" class="placesList"></ul>';
		html+=	'<div id="'+id+'-pagination" class="pagination"></div>';
		html+='</div>';
	}
	return html;
}
//검색결과 항목을 Element로 반환하는 함수입니다
KakaoMap.prototype.getListItem=function (index, places) {
	var el = document.createElement('li'),
	itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
				'<div class="info">' +
				'   <h5>' + places.place_name + '</h5>';
	if (places.road_address_name) {
		itemStr += '	<span>' + places.road_address_name + '</span>' +
					'   <span class="jibun gray">' +  places.address_name  + '</span>';
	} else {
		itemStr += '	<span>' +  places.address_name  + '</span>'; 
	}
				 
	  itemStr += '  <span class="tel">' + places.phone  + '</span>' +
				'</div>';		   
	el.innerHTML = itemStr;
	el.className = 'item';
	return el;
}

var kakaoMap={
		markers :[],
		createMap:function (id){
	 		
	 		var container = document.getElementById(id); //지도를 담을 영역의 DOM 레퍼런스
	 		var options = { //지도를 생성할 때 필요한 기본 옵션
	 			center: new kakao.maps.LatLng(37.37992393181718, 126.92881366045285), //지도의 중심좌표.
	 			level: 3 //지도의 레벨(확대, 축소 정도)
	 		};

	 		kakaoMap.map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	 		// 장소 검색 객체를 생성합니다
	 		kakaoMap.ps = new kakao.maps.services.Places();  

	 		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	 		kakaoMap.infowindow = new kakao.maps.InfoWindow({zIndex:1});
	 		//searchPlaces();
	 	},
	 // 키워드 검색을 요청하는 함수입니다
	 	searchPlaces:function (sel) {
	 		var keyword = $(sel).val();
	 		if (!keyword.replace(/^\s+|\s+$/g, '')) {
	 			alert('키워드를 입력해주세요!');
	 			return false;
	 		}

	 		// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	 	   kakaoMap.ps.keywordSearch( keyword, kakaoMap.placesSearchCB); 
	 	},

	 	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	 	placesSearchCB:function (data, status, pagination) {
	 		if (status === kakao.maps.services.Status.OK) {
	 			// 정상적으로 검색이 완료됐으면
	 			// 검색 목록과 마커를 표출합니다
	 			kakaoMap.displayPlaces(data);
	 			// 페이지 번호를 표출합니다
	 			kakaoMap.displayPagination(pagination);
	 		} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	 			alert('검색 결과가 존재하지 않습니다.');
	 			return;
	 		} else if (status === kakao.maps.services.Status.ERROR) {
	 			alert('검색 결과 중 오류가 발생했습니다.');
	 			return;
	 		}
	 	},

	 	// 검색 결과 목록과 마커를 표출하는 함수입니다
	 	displayPlaces:function (places) {
	 		var listEl = document.getElementById('placesList'), 
	 		menuEl = document.getElementById('menu_wrap'),
	 		fragment = document.createDocumentFragment(), 
	 		bounds = new kakao.maps.LatLngBounds(), 
	 		listStr = '';
	 		
	 		// 검색 결과 목록에 추가된 항목들을 제거합니다
	 	   kakaoMap.removeAllChildNods(listEl);
	 		// 지도에 표시되고 있는 마커를 제거합니다
	 	   kakaoMap.removeMarker();
	 		
	 		for ( var i=0; i<places.length; i++ ) {
	 			// 마커를 생성하고 지도에 표시합니다
	 			var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	 				marker = kakaoMap.addKeywordMarker(placePosition, i), 
	 				itemEl = kakaoMap.getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
	 			// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	 			// LatLngBounds 객체에 좌표를 추가합니다
	 			bounds.extend(placePosition);
	 			// 마커와 검색결과 항목에 mouseover 했을때
	 			// 해당 장소에 인포윈도우에 장소명을 표시합니다
	 			// mouseout 했을 때는 인포윈도우를 닫습니다
	 			(function(marker, title) {
	 				kakao.maps.event.addListener(marker, 'mouseover', function() {
	 					kakaoMap.displayInfowindow(marker, title);
	 				});
	 				kakao.maps.event.addListener(marker, 'mouseout', function() {
	 					kakaoMap.infowindow.close();
	 				});
	 				itemEl.onmouseover =  function () {
	 					kakaoMap.displayInfowindow(marker, title);
	 				};
	 				itemEl.onmouseout =  function () {
	 					kakaoMap.infowindow.close();
	 				};
	 			})(marker, places[i].place_name);

	 			fragment.appendChild(itemEl);
	 		}
	 		// 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
	 		listEl.appendChild(fragment);
	 		menuEl.scrollTop = 0;
	 		// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	 	   kakaoMap.map.setBounds(bounds);
	 	},

	 	// 검색결과 항목을 Element로 반환하는 함수입니다
	 	getListItem:function (index, places) {
	 		var el = document.createElement('li'),
	 		itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	 					'<div class="info">' +
	 					'   <h5>' + places.place_name + '</h5>';
	 		if (places.road_address_name) {
	 			itemStr += '	<span>' + places.road_address_name + '</span>' +
	 						'   <span class="jibun gray">' +  places.address_name  + '</span>';
	 		} else {
	 			itemStr += '	<span>' +  places.address_name  + '</span>'; 
	 		}
	 					 
	 		  itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	 					'</div>';		   
	 		el.innerHTML = itemStr;
	 		el.className = 'item';
	 		return el;
	 	},

	 	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	 	addKeywordMarker:function (position, idx, title) {
	 		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	 			imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	 			imgOptions =  {
	 				spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	 				spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	 				offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	 			},
	 			markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	 				marker = new kakao.maps.Marker({
	 				position: position, // 마커의 위치
	 				image: markerImage 
	 			});
	 		marker.setMap(kakaoMap.map); // 지도 위에 마커를 표출합니다
	 	   kakaoMap.markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	 		return marker;
	 	},
	 	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	 	removeMarker:function () {
	 		for ( var i = 0; i < kakaoMap.markers.length; i++ ) {
	 			kakaoMap.markers[i].setMap(null);
	 		}   
	 	   kakaoMap.markers = [];
	 	},
	 	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	 	displayPagination:function (pagination) {
	 		var paginationEl = document.getElementById('pagination'),
	 			fragment = document.createDocumentFragment(),
	 			i; 
	 		// 기존에 추가된 페이지번호를 삭제합니다
	 		while (paginationEl.hasChildNodes()) {
	 			paginationEl.removeChild (paginationEl.lastChild);
	 		}
	 		for (i=1; i<=pagination.last; i++) {
	 			var el = document.createElement('a');
	 			el.href = "#";
	 			el.innerHTML = i;
	 			if (i===pagination.current) {
	 				el.className = 'on';
	 			} else {
	 				el.onclick = (function(i) {
	 					return function() {
	 						pagination.gotoPage(i);
	 					}
	 				})(i);
	 			}
	 			fragment.appendChild(el);
	 		}
	 		paginationEl.appendChild(fragment);
	 	},

	 	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	 	// 인포윈도우에 장소명을 표시합니다
	 	displayInfowindow:function (marker, title) {
	 		var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
	 	   kakaoMap.infowindow.setContent(content);
	 	  kakaoMap.infowindow.open(kakaoMap.map, marker);
	 	},

	 	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	 	removeAllChildNods:function (el) {   
	 		while (el.hasChildNodes()) {
	 			el.removeChild (el.lastChild);
	 		}
	 	 }
	 	
	}