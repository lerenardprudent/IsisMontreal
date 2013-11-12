
private function actkeydown(ob, k):void
{
	var v;
	var obn = ob.name;
	if (k == 13)
	{
		switch(obn)
		{
			case "OBJ_INP_19":		//login
			case "OBJ_INP_20":
				_ual = getobj(_wins[6], "INP", 19).xval;					//user alias
				_upw = getobj(_wins[6], "INP", 20).xval;					//user pass
				dbloginuser(_ual, _upw);
				break;
			default:
				break;
		}
	}
}

private function objactionsclick(ob, ... parms):*			//object, object element (target)
{
	var win, obn, obi;
	win = ob.parent.parent;
	obn = ob.name.substr(4);
	obi = parseInt(obn.substr(4));
	if (obn.substr(0, 3) == "BTN")
	{
		if (obi < _stqueobj) { obactbtn(ob, obn, win); } else { questbizrules(ob, obn, win); }
	}
	else if (obn.substr(0, 3) == "IMG")
	{
		if (obi < _stqueobj) { obactimg(ob, obn, win); } else { questbizrules(ob, obn, win); }
	}
	else if (obn.substr(0, 3) == "STP")
	{
		if (obi < _stqueobj) { obactstp(ob, obn, win); } else { questbizrules(ob, obn, win); }
	}
	else if (obn.substr(0, 3) == "CAL")
	{
		if (obi < _stqueobj) { obactcal(ob, obn, win); } else { questbizrules(ob, obn, win); }
	}
	else if (obn.substr(0, 3) == "TIM")
	{
		if (obi < _stqueobj) { obacttim(ob, obn, win); } else { questbizrules(ob, obn, win); }
	}
	else if (obn.substr(0, 3) == "CHK")
	{
		if (obi < _stqueobj) { obactchk(ob, obn, win); } else { questbizrules(ob, obn, win); }
	}
	else if (obn.substr(0, 3) == "RAD")
	{
		if (obi < _stqueobj) { obactrad(ob, obn, win); } else { questbizrules(ob, obn, win); }
	}
	return true;
}

private function obactstp(ob, obn, win):void
{

}

private function obactcal(ob, obn, win):void
{

}

private function obacttim(ob, obn, win):void
{

}

private function obactchk(ob, obn, win):void
{

}

private function obactrad(ob, obn, win):void
{

}

private function obactimg(ob, obn, win):void
{
	switch(obn)
	{
		case "IMG_45":		//close pop image
			win.visible = false;
			showblocker(false);
			break;
	}
}

private function obactbtn(ob, obn, win):void
{
	var i, l, j, a, v, v1, v2, ww, ox, yy, tout, pv;
	switch(obn)
	{
		case "BTN_2":		//cancel alert
		case "BTN_5":
		case "BTN_9":
			showblocker(false);
			break
		case "BTN_4":		//confirm alert
		case "BTN_8":
			showblocker(false);
			actionalert();
			break;
		case "BTN_51":		// menu help
			if (ob.xval == "D")
			{
				tofront(_wins[7]);
				showwin(_wins[7], true, 1, 0);
			}
			else if (ob.xval == "U")
			{
				if(_wins[7].visible){ showwin(_wins[7], false, 1, 0); }
			}
			break;
		case "BTN_52":		// menu login
			if (_logged)	//logout
			{
				_logged = false;
				changelabtxt(ob, "Logout", "Login");
				for (i = 46; i <= 51; ++i) { getobj(_wins[4], "BTN", i).xval = "U"; getobj(_wins[4], "BTN", i).visible = false; }
				showblocker(false);
				//for (i = 9; i <= 28; ++i)
				for (i = 7; i <= 8; ++i)
				{ 
					if (_wins[i].visible) { showwin(_wins[i], false, 1, 0); }
				}
				ox = _main.getChildAt(1);
				if (ox != null)
				{
					TweenMax.to(ox, .3, { alpha:.6 } );
				}
			}
			else			//login
			{
				pozwin(_wins[6], true, true, 0, 0, false, 0);
				showwin(_wins[6], true, 0, 0);
				showblocker(true);
			}
			break;
		case "BTN_21":		//confirm login
			_ual = getobj(_wins[6], "INP", 19).xval;					//user alias
			_upw = getobj(_wins[6], "INP", 20).xval;					//user pass
			dbloginuser(_ual, _upw);
			break;
		case "BTN_22":		//cancel login
			showwin(_wins[6], false, 1, 0);
			showblocker(false);
			break;
		default:
			break;
	}
}

