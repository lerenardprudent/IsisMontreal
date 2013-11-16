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
          mapTypeId: google.maps.MapTypeId.ROADMAP		//HYBRID, SATELLITE, TERRAIN
    }	  
	_map = new google.maps.Map(document.getElementById('mapdiv'), mapOptions);	  
	
	_mapmark = new google.maps.Marker({ map:_map, position:_loca, draggable:true });
	_mapmark.setMap(_map);
	_mapmark.setIcon(tripiniconpath);
	_mapmark.setVisible(false);
	
	_infowin = new google.maps.InfoWindow( { content:"Window" } );
	google.maps.event.addListener(_infowin, 'closeclick', function(){ deselectfavs(); });
	
	_strviewser = new google.maps.StreetViewService();
	_strviewpano = new google.maps.StreetViewPanorama(document.getElementById('strviewdiv'));
	
	google.maps.event.addListener(_map, 'click', mapclickhandler);
	google.maps.event.addListener(_mapmark, 'dragend', dragmarkerhandler);
	google.maps.event.addListener(_strviewpano, 'position_changed', strvwposchangehandler);
	
	fillmapdata(_mapdata);
//	updateobjaddr("");
	
	try { onwindowsize(); } catch (er) { }	
}


function fillmapdata(mda)
{
	var i, j, md, poz, cc, co, bn, vi, obj;
	var pa = [];
	console.log("fill map")
	if (mda == null || mda == "") { return; }	
	_favobjects = [];
	md = mda.split("◘");
	
	for (i = 0; i < md.length; i++)
	{
		obj = null;
		md[i] = md[i].split("•");
		switch(md[i][6])
		{
			case "M":
				cc = md[i][7].split(",");
				poz = new google.maps.LatLng(parseFloat(cc[0]), parseFloat(cc[1]));
				obj = new google.maps.Marker( { position:poz, title:md[i][15], icon:md[i][8], draggable:false } );
				break;
			case "C":
				co = md[i][7].split(";");
				ra = parseFloat(co[1]);
				co = co[0].split(","); 
				co = new google.maps.LatLng(parseFloat(co[0]), parseFloat(co[1]));
				obj = new google.maps.Circle({ center:co, radius:ra, strokeColor:"#000000", strokeWeight:1, fillColor:"#ff0000", fillOpacity:0.5 });
				break;
			case "R":
				co = md[i][7].split(";");
				co[1] = co[1].split(","); 
				co[1] = new google.maps.LatLng(parseFloat(co[1][0]), parseFloat(co[1][1]));
				co[2] = co[2].split(",");
				co[2] = new google.maps.LatLng(parseFloat(co[2][0]), parseFloat(co[2][1]));
				bn = new google.maps.LatLngBounds(co[2], co[1]);
				obj = new google.maps.Rectangle({ bounds:bn, strokeColor:"#000000", strokeWeight:1, fillColor:"#ff0000", fillOpacity:0.5 });
				break;
			case "P":
				co = md[i][7].split(";");
				pa = [];
				for (j = 1; j < co.length; j++)
				{
					co[j] = co[j].split(","); 
					pa[j-1] = new google.maps.LatLng( parseFloat(co[j][0]), parseFloat(co[j][1]) );
				}	
				obj = new google.maps.Polygon( { paths:pa, strokeColor:'#000000', strokeOpacity:1.0, strokeWeight:4, fillColor:"#ff0000", fillOpacity:0.5 } );
				break;
			case "L":
				console.log(md[i][7])
				co = md[i][7].split(";");
				pa = [];
				for (j = 1; j < co.length; j++)
				{
					co[j] = co[j].split(","); 
					pa[j-1] = new google.maps.LatLng( parseFloat(co[j][0]), parseFloat(co[j][1]) );
				}
				obj = new google.maps.Polyline( { path:pa, strokeColor:'#000000', strokeOpacity:1.0, strokeWeight:4 } );
				break;
			default:
				break;
		}

		obj.setMap(_map);
		
		obj.prop0 = 1;
		obj.prop1 = md[i][1];
		obj.prop2 = md[i][2];
		obj.prop3 = md[i][3];
		obj.prop4 = md[i][4];
		obj.prop5 = md[i][5];
		obj.prop6 = md[i][6];
		obj.prop7 = md[i][7];
		obj.prop8 = md[i][8];
		obj.prop9 = md[i][9];
		obj.prop10 = md[i][10];
		obj.prop11 = md[i][11];
		obj.prop12 = md[i][12];
		obj.prop13 = md[i][13];
		obj.prop14 = md[i][14];
		obj.prop15 = md[i][15];
		obj.prop16 = md[i][16];
		obj.prop17 = md[i][17];
		obj.prop18 = md[i][18];
		obj.prop19 = md[i][19];
		obj.prop20 = md[i][20];
		obj.prop21 = md[i][21];
		obj.prop22 = md[i][22];
		obj.prop23 = md[i][23];
		obj.prop24 = md[i][24];
		obj.prop25 = md[i][25];
		obj.prop26 = md[i][26];
		obj.prop27 = md[i][27];
		obj.prop28 = md[i][28];
		obj.prop29 = md[i][29];
		obj.prop30 = md[i][30];
		obj.prop31 = md[i][31];
		obj.prop32 = md[i][32];
		obj.prop33 = md[i][33];
		obj.prop34 = md[i][34];
		obj.prop35 = md[i][35];
		obj.prop36 = md[i][36];
		obj.prop37 = md[i][37];
		obj.prop38 = md[i][38];
		obj.prop39 = md[i][39];
		obj.prop40 = md[i][40];
		obj.prop41 = md[i][41];
		obj.prop42 = md[i][42];
		obj.prop43 = md[i][43];
		obj.prop44 = md[i][44];
		obj.prop45 = md[i][45];
		obj.prop46 = md[i][46];
		obj.prop47 = md[i][47];
		obj.prop48 = md[i][48];
		obj.prop49 = md[i][49];
		
		obj.setVisible(obj.prop2 == _currpg);
		_favobjects[md[i][1]] = obj;
		//setobjcenter(_favobjects.length - 1);
		setobjcenter(obj);
		
		google.maps.event.addListener(obj, 'dragend', function(e) 
		{
			setobjcenter(this);
			//if (this.prop6 == "M") { _mapmark.setVisible(false); } else { _mapmark.setVisible(true); }
			if (_strviewon) { _strviewser.getPanoramaByLocation(_loca, 30, showstrview); }	
		});
		
		google.maps.event.addListener(obj, 'click', function(e) 
		{
			var ctrl, wp, op;
			if (_editon && _delobjon) { clearfavsmarker(this.prop1); return; }
			deselectfavs();
			setobjcenter(this);
			_infowin.setContent(makeinfowindowcontent(this, "ciw", 0));
			_mapmark.setVisible(false);
			if (this.prop6 != "M")
			{
				// _mapmark.setVisible(true);
				_infowin.setPosition(_loca);
				op = { strokeWeight:4 };
				this.setOptions(op);
				if (!_editon) { _infowin.open(_map); }	
			}
			else
			{
				this.setIcon(this.prop8.substr(0, 13) + "sta.png");
				if (!_editon) { _infowin.open(_map, this); }
			}
			if (_strviewon) { _strviewser.getPanoramaByLocation(_loca, 30, showstrview); }			
		});
	}
	
	/*
	for (i = 0; i < _favobjects.length; i++)
	{
		if (_favobjects[i] != null && _favobjects[i] != undefined) { _favobjects[i].setMap(_map); }	
	}
	*/
}


