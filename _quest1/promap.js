/* Consts */
var GMAPS_ADDR_COMP_TYPE_LOCALITY = "locality";

function mapinit()
{
	_loca = new google.maps.LatLng( 45.5086699, -73.55399249999999); // Montreal
	var mapOptions = {
          zoom: 12,
          center: _loca,
          zoomControl: true,
		  panControl:false,
          scaleControl: true,
          streetViewControl: false,
		  mapTypeControl: false,
		  draggableCursor: 'crosshair',
          mapTypeId: google.maps.MapTypeId.ROADMAP		//HYBRID, SATELLITE, TERRAIN
    }	  
	_map = new google.maps.Map(document.getElementById('mapdiv'), mapOptions);	  
	
	_mapmark = new google.maps.Marker({ map:_map, position:_loca, draggable:true });
	_mapmark.setMap(_map);
	_mapmark.setIcon(tripiniconpath);
	_mapmark.setVisible(false);
	_infowin = new google.maps.InfoWindow( { content:"Window" } );
	google.maps.event.addListener(_infowin, 'closeclick', function(){ deselectfavs(); });
	
	google.maps.event.addListener(_map, 'click', mapclickhandler);
	google.maps.event.addListener(_mapmark, 'dragend', dragmarkerhandler);
	
	_serv = new google.maps.places.PlacesService(_map);
}

//---------------------------------------------------------------------

function onwindowsize()
{
	var vw, vh;
	_winh = $(window).height();
	_winw = $(window).width();
	//vw =  parseInt(document.getElementById('maindiv').style.width);
	//vh = parseInt(document.getElementById('maindiv').style.height);
	var num_buttons = 1;
	var iph = $("#infopanel").height();
	if ( _mode == MODE_DESSIN.Polygone ) {
		num_buttons = 4;
	}
	var ipb = $("#infopanel").position().top + iph + 15;
	var mdt = ipb+25;
	document.getElementById('mapdiv').style.top = mdt + "px" ;
	document.getElementById('mapdiv').style.height =  (_winh - mdt - 4) + "px";
	document.getElementById('mapdiv').style.width = (_winw - 4) + "px";
	document.getElementById('address').style.width = (parseInt(document.getElementById('dash').style.width) - (36*num_buttons)) + "px";
	try { _map.setCenter(_mapmark.getPosition()); } catch (er) {}	
}

function setDrawTools()
{
	var i;
	var newobj;
	var edopt;
	
	_map.setOptions({ draggableCursor: 'default' });
	_drawman = new google.maps.drawing.DrawingManager({
		drawingMode: google.maps.drawing.OverlayType.NULL,
		drawingControl: false,
		drawingControlOptions: {
		position: google.maps.ControlPosition.TOP_CENTER,
		drawingModes: [
		  //google.maps.drawing.OverlayType.MARKER,
		  //google.maps.drawing.OverlayType.CIRCLE,
		  google.maps.drawing.OverlayType.POLYGON,
		  //google.maps.drawing.OverlayType.POLYLINE,
		  //google.maps.drawing.OverlayType.RECTANGLE
		]
		},
		/*markerOptions: {
		clickable: true,
		draggable: true,
		raiseOnDrag:true,
		shadow:null
		},
		circleOptions: {
		fillColor: '#ff0000',
		fillOpacity: .5,
		strokeWeight: 1,
		clickable: true,
		draggable: true,
		editable: true
		},
		rectangleOptions: {
		fillColor: '#ff0000',
		fillOpacity: .5,
		strokeWeight: 1,
		clickable: true,
		draggable: true,
		editable: true
		},*/
		polygonOptions: {
			fillColor: '#ff0000',
			fillOpacity: .5,
			strokeWeight: 1,
			clickable: true,
			draggable: true,
			editable: true
		},
		polylineOptions: {
		strokeWeight: 4,
		clickable: true,
		draggable: true,
		editable: true
		}
		});
		
		_editon = true;
		_infowin.close();
		_mapmark.setVisible(false);
		_drawman.setMap(_map);
		drawevents();
	clickPoly();
}

function drawevents()
{
	google.maps.event.addListener(_drawman, 'overlaycomplete', polygonDrawnHandler);
}

function polygonDrawnHandler(e)
{
	if ( _drawnPolygon != null ) {
		removePolygonFromMap();
	}
	processNewPolygonOnMap(e.overlay);
}