private function objactionsover(ob):*
{
	var win;
	win = ob.parent.parent;
}

private function objactionsout(ob):*
{
	var win;
	win = ob.parent.parent;
}

private function winrefresh(win):void
{

}

private function actionresize(sw, sh):void
{
	var i, l, bt;
	bt = null;
	_wins[4].resizewin(sw - 40, _wins[4].vheight);			//menu
	bt = getobj(_wins[4], "BTN", 52);
	if (bt != null) { bt.x = _wins[4].vwidth - bt.xwidth; }
	_wins[4].x = 20;
	_wins[5].x = 20;										//status bar
	_wins[5].y = _main.back.height;
}

private function onwinlayout(win):void
{
	if (win == _wins[6])			//login
	{
		getobj(win, "INP", 20).inp.displayAsPassword = true;
	}
	else if (win == _wins[8])
	{
		questadjustform();
		//getobj(_wins[5], "LAB", 60).labtext = "   adjust form";
	}
}

private function onwinclose(win):void
{
	if (win == _wins[7])		//help
	{
		getobj(_wins[4], "BTN", 51).xval = "U";
	}
}

private function actiondragwin(win):void
{
	var i, pa;
	if (win == _wins[6])
	{
		pozwin(_wins[5], false, false, _wins[6].x + 30, _wins[6].y + _wins[6].vheight + 10, true, 0);
	}
}

private function delaypageload():void
{
	var wi;
	wi = arguments[0];
	wi.holder.y = wi.holdermask.y;
	wi.scrlbarv.percent = 0;
	makewinlayout(wi, arguments[1]);
	fitwin(wi, false);
	if (arguments[2] == "R")
	{
		pozwin(wi, false, false, wi.parent.width + 2, wi.y, 0, 0);
	}
	else if (arguments[2] == "L")
	{
		pozwin(wi, false, false, -wi.vwidth - 2, wi.y, 0, 0);
	}
	pozwin(wi, true, true, 0, 0, 1, 0);
}

private function actionalert(... parms):void
{
	var a, t, i, v, pv;
	switch(_alertact)
	{
		case "ABAN":		//quest. abandon
			getobj(_wins[4], "BTN", 46).xval = "U";
			showwin(_wins[8], false, 1, 0);
			questsaveansw("ABAN");
			break;
		case "QUIT":			//quest. interrupt
			getobj(_wins[4], "BTN", 46).xval = "U";
			showwin(_wins[8], false, 1, 0);
			questsaveansw("QUIT");
			break;
		default:
			break;
	}
}

private function actionapplyto():void
{

}


//--------------------------------------------- validate form functions


private function resetform(win):void
{
	var i, hld, oc, ox;
	hld = win.getChildByName("holder");
	for (i = 0; i < hld.numChildren; ++i)
	{
		ox = hld.getChildAt(i);
		if (ox.hasOwnProperty("xval"))
		{
			oc = ox.name.substr(4, 3);
			if (oc == "INP" || oc == "DDL" || oc == "STP" || oc == "CAL" || oc == "TIM")
			{
				ox.xval = "---";
			}
			else if (oc == "CHK" || oc == "RAD")
			{
				ox.xval = 0;
			}
			else if (oc == "LST")
			{
				ox.xval = "";
			}
		}
	}
}

private function resetfields(win, fls):void
{
	var i, l, ob;
	l = fls.length;
	for (i = 0; i < l; ++i)
	{
		ob = getobj(win, fls[i][0], fls[i][1]);
		if (fls[i][0] == "INP" || fls[i][0] == "DDL" || fls[i][0] == "STP" || fls[i][0] == "CAL" || fls[i][0] == "TIM")
		{
			ob.xval = "---";
		}
		else if (fls[i][0] == "CHK" || fls[i][0] == "RAD")
		{
			ob.xval = 0;
		}
		else if (fls[i][0] == "LST")
		{
			ob.xval = "";
		}
	}
}