//---------------------------------------------------------------------

function onwindowsize()
{
	var vw, vh;
	_winh = $(window).height();
	_winw = $(window).width();
	document.getElementById('maindiv').style.width = _winw + "px";
	document.getElementById('maindiv').style.height = (_winh - 150) + "px";
	vw =  parseInt(document.getElementById('maindiv').style.width);
	vh = parseInt(document.getElementById('maindiv').style.height);
	document.getElementById('mapdiv').style.width = vw + "px"; 
	document.getElementById('mapdiv').style.height = (vh - 2) + "px";
	document.getElementById('infopanel').style.width = (vw - 6) + "px";
	document.getElementById('strviewdiv').style.left = (Math.round( vw * .6) + 10) + "px"; 
	document.getElementById('strviewdiv').style.width = Math.round( vw * .4) + "px"; 
	document.getElementById('strviewdiv').style.height = document.getElementById('mapdiv').style.height; 
	//document.getElementById('btn9').style.left = (vw - 40) + "px";
	document.getElementById('btn10').style.left = (vw - 20) + "px";
	try { _map.setCenter(_loca); } catch (er) {}	
}



function setdrawtools()
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
		  google.maps.drawing.OverlayType.MARKER,
		  google.maps.drawing.OverlayType.CIRCLE,
		  google.maps.drawing.OverlayType.POLYGON,
		  google.maps.drawing.OverlayType.POLYLINE,
		  google.maps.drawing.OverlayType.RECTANGLE
		]
		},
		markerOptions: {
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
		},
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
}

function drawevents()
{
	var newobj, obtype, pozz, obp;
	google.maps.event.addListener(_drawman, 'overlaycomplete', function(e) 
	{
		newobj = e.overlay;
		obtype = e.type;
		//newobj.prop1 = _favobjects.length;
		newobj.prop2 = _currpg;
		newobj.prop13 = setplacecat();			// "Custom";
		newobj.prop15 = setplacename();			// "Custom place " + _favobjects.length;
		newobj.title = newobj.prop15;
		if (obtype == google.maps.drawing.OverlayType.MARKER) 
		{
			newobj.prop6 = "M";
			newobj.prop11 = 0;
			newobj.prop12 = 1;
			newobj.prop8 = "media/mk-red-dot.png"; 		//'http://maps.google.com/mapfiles/ms/icons/red-dot.png'
		}
		else if (obtype == google.maps.drawing.OverlayType.CIRCLE)
		{
			newobj.prop6 = "C";
			newobj.prop11 = 1;
			newobj.prop12 = .5;
			newobj.prop8 = "media/mk-trans.png"; 		//'http://maps.google.com/mapfiles/ms/icons/red-dot.png'
		}
		else if (obtype == google.maps.drawing.OverlayType.RECTANGLE)
		{
			newobj.prop6 = "R";
			newobj.prop11 = 1;
			newobj.prop12 = .5;
			newobj.prop8 = "media/mk-trans.png"; 		//'http://maps.google.com/mapfiles/ms/icons/red-dot.png'
		}
		else if (obtype == google.maps.drawing.OverlayType.POLYGON)
		{
			newobj.prop6 = "P";
			newobj.prop11 = 1;
			newobj.prop12 = .5;
			newobj.prop8 = "media/mk-trans.png"; 		//'http://maps.google.com/mapfiles/ms/icons/red-dot.png'
		}
		else if (obtype == google.maps.drawing.OverlayType.POLYLINE)
		{
			newobj.prop6 = "L";
			newobj.prop11 = 4;
			newobj.prop12 = .5;
			newobj.prop8 = "media/mk-trans.png"; 		//'http://maps.google.com/mapfiles/ms/icons/red-dot.png'
		}

		newobj.prop0 = true;
		//newobj.prop1 = -1;
		//newobj.prop2 = _currpg;
		newobj.prop3 = "";
		newobj.prop4 = "INP_414,INP_415";
		newobj.prop5 = "16,17";
		//newobj.prop6 = "M";
		//newobj.prop7 = co[0] + "," + co[1];
		//newobj.prop8 = iconfile;
		newobj.prop9 = "#ff0000";
		newobj.prop10 = "#000000";
		//newobj.prop11 = 0;
		//newobj.prop12 = 1;
		//newobj.prop13 = setplacecat();			// "Custom";
		newobj.prop14 = "";
		//newobj.prop15 = setplacename();			// "Custom place " + _favobjects.length;
		//newobj.prop16 = document.getElementById('ciw3').value;
		newobj.prop17 = "";
		//newobj.prop18 = co[0] + " " + co[1];
		newobj.prop19 =  0;
		newobj.prop20 =  "";
		newobj.prop21 = "";
		newobj.prop22 = "";
		newobj.prop23 = "";
		newobj.prop24 = "";
		newobj.prop25 = 1;
		newobj.prop26 = -1;
		newobj.prop27 = 0;
		newobj.prop28 = 0;
		newobj.prop29 = 0;
		newobj.prop30 = "";
		newobj.prop31 = "";
		newobj.prop32 = "";
		newobj.prop33 = "";
		newobj.prop34 = "";
		newobj.prop35 = "";
		newobj.prop36 = "";
		newobj.prop37 = "";
		newobj.prop38 = "";
		newobj.prop39 = "";
		newobj.prop40 = "";
		newobj.prop41 = "";
		newobj.prop42 = "";
		newobj.prop43 = "";
		newobj.prop44 = "";
		newobj.prop45 = "";
		newobj.prop46 = "";
		newobj.prop47 = "";
		newobj.prop48 = "";
		newobj.prop49 = "";
		

		newobj.prop1 = _favobjects.length;
		_favobjects[_favobjects.length] = newobj;
		if (newobj.prop6 == "M")
		{
			newobj.setIcon(newobj.prop8);
		}
		else 
		{
			obp = { strokeWeight:newobj.prop11 };
			newobj.setOptions(obp);
		}
		setobjcenter(newobj);
		
		google.maps.event.addListener(newobj, 'dragend', function(e) 
		{
			setobjcenter(this);
			//if (this.prop6 == "M") { _mapmark.setVisible(false); } else { _mapmark.setVisible(true); }
			if (_strviewon) { _strviewser.getPanoramaByLocation(_loca, 30, showstrview); }	
		});
		
		google.maps.event.addListener(newobj, 'click', function(e) 
		{
			var ctrl, wp, op;
			if (_editon && _delobjon) { clearfavsmarker(this.prop1); return; }
			deselectfavs();
			setobjcenter(this);
			_infowin.setContent(makeinfowindowcontent(this, "ciw", 0));
			_mapmark.setVisible(false);
			if (this.prop6 != "M")
			{
				// _mapmark.setVisible(true);
				_infowin.setPosition(_loca);
				op = { strokeWeight:4 };
				this.setOptions(op);
				if (!_editon) { _infowin.open(_map); }	
			}
			else
			{
				this.setIcon(this.prop8.substr(0, 13) + "sta.png");
				if (!_editon) { _infowin.open(_map, this); }
			}
			if (_strviewon) { _strviewser.getPanoramaByLocation(_loca, 30, showstrview); }			
		});
	});
}

