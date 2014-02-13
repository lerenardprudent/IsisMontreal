function saveLocationToDB()
{
	_httpReqSaveLoc = new XMLHttpRequest();
	_httpReqSaveLoc.onreadystatechange=locSaveResp;
	var addr_shown = document.getElementById('address').value;
	var point_wkt = "point(" + _mapmark.getPosition().lat().toFixed(_decimal_prec) + " " + _mapmark.getPosition().lng().toFixed(_decimal_prec) + ")";
	var php_url = _php_db_fname + "?up=in&id=" + _id_participant + "&q=" + _qno + "&t=" + _mode.nom + "&geo=" + encodeURIComponent(point_wkt) + "&s=" + encodeURIComponent(addr_shown);
	sendHTTPReq(_httpReqSaveLoc,php_url,"Enregistrement de point pour question " + _qno); 
}
		
function locSaveResp()
{
	if (_httpReqSaveLoc.readyState==4 && _httpReqSaveLoc.status==200) {
		var resp = _httpReqSaveLoc.responseText;
		if ( !mysqlErrorResp( resp, 'saveLocationToDB' ) ) {
			setMapPin(_mapmark.getPosition(), 'media/star-marker.png', false, true);
			toConsole("Résultat de l'enregistrement de point:\n\"" + _httpReqSaveLoc.responseText + "\"");
			retournerdanslimesurvey( DIRECTION_QUESTIONNAIRE.Suivant );
		}
	}
}

function savePolyToDB()
{
	var pointList = [];
	var path = _drawnPolygon.getPath().getArray();
	for (i = 0; i < path.length; i++) {
		pointList.push( { 'lat' : path[i].lat(), 'lon' : path[i].lng() } );
	}
	_httpReqSavePoly = new XMLHttpRequest();
	_httpReqSavePoly.onreadystatechange=savePolyResp;
	var polyStrForInsert = "POLYGON((";
	for (var i = 0; i < pointList.length; i++) {
		polyStrForInsert += pointList[i].lat + " " + pointList[i].lon + ", ";
	}
	polyStrForInsert += pointList[0].lat + " " + pointList[0].lon + "))"; // Repeat the first point to make a closed polygon
	var php_url = _php_db_fname + "?up=ip&id=" + _id_participant + "&q=" + _qno + "&t=" + _mode.nom + "&s=" + encodeURIComponent(_geocodedSpecial.addr) + "&geo=" + encodeURIComponent(polyStrForInsert);
	sendHTTPReq(_httpReqSavePoly,php_url,"Enregistrement de polygone"); 
}

function savePolyResp()
{
	if (_httpReqSavePoly.readyState==4 && _httpReqSavePoly.status==200) {
		var resp = _httpReqSavePoly.responseText;
		if ( !mysqlErrorResp( resp, 'savePolyToDB' ) ) {
			_drawnPolygon.setOptions({fillColor: "#009933", fillOpacity: 1});
			toConsole("Résultat de l'enregistrement de polygone:\n\"" + _httpReqSavePoly.responseText + "\"");
			retournerdanslimesurvey( DIRECTION_QUESTIONNAIRE.Suivant );
		}
	}
}

function saveHomeAddress(marker, isEligible)
{
	_httpReqSaveHome = new XMLHttpRequest();
	_httpReqSaveHome.onreadystatechange=saveHomeResp;
	var addr_shown = document.getElementById('address').value;
	var point_wkt = "point(" + marker.getPosition().lat().toFixed(_decimal_prec) + " " + marker.getPosition().lng().toFixed(_decimal_prec) + ")";
	var php_url = _php_db_fname + "?up=dom&id=" + _id_participant + "&t=" + Number(isEligible) + "&geo=" + encodeURIComponent(point_wkt) + "&s=" + encodeURIComponent(addr_shown);
	sendHTTPReq(_httpReqSaveHome,php_url,"Enregistrement de l'adresse du lieu de domicile"); 
}