private function validateform(win, subwin):Boolean
{
	return true;
}


//--------------------------------------------- permissions


private function setwinperms(win):void
{

}

private function setfldsperms(win:*):void
{
	var i, hld, oc, ox, v, fl, l;
	hld = win.getChildByName("holder");
	for (i = 0; i < hld.numChildren; ++i)
	{
		ox = hld.getChildAt(i);
		if (ox.hasOwnProperty("xval")) 
		{
			oc = ox.name.split("_");
			enableobj(win, oc[1], oc[2]);
		}
	}
}


//--------------------------------------------- db list functions


private function dbloginuser(uid:String, pwd:String):void
{
	var pv;
	pv = "fn100¦" + uid + "¦" + pwd;
	//trace("fn100",_apppath + "dbactions.php", pv);
	actdbpost(_apppath + "dbactions.php", pv);
}

private function dbloadquest(que:String, par:String):void
{
	var pv;
	pv = "fn101¦" + que + "¦" + par;
	//trace("fn101",_apppath + "dbactions.php", pv);
	actdbpost(_apppath + "dbactions.php", pv);
}

private function dbloadlookup(tb, flt)
{

}

private function dblistscroll(sn):void
{

}

private function dbnextpage(ls):void
{

}

private function dbprevpage(ls):void
{

}

private function dbloadlist(tbl:String, po:int, ps:int, flt:String, srt:String, srtd:String, ... parms):void			//tbl=table (USR,ACT,MAT), po=db table paging offset, ps=db table page size, flt = filter: val1.val2.val3...  where vals in same order as from the filter form, srt = sort colum, srtd = sort direction		
{

}

private function dbfindrec(tbl:String, v:String)
{

}

private function dbloadrecord(tbl:String, id:String):void		//tbl=table
{

}

private function dbsaverecord(tbl:String)
{

}

private function dbsaverecordcombo(win:*):void
{

}

private function dbdeleterecord(tbl:String, id:String):void
{
	
}

private function dbmakefilter(tbl:String):void
{

}

private function dbsortlist(tbl:String, fld:String, ob:*):void
{

}

private function rec2form(win:*, rec:*):void
{
	//trace("RTF")
	/*
	var i, hld, oc, ox, v;
	hld = win.getChildByName("holder");
	if (rec.length == 1) { return; }
	for (i = 0; i < hld.numChildren; ++i)
	{
		ox = hld.getChildAt(i);
		if (ox.hasOwnProperty("xdbfld") && ox.hasOwnProperty("xval"))
		{
			if (ox.xdbfld > 0)
			{
				oc = ox.name.substr(4, 3);
				v = rec[ox.xdbfld -1];
				if (oc == "CHK_")
				{
					v = int(v);
				}
				else if (oc == "INP" || oc == "DDL" || oc == "STP" || oc == "CAL" || oc == "TIM")
				{
					if (v == "0000-00-00") { v = ""; }
				}
				ox.xval = v;
			}
		}
	}
	//if (win == _wins[10]) { setfldsperms(win); }
	adjustrec2form(win);
	*/
}

private function adjustrec2form(win:*):void
{

}

private function form2rec(win:*):String
{
	return "";
}

private function lookup2form(win):void
{

}

private function tblactions(t):void
{

}

private function selrecsarray(win, ot, oi):String
{
	return "";
}




private function actdbpost(purl:String, pv:String):void
{
	var rq, vs;
	showpreloader();
	_actloader = new URLLoader();
	_actloader.dataFormat = URLLoaderDataFormat.TEXT;
	rq = new URLRequest();
	rq.method = URLRequestMethod.POST;
	vs = new URLVariables();
	vs.pvar = pv;
	rq.url = purl;
	rq.data = vs;
	_actloader.addEventListener(Event.COMPLETE, actdbposted, false, 0, true);
	_actloader.addEventListener(IOErrorEvent.IO_ERROR, actdbioerror, false, 0, true);
	_actloader.load(rq);
}

