		function saveLocationToDB()
		{
			_httpReqSaveLoc = new XMLHttpRequest();
			_httpReqSaveLoc.onreadystatechange=locSaveResp;
			var addr_shown = document.getElementById('address').value;
			var point_wkt = "point(" + _mapmark.getPosition().lat().toFixed(_decimal_prec) + " " + _mapmark.getPosition().lng().toFixed(_decimal_prec) + ")";
			var php_url = _php_db_fname + "?up=in&id=" + _id_participant + "&q=" + _qno + "&t=" + _mode.nom + "&geo=" + encodeURI(point_wkt) + "&s=" + encodeURI(addr_shown);
			sendHTTPReq(_httpReqSaveLoc,php_url,"Enregistrement de point pour question " + _qno); 
		}
		
		function locSaveResp()
		{
			if (_httpReqSaveLoc.readyState==4 && _httpReqSaveLoc.status==200) {
				var resp = _httpReqSaveLoc.responseText;
				if ( !mysqlErrorResp( resp, 'saveLocationToDB' ) ) {
					setMapPin(_mapmark.getPosition(), 'media/star-marker.png', false, true);
					console.info("Résultat de l'enregistrement de point:\n\"" + _httpReqSaveLoc.responseText + "\"");
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
	var php_url = _php_db_fname + "?up=ip&id=" + _id_participant + "&q=" + _qno + "&t=" + _mode.nom + "&s=" + encodeURI(_geocodedSpecial.addr) + "&geo=" + encodeURI(polyStrForInsert);
	sendHTTPReq(_httpReqSavePoly,php_url,"Enregistrement de polygone"); 
}

function savePolyResp()
{
	if (_httpReqSavePoly.readyState==4 && _httpReqSavePoly.status==200) {
		var resp = _httpReqSavePoly.responseText;
		if ( !mysqlErrorResp( resp, 'savePolyToDB' ) ) {
			_drawnPolygon.setOptions({fillColor: "#009933", fillOpacity: 1});
			console.info("Résultat de l'enregistrement de polygone:\n\"" + _httpReqSavePoly.responseText + "\"");
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
	var php_url = _php_db_fname + "?up=dom&id=" + _id_participant + "&t=" + Number(isEligible) + "&geo=" + encodeURI(point_wkt) + "&s=" + encodeURI(addr_shown);
	sendHTTPReq(_httpReqSaveHome,php_url,"Enregistrement de l'adresse du lieu de domicile"); 
}

function saveHomeResp()
{
	if (_httpReqSaveHome.readyState==4 && _httpReqSaveHome.status==200) {
		var resp = _httpReqSaveHome.responseText;
		if ( !mysqlErrorResp( resp, 'saveHomeAddress' ) ) {
			console.info("Résultat de l'enregistrement de l'adresse du lieu de domicile:\n\"" + _httpReqSaveHome.responseText + "\"");
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
		console.info("Résultat de l'effacement du polygone:\n\"" + _httpReqDelPoly.responseText + "\"");
		retournerdanslimesurvey(DIRECTION_QUESTIONNAIRE.Suivant);
	}
}