function polygonDragged(e) 
{
	geocodeLatLng(e.overlay);
}
		
function polygonClicked(e)
{
	var ctrl, wp, op;
	if (_editon && _delobjon) {
		removePolygonFromMap();
		return; 
	}
	
	_mapmark.setVisible(false);
}

function processNewPolygonOnMap(poly)
{
	_drawnPolygon = poly;
	var polyCenter = calcPolyCenter(poly);
	geocodeLatLng(polyCenter);
	_map.setCenter(polyCenter);
	obp = { strokeWeight:1 };
	poly.setOptions(obp);
				
	google.maps.event.addListener(poly, 'dragend', polygonDragged);
	google.maps.event.addListener(poly, 'click', polygonClicked);
}



function calcPolyCenter(poly)
{
	var a = [];
	var path = poly.getPath().getArray();
	for (i = 0; i < path.length; i++){ a[i]=[path[i].lat(), path[i].lng()]; }
	var cc = polygoncentroid(a);
	var center = _loca =  new google.maps.LatLng(cc[0], cc[1]);
	return center;
}

function polygoncentroid(pts) 
{
   var twicearea = 0;
   var x = 0; 
   var y = 0;
   var nPts = pts.length;
   var p1, p2, f;
   if (nPts == 2) 
   { 
	   p1 = pts[0];
	   p2 = pts[1];
	   f = [(p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2 ];
	   return f; 
   }
   for (var i = 0, j = nPts - 1 ; i < nPts; j = i++) 
   {
      p1 = pts[i]; p2 = pts[j];
      twicearea += p1[0] * p2[1];
      twicearea -= p1[1] * p2[0];
      f = p1[0] * p2[1] - p2[0] * p1[1];
      x += (p1[0] + p2[0]) * f;
      y += (p1[1] + p2[1]) * f;
   }
   f = twicearea * 3;
   return [x / f, y / f]; 
}

function selectDrawButton(ib)
{
	if (ib != 2) { _delobjon = false; }	
	var a = ["btn_select_cursor", "btn_draw_poly", "btn_erase_poly"];
	for(var i=0; i<a.length;i++)
	{
		if(i != ib){ document.getElementById(a[i]).style.borderColor = "#a0a0a0"; }
	}
	document.getElementById(a[ib]).style.borderColor = "#ff0000";
}

//----------------------------------edit functions from here

function stopDraw()
{
	_drawman.setDrawingMode(google.maps.drawing.OverlayType.NULL);
	selectDrawButton(0);
	_map.setOptions({ draggableCursor: 'default' });
}

function clickPoly()
{
	_drawman.setDrawingMode(google.maps.drawing.OverlayType.POLYGON);
	selectDrawButton(1);
	_map.setOptions({ draggableCursor: 'crosshair' });
}

function clickEditDel() 
{
	stopDraw();
	_delobjon = true;
	selectDrawButton(2);
	_map.setOptions({ draggableCursor: 'default' });
}


//---------------------------------------------------------------------

function radialPlaceSearch()
{
	var kwds = getAddressText().split(' ');
	if(kwds.length > 0)
	{
		clearAllSearchResults();
		_serv.nearbySearch({ location:_mapmark.getPosition(), radius:_searchradius*1000, keyword:kwds }, radialSearchResponse);
	}
}

function radialSearchResponse(results, status, pagination) 
{
	if (status == google.maps.places.PlacesServiceStatus.OK) {
	document.getElementById('findspanel').style.visibility = "visible";
	makefindmarkers(results);
	var morebtn = document.getElementById('morefinds');
	}
	else {
		alert("Aucun lieu correspondant aux mots-clés n'a été trouvé. Veuillez réessayer." );
		clearAddressField();
	}
	/*
	if (pagination.hasNextPage) 
	{
		morebtn.disabled = false;
		google.maps.event.addDomListenerOnce(morebtn, 'click', function() { pagination.nextPage(); });
	}
	else
	{
		morebtn.disabled = true;
	}
	*/
}

function makefindmarkers(places) 			//search results
{
	_bnds = new google.maps.LatLngBounds();
	var placesList = document.getElementById('places');
	for (var i = 0, place; place = places[i]; i++)
	{
		var image = {url:place.icon, size:new google.maps.Size(40, 40), origin:new google.maps.Point(0, 0), anchor:new google.maps.Point(10,20), scaledSize:new google.maps.Size(20, 20)};
		var mark = new google.maps.Marker({ map:_map, icon:image, position:place.geometry.location, raiseOnDrag:false });
		_findmarkers.push(mark);
		mark.ID = _findmarkers.length - 1;
		mark.name = place.name;
		google.maps.event.addListener(mark, 'mouseover', placeHoverListener);
		google.maps.event.addListener(mark, 'mouseout', function() { _infowin.close(); });
		google.maps.event.addListener(mark, 'click', placeClickListener );
		placesList.innerHTML += "<li id='lsm" + mark.ID + "'>" + "<a style='color:#404040; width:186px;' href='javascript:selectfindmarker(" + mark.ID + ")'>" + (mark.ID+1) + ". " + place.name + "</a></li>";
		_bnds.extend(place.geometry.location);
	}
	_map.fitBounds(_bnds);
}

function placeHoverListener() {
	_lastPlaceIconClicked = this;
	_infowin.setContent(makeinfowindowcontent(this));
	_infowin.open(_map, this);	
};

function placeClickListener()
{
	_infowin.close();
	geocodePlaceMarker(this);
}

function selectfindmarker(id)
{
	var markerPos = _findmarkers[id].getPosition();
	_map.panTo(markerPos);
	console.info(_findmarkers[id]);
	google.maps.event.trigger(_findmarkers[id], 'mouseover');
}

function clearfindmarker(id) 
{
	_infowin.close();
	if(_findmarkers[id] == null){ return; }
	var l = document.getElementById('lsm'+id);
	try{ l.parentNode.removeChild(l); } catch(er){}
	try{ clearListeners(_findmarkers[id], 'click'); } catch(er){}
	try{ _findmarkers[id].setMap(null);} catch(er){ _findmarkers[id] = null; }
	try{_findmarkers[id] = null; } catch(er){}
}

function clearfindpanel()
{
	//document.getElementById('findtype').value = "";
	//document.getElementById('findkwds').value = "";
	//document.getElementById('findrads').value = "1000";
	document.getElementById('places').innerHTML = "";
	document.getElementById('findspanel').style.visibility = "hidden";
}

function clearfindall()
{
	for (var i = 0; i < _findmarkers.length; i++ )
	{
		if(_findmarkers[i] != null)
		{
			try{ clearListeners(_findmarkers[i], 'click'); } catch(er){}
			try{ _findmarkers[i].setMap(null);} catch(er){ _findmarkers[i] = null; }
			try{_findmarkers[i] = null; } catch(er){}
		}
	}
	_findmarkers = [];
}

//---------------------------------------------------------------------

function find_local_match(results, addr_comp_type, addr_comp_value)
{
	for (var i=0; i<results.length; i++) {
        for (var j=0; j<results[i].address_components.length; j++) {
            for (var k=0;k<results[i].address_components[j].types.length; k++) {
				if ( results[i].address_components[j].types[k] == addr_comp_type && results[i].address_components[j].short_name == addr_comp_value) {
					return i;
				}
            }
        }
	}
	return 0;
}

function getAddressText()
{
	return document.getElementById("address").value;
}

function updateAddressText( newText )
{
	document.getElementById("address").value = newText;
	_lastAddressText = newText;
}

function restoreAddressText()
{
	updateAddressText(_lastAddressText);
}

function geocodeAddress(addr)
{
	if ( addr.length > 0 ) {
		_geocoder.geocode( { 'address': addr }, geocoderResponseUpdateDisplayAndCenterMap );
	}
}

function geocodePlaceMarker(marker)
{
	_geocoder.geocode( { latLng:marker.getPosition()} , function(results, status) {
		var georesp = geocoderResponse(results, status);
		if ( georesp != null ) {
			updateAddressText( marker.name + ", " + georesp.addr );
		}
	});
}

function geocodeMarker(lat_lng, centerOnMarker)
{
	var respHandler;
	if (typeof(centerOnMarker)==='undefined') {
		respHandler = geocoderResponseUpdateDisplay;
	}
	else {
		respHandler = geocoderResponseUpdateDisplayAndCenterMap;
	}
	_geocoder.geocode( { latLng:lat_lng}, respHandler );
	
}

function geocodeLatLng(lat_lng)
{
	_geocoder.geocode( { latLng:lat_lng}, geocoderLatLngResponse );
}

function geocoderLatLngResponse(results, status)
{
	geoResp = geocoderResponse(results, status);
	if ( geoResp != null ) {
		_geocodedSpecial = geoResp;
	}
}
		
function geocoderResponse(results, status)
{
	if (status == google.maps.GeocoderStatus.OK)
	{
		var res_index = find_local_match(results, GMAPS_ADDR_COMP_TYPE_LOCALITY, "Montreal");
		geocodedCoords = results[res_index].geometry.location;
		_lastGeocodedAddrComps = results[res_index];
		var formatted_addr = results[res_index].formatted_address;
		return { 'coords': geocodedCoords, 'addr' : formatted_addr };
	} 
	else 
	{
		console.info("Geocoder n'a pu localiser l'adresse" );
		$.prompt(bilingualSubstitution("Impossible de localiser l'adresse fournie. Veuillez réessayer. / Unable to locate the supplied address. Please try again."));
		clearAddressField();
		return null;
	}
}

function geocoderResponseUpdateDisplay(results, status)
{
	var geoResp = geocoderResponse(results, status);
	if ( geoResp != null ) {
		setMapPin(geoResp.coords, null, true);
		updateAddressText( geoResp.addr );
		document.getElementById('radio_adresse').checked = "checked";
		_pointPlaced = true;
		return geoResp;
	}
	else if ( _lastGeocodedAddrComps != null ) {
		updateAddressText( _lastGeocodedAddrComps.formatted_address );
	}
	return null;
}

function geocoderResponseUpdateDisplayAndCenterMap(results, status)
{
	var geoResp = geocoderResponseUpdateDisplay(results, status);
	if ( geoResp != null ) {
		_map.setCenter(geoResp.coords);
	}
}

function geocoderResponseCenter(results, status)
{
	var geoResp = geocoderResponse(results, status);
	if ( geoResp != null ) {
		_map.setCenter(geoResp.coords);
	}
}

function findCurrentAddressMunicipality()
{
	var addr = getAddressText();
	if ( addr.length > 0 ) {
		_geocoder.geocode( { 'address': addr }, geocoderMunicipalityResponse );
	}
}

function geocoderMunicipalityResponse(results, status)
{
	if (status == google.maps.GeocoderStatus.OK)
	{
		var res_index = find_local_match(results, GMAPS_ADDR_COMP_TYPE_LOCALITY, "Montreal");
		_lastGeocodedAddrComps = results[res_index];
	}
}

function rechercher()
{
	if ( getAddressText().length > 0 ) {
		if (document.getElementById("radio_nom").checked) {
			radialPlaceSearch();
		}
		else {
			geocodeAddress(getAddressText());
		}
	}
}

function getLatLngFromText(text)
{
	var expected_pfx = "POINT(";
	if ( text.substring(0,expected_pfx.length) == expected_pfx ) {
		var tokens = text.substring(expected_pfx.length).split(" ");
		if (tokens.length == 2) {
			var lat = tokens[0];
			var lon = tokens[1].substring(0, tokens[1].length-1);
			return new google.maps.LatLng(parseFloat(lat),parseFloat(lon));
		}
	}
	return null;
}

function normaliserNomFrancais(s){
                        var r=s.toLowerCase();
                        r = r.replace(new RegExp("\\s", 'g'),"");
                        r = r.replace(new RegExp("[àáâãäå]", 'g'),"a");
                        r = r.replace(new RegExp("æ", 'g'),"ae");
                        r = r.replace(new RegExp("ç", 'g'),"c");
                        r = r.replace(new RegExp("[èéêë]", 'g'),"e");
                        r = r.replace(new RegExp("[ìíîï]", 'g'),"i");
                        r = r.replace(new RegExp("ñ", 'g'),"n");                            
                        r = r.replace(new RegExp("[òóôõö]", 'g'),"o");
                        r = r.replace(new RegExp("œ", 'g'),"oe");
                        r = r.replace(new RegExp("[ùúûü]", 'g'),"u");
                        r = r.replace(new RegExp("[ýÿ]", 'g'),"y");
						r = r.replace(new RegExp("st\\W", 'g'),"saint-");
						r = r.replace(new RegExp("mt\\W", 'g'),"mont-");
                        r = r.replace(new RegExp("\\W", 'g'),""); // Watch out for hyphen
                        return r;
};
	
function check_if_marker_in_rmm()
{
	console.info("Validation de l'adresse du lieu de domicile de '" + _id_participant + "' comme étant dans la région métropolitaine de Montréal."); 
	var addr_comp = _lastGeocodedAddrComps.address_components;
	var municipalities = [
    "Baie-D'Urfé",
    "Beaconsfield",
    "Beauharnois",
    "Beloeil",
    "Blainville",
    "Bois-des-Filion",
    "Boisbriand",
    "Boucherville",
    "Brossard",
    "Candiac",
    "Carignan",
    "Chambly",
    "Charlemagne",
    "Châteauguay",
    "Coteau-du-Lac",
    "Côte-Saint-Luc",
    "Delson",
    "Deux-Montagnes",
    "Dollard-Des Ormeaux",
    "Dorval",
    "Gore",
    "Hampstead",
    "Hudson",
    "Kahnawake",
    "Kanesatake",
    "Kirkland",
    "L'Assomption",
    "L'Epiphanie",
    "L'Île-Cadieux",
    "L'Île-Dorval",
    "L'Île-Perrot",
    "La Prairie",
    "Laval",
    "Lavaltrie",
    "Les Coteaux",
    "Les Cèdres",
    "Longueuil",
    "Lorraine",
    "Léry",
    "Mascouche",
    "McMasterville",
    "Mercier",
    "Mirabel",
    "Mont-Royal",
    "Mont-Saint-Hilaire",
    "Montréal",
    "Montréal-Est",
    "Montréal-Ouest",
    "Notre-Dame-de-l'Île-Perrot",
    "Oka",
    "Otterburn Park",
    "Pincourt",
    "Pointe-Calumet",
    "Pointe-Claire",
    "Pointe-des-Cascades",
    "Repentigny",
    "Richelieu",
    "Rosemère",
    "Saint-Amable",
    "Saint-Basile-le-Grand",
    "Saint-Bruno-de-Montarville",
    "Saint-Colomban",
    "Saint-Constant",
    "Saint-Eustache",
    "Saint-Isidore",
    "Saint-Joseph-du-Lac",
    "Saint-Jérôme",
    "Saint-Lambert",
    "Saint-Lazare",
    "Saint-Mathias-sur-Richelieu",
    "Saint-Mathieu",
    "Saint-Mathieu-de-Beloeil",
    "Saint-Philippe",
    "Saint-Placide",
    "Saint-Sulpice",
    "Saint-Zotique",
    "Sainte-Anne-de-Bellevue",
    "Sainte-Anne-des-Plaines",
    "Sainte-Catherine",
    "Sainte-Julie",
    "Sainte-Marthe-sur-le-Lac",
    "Sainte-Thérèse",
    "Senneville",
    "Terrasse-Vaudreuil",
    "Terrebonne",
    "Varennes",
    "Vaudreuil-Dorion",
    "Vaudreuil-sur-le-Lac",
    "Verchères",
    "Westmount"];

	var types="";
	var short_names = [];
    for (var j=0; j<addr_comp.length; j++) {
        for (var k=0;k<addr_comp[j].types.length; k++) {
			if ( addr_comp[j].types[k] == "locality" || addr_comp[j].types[k] == "political") {
				short_names.push(normaliserNomFrancais(addr_comp[j].short_name));
			}
        }
    }
	
	var found_match = false;
	var x, y;
	var matchingMunic = null;
	for (y=0; y < municipalities.length; y++) {
		var munic = normaliserNomFrancais(municipalities[y]);
		for (x=0; x < short_names.length && !found_match; x++) {
			var sn = short_names[x];
			if (munic == sn) {
				found_match = true;
				matchingMunic = municipalities[y];
				break;
			}
		}
	}

	if (found_match)
		console.info("Participant est éligible à remplir le questionnaire.\nMunicipalité du lieu de domicile : " + matchingMunic + ".");
	else
		console.info("Participant est inéligible.");

	return found_match;
}

function setMapPin(latlng, iconPath, canDrag, centerOnPin)
{
	var pin;
	if ( iconPath != null ) {
		pin = new google.maps.Marker({ map:_map, position:latlng, draggable:canDrag });
		pin.setMap(_map);
		pin.setIcon(iconPath);
		pin.title = " Holy mar";
	}
	else {
		pin = _mapmark;
		pin.setPosition(latlng);
	}
	pin.setVisible(true);
	if (!(typeof(centerOnPin)==='undefined')) {
		_map.setCenter(latlng);
	}
	return pin;
}


function retournerdanslimesurvey(dir)
{
	var nextUrl;
	if (dir == DIRECTION_QUESTIONNAIRE.Fin ) {
		nextUrl = "https://www.isis-montreal.ca/questionnaire/nonEligible.php?lang=" + _langue.val;
		console.info("Fin de questionnaire.");
	}
	else {
		nextUrl = "https://www.isis-montreal.ca/questionnaire/index.php?sid=48336&token=" + _id_participant + "&lang=" + _langue.val + "&" + dir.val + "=1";
	}
	console.info("Retour dans LimeSurvey: " + nextUrl);
	_jumpedOffPage = true;
	if ( !CONFIG.test_mode ) {
		window.location.href = nextUrl;
	}
}

function selectfav(id)
{
	var i;
	for(i=0; i<_favobjects.length; i++)
	{
		if(_favobjects[i] != null)
		{
			if(i == id)
			{
				if ( _favobjects[i].prop6 == "M" ) { _map.panTo(_favobjects[id].getPosition()); }
				google.maps.event.trigger(_favobjects[id], 'click');
				break; 
			}
		}
	}
}

function deselectfavs()
{
	var i, edopt;
	for(i=0; i<_favobjects.length; i++)
	{
		if(_favobjects[i] != null)
		{
			if (_favobjects[i].prop6 == "M")
			{
				_favobjects[i].setIcon(_favobjects[i].prop8);
			}
			else
			{
				if (_favobjects[i].prop6 != "L")
				{
					edopt = { strokeWeight:1 }; 
					_favobjects[i].setOptions(edopt);
				}
			}
		}
	}
}

function clearfavsmarker(id)
{
	var l = document.getElementById('lob'+ id);
	if(l != null && l != undefined){ l.parentNode.removeChild(l); }
	google.maps.event.clearListeners(_favobjects[id], 'click');
	_favobjects[id].setMap(null);
	_favobjects[id] = null;
	_infowin.close();
}

function removePolygonFromMap()
{
	google.maps.event.clearListeners(_drawnPolygon, 'click');
	_drawnPolygon.setMap(null);
	_drawnPolygon = null;
	_infowin.close();
	clearAddressField();
}

function clearfavsall()
{
	for (var i = 0; i < _favobjects.length; i++ )
	{
		
		if(_favobjects[i] != null && _favobjects[i] != undefined)
		{
			try{ clearListeners(_favobjects[i], 'click'); } catch(er){}
			try{ _favobjects[i].setMap(null);} catch(er){ _favobjects[i] = null; }
			try{_favobjects[i] = null; } catch(er){}
		}
	}
	_favobjects = [];
}

function makeinfowindowcontent(marker)
{
	var cn;
	cn = "<div id=\"iwdiv\" style=\"height:50px; width:120px; opacity:.9\">" +
		"<br><b>" + marker.name + "</b></div>";
	return cn;
}

function clearAllSearchResults()
{
	for(var i = 0; i < _findmarkers.length; i++)
	{ 
		clearfindmarker(i);
	}
	_findmarkers = [];
	clearfindpanel();
}

//------------------------------------------------------------------- special functions

google.maps.Polyline.prototype.inKm = function(n){ 
    var a = this.getPath(n), len = a.getLength(), dist = 0; 
    for(var i=0; i<len-1; i++){ 
      dist += a.getAt(i).kmTo(a.getAt(i+1)); 
    } 
    return dist; 
	//usage:  console.info(poly.inKm());
}
  
google.maps.LatLng.prototype.kmTo = function(a){ 
    var e = Math, ra = e.PI/180; 
    var b = this.lat() * ra, c = a.lat() * ra, d = b - c; 
    var g = this.lng() * ra - a.lng() * ra; 
    var f = 2 * e.asin(e.sqrt(e.pow(e.sin(d/2), 2) + e.cos(b) * e.cos(c) * e.pow(e.sin(g/2), 2))); 
    return f * 6378.137; 
} 



//------------------------------------------------------------------- external interface

function mapclickhandler(e) 
{ 
	geocodeMarker(e.latLng);
}

function dragmarkerhandler(e)
{
	geocodeMarker(e.latLng, true);
}

function keyUpTextField(e) {
	//var charCode = e.charCode;
	var addr = document.getElementById('address').value;
	var search_btn = document.getElementById('search_btn');
	search_btn.disabled = ( addr.length == 0 );
  
}