function setobjcenter(ob)
{
	var i, n;
	var a = [];
	var pts;
	var bnd;
	var path;
	var pos;
	var typ = ob.prop6;
	if (typ == "M")
	{
		_loca = ob.getPosition();
		geocodepos(ob, _loca);
	}
	else if (typ == "C")
	{
		_loca = ob.getCenter();
		geocodepos(ob, _loca);
	}
	else if (typ == "R")
	{
		bnd = ob.getBounds();
		_loca = bnd.getCenter();
		geocodepos(ob, _loca);
	}
	else if (typ == "P")
	{
		path = ob.getPath().getArray();
		for (i = 0; i < path.length; i++){ a[i]=[path[i].lat(), path[i].lng()]; }
		var cc = polygoncentroid(a);
		_loca =  new google.maps.LatLng(cc[0], cc[1]);
		geocodepos(ob, _loca);
	}
	else if (typ == "L")
	{
		path = ob.getPath().getArray();
		for (i = 0; i < path.length; i++){ a[i]=[path[i].lat(), path[i].lng()]; }
		var cc = polygoncentroid(a);
		_loca =  new google.maps.LatLng(cc[0], cc[1]);
		geocodepos(ob, _loca);
	}
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

function showstrview(data, status) 
{
	if (_strviewon)
	{
		if (status == google.maps.StreetViewStatus.OK) 
		{
			_strviewpano.setPano(data.location.pano);			// set the Pano to use the passed panoID
			/*
			_strviewpano.setPov({
				heading: 0,
				pitch: 0
			});
			*/
			_strviewpano.setVisible(true);
			document.getElementById('strviewdiv').style.visibility = "visible";
			
		} 
		else 
		{
			updateobjaddr("Street View data not found here.", "#dd0000");
		}
	}
	else
	{
		_strviewpano.setVisible(false);
		document.getElementById('strviewdiv').style.visibility = "hidden";
	}
}

function togglestreetview()
{
	//var strviewbtn = document.getElementById('btn3');
	var strviewdiv = document.getElementById('strviewdiv')
	if (!_strviewon)
	{
		_strviewon = true;
		strviewbtn.value = "D";
		//strviewbtn.style.color = "#dd0000";
		//strviewbtn.style.borderColor = "#dd0000";
		_strviewpano.setVisible(true);
		strviewdiv.style.visibility = "visible";
		geocodestrview(document.getElementById("address").value);
	}
	else
	{
		_strviewon = false;
		strviewbtn.value = "U";
		//strviewbtn.style.color = "#404040";
		//strviewbtn.style.borderColor = "#a0a0a0";
		_strviewpano.setVisible(false);
		strviewdiv.style.visibility = "hidden";
	}
}

function geocodepos(ob, pos) 
{
	var b, p, p1, p2;
	ob.prop7 = pos.lat().toFixed(5) + "," + pos.lng().toFixed(5);
	if (ob.prop6 == "C")
	{
		ob.prop7 += ";" + ob.getRadius().toFixed(5);
	}
	else if (ob.prop6 == "R")
	{
		b = ob.getBounds();
		p1 = b.getNorthEast();
		p2 = b.getSouthWest();
		p1 = p1.lat().toFixed(5) + "," + p1.lng().toFixed(5);
		p2 = p2.lat().toFixed(5) + "," + p2.lng().toFixed(5);
		ob.prop7 += ";" + p1 + ";" + p2;
	}
	else if (ob.prop6 == "P" || ob.prop6 == "L")
	{
		b = ob.getPath().getArray();
		for (i = 0; i < b.length; i++)
		{ 
			ob.prop7 += ";" + b[i].lat().toFixed(5) + "," + b[i].lng().toFixed(5);
		}
	}
	ob.prop18 = pos.lat().toFixed(5) + " " + pos.lng().toFixed(5);
	_geocoder.geocode( { latLng:pos }, function(responses)
	{ 
		if (responses && responses.length > 0)
		{ 
			_addr = responses[0].formatted_address;
			ob.prop16 = _addr;
			//_bnds = responses[0].LatLngBounds().extend(pos);
		}
		else
		{ 
			_addr = ""; 
			ob.prop16 = _addr;
		}
		updateobjaddr(_addr);
	});
}

function geocodestrview(adr)
{
	updateaddress(adr, false);
}

function selecteditsubbtn(ib)
{
	if (ib != 2) { _delobjon = false; }	
	var a = ["btn11", /*"btn12", "btn13", "btn14",*/ "btn15", /*"btn16",*/ "btn17"];
	for(var i=0; i<a.length;i++)
	{
		if(i != ib){ document.getElementById(a[i]).style.borderColor = "#a0a0a0"; }
	}
	document.getElementById(a[ib]).style.borderColor = "#ff0000";
}

function updateobjaddr(str, clr) 
{
	var fld = document.getElementById("address");
	fld.value = str;
	if (typeof(clr) === 'undefined' || clr == null || str == "")
	{
		fld.style.color = "#404040";
	}
	else
	{
		fld.style.color = clr;
	}
	if (str == "")
	{
		fld.title = "Saisissez une adresse dans ce champ de texte";
	}
	else
	{
		fld.title = "Adresse actuellement indiquée par l'icône sur la carte";
	}
}

function disableproximitysearch()
{
	document.getElementById('radio_nom').disabled = true;
	document.getElementById('radio_adresse').checked = "checked";
	document.getElementById('search_prox_label').style.color = "LightGrey";
	
}

function enableproximitysearch()
{
	document.getElementById('radio_nom').disabled = false;
	document.getElementById('radio_adresse').checked = "checked";
	document.getElementById('search_prox_label').style.color = "#404040";
	
}

//----------------------------------edit functions from here

function stopDraw()
{
	_drawman.setDrawingMode(google.maps.drawing.OverlayType.NULL);
	selecteditsubbtn(0);
	_map.setOptions({ draggableCursor: 'default' });
}
/*
function clickMarker()
{
	_drawman.setDrawingMode(google.maps.drawing.OverlayType.MARKER);
	selecteditsubbtn(1);
	_map.setOptions({ draggableCursor: 'default' });
}

function clickCirc()
{
	_drawman.setDrawingMode(google.maps.drawing.OverlayType.CIRCLE);
	selecteditsubbtn(2);
	_map.setOptions({ draggableCursor: 'default' });
}

function clickRect()
{
	_drawman.setDrawingMode(google.maps.drawing.OverlayType.RECTANGLE);
	selecteditsubbtn(3);
	_map.setOptions({ draggableCursor: 'default' });
}
*/

function clickPoly()
{
	_drawman.setDrawingMode(google.maps.drawing.OverlayType.POLYGON);
	selecteditsubbtn(1);
	_map.setOptions({ draggableCursor: 'default' });
}

function clickLine()
{
	_drawman.setDrawingMode(google.maps.drawing.OverlayType.POLYLINE);
	selecteditsubbtn(5);
	_map.setOptions({ draggableCursor: 'default' });
}

function clickEditDel() 
{
	stopDraw();
	_delobjon = true;
	selecteditsubbtn(2);
	_map.setOptions({ draggableCursor: 'crosshair' });
}


//---------------------------------------------------------------------

function trouvercommerce()
{
	var request;
	clearfindall();
	clearfindpanel();
	//document.getElementById('places').innerHTML = "";
	document.getElementById('findspanel').style.visibility = "hidden";
	document.getElementById('favspanel').style.visibility = "hidden";
	
	var gclat = _map.getCenter().lat();
	var gclng = _map.getCenter().lng();
	var lc = new google.maps.LatLng(gclat, gclng);
	
	var lc = _mapmark.getPosition();
	//var typ = document.getElementById('findtype').value;
	//var rads =  parseInt(document.getElementById('findrads').value);
	var kwds = document.getElementById('address').value.split(' ');
	if(kwds.length > 0)
	{
		request = { location:lc, radius:_searchradius, keyword:kwds };
		_serv = new google.maps.places.PlacesService(_map);
		_serv.nearbySearch(request, callback);
	}
	else {
		alert('Aucun mot-clé n\'a été entré');
	}
}


function findplace()
{
	var request;
	clearfindall();
	document.getElementById('places').innerHTML = "";
	document.getElementById('findspanel').style.visibility = "hidden";
	document.getElementById('favspanel').style.visibility = "hidden";
	
	//var gclat = _map.getCenter().lat();
	//var gclng = _map.getCenter().lng();
	//var lc = new google.maps.LatLng(gclat, gclng);
	
	var lc = _mapmark.getPosition();
	var typ = document.getElementById('findtype').value;
	var rads =  parseInt(document.getElementById('findrads').value);
	var kwd = document.getElementById('findkwds').value;		//keyword array
	if(typ != "")
	{
		if(kwd != "")
		{
			request = { location:lc, radius:rads, types:[typ], keyword:[kwd] };
		}
		else
		{
			request = { location:lc, radius:rads, types:[typ] };
		}
	}
	else
	{
		if(kwd != "")
		{
			request = { location:lc, radius:rads, keyword:[kwd] };
		}
	}
	_serv = new google.maps.places.PlacesService(_map);
	_serv.nearbySearch(request, callback);
}

function callback(results, status, pagination) 
{
	if (status != google.maps.places.PlacesServiceStatus.OK) { return; }
	document.getElementById('findspanel').style.visibility = "visible";
	document.getElementById('favspanel').style.visibility = "hidden";
	makefindmarkers(results);
	var morebtn = document.getElementById('morefinds');
	if (pagination.hasNextPage) 
	{
		morebtn.disabled = false;
		google.maps.event.addDomListenerOnce(morebtn, 'click', function() { pagination.nextPage(); });
	}
	else
	{
		morebtn.disabled = true;
	}
}

function makefindmarkers(places) 			//search results
{
	_bnds = new google.maps.LatLngBounds();
	var placesList = document.getElementById('places');
	for (var i = 0, place; place = places[i]; i++)
	{
		//place = places[i];
		//place.formatted_address, place.name, place.formatted_phone_number, place.website, place.website;
		var image = {url:place.icon, size:new google.maps.Size(40, 40), origin:new google.maps.Point(0, 0), anchor:new google.maps.Point(10,20), scaledSize:new google.maps.Size(20, 20)};
		var mark = new google.maps.Marker({ map:_map, icon:image, title:place.name, position:place.geometry.location, raiseOnDrag:false });
		_findmarkers.push(mark);
		mark.ID = _findmarkers.length - 1;
		google.maps.event.addListener(mark, 'click', function(e) {
			_mapmark.setVisible(false);
			findmarkersinfowin(this, this.getPosition());
		});
		placesList.innerHTML += "<li id='lsm" + mark.ID + "'>" + "<a style='color:#404040; width:186px;' href='javascript:selectfindmarker(" + mark.ID + ")'>" + (mark.ID+1) + ". " + place.name + "</a></li>";
		_bnds.extend(place.geometry.location);
	}
	_map.fitBounds(_bnds);
}

function findmarkersinfowin(ob, pos)
{
	var add = "";
	var opt;
	_geocoder.geocode({'latLng':pos}, function(results, status)
	{
		if (status == google.maps.GeocoderStatus.OK) 
		{
			if (results[0])
			{
				add = results[0].formatted_address;
				ob.prop1 = ob.ID;
				ob.prop2 = _currpg;
				ob.prop6 = "M";
				ob.prop7 = pos.lat().toFixed(5) + "," +  pos.lng().toFixed(5);
				//opt = document.getElementById('findtype');
				//ob.prop13 = opt.options[opt.selectedIndex].text;
				//ob.prop14 = document.getElementById('findkwds').value;
				ob.prop15 = setplacename();			// "Custom";
				ob.prop16 = add;
				ob.prop17 = ob.title;
				ob.prop18 = pos.lat().toFixed(5) + " " +  pos.lng().toFixed(5);
				ob.prop31 = "";
				ob.prop32 = "";
				updateobjaddr(ob.prop16);
				_infowin.setContent(makeinfowindowcontent(ob, "siw", 1));
				if(!_editon){ _infowin.open(_map, ob); }
				if (_strviewon) { _strviewser.getPanoramaByLocation(pos, 30, showstrview); }	
			}
			else
			{
				add = "";
				updateobjaddr("Geocoder failed.", "#dd0000")
			}
		}
		else
		{
			add = "";
			updateobjaddr("Geocoder failed.", "#dd0000")
		}
	});
}

function selectfindmarker(id)
{
	_map.panTo(_findmarkers[id].getPosition())
	google.maps.event.trigger(_findmarkers[id], 'click');
	_loca = _findmarkers[id].getPosition();
	_map.setCenter(_loca);
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
	//document.getElementById('places').innerHTML = "";
	document.getElementById('findspanel').style.visibility = "hidden";
	document.getElementById('favspanel').style.visibility = "hidden";
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

function keepfindmarker(id)
{	
	var co = document.getElementById('siw5').innerHTML.split(" ");
	var poz = new google.maps.LatLng(co[0], co[1]);
	var mark = new google.maps.Marker({ map:_map, position:poz, title:document.getElementById('siw2').value, draggable:false });
	var iconfile = "media/mk-red-dot.png"; 		//'http://maps.google.com/mapfiles/ms/icons/red-dot.png'
	
	mark.prop0 = true;
	mark.prop1 = -1;
	mark.prop2 = _currpg;
	mark.prop3 = "";
	mark.prop4 = "INP_414,INP_415";
	mark.prop5 = "16,17";
	mark.prop6 = "M";
	
	mark.prop7 = co[0] + "," + co[1];	//conditional by type (M, C, ...)
	
	mark.prop8 = iconfile;
	mark.prop9 = "#ff0000";
	mark.prop10 = "#000000";
	mark.prop11 = 0;
	mark.prop12 = 1;
	mark.prop13 = document.getElementById('siw8').value;
	mark.prop14 = document.getElementById('siw9').value;
	mark.prop15 = document.getElementById('siw2').value;
	mark.prop16 = document.getElementById('siw3').value;
	mark.prop17 = document.getElementById('siw4').value;
	mark.prop18 = co[0] + " " + co[1];
	mark.prop19 = 0;
	mark.prop20 = document.getElementById('siw6').value;
	mark.prop21 = document.getElementById('siw7').value;
	mark.prop22 = "";
	mark.prop23 = "";
	mark.prop24 = "";
	mark.prop25 = 1;
	mark.prop26 = -1;
	mark.prop27 = 0;
	mark.prop28 = 0;
	mark.prop29 = 0;
	mark.prop30 = "";
	mark.prop31 = "";
	mark.prop32 = "";
	mark.prop33 = "";
	mark.prop34 = "";
	mark.prop35 = "";
	mark.prop36 = "";
	mark.prop37 = "";
	mark.prop38 = "";
	mark.prop39 = "";
	mark.prop40 = "";
	mark.prop41 = "";
	mark.prop42 = "";
	mark.prop43 = "";
	mark.prop44 = "";
	mark.prop45 = "";
	mark.prop46 = "";
	mark.prop47 = "";
	mark.prop48 = "";
	mark.prop49 = "";
	
	
	clearfindmarker(id);

	mark.prop1 = _favobjects.length;
	_favobjects[_favobjects.length] = mark;
	mark.setMap(_map);
	mark.setIcon(iconfile);
	setobjcenter(mark);
	
	google.maps.event.addListener(mark, 'dragend', function(e) 
	{
		setobjcenter(this);
		//if (this.prop6 == "M") { _mapmark.setVisible(false); } else { _mapmark.setVisible(true); }
		if (_strviewon) { _strviewser.getPanoramaByLocation(_loca, 30, showstrview); }	
	});
	
	google.maps.event.addListener(mark, 'click', function(e)
	{
		if (this.prop6 == "M") { _mapmark.setVisible(false); } else { _mapmark.setVisible(true); }
		if (_editon && _delobjon) { clearfavsmarker(this.prop1); return; }
		deselectfavs();
		_infowin.setContent("");
		_infowin.setContent(makeinfowindowcontent(this, "ciw", 0));
		setobjcenter(this);
		if (!_editon) { _infowin.open(_map, this); }	
		this.setIcon(this.prop8.substr(0, 13) + "sta.png"); 
		updateobjaddr(this.prop16 + "|" + this.prop17);
		if (_strviewon) { _strviewser.getPanoramaByLocation(_loca, 30, showstrview); }	
	});
}


//---------------------------------------------------------------------

function homelookupresphandler(results, status)
{
	if (status == google.maps.GeocoderStatus.OK)
	{
		var res_index = find_local_match(results, GMAPS_ADDR_COMP_TYPE_LOCALITY, "Montreal");
		_map.setCenter(results[res_index].geometry.location);
		_mapmark.setPosition(results[res_index].geometry.location);
		_mapmark.setVisible(true);
		updateobjaddr(results[res_index].formatted_address);
	}
}

function recherchergeocoderresphandler(results, status)
{
	var rechercherbtn = document.getElementById("btn1");
	//var strviewbtn = document.getElementById("btn3");
	if (status == google.maps.GeocoderStatus.OK)
	{
		var res_index = find_local_match(results, GMAPS_ADDR_COMP_TYPE_LOCALITY, "Montreal");
		_map.setCenter(results[res_index].geometry.location);
		_mapmark.setPosition(results[res_index].geometry.location);
		_mapmark.setVisible(true);
		updateobjaddr(results[res_index].formatted_address);
		enableproximitysearch();
		rechercherbtn.disabled = false;
		if (_strviewon) { 
			_strviewser.getPanoramaByLocation(_mapmark.getPosition(), 30, showstrview);
		}
		//else {
		//	strviewbtn.disabled = false;
		//}
	} 
	else 
	{
		updateobjaddr("Geocoder failed.", "#dd0000");
		disableproximitysearch();
		//strviewbtn.disabled = true;
		rechercherbtn.disabled = true;
	}
}

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

function makefavgeocoderresphandler(results, status)
{ 
	var poz;
	var os = [];
	var adr = document.getElementById("address").value;
	var iconfile = "media/mk-red-dot.png"; 		//'http://maps.google.com/mapfiles/ms/icons/red-dot.png'
	
	if (status == google.maps.GeocoderStatus.OK)
	{
		_map.setCenter(results[0].geometry.location);
		var mark = new google.maps.Marker({ map:_map, position:results[0].geometry.location, draggable:false });
		saveLocationToDB(mark);
	
		mark.prop0 = true;
		mark.prop1 = -1;
		mark.prop2 = _currpg;
		mark.prop3 = "";
		mark.prop4 = "";
		mark.prop5 = "";
		mark.prop6 = "M";
		mark.prop7 = mark.getPosition().lat() + "," + mark.getPosition().lng();
		mark.prop8 = iconfile;
		mark.prop9 = "#ff0000";
		mark.prop10 = "#000000";
		mark.prop11 = 0;
		mark.prop12 = 1;
		mark.prop13 = "custom";
		mark.prop14 = "";
		mark.prop15 = "";
		mark.prop16 = adr;
		mark.prop17 = "";
		mark.prop18 = mark.getPosition().lat().toFixed(5) + " " + mark.getPosition().lng().toFixed(5);
		mark.prop19 = 0;
		mark.prop20 = "";
		mark.prop21 = "";
		mark.prop22 = "";
		mark.prop23 = "";
		mark.prop24 = "";
		mark.prop25 = "";
		mark.prop26 = -1;
		mark.prop27 = 0;
		mark.prop28 = 0;
		mark.prop29 = 0;
		mark.prop30 = "";
		mark.prop31 = "";
		mark.prop32 = "";
		mark.prop33 = "";
		mark.prop34 = "";
		mark.prop35 = "";
		mark.prop36 = "";
		mark.prop37 = "";
		mark.prop38 = "";
		mark.prop39 = "";
		mark.prop40 = "";
		mark.prop41 = "";
		mark.prop42 = "";
		mark.prop43 = "";
		mark.prop44 = "";
		mark.prop45 = "";
		mark.prop46 = "";
		mark.prop47 = "";
		mark.prop48 = "";
		mark.prop49 = "";
				
		mark.prop13 = setplacecat();			// "Custom";
		mark.prop15 = setplacename();			// "Custom place " + _favobjects.length;
		mark.setTitle(mark.prop15);

		mark.prop1 = _favobjects.length;
		_favobjects[_favobjects.length] = mark;
		mark.setMap(_map);
		mark.setIcon(iconfile);
		setobjcenter(mark);
		mark.setVisible(true);
				
		google.maps.event.addListener(mark, 'dragend', function(e) 
		{
			setobjcenter(this);
			//if (this.prop6 == "M") { _mapmark.setVisible(false); } else { _mapmark.setVisible(true); }
			if (_strviewon) { _strviewser.getPanoramaByLocation(_loca, 30, showstrview); }	
		});
				
		google.maps.event.addListener(mark, 'click', function() 
		{
			if (this.prop6 == "M") { _mapmark.setVisible(false); } else { _mapmark.setVisible(true); }	
			if (_editon && _delobjon) { clearfavsmarker(this.prop1); return; }
			deselectfavs();
			_infowin.setContent(makeinfowindowcontent(this, "ciw", 0));
			setobjcenter(this);
			this.setIcon(this.prop8.substr(0, 13) + "sta.png");
			if(!_editon){ _infowin.open(_map, this); }
			updateobjaddr(this.prop16 + "|" + this.prop17);
			if (_strviewon) { _strviewser.getPanoramaByLocation(_loca, 30, showstrview); }	
			showfavs();
		});
		
		remercier_et_fermer();
	} 
	else 
	{
		updateobjaddr("Geocoder failed.", "#dd0000")
	}
}

function rechercheradresse()
{
	_infowin.close();
	_mapmark.setVisible(false);
	var addr = document.getElementById("address").value;
	if ( addr.length > 0 ) {
		var region_hint_to_geocoder = ",QC";		
		var addr_hack =  addr + region_hint_to_geocoder;
		if (document.getElementById("radio_nom").checked) {
			trouvercommerce();
		}
		else {
			_geocoder.geocode( { 'address': addr_hack }, recherchergeocoderresphandler );
		}
	}
}

function showhomeaddress(addr)
{
	_geocoder.geocode( { 'address': addr }, homelookupresphandler );
}

function puthomepin()
{
	xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=homeAddressLookupResp;
	var php_url = "reponses_bdd.php?up=hl&id=" + _id_participant;
	xmlhttp.open("get",php_url,true);
	xmlhttp.send();
}
		
function homeAddressLookupResp()
{
	var ok = false;
	if (xmlhttp.readyState==4 && xmlhttp.status==200) {
		var point_resp = xmlhttp.responseText;
		var expected_pfx = "POINT(";
		var expected_sfx = ")";
		if ( point_resp.substring(0,expected_pfx.length) == expected_pfx ) {
			var tokens = point_resp.substring(expected_pfx.length).split(" ");
			if (tokens.length == 2) {
				var lat = tokens[0];
				var lon = tokens[1].substring(0, tokens[1].length-1);
				var homepos = new google.maps.LatLng(parseFloat(lat),parseFloat(lon));
				homemark = new google.maps.Marker({ map:_map, position:homepos, draggable:false });
				homemark.setMap(_map);
				homemark.setIcon('media/home2.png');
				homemark.setVisible(true);
				_map.setCenter(homepos);
				ok = true;
			}
		}
		if (!ok) {
			//alert( "Impossible d'afficher votre lieu de domicile" );
		}
	}
}

function confirmeraddress()
{
	_mapmark.setVisible(false);
	if ( _qno == 'A2' ) {
		saveHomeAddress(_mapmark);
	}
	else {
		var region_hint_to_geocoder = ",QC'";
		var addr = document.getElementById("address").value + region_hint_to_geocoder;
		_geocoder.geocode( { 'address': addr }, makefavgeocoderresphandler );
	}
}

function saveHomeAddress(marker)
{
	xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=saveHomeResp;
	var php_url = "reponses_bdd.php?up=dom&id=" + _id_participant + "&q=" + _qno + "&t=" + _mode + "&lat=" + marker.getPosition().lat().toFixed(8) + "&lon=" + marker.getPosition().lng().toFixed(8);
	xmlhttp.open("post",php_url,true);
	xmlhttp.send();
}
		
function saveHomeResp()
{
	if (xmlhttp.readyState==4 && xmlhttp.status==200) {
		remercier_et_fermer();
	}
}

function remercier_et_fermer()
{
	popup_info_to_user("Retourner dans le questionnaire textuel", 8, "Merci!");
	setTimeout("retournerdanslimesurvey();" , 3000);
}

function retournerdanslimesurvey()
{
	window.location.href = "https://www.isis-montreal.ca/questionnaire/fakeVeritas.php";
}

function setplacename()
{
	if (_currpg == 1){ return "Principal residence"; }
	else if (_currpg == 3){ return "Principal residence (corrected)"; }
	else if (_currpg == 4){ return "Another residence"; }
	else if (_currpg == 5){ return "Another residence (corrected)"; }
	else if (_currpg == 7){ return "Convenience store"; }
	else if (_currpg == 8){ return "Supermarket"; }
	else{ return "Custom place " + _favobjects.length; }
}

function setplacecat()
{
	if (_currpg >= 1 && _currpg <= 5){ return "Principal residence"; }
	else if (_currpg >= 7 && _currpg <= 14){ return "Shopping and services"; }
	else{ return "Custom"; }
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

/*
function clearfavspanel()
{
	document.getElementById('findtype').value = "";
	document.getElementById('findkwds').value = "";
	document.getElementById('findrads').value = "1000";
	document.getElementById('objects').innerHTML = "";
	document.getElementById('findspanel').style.visibility = "hidden";
	document.getElementById('favspanel').style.visibility = "hidden";	
}
*/

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

function makeinfowindowcontent(obj, src, typ)		//typ 0=favs , 1=finds 
{
	var cn;
	var ro = "";
	if (src == "siw") { so = 1; } else { so = 2; };
	if (_currpg > 0)
	{
		if (typ == 1) { ro = "readonly='readonly'"; } else { ro = ""; }
		cn = "<div id='iwdiv' style='height:160px; width:300px; opacity:.9;'><b><span id='" + src + "1'>" + (obj.prop1 + 1) + "</span>. </b>" + 
		"<input id='" + src + "2' type='textbox' size='40' maxlength='120' style='border-width:0px 0px 1px 0px; height 16px; font-weight:bold;' value='" + obj.prop15 + "' " + ro + " />" + 
		"<br>Address:  &nbsp;<input id='" + src + "3' type='textbox' size='34' maxlength='120' style='border-width:0px 0px 1px 0px; height 16px; font-weight:bold;' value='" + obj.prop16 + "' readonly='readonly' />" +
		"<br>Address extra: &nbsp;<input id='" + src + "4' type='textbox' size='30' maxlength='120' style='border-width:0px 0px 1px 0px; height 16px; font-weight:bold;' value='" + obj.prop17 + "' " + ro + " />" +
		"<br>Phone: &nbsp;<input id='" + src + "6' type='textbox' size='22' maxlength='20' style='border-width:0px 0px 1px 0px; height 16px; font-weight:bold;' value='" + obj.prop31 + "' " + ro + " />" +
		"<br>Email: &nbsp;<input id='" + src + "7' type='textbox' size='34' maxlength='80' style='border-width:0px 0px 1px 0px; height 16px; font-weight:bold;' value='" + obj.prop32 + "' " + ro + " />" +
		"<br>Category: &nbsp;<input id='" + src + "8' type='textbox' size='33' maxlength='120' style='border-width:0px 0px 1px 0px; height 16px; font-weight:bold;' value='" + obj.prop13 + "' " + ro + " />" +
		"<br>Keywords: &nbsp;<input id='" + src + "9' type='textbox' size='33' maxlength='120' style='border-width:0px 0px 1px 0px; height 16px; font-weight:bold;' value='" + obj.prop14 + "' " + ro + " />";
		if (obj.prop6 == "L")
		{
			cn += "<br><span>Distance: &nbsp;<b>" + obj.inKm().toFixed(2) + " Km.</b></span>"; 		//poly length
		}
		if (typ == 1)
		{
			cn += "<br><span style='visibility:hidden;'>Coordinates: &nbsp;<b><span id='" + src + "5'>" + obj.prop18 + "</span></b></span>";
			cn += "<br><br><b><a href='javascript:keepfindmarker(" + obj.prop1 + ");' style='text-decoration:underline;'>Keep</a></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else
		{
			cn += "<br><br><b><a href='javascript:saveinfowindowcontent(" + obj.prop1 + "," + so + ")' style='text-decoration:underline;'>Save</a></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		cn += "<b><a href='javascript:clearfavsmarker(" + obj.prop1 + ")' style='text-decoration:underline;'>Remove</a></b><div>";
	}
	return cn;
}

function saveinfowindowcontent(id, so)
{
	var so;
	if (so == 1) { src = "siw"; } else { src = "ciw"; }
	var ob = getobject(id);
	ob.prop13 = document.getElementById(src+"8").value;
	ob.prop14 = document.getElementById(src+"9").value;
	ob.prop15 = document.getElementById(src+"2").value;
	ob.prop16 = document.getElementById(src+"3").value;
	ob.prop17 = document.getElementById(src+"4").value;
	ob.prop31 = document.getElementById(src+"6").value;
	ob.prop32 = document.getElementById(src+"7").value;
	try{ob.setTitle(ob.prop15);}catch(er){}
	if(ob.prop17 != "" && ob.prop17 != null && ob.prop17 != undefined){ updateobjaddr(ob.prop16 + "|" + ob.prop17); }else{ updateobjaddr(ob.prop16); }
	deselectfavs();
	_infowin.close();
	if (document.getElementById("favspanel").style.visibility == "visible") { showfavs(); }	
}

function getobject(id)
{
	for(var i=0; i<_favobjects.length; i++)
	{
		if (_favobjects[i] != null && _favobjects[i] != undefined)
		{	
			if (_favobjects[i].prop1 == id) { return _favobjects[i]; break; }
		}
	}
	return null;
}

function toggleviewpanel()
{
	var vp = document.getElementById("viewpanel")
	if (vp.style.visibility == "visible") 
	{ 
		vp.style.visibility = "hidden"; 
	} 
	else 
	{ 
		vp.style.visibility = "visible"; 
		document.getElementById("findspanel").style.visibility = "hidden";
		document.getElementById("favspanel").style.visibility = "hidden";
	}	
}

function closeviewpanel()
{
	document.getElementById("viewpanel").style.visibility = "hidden";	
}

function effacerlieux()
{
	document.getElementById('findspanel').style.visibility = 'hidden';
	document.getElementById('view2').checked = false;
	for(var i = 0; i<_findmarkers.length; i++)
	{ 
		clearfindmarker(i);
	}
	updateobjaddr("");
	disableproximitysearch();
	document.getElementById('address').focus();
}

function showfavs()
{
	var pg;
	document.getElementById('findspanel').style.visibility = "hidden";
	document.getElementById('favspanel').style.visibility = "visible";
	var oblst = document.getElementById('objects');
	oblst.innerHTML = "";
	if(document.getElementById("rfav1").checked){ pg = _currpg; }else{ pg = 0; }
	for(var i = 0; i<_favobjects.length; i++)
	{
		if(_favobjects[i] != null)
		{
			if(pg > 0)
			{
				if( parseInt(_favobjects[i].prop2) == _currpg)
				{
					_favobjects[i].setVisible(true);
					oblst.innerHTML += "<li id='lob" + i + "'>" + "<a style='color:#404040; width:186px;;' href='javascript:selectfav(" + i + ")'>" + (i+1) + ". " + _favobjects[i].prop15 + "</a></li>";
				}
				else
				{
					_favobjects[i].setVisible(false);
				}
			}
			else
			{
				_favobjects[i].setVisible(true);
				oblst.innerHTML += "<li id='lob" + i + "'>" + "<a style='color:#404040; width:186px;' href='javascript:selectfav(" + i + ")'>" + (i+1) + ". " + _favobjects[i].prop15 + "</a></li>";
			}
		}
	}
}

function hidefavs()
{
	document.getElementById("favspanel").style.visibility = "hidden";	
	for(var i = 0; i<_favobjects.length; i++)
	{ 
		if(_favobjects[i] != null){ _favobjects[i].setVisible(false); }
	}
}

function showfinds()
{
	document.getElementById('findspanel').style.visibility = "visible";	
	document.getElementById('favspanel').style.visibility = "hidden";
	for(var i = 0; i<_findmarkers.length; i++)
	{ 
		if(_findmarkers[i] != null){ _findmarkers[i].setVisible(true); }
	}
}

function hidefinds()
{
	document.getElementById("findspanel").style.visibility = "hidden";	
	for(var i = 0; i<_findmarkers.length; i++)
	{ 
		if(_findmarkers[i] != null){ _findmarkers[i].setVisible(false); }
	}
}

function doview()
{
	var v1 = document.getElementById("view1");
	var v2 = document.getElementById("view2");
	var v3 = document.getElementById("view3");
	var v4 = document.getElementById("view4");
	var v5 = document.getElementById("view5");
	var v6 = document.getElementById("view6");
	var v7 = document.getElementById("view7");
	var v8 = document.getElementById("view8");
	var v9 = document.getElementById("view9");
	var v10 = document.getElementById("view10");
	if(_layerbike != null) {_layerbike.setMap(null); _layerbike = null;}
	if(_layertrans != null) {_layertrans.setMap(null); _layertrans = null;}
	if(_layertraff != null){_layertraff.setMap(null); _layertraff = null;}
	if(v7.checked){ _layerbike = new google.maps.BicyclingLayer(); _layerbike.setMap(_map); }
	if(v8.checked){ _layertrans = new google.maps.TransitLayer(); _layertrans.setMap(_map); }
	if(v9.checked){ _layertraff = new google.maps.TrafficLayer(); _layertraff.setMap(_map); }
	if(v1.checked){ showfavs(); }else{ hidefavs(); }
	if (v2.checked) { showfinds(); } else { hidefinds(); }
	if (v3.checked) { _map.setMapTypeId(google.maps.MapTypeId.ROADMAP); }	
	else if (v4.checked) { _map.setMapTypeId(google.maps.MapTypeId.HYBRID); }	
	else if (v5.checked) { _map.setMapTypeId(google.maps.MapTypeId.SATELLITE); }	
	else if (v6.checked) { _map.setMapTypeId(google.maps.MapTypeId.TERRAIN); }	
}

function directions()
{
	
}


//------------------------------------------------------------------- special functions

google.maps.Polyline.prototype.inKm = function(n){ 
    var a = this.getPath(n), len = a.getLength(), dist = 0; 
    for(var i=0; i<len-1; i++){ 
      dist += a.getAt(i).kmTo(a.getAt(i+1)); 
    } 
    return dist; 
	//usage:  console.log(poly.inKm());
}
  
google.maps.LatLng.prototype.kmTo = function(a){ 
    var e = Math, ra = e.PI/180; 
    var b = this.lat() * ra, c = a.lat() * ra, d = b - c; 
    var g = this.lng() * ra - a.lng() * ra; 
    var f = 2 * e.asin(e.sqrt(e.pow(e.sin(d/2), 2) + e.cos(b) * e.cos(c) * e.pow(e.sin(g/2), 2))); 
    return f * 6378.137; 
} 



//------------------------------------------------------------------- external interface

function hidemap(par)			//external interface
{
	var i;
	var c = 0;
	if(par == 1)
	{
		if (_editon) { alert("Exit EDIT MODE first."); return; }
		for (i = 0; i < _favobjects.length; i++)
		{
			if (_favobjects[i] != null && _favobjects[i].prop2 == _currpg && _favobjects[i].prop6 != "L") { c++; }	
		}
		if ( c > _maxfavs) { alert("Only " + _maxfavs + " locations allowed."); return; }		//test number of favs here !!!
	}
	clearfindall();
	clearfindpanel();
	if(par == 1){map2quest();}
	document.getElementById('favspanel').style.visibility = "hidden";
	document.getElementById('findspanel').style.visibility = "hidden";
	document.getElementById('maindiv').style.visibility = "hidden";
	//document.getElementById('btn9').style.visibility = "hidden";
	document.getElementById('btn10').style.visibility = "hidden";
	document.getElementById('strviewdiv').style.visibility = "hidden";
}

function showmap(par)			//external interface
{
	var pr = par.split("|");
	document.getElementById('maindiv').style.visibility = "visible";
	//document.getElementById('btn9').style.visibility = "visible";
	document.getElementById('btn10').style.visibility = "visible";
	_currpg = parseInt(pr[1]);			//current page
	_maxfavs =  parseInt(pr[2]);		//max places
	_mapdata = pr[4];
	if (pr[0] == "T") {	mapinit(); }
}

function map2quest()		//external interface - save objects data to questionnaire: MODIFY!
{
	var i, j;
	var pr = "";
	var fa = "";		//favs all
	for (i = 0; i < _favobjects.length; i++)
	{
		if (_favobjects[i] != null)
		{
			pr = "•" + _favobjects[i].prop1 + "•" + _favobjects[i].prop2 + "•" + _favobjects[i].prop3 +  "•" + _favobjects[i].prop4 +  "•" + _favobjects[i].prop5 +  "•" + _favobjects[i].prop6 +  "•" + _favobjects[i].prop7 +  "•" + _favobjects[i].prop8 + "•" + _favobjects[i].prop9 + "•" + _favobjects[i].prop10 + "•" + _favobjects[i].prop11 + "•" + _favobjects[i].prop12 + "•" + _favobjects[i].prop13 + "•" + _favobjects[i].prop14 + "•" + _favobjects[i].prop15 + "•" + _favobjects[i].prop16 + "•" + _favobjects[i].prop17 + "•" + _favobjects[i].prop18 + "•" + _favobjects[i].prop19 + "•" + _favobjects[i].prop20 + "•" + _favobjects[i].prop21 + "•" + _favobjects[i].prop22 + "•" + _favobjects[i].prop23 + "•" + _favobjects[i].prop24 + "•" + _favobjects[i].prop25 + "•" + _favobjects[i].prop26 + "•" + _favobjects[i].prop27 + "•" + _favobjects[i].prop28 + "•" + _favobjects[i].prop29 + "•" + _favobjects[i].prop30 + "•" + _favobjects[i].prop31 + "•" + _favobjects[i].prop32 + "•" + _favobjects[i].prop33 + "•" + _favobjects[i].prop34 + "•" + _favobjects[i].prop35 + "•" + _favobjects[i].prop36 + "•" + _favobjects[i].prop37 + "•" + _favobjects[i].prop38 + "•" + _favobjects[i].prop39 + "•" + _favobjects[i].prop40 + "•" + _favobjects[i].prop41 + "•" + _favobjects[i].prop42 + "•" + _favobjects[i].prop43 + "•" + _favobjects[i].prop44 + "•" + _favobjects[i].prop45 + "•" + _favobjects[i].prop46 + "•" + _favobjects[i].prop47 + "•" + _favobjects[i].prop48 + "•" + _favobjects[i].prop49;
			fa += "◘" + pr;
		}
	}
	fa = fa.substr(1);
	send2flash(fa);		//external interface 
}

function remhtml(str)
{
	return($(str).text());
}


// alert, confirm, prompt, print, find dialog boxes

/*
var sv = new google.maps.StreetViewService();
sv.getPanoramaById(inputID, processSVData);
...
function processSVData(data, status) {
...
  console.log(data.location.latLng);
...
}

event position_changed onpanorama

*/

function mapclickhandler(e) 
{ 
	deselectfavs();
	_infowin.close();
	updateaddress(e.latLng);
}

function dragmarkerhandler()
{
	setobjcenter(this);
	updateaddress(_mapmark.getPosition());
}

function strvwposchangehandler() {
	updateaddress(_strviewpano.getPosition());
}

function handlegeocoderresp(responses, status)
{
 	if (responses && responses.length > 0 && status == google.maps.GeocoderStatus.OK)
	{
		_addr = responses[0].formatted_address;
		updateobjaddr(_addr);
	}
	else
	{
		_addr = "Adresse ne peut être identifié";
		updateobjaddr(_addr, "#dd0000");
	}
}
	
function updateaddress(newlatlng, markermoved)
{
	if (typeof(markermoved)==='undefined')
	{
		_loca = newlatlng;
		_mapmark.setPosition(_loca);
		_mapmark.setVisible(true);
		enableproximitysearch();
	}
	
	_geocoder.geocode( { latLng:_loca }, recherchergeocoderresphandler); /*handlegeocoderresp);
	if (_strviewon)
	{
		_strviewser.getPanoramaByLocation(_loca, 30, showstrview);
	}*/
}

function inputs_init()
{
	disableproximitysearch();
	var searchradtooltiptext = "Faire une recherche de lieux par mots-clés dans un rayon de " + _searchradius + "m du marqueur";
	document.getElementById('radio_nom').title = searchradtooltiptext;
	document.getElementById('search_prox_label').title = searchradtooltiptext;
	var address_input = document.getElementById('address');
	address_input.addEventListener("keyup", keyUpTextField, false);
	document.getElementById('btn1').disabled = true; // Rechercher d'adresse
	//document.getElementById('btn3').disabled = true; // Visualiser
}

function keyUpTextField(e) {
	//var charCode = e.charCode;
	var addr = document.getElementById('address').value;
	var search_btn = document.getElementById('btn1');
	search_btn.disabled = ( addr.length == 0 );
  
}