function saveHomeResp()
{
	if (_httpReqSaveHome.readyState==4 && _httpReqSaveHome.status==200) {
		var resp = _httpReqSaveHome.responseText;
		if ( !mysqlErrorResp( resp, 'saveHomeAddress' ) ) {
			toConsole("Résultat de l'enregistrement de l'adresse du lieu de domicile:\n\"" + _httpReqSaveHome.responseText + "\"");
			if ( resp.indexOf( "__PARTICIPANT_EST_INELIGIBLE__" ) >= 0 ) {
				retournerdanslimesurvey(DIRECTION_QUESTIONNAIRE.Fin);
			}
			else {
				setMapPin(_mapmark.getPosition(), 'media/home2.png', false, true);
				retournerdanslimesurvey( DIRECTION_QUESTIONNAIRE.Suivant );
			}
		}
	}
}

function sendDelPolyToDB()
{
	_httpReqDelPoly = new XMLHttpRequest();
	_httpReqDelPoly.onreadystatechange=delPolyResp;
	var php_url = _php_db_fname + "?up=dp&id=" + _id_participant + "&q=" + _qno;
	sendHTTPReq(_httpReqDelPoly,php_url,"Effacement du polygone"); 
}

function delPolyResp()
{
	if (_httpReqDelPoly.readyState==4 && _httpReqDelPoly.status==200) {
		toConsole("Résultat de l'effacement du polygone:\n\"" + _httpReqDelPoly.responseText + "\"");
		retournerdanslimesurvey(DIRECTION_QUESTIONNAIRE.Suivant);
	}
}

function puthomepin()
{
	_httpReqHomeLookup = new XMLHttpRequest();
	_httpReqHomeLookup.onreadystatechange=homeAddressLookupResp;
	var php_url = _php_db_fname + "?up=hl&id=" + _id_participant;
	sendHTTPReq(_httpReqHomeLookup, php_url, "Recherche d'adresse de lieu de domicile");
}

function homeAddressLookupResp()
{
	var ok = false;
	if (_httpReqHomeLookup.readyState==4 && _httpReqHomeLookup.status==200) {
		var resp = _httpReqHomeLookup.responseText;
		toConsole("Résultats de la recherche d'adresse de lieu de domicile:\n\"" + resp + "\"");
		var tokens = resp.split("$");
		if (tokens.length == 3) {
			var point_resp = tokens[0];
			var home_addr_text = tokens[1];
			var isEligible = tokens[2];
			var homepos = getLatLngFromText(point_resp);
			if (homepos != null) {
				_lookupPerformed = true;
				if ( isEligible == '0' && _mode != MODE_DESSIN.DomicileVerification ) { // Pas éligible de remplir les autres questions!
				// TODO: Ineligible handling
				}
				else {
					ok = true;
				}
				if ( _mode == MODE_DESSIN.DomicileVerification ) {
					setMapPin(homepos, null, true, true);
					updateAddressText(home_addr_text);
					findCurrentAddressMunicipality();
				}
				else {
					_mapmark.setPosition(homepos);
					homepin = setMapPin(homepos, 'media/home2.png', false, true, bilingualSubstitution("Adresse du lieu de domicile:\n / Home address:\n") + home_addr_text);
					//_domicileInfoWindow.setContent("<div id=\"iwdiv\" style=\"text-align:center; height:80px; width:300px; opacity:.9\"><b>" + bilingualSubstitution("Lieu de domicile / Home") + "</b><br><br><em>" + home_addr_text + "</em></div>");
					//_domicileInfoWindow.setPosition(homepos);
					//google.maps.event.addListener(homepin, 'mouseover', function() { _domicileInfoWindow.open(_map); });
					//google.maps.event.addListener(homepin, 'mouseout', function() { _domicileInfoWindow.close(); });
				}
			}
		}
		if (!ok) {
			retournerdanslimesurvey(DIRECTION_QUESTIONNAIRE.Fin);
		}
	}
}

function init_map_pin_if_question_already_answered(quest_no)
{
	_httpReqRespLookup =new XMLHttpRequest();
	_httpReqRespLookup.onreadystatechange=existingRespHandler;
	var php_url = _php_db_fname + "?up=rl&id=" + _id_participant + "&q=" + quest_no;
	sendHTTPReq(_httpReqRespLookup,php_url,"Recherche de réponse préexistante à la question " + quest_no); 
}