private function actdbposted(e:Event):void
{
	var i, a, d;
	hidepreloader();
	try { _actloader.removeEventListener(Event.COMPLETE, actdbposted); } catch (er) { }
	try { _actloader.removeEventListener(IOErrorEvent.IO_ERROR, actdbioerror); } catch (er) { }
	_actloader = null;
	d = e.target.data;
	if (d.substr(0, 4) != "-er-")
	{
		actiondb(e.target.data);
	}
	else
	{
		if (d == "-er-sql-")
		{
			a = "Erreur BD SQL.";
		}
		else if (d == "-er-fn100-")
		{
			a = "Login invalide.";
		}
		else if (d == "-er-fn101-")
		{
			a = "Questionnaire ou ID invalide.";
			getobj(_wins[4], "BTN", 46).xval = "U";
		}
		else
		{
			a = "Erreur : " + d.substr(4,5);
		}
		alert(_wins[0], a, "");
	}
}

private function actdbioerror(e:IOErrorEvent):void
{
	hidepreloader();
	_actloader.removeEventListener(Event.COMPLETE, actdbposted);
	_actloader.removeEventListener(IOErrorEvent.IO_ERROR, actdbioerror);
	_actloader = null;
	//_actrequest = null;
	//_actdbvars  = null;
	alert(_wins[0], "Erreur BD I/O.", "");
}

private function actiondb(d:String):void
{
	var i, j, k, v, wi, da, s, a, ox, lst, rec, pv;
	da = d.substr(0, 10);
	if (da == "-ok-fn100-")		//login ok
	{
		d = d.substr(10);
		_curuser = d.split("¦");
		showwin(_wins[6], false, 1, 0);
		showblocker(false);
		if (_curuser[3] == "PAR" || _curuser[3] == "POT")
		{
			alert(_wins[0], "Access réfusé.", "");
			return;
		}
		_logged = true;
		getobj(_wins[4], "BTN", 52).visible = false;
		//changelabtxt(getobj(_wins[4], "BTN", 52), "Login", "Logout");
		ox = _main.getChildAt(1);
		if (ox != null) { TweenMax.to(ox, .3, { alpha:.1 } ); }
		dbloadquest("", _queparti);			//_queparti from url text !!!
	}
	else if (da == "-ok-fn101-")		//quest selection ok
	{
		d = d.substr(10);
		_queparti = d.split("¦");
		pv = "fn402¦" + _curquest + "¦" + _queparti[0];
		getobj(_wins[5], "LAB", 60).labtext = "Questionnaire : " + _curquest + "    Participant : " + _queparti[3] + " " + _queparti[4] + "    IPC : " + _queparti[1];
		actdbpost(_apppath + "dbactions.php", pv);			//load questionnaire answers
	}
	else if (da == "-ok-fn401-")		//answers saved ok
	{
		d = d.substr(11);
		da = d.split("¦");
		makeactivity();
	}
	else if (da == "-ok-fn402-")		//answers loaded ok
	{
		d = d.substr(11);
		da = d.split("¦");
		questclearansw();
		if (da[0].length > 0) { questfillansw(da[0]); }
		_mapdata = da[2];
		trace(_mapdata)
		_wins[8].holder.y = _wins[8].holdermask.y;
		_wins[8].scrlbarv.percent = 0;
		makewinlayout(_wins[8], _qnav[_curqpg]);				//refresh quest page
		fitwin(_wins[8], 0)
		showwin(_wins[8], true, 0, 0);
	}
}


//----------------------------------------------------------------misc functions

private function getnewuserid():void
{
	var pfx, pv;
	pfx = arguments[0];
	pv = "fn112¦" + pfx;				//load answers	
	actdbpost(_apppath + "dbactions.php", pv);
}

private function showpopimage(fa:Array, ww, hh):void
{
	var ox;
	showblocker(true);
	_wins[3].resizewin(ww + 20, Math.min(hh + 20, _blocker.height * .9));
	ox = getobj(_wins[3], "IMG", 45);
	ox.setpics(fa);
	pozwin(_wins[3], true, true, 0, 0, false, 0);
	showwin(_wins[3], true, 1, 0);
}


//------------------------------------------------------------ activities


private function makeactivity():void
{
	var pfx, pv;
	pfx = arguments[0];
	pv = "fn500¦" + pfx;				//load answers	
	actdbpost(_apppath + "dbactions.php", pv);
}