function existingRespHandler()
{
	var ok = false;
	if (_httpReqRespLookup.readyState==4 && _httpReqRespLookup.status==200) {
		var resp = _httpReqRespLookup.responseText;
		if (resp.length > 0) {
			toConsole("Résultat de la recherche de réponse préexistante à la question " + _qno + ":\n\""
			+ resp + "\"");
			_existingRecInDB = true;
		}
		else
		{
			toConsole("Aucune réponse préexistante trouvée à la question " + _qno + ".");
		}
		
		var tokens = resp.split("$");
		if (tokens.length == 3) {
			var point_resp = tokens[0];
			if (point_resp.length > 0) {
				var loc_addr_text = tokens[2];
				var locpos = getLatLngFromText(point_resp);
				if (locpos != null) {
					setMapPin(locpos, null, true, true);
					updateAddressText(loc_addr_text);
					_pointPlaced = true;
					findCurrentAddressMunicipality();
					_map.setOptions({ zoom: _closeUpZoomLevel });
					ok = true;
				}
			}
			else {
				polygon_resp = tokens[1];
				if ( polygon_resp.length > 0 ) {
					var expected_pfx = "POLYGON((";
					var expected_sfx = "))";
					if ( polygon_resp.substring(0, expected_pfx.length) == expected_pfx &&
						 polygon_resp.substring(polygon_resp.length-expected_sfx.length) == expected_sfx ) {
						var pointliststr = polygon_resp.substring(expected_pfx.length,
																 polygon_resp.length-expected_sfx.length);
						var pointList = pointliststr.split(",");
						var latLngList = [];
						var polyBounds = new google.maps.LatLngBounds ();
						for (var i=0; i < pointList.length; i++) {
							var latAndLng = pointList[i].split(" ");
							var newPoint = new google.maps.LatLng(latAndLng[0], latAndLng[1]);
							polyBounds.extend(newPoint);
							latLngList.push(newPoint);
						}
						savedZone = new google.maps.Polygon({
							paths:latLngList,
							fillColor: '#ff0000',
							fillOpacity: .5,
							strokeWeight: 1,
							clickable: true,
							draggable: true,
							editable: true });
						savedZone.setMap(_map);
						processNewPolygonOnMap(savedZone);
						google.maps.event.trigger(_map, 'resize');
						_map.fitBounds(polyBounds);
						_map.panToBounds(polyBounds);
						stopDraw();
					}
				}
			}
		}
	}
}

function validerAdresse(lat_lng)
{
	_httpReqValiderAddr = new XMLHttpRequest();
	_httpReqValiderAddr.onreadystatechange=validerAddrRespHandler;
  var arrConf = get_config('arronds_spatials');
	var php_url = _php_db_fname + "?up=" + [arrConf.cle, arrConf.latitude + '=' + lat_lng.lat(), arrConf.longitude + '=' + lat_lng.lng()].join('&');
	sendHTTPReq(_httpReqValiderAddr, php_url, "Validation d'adresse du lieu de domicile"); 
}

function validerAddrRespHandler()
{
	var ok = false;
	if (_httpReqValiderAddr.readyState==4 && _httpReqValiderAddr.status==200) {
		var resp = _httpReqValiderAddr.responseText;
    var ineligibleFlag = get_config('arronds_spatials', {ineligible: "HORS_RMR"}).ineligible; 
    var inRMR = resp.indexOf(ineligibleFlag) < 0;
    if ( inRMR ) {
			toConsole("Lieu de domicile validé comme dans la RMR (municipalité: " + resp + ").");
		}
		else {
			toConsole("Lieu de domicile hors de la région.");
		}
    saveHomeAddress(_mapmark, inRMR);
	}
}

function sendHTTPReq(req, url, debug)
{
	toConsole(debug + ".\nURL: \"" + url + "\"");
	req.open("get",url,false);
	req.send();
}