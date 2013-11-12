
private function map2quest(par)		//external interface
{
	var i, j, o, t, a1, a2, a3, v1, v2, v3;
	var win = _wins[8];
	//trace("page: ", _curqpg)
	if (par.length < 20) { return; }
	_mapdata = par;		//_mapdata info
	a2 = [];
	a3 = [];
	a1 = par.split("◘");		//all favs, all pages
	for (i = 0; i < a1.length; ++i) 	//isolate current page array
	{
		a1[i] = a1[i].split("•");
		if (_curqpg == parseInt(a1[i][2]))
		{
			if (a1[i][6] != "L") { a2.push(a1[i]); }
			a3.push(a1[i].join("•"));
		}
	}
	switch(_curqpg)		//questionnaire displayed page number (at page top-left)
	{
		case 1:
			if (a2.length > 0)
			{
				getobj(win, "INP", 215).xval = a2[0][16];
				getobj(win, "INP", 216).xval = a2[0][17];
			}
			v1 = a3.join("◘");
			getobj(win, "LAB", 276).labtext = v1;
			break;
		case 3:
			if (a2.length > 0)
			{
				getobj(win, "INP", 321).xval = a2[0][16];
				getobj(win, "INP", 322).xval = a2[0][17];
			}
			v1 = a3.join("◘");
			getobj(win, "LAB", 342).labtext = v1;
			break;
		case 4:
			if (a2.length > 0)
			{
				getobj(win, "INP", 360).xval = a2[0][16];
				getobj(win, "INP", 361).xval = a2[0][17];
			}
			v1 = a3.join("◘");
			getobj(win, "LAB", 364).labtext = v1;
			break;
		case 5:
			if (a2.length > 0)
			{
				getobj(win, "INP", 412).xval = a2[0][16];
				getobj(win, "INP", 413).xval = a2[0][17];
			}
			v1 = a3.join("◘");
			getobj(win, "LAB", 478).labtext = v1;
			break;
		case 7:	
		case 8:
		case 9:
		case 10:	
		case 11:	
		case 12:	
		case 13:	
		case 14:	
		case 15:	
		case 16:	
		case 17:	
		case 18:	
		case 19:	
		case 20:	
		case 21:	
		case 22:	
		case 23:	
		case 24:	
		case 25:	
		case 26:	
		case 27:	
		case 28:	
		case 29:	
		case 30:	
		case 31:	
			if (a2.length > 0)
			{
				getobj(win, "INP", 553 + (_curqpg - 7) * 50).xval = a2[0][16] + ", " + a2[0][17];
			}
			v1 = a3.join("◘");
			getobj(win, "LAB",  578 + (_curqpg - 7) * 50).labtext = v1;
			break;
		case 32:
			v1 = a3.join("◘");
			getobj(win, "LAB", 1855).labtext = v1;
			break;
		case 33:
			v1 = a3.join("◘");
			getobj(win, "LAB", 1918).labtext = v1;
			break;
		case 34:
			v1 = a3.join("◘");
			getobj(win, "LAB", 1961).labtext = v1;
			break;
		case 35:
			v1 = a3.join("◘");
			getobj(win, "LAB", 1999).labtext = v1;
			break;
		case 36:
			v1 = a3.join("◘");
			getobj(win, "LAB", 2033).labtext = v1;
			break;
		case 37:
			v1 = a3.join("◘");
			getobj(win, "LAB", 2048).labtext = v1;
			break;
		default:
			break;
	}
}

private function questadjustform():void
{
	var i, j, o, t, a, a1, a2, a3, v, v1, v2, v3, fl;
	var win = _wins[8];
	//trace("page: ", _curqpg)
	switch(_curqpg)
	{
		case 1:		//page 1
			o = getobj(win, "STP", 237);
			if (isempty(o.xval)) { o.xval = "Myself"; }
			o = getobj(win, "INP", 236);
			if (isempty(o.xval)) { o.xval = 0; }
			o = getobj(win, "STP", 229);
			if (isempty(o.xval)) { o.xval = 1; }
			v1 = int(o.xval);
			j = 0
			for (i = 1; i <= 10; i++)
			{
				getobj(win, "INP", 236 + j).visible = (i <= v1);
				getobj(win, "STP", 237 + j).visible = (i <= v1);
				getobj(win, "RAD", 238 + j).visible = (i <= v1);
				getobj(win, "RAD", 239 + j).visible = (i <= v1);
				j += 4;
			}
			break;
			
		case 2:		//page 2
			if (_qnavkey == "NEXT") 
			{
				a1 = getobjprops("OBJ_INP_215");
				v1 = a1[64];
				a2 = getobjprops("OBJ_INP_216");
				v2 = a2[64];
				getobj(win, "LAB", 294).labtext = v1;
				getobj(win, "LAB", 295).labtext = v2;
			}
			break;
			
		case 3:		//page 3
			if (_qnavkey == "NEXT") 
			{
				if (isempty(getobj(win, "INP", 321).xval))
				{
					a1 = getobjprops("OBJ_INP_215"); getobj(win, "INP", 321).xval = a1[64];
					a1 = getobjprops("OBJ_INP_216"); getobj(win, "INP", 322).xval = a1[64];
					a1 = getobjprops("OBJ_CHK_217"); getobj(win, "CHK", 323).xval = a1[64];
				}
				a1 = getobjprops("OBJ_RAD_298"); v1 = a1[64];	
				a2 = getobjprops("OBJ_RAD_301"); v2 = a2[64];	
				a3 = getobjprops("OBJ_RAD_304"); v3 = a3[64];
				v = (v1 == 1 && v2 == 1 && v3 == 1);
				if (v)
				{
					getobj(win, "CHK", 319).xval = 1;
					disableobj(win, "IMG", 317);
					//disableobj(win, "LAB", 318);
					//disableobj(win, "CHK", 319);
					getobj(win, "LAB", 320).visible = false; 
					disableobj(win, "CHK", 323);
					//disableobj(win, "CHK", 323);
					disableobj(win, "INP", 321);			
					disableobj(win, "INP", 322);			
				}
				if (isempty(getobj(win, "STP", 326).xval)) { getobj(win, "STP", 326).xval = 7; }
			}	
			break;
			
		case 5:		//page 5
			if (_qnavkey == "NEXT") 
			{
				if (isempty(getobj(win, "INP", 412).xval))
				{
					a1 = getobjprops("OBJ_INP_360"); getobj(win, "INP", 412).xval = a1[64];
					a1 = getobjprops("OBJ_INP_361"); getobj(win, "INP", 413).xval = a1[64];
					a1 = getobjprops("OBJ_CHK_362"); getobj(win, "CHK", 414).xval = a1[64];
					//a1 = getobjprops("OBJ_CHK_362"); getobj(win, "CHK", 414).xval = a1[64];
				}				
				o = getobj(win, "STP", 425);
				if (isempty(o.xval)) { o.xval = "Myself"; }
				o = getobj(win, "INP", 424);
				if (isempty(o.xval)) { o.xval = 0; }
				o = getobj(win, "STP", 417);
				if (isempty(o.xval)) { o.xval = 1; }
				v1 = int(o.xval);
				j = 0
				for (i = 1; i <= 10; i++)
				{
					getobj(win, "INP", 424 + j).visible = (i <= v1);
					getobj(win, "STP", 425 + j).visible = (i <= v1);
					getobj(win, "RAD", 426 + j).visible = (i <= v1);
					getobj(win, "RAD", 427 + j).visible = (i <= v1);
					j += 4;
				}
			}
			if (isempty(getobj(win, "STP", 465).xval)) { getobj(win, "STP", 465).xval = 7; }
			break;
			
		case 6:
			break;

		case 7:		//pg 7
			fl = [548,549,551,552,553,555,557,558,559,561,562,563,564,565,566,567,569,570,572,573,574,575,576,577,578,586];
			questadjustformxtra(fl, win);
			break;

		case 8:        //pg 8
			fl = [598,599,601,602,603,605,607,608,609,611,612,613,614,615,616,617,619,620,622,623,624,625,626,627,628,636];
			questadjustformxtra(fl, win);
			break;

		case 9:        //pg 9
			fl = [648,649,651,652,653,655,657,658,659,661,662,663,664,665,666,667,669,670,672,673,674,675,676,677,678,686];
			questadjustformxtra(fl, win);
			break;

		case 10:        //pg 10
			fl = [698,699,701,702,703,705,707,708,709,711,712,713,714,715,716,717,719,720,722,723,724,725,726,727,728,736];
			questadjustformxtra(fl, win);
			break;

		case 11:        //pg 11 ok
			fl = [748,749,751,752,753,755,757,758,759,761,762,763,764,765,766,767,769,770,772,773,774,775,776,777,778,786];
			questadjustformxtra(fl, win);
			break;

		case 12:        //pg 12
			fl = [798,799,801,802,803,805,807,808,809,811,812,813,814,815,816,817,819,820,822,823,824,825,826,827,828,836];
			questadjustformxtra(fl, win);
			break;

		case 13:        //pg 13
			fl = [848,849,851,852,853,855,857,858,859,861,862,863,864,865,866,867,869,870,872,873,874,875,876,877,878,886];
			questadjustformxtra(fl, win);
			break;

		case 14:        //pg 14
			fl = [898,899,901,902,903,905,907,908,909,911,912,913,914,915,916,917,919,920,922,923,924,925,926,927,928,936];
			questadjustformxtra(fl, win);
			break;

		case 15:        //pg 15
			fl = [948,949,951,952,953,955,957,958,959,961,962,963,964,965,966,967,969,970,972,973,974,975,976,977,978,986];
			questadjustformxtra(fl, win);
			break;

		case 16:        //pg 16
			fl = [998,999,1001,1002,1003,1005,1007,1008,1009,1011,1012,1013,1014,1015,1016,1017,1019,1020,1022,1023,1024,1025,1026,1027,1028,1036];
			questadjustformxtra(fl, win);
			break;

		case 17:        //pg 17
			fl = [1048,1049,1051,1052,1053,1055,1057,1058,1059,1061,1062,1063,1064,1065,1066,1067,1069,1070,1072,1073,1074,1075,1076,1077,1078,1086];
			questadjustformxtra(fl, win);
			break;

		case 18:        //pg 18
			fl = [1098,1099,1101,1102,1103,1105,1107,1108,1109,1111,1112,1113,1114,1115,1116,1117,1119,1120,1122,1123,1124,1125,1126,1127,1128,1136];
			questadjustformxtra(fl, win);
			break;

		case 19:        //pg 19
			fl = [1148,1149,1151,1152,1153,1155,1157,1158,1159,1161,1162,1163,1164,1165,1166,1167,1169,1170,1172,1173,1174,1175,1176,1177,1178,1186];
			questadjustformxtra(fl, win);
			break;

		case 20:        //pg 20
			fl = [1198,1199,1201,1202,1203,1205,1207,1208,1209,1211,1212,1213,1214,1215,1216,1217,1219,1220,1222,1223,1224,1225,1226,1227,1228,1236];
			questadjustformxtra(fl, win);
			break;

		case 21:        //pg 21
			fl = [1248,1249,1251,1252,1253,1255,1257,1258,1259,1261,1262,1263,1264,1265,1266,1267,1269,1270,1272,1273,1274,1275,1276,1277,1278,1286];
			questadjustformxtra(fl, win);
			break;

		case 22:        //pg 22
			fl = [1298,1299,1301,1302,1303,1305,1307,1308,1309,1311,1312,1313,1314,1315,1316,1317,1319,1320,1322,1323,1324,1325,1326,1327,1328,1336];
			questadjustformxtra(fl, win);
			break;

		case 23:        //pg 23
			fl = [1348,1349,1351,1352,1353,1355,1357,1358,1359,1361,1362,1363,1364,1365,1366,1367,1369,1370,1372,1373,1374,1375,1376,1377,1378,1386];
			questadjustformxtra(fl, win);
			break;

		case 24:        //pg 24
			fl = [1398,1399,1401,1402,1403,1405,1407,1408,1409,1411,1412,1413,1414,1415,1416,1417,1419,1420,1422,1423,1424,1425,1426,1427,1428,1436];
			questadjustformxtra(fl, win);
			break;

		case 25:        //pg 25
			fl = [1448,1449,1451,1452,1453,1455,1457,1458,1459,1461,1462,1463,1464,1465,1466,1467,1469,1470,1472,1473,1474,1475,1476,1477,1478,1486];
			questadjustformxtra(fl, win);
			break;

		case 26:        //pg 26
			fl = [1498,1499,1501,1502,1503,1505,1507,1508,1509,1511,1512,1513,1514,1515,1516,1517,1519,1520,1522,1523,1524,1525,1526,1527,1528,1536];
			questadjustformxtra(fl, win);
			break;

		case 27:        //pg 27
			fl = [1548,1549,1551,1552,1553,1555,1557,1558,1559,1561,1562,1563,1564,1565,1566,1567,1569,1570,1572,1573,1574,1575,1576,1577,1578,1586];
			questadjustformxtra(fl, win);
			break;

		case 28:        //pg 28
			fl = [1598,1599,1601,1602,1603,1605,1607,1608,1609,1611,1612,1613,1614,1615,1616,1617,1619,1620,1622,1623,1624,1625,1626,1627,1628,1636];
			questadjustformxtra(fl, win);
			break;

		case 29:        //pg 29
			fl = [1648,1649,1651,1652,1653,1655,1657,1658,1659,1661,1662,1663,1664,1665,1666,1667,1669,1670,1672,1673,1674,1675,1676,1677,1678,1686];
			questadjustformxtra(fl, win);
			break;

		case 30:        //pg 30
			fl = [1698,1699,1701,1702,1703,1705,1707,1708,1709,1711,1712,1713,1714,1715,1716,1717,1719,1720,1722,1723,1724,1725,1726,1727,1728,1736];
			questadjustformxtra(fl, win);
			break;

		case 31:        //pg 31
			fl = [1748,1749,1751,1752,1753,1755,1757,1758,1759,1761,1762,1763,1764,1765,1766,1767,1769,1770,1772,1773,1774,1775,1776,1777,1778,1786];
			questadjustformxtra(fl, win);
			break;
			
		default:
			break;
	}
	
}

function questadjustformxtra(fl, win)
{
	if (_qnavkey == "NEXT") 
	{
		try { getobj(win, "INP", fl[4]).inp.wordWrap = false; } catch (er) { }
		
	}
}

private function questbizrules(ob, obn, win):void
{
	var i, l, j, a, v, v1, v2, ox, yy, mf, tout, ut, vt;
	var a1, a2, a3, a4, a5, a6;
	ut = _curuser[3];		//user type (author, admin, interviewer, etc.
	//trace(_curqpg);
	var obv = parseInt(obn.substr(4));
	switch(obn)		//btn clicked
	{
		//case "IMG_401":			//show pop image pg 1
			//showpopimage(["media/pic2.jpg", "", ""], 500, 500);
			//showpopimage(["media/test1.swf", "", ""], 500, 500);
			//break;
	//---------------------------------------------------------------- map launch buttons	
			
		case "IMG_213":			//show map pg 1 ...
		case "IMG_317":			
		case "IMG_358":			
		case "IMG_408":			
		case "IMG_546":
		case "IMG_596":
		case "IMG_646":
		case "IMG_696":
		case "IMG_746":
		case "IMG_796":
		case "IMG_846":
		case "IMG_896":
		case "IMG_946":
		case "IMG_996":
		case "IMG_1046":
		case "IMG_1096":
		case "IMG_1146":
		case "IMG_1196":
		case "IMG_1246":
		case "IMG_1296":
		case "IMG_1346":
		case "IMG_1396":
		case "IMG_1446":
		case "IMG_1496":
		case "IMG_1546":
		case "IMG_1596":	
		case "IMG_1646":
		case "IMG_1696":
		case "IMG_1746":
		case "IMG_1796":
		case "IMG_1873":
		case "IMG_1936":
		case "IMG_1974":
		case "IMG_2010":
		case "IMG_2044":
			if (ut != "INT") { return; }
			a1 = [ null, 276, null, 342, 364, 478, null, 578, 628, 678, 728, 778, 828, 878, 928, 978, 1028, 1078, 1128, 1178, 1228, 1278, 1328, 1378, 1428, 1478, 1528, 1578, 1628, 1678, 1728, 1778, 1855, 1918, 1961, 1999, 2033, 2048];		//page 7 to 32
			a2 = [ null, 1, null, 1, 1, 1, null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 99, 99, 99, 99, 99, 99, 99];		//page 7 to 32
			if (!_mapgen) 
			{ 
				_mapgen = true; 
				v = "T|" + _curqpg + "|" + a2[_curqpg] + "|" + getobj(win, "LAB", a1[_curqpg]).labtext + "|" + _mapdata;
			}
			else 
			{
				v = "|" + _curqpg + "|" + a2[_curqpg] + "|" + getobj(win, "LAB", a1[_curqpg]).labtext + "|";
			}
			ExternalInterface.call("showmap", v)
			_mapon = true;
			break;
			
		//-------------------------------------------------	
			
		case "BTN_211":			//next quest page
		case "BTN_291":
		case "BTN_315":
		case "BTN_356":
		case "BTN_406":
		case "BTN_494":
		case "BTN_544":
		case "BTN_594":
		case "BTN_644":
		case "BTN_694":
		case "BTN_744":
		case "BTN_794":
		case "BTN_844":
		case "BTN_894":
		case "BTN_944":
		case "BTN_994":
		case "BTN_1044":
		case "BTN_1094":
		case "BTN_1144":
		case "BTN_1194":
		case "BTN_1244":
		case "BTN_1294":
		case "BTN_1344":
		case "BTN_1394":
		case "BTN_1444":
		case "BTN_1494":
		case "BTN_1544":
		case "BTN_1594":
		case "BTN_1644":
		case "BTN_1694":
		case "BTN_1744":
		case "BTN_1794":
		case "BTN_1871":
		case "BTN_1934":
		case "BTN_1972":
		case "BTN_2008":
		case "BTN_2042":
		case "BTN_2057":
			_qnavkey = "NEXT";
			if (ut == "INT")
			{
				if (!questvalidpage()) { alert(_wins[0], _alertmsg1, ""); return; }
				savewindata(win, "NEXT", (_curqpg == 1));		//update user on first page only
			}
			if (obn == "BTN_544")
			{
				a1 = [497, 499, 502, 503, 505, 507, 509, 511, 514, 515, 517, 519, 521, 523, 498, 500, 502, 504, 506, 508, 510, 512, 514, 516, 518, 520, 522];
				for (i = 0; i < a1.length; ++i)
				{
					ox = getobj(win, "CHK", a1[i]);
					if (ox.xval == 1)
					{
						a = parseInt(ox.xvar.substr(3, 2)) + 6;
						if (ox.xval == 0) { _qnav[a] = -1; } else { _qnav[a] = _qnavx[a]; }
					}
				}
			}
			if (obn == "BTN_356")
			{
				if (getobj(win, "RAD", 341).xval == 1) { _curqpg += 3; } else { _curqpg++; }
			}
			else if (obn == "BTN_2008")
			{
				if (getobj(win, "RAD", 1998).xval == 1) { _curqpg += 2; } else { _curqpg++; }
			}
			else
			{
				do
				{
					_curqpg++;
				}
				while (_qnav[_curqpg] == -1);
			} 
			if (_curqpg > _qnav.length - 1) { _curqpg = _qnav.length - 1; return; }
			_lastpg = _curqpg;
			vt = Math.round((new Date().getTime() - _visquetim)/1000);
			_visquetim = new Date().getTime();
			_visquepgs += _curqpg + ":" + vt + "-";
			pozwin(win, false, false, -win.vwidth - 2, win.y, 1, .1);
			tout = setTimeout(delaypageload, 600, win, _qnav[_curqpg], "R");
			//ExternalInterface.call("setcurpage", _curqpg + "");
			break;
		case "BTN_210":			//previous quest page
		case "BTN_290":
		case "BTN_314":
		case "BTN_355":
		case "BTN_405":
		case "BTN_493":
		case "BTN_543":
		case "BTN_593":
		case "BTN_643":
		case "BTN_693":
		case "BTN_743":
		case "BTN_793":
		case "BTN_843":
		case "BTN_893":
		case "BTN_943":
		case "BTN_993":
		case "BTN_1043":
		case "BTN_1093":
		case "BTN_1143":
		case "BTN_1193":
		case "BTN_1243":
		case "BTN_1293":
		case "BTN_1343":
		case "BTN_1393":
		case "BTN_1443":
		case "BTN_1493":
		case "BTN_1543":
		case "BTN_1593":
		case "BTN_1643":
		case "BTN_1693":
		case "BTN_1743":
		case "BTN_1793":
		case "BTN_1870":
		case "BTN_1933":
		case "BTN_1971":
		case "BTN_2007":
		case "BTN_2041":
		case "BTN_2056":
			//if (!questvalidpage()) { return; }
			//savewindata(win, "PREV");
			//if (ut == "INT") { return; }
			_qnavkey = "PREV";
			do
			{
				_curqpg--;
			}
			while (_qnav[_curqpg] == -1);
			//_curqpg--;
			if (_curqpg < 0) { _curqpg = 0; return; }
			_lastpg = _curqpg;
			vt = Math.round((new Date().getTime() - _visquetim)/1000);
			_visquetim = new Date().getTime();
			_visquepgs += _curqpg + ":" + vt + "-";
			pozwin(win, false, false, win.parent.width + 2, win.y, 1, .1);
			tout = setTimeout(delaypageload, 600, win, _qnav[_curqpg], "L");
			//ExternalInterface.call("setcurpage", _curqpg + "");
			break;
			
		case "BTN_209":			//interrupt quest page
		case "BTN_289":
		case "BTN_313":
		case "BTN_354":
		case "BTN_404":
		case "BTN_492":
		case "BTN_542":
		case "BTN_592":
		case "BTN_642":
		case "BTN_692":
		case "BTN_742":
		case "BTN_792":
		case "BTN_842":
		case "BTN_892":
		case "BTN_942":
		case "BTN_992":
		case "BTN_1042":
		case "BTN_1092":
		case "BTN_1142":
		case "BTN_1192":
		case "BTN_1242":
		case "BTN_1292":
		case "BTN_1342":
		case "BTN_1392":
		case "BTN_1442":
		case "BTN_1492":
		case "BTN_1542":
		case "BTN_1592":
		case "BTN_1642":
		case "BTN_1692":
		case "BTN_1742":
		case "BTN_1792":
		case "BTN_1869":
		case "BTN_1932":
		case "BTN_1970":
		case "BTN_2006":
		case "BTN_2040":
		case "BTN_2055":
			if (ut != "INT") { return; }
			_qnavkey = "Q";
			vt = Math.round((new Date().getTime() - _visquetim)/1000);
			_visquetim = new Date().getTime();
			_visquepgs += "QI:" + vt + "-";
			savewindata(win, "QUIT", true);
			_alertact = "QUIT"
			alert(_wins[1], "Would you like to interrupt the questionnaire?", "")
			break;
			
		case "BTN_208":			//abandon quest page
		case "BTN_288":
		case "BTN_312":
		case "BTN_353":
		case "BTN_403":
		case "BTN_491":
		case "BTN_541":
		case "BTN_591":
		case "BTN_641":
		case "BTN_691":
		case "BTN_741":
		case "BTN_791":
		case "BTN_841":
		case "BTN_891":
		case "BTN_941":
		case "BTN_991":
		case "BTN_1041":
		case "BTN_1091":
		case "BTN_1141":
		case "BTN_1191":
		case "BTN_1241":
		case "BTN_1291":
		case "BTN_1341":
		case "BTN_1391":
		case "BTN_1441":
		case "BTN_1491":
		case "BTN_1541":
		case "BTN_1591":
		case "BTN_1641":
		case "BTN_1691":
		case "BTN_1741":
		case "BTN_1791":
		case "BTN_1868":
		case "BTN_1931":
		case "BTN_1969":
		case "BTN_2005":
		case "BTN_2039":
		case "BTN_2054":
			if (ut != "INT") { return; }
			_qnavkey = "A";
			vt = Math.round((new Date().getTime() - _visquetim)/1000);
			_visquetim = new Date().getTime();
			_visquepgs += "ABA:" + vt + "-";
			savewindata(win, "ABAN", true);
			_alertact = "ABAN"
			alert(_wins[1], "Would you like to abandon the questionnaire?", "")
			break;
			//pozwin(win, false, false, win.parent.width + 2, win.y, 1, .1);
			//tout = setTimeout(delaypageload, 600, win, _qnav[_curqpg], "L");
			break;
			 
		case "BTN_2061":			//button END OF SESSION completed
			if (ut != "INT") { return; }
			getobj(_wins[4], "BTN", 46).xval = "U";
			vt = Math.round((new Date().getTime() - _visquetim)/1000);
			_visquetim = new Date().getTime();
			_visquepgs += "COM:" + vt + "-";
			showwin(_wins[8], false, 1, 0);
			savewindata(win, "FCOM", true);
			questsaveansw("COMP");
			break;
			
			
		case "BTN_2065":			//button END OF SESSION abandoned
			if (ut != "INT") { return; }
			getobj(_wins[4], "BTN", 46).xval = "U";
			vt = Math.round((new Date().getTime() - _visquetim)/1000);
			_visquetim = new Date().getTime();
			_visquepgs += "ABA:" + vt + "-";
			showwin(_wins[8], false, 1, 0);
			savewindata(win, "FABA", true);
			questsaveansw("ABA");
			break;
			
	//--------------------------------------------------------------- in page objects behaviour
	
		//quest pg 1
		case "RAD_221":
		case "RAD_222":
		case "RAD_223":
		case "RAD_226":
		case "RAD_227":
			getobj(win, "INP", 225).xval = "";
			break;
		case "STP_229":			//people show details
			if (ob.xval > 10) { ob.xval = 10; } else if (isempty(ob.xval) || ob.xval < 1) { ob.xval = 1; }
			v = int(ob.xval);
			j = 0
			for (i = 1; i <= 10; i++)
			{
				getobj(win, "INP", 236 + j).visible = (i <= v);
				getobj(win, "STP", 237 + j).visible = (i <= v);
				getobj(win, "RAD", 238 + j).visible = (i <= v);
				getobj(win, "RAD", 239 + j).visible = (i <= v);
				j += 4;
			}
			break;
		case  "CHK_217":
			if (ob.xval == 1)
			{
				getobj(win, "INP", 215).xval = ""; getobj(win, "INP", 216).xval = "";
			}
			break;
			

		//quest pg 2
			//no actions
			
			
		//quest pg 3
		case  "CHK_319":
			if (ob.xval == 0)
			{
				getobj(win, "LAB", 320).visible = true; 
				enableobj(win, "IMG", 317); 
				enableobj(win, "INP", 321);
				enableobj(win, "INP", 322); 
				enableobj(win, "CHK", 323); 
			}
			else
			{
				getobj(win, "LAB", 320).visible = false; 
				disableobj(win, "IMG", 317); 
				disableobj(win, "INP", 321);
				disableobj(win, "INP", 322);
				disableobj(win, "CHK", 323); 
			}
			break;
		case  "STP_326":
			v = int(ob.xval);
			if (v > 31) { ob.xval = 31; } else if (v < 1) { ob.xval = 1; }
			break;
			
			
		//quest pg 4
		case  "CHK_362":
			if (ob.xval == 1)
			{
				getobj(win, "INP", 360).xval = ""; getobj(win, "INP", 361).xval = "";
			}
			break;
			
		//quest pg 5
		case "CHK_410":
			if (ob.xval == 0)
			{
				getobj(win, "LAB", 411).visible = true; 
				enableobj(win, "IMG", 408);
				enableobj(win, "INP", 412);
				enableobj(win, "INP", 413); 
				enableobj(win, "CHK", 414); 
			}
			else
			{
				getobj(win, "LAB", 411).visible = false; 
				disableobj(win, "IMG", 408); 
				disableobj(win, "INP", 412); 
				disableobj(win, "INP", 413); 
				disableobj(win, "CHK", 414); 
			}
			break;
		case "STP_417":			//another place
			if (ob.xval > 10) { ob.xval = 10; } else if (isempty(ob.xval) || ob.xval < 1) { ob.xval = 1; }
			v = int(ob.xval);
			j = 0
			for (i = 1; i <= 10; i++)
			{
				getobj(win, "INP", 424 + j).visible = (i <= v);
				getobj(win, "STP", 425 + j).visible = (i <= v);
				getobj(win, "RAD", 426 + j).visible = (i <= v);
				getobj(win, "RAD", 427 + j).visible = (i <= v);
				j += 4;
			}
			break;
		case "STP_465":			//time spent
			v = int(ob.xval);
			if (v > 31) { ob.xval = 31; } else if (v < 1) { ob.xval = 1; }
			break;
			
		//quest pg 6
		/*
		case "CHK_497":
		case "CHK_499":
		case "CHK_502":
		case "CHK_503":
		case "CHK_505":
		case "CHK_507":
		case "CHK_509":
		case "CHK_511":
		case "CHK_514":
		case "CHK_515":
		case "CHK_517":
		case "CHK_519":
		case "CHK_521":
		case "CHK_523":
		case "CHK_498":
		case "CHK_500":
		case "CHK_502":
		case "CHK_504":
		case "CHK_506":
		case "CHK_508":
		case "CHK_510":
		case "CHK_512":
		case "CHK_514":
		case "CHK_516":
		case "CHK_518":
		case "CHK_520":
		case "CHK_522":
			a = parseInt(ob.xvar.substr(3, 2)) + 6;
			if (ob.xval == 0) { _qnav[a] = -1; } else { _qnav[a] = _qnavx[a]; }
			break;
		*/
			
		
		//quest pg 7, ..., 32
		
		case "RAD_551":
		case "RAD_601":
		case "RAD_651":
		case "RAD_701":
		case "RAD_751":
		case "RAD_801":
		case "RAD_851":
		case "RAD_901":
		case "RAD_951":
		case "RAD_1001":
		case "RAD_1051":
		case "RAD_1101":
		case "RAD_1151":
		case "RAD_1201":
		case "RAD_1251":
		case "RAD_1301":
		case "RAD_1351":
		case "RAD_1401":
		case "RAD_1451":
		case "RAD_1501":
		case "RAD_1551":
		case "RAD_1601":
		case "RAD_1651":
		case "RAD_1701":
		case "RAD_1751":
			enableobj(win, "INP", obv+2);
			enableobj(win, "IMG", obv-5);
			break;	

		case "RAD_552":
		case "RAD_602":
		case "RAD_652":
		case "RAD_702":
		case "RAD_752":
		case "RAD_802":
		case "RAD_852":
		case "RAD_902":
		case "RAD_952":
		case "RAD_1002":
		case "RAD_1052":
		case "RAD_1102":
		case "RAD_1152":
		case "RAD_1202":
		case "RAD_1252":
		case "RAD_1302":
		case "RAD_1352":
		case "RAD_1402":
		case "RAD_1452":
		case "RAD_1502":
		case "RAD_1552":
		case "RAD_1602":
		case "RAD_1652":
		case "RAD_1702":
		case "RAD_1752":
			disableobj(win, "INP", obv+1);
			disableobj(win, "IMG", obv-6);
			break;	
		
		case "RAD_1801":
			enableobj(win, "IMG", obv-5);
			break;
			
		case "RAD_1802":
			disableobj(win, "IMG", obv-6);
			break;	
			
		// page 33	
		case "RAD_1878":
			enableobj(win, "IMG", obv-5);
			break;
		case "RAD_1879":
			disableobj(win, "IMG", obv-6);
			break;	
		case "CHK_1892":
		case "CHK_1906":
		case "CHK_1915":
			if (ob.xval == 1) { enableobj(win, "INP", obv+1); } else { disableobj(win, "INP", obv+1); getobj(win, "INP", obv+1).xval = ""; }
			break;
			
		//page 34
		case "RAD_1938":
			enableobj(win, "IMG", obv-2);
			break;
		case "RAD_1939":
			disableobj(win, "IMG", obv-3);
			break;
			
		//page 35-37
		case "RAD_1976":
		case "RAD_2012":
		case "RAD_2046":
			enableobj(win, "IMG", obv-2);
			break;
		case "RAD_1977":
		case "RAD_2013":
		case "RAD_2047":
			disableobj(win, "IMG", obv-3);
			break;
			
		default:
			break;
	}
}

private function questvalidpage():Boolean
{
	//if (_curqpg > 8 && _curqpg < 31) { return true; }
	
	var i, j, a, a1, a2, a3, o1, o2, t, v, v1, v2, v3, fl;
	var win = _wins[8];
	switch(_curqpg)
	{
		case 0:		//pg 0 intro
			if (getobj(win, "STA", 204).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
			break;
		case 1:		//pg 1
			v1 = getobj(win, "INP", 215).xval;
			if (isempty(v1))
			{
				if(getobj(win, "CHK", 217).xval == 0) { _alertmsg1 = "Please fill in the address in question Q1a."; return false; }
			}
			else
			{
				//if (isNaN(v1.substr(0, 1)))
				if (v1.length < 6)
				{
					if (getobj(win, "CHK", 217).xval == 0) { _alertmsg1 = "Please answer properly the question Q1a."; return false; } else { getobj(win, "INP", 215).xval = getobj(win, "INP", 216).xval = ""; }
				}
			}
			a = [221, 222, 223, 224, 225];
			j = false;
			for (i = 0; i < a.length; ++i)
			{
				if(getobj(win, "RAD", a[i]).xval == 1) { j = true; break;}
			}
			if (!j) { _alertmsg1 = "Please answer properly the question Q1b."; return false; }
			if (getobj(win, "RAD", 225).xval == 1 && isempty(getobj(win, "INP", 226).xval)) { _alertmsg1 = "Please answer properly the question Q1b."; return false; }
			j = 0;
			for (i = 1; i <= 10; ++i)
			{
				o1 = getobj(win, "INP", 236 + j);
				if (o1.visible && isempty(o1.xval)) { _alertmsg1 = "Please fill in all required info for the question Q1d."; return false; }
				o1 = getobj(win, "STP", 237 + j);
				if (o1.visible && isempty(o1.xval)) { _alertmsg1 = "Please fill in all required info for the question Q1d."; return false; }
				o1 = getobj(win, "RAD", 238 + j);
				o2 = getobj(win, "RAD", 239 + j);
				if (o1.visible && o1.xval == 0 && o2.xval == 0 ) { _alertmsg1 = "Please fill in all required info for the question Q1d."; return false; }
				j += 4;
			}
			if (getobj(win, "STA", 283).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
			break;
			
		case 2:		//pg 2
			//v1 = getobj(win, "LAB", 493).labtext;
			//if (isempty(v1)) { _alertmsg1 = "Please fill in the address in question Q2a."; return false; }
			j = 0;
			for (i = 0; i < 3; ++i)
			{
				o1 = getobj(win, "RAD", 298 + j);
				o2 = getobj(win, "RAD", 299 + j);
				if (o1.xval == 0 && o2.xval == 0 ) { _alertmsg1 = "Please fill in all the 'Yes/No' answers for the question Q2a."; return false; }
				j += 3;
			}
			if (getobj(win, "STA", 307).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
			break;
		case 3:		//pg 3
			v1 = getobj(win, "INP", 321).xval;
			if (isempty(v1))
			{
				if(getobj(win, "CHK", 323).xval == 0) { _alertmsg1 = "Please fill in the address in question Q3a."; return false; }
			}
			else
			{
				//if (isNaN(v1.substr(0, 1)))
				if (v1.length < 6)
				{
					if (getobj(win, "CHK", 323).xval == 0) { _alertmsg1 = "Please answer properly the question Q3a."; return false; } else { getobj(win, "INP", 321).xval = getobj(win, "INP", 322).xval = ""; }
				}
			}
			if(getobj(win, "RAD", 328).xval == 0 && getobj(win, "RAD", 329).xval == 0){_alertmsg1 = "Please choose week or month in question Q3b."; return false; }
			a = [331, 332, 333, 334, 335, 336, 337];
			j = false;
			for (i = 0; i < 7; ++i)
			{
				if(getobj(win, "RAD", a[i]).xval == 1) { j = true; break;}
			}
			if (!j) { _alertmsg1 = "Please choose one value in question Q3c."; return false; }
			if(getobj(win, "RAD", 340).xval == 0 && getobj(win, "RAD", 341).xval == 0){_alertmsg1 = "Please answer question Q3d."; return false; }
			if (getobj(win, "STA", 348).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
			break;
			
		case 4:		//pg 4
			v1 = getobj(win, "INP", 360).xval;
			if (isempty(v1))
			{
				if(getobj(win, "CHK", 362).xval == 0) { _alertmsg1 = "Please fill in the address in question Q4a."; return false; }
			}
			else
			{
				//if (isNaN(v1.substr(0, 1)))
				if (v1.length < 6)
				{
					if (getobj(win, "CHK", 362).xval == 0) { _alertmsg1 = "Please answer correctly the question Q4a."; return false; } else { getobj(win, "INP", 360).xval = getobj(win, "INP", 361).xval = ""; }
				}
			}
			if (getobj(win, "STA", 398).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
			break;
			
		case 5:		//pg 5
			if (getobj(win, "CHK", 410).xval == 0)
			{
				v1 = getobj(win, "INP", 412).xval;
				if (isempty(v1))
				{
					if(getobj(win, "CHK", 414).xval == 0) { _alertmsg1 = "Please fill in the address in question Q1a."; return false; }
				}
				else
				{
					//if (isNaN(v1.substr(0, 1)))
					if (v1.length < 6)
					{
						if (getobj(win, "CHK", 414).xval == 0) { _alertmsg1 = "Please answer correctly the question Q1a."; return false; } else { getobj(win, "INP", 412).xval = getobj(win, "INP", 413).xval = ""; }
					}
				}
			}
			j = 0;
			for (i = 1; i <= 10; ++i)
			{
				o1 = getobj(win, "INP", 424 + j);
				if (o1.visible && isempty(o1.xval)) { _alertmsg1 = "Please fill in all required info for the question Q5c."; return false; }
				o1 = getobj(win, "STP", 425 + j);
				if (o1.visible && isempty(o1.xval)) { _alertmsg1 = "Please fill in all required info for the question Q5c."; return false; }
				o1 = getobj(win, "RAD", 426 + j);
				o2 = getobj(win, "RAD", 427 + j);
				if (o1.visible && o1.xval == 0 && o2.xval == 0 ) { _alertmsg1 = "Please fill in all required info for the question Q5c."; return false; }
				j += 4;
			}
			v1 = getobj(win, "STP", 465).xval;
			v2 = getobj(win, "RAD", 467).xval;
			v3 = getobj(win, "RAD", 468).xval;
			if( v1 != 1 && v2 != 1 ){ _alertmsg1 = "Please fill in all required info for the question Q5d."; return false; }
			if (( v2 == 1 && v1 > 7) || (v3 == 1 && v1 > 31)) { _alertmsg1 = "Please fill in all required info for the question Q5d."; return false; }
			v1 = false;
			for (i = 470; i <= 475; ++i)
			{
				if (getobj(win, "RAD", i).xval == 1) { v1 = true; break; }
			}
			if(!v1){ _alertmsg1 = "Please answer properly the question Q5e."; return false; }
			if (getobj(win, "STA", 486).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
			break;
			
		case 6:		//pg 6
			v1 = false;
			for (i = 497; i <= 523; ++i)
			{
				o1 = getobj(win, "CHK", i);
				if ( o1 != null)
				{
					if (o1.xval == 1) { v1 = true; break; }
				}
			}
			if(!v1){ _alertmsg1 = "Please fill in all required info for the question Q6a."; return false; }			
			if (getobj(win, "STA", 536).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
			break;
			
		case 7:		//pg 7
			fl = [548,549,551,552,553,555,557,558,559,561,562,563,564,565,566,567,569,570,572,573,574,575,576,577,578,586];
			return(questvalidpagereps(win, fl, 7));
			break;

		case 8:        //pg 8
			fl = [598,599,601,602,603,605,607,608,609,611,612,613,614,615,616,617,619,620,622,623,624,625,626,627,628,636];
			return(questvalidpagereps(win, fl, 8));
			break;

		case 9:        //pg 9
			fl = [648,649,651,652,653,655,657,658,659,661,662,663,664,665,666,667,669,670,672,673,674,675,676,677,678,686];
			return(questvalidpagereps(win, fl, 9));
			break;

		case 10:        //pg 10
			fl = [698,699,701,702,703,705,707,708,709,711,712,713,714,715,716,717,719,720,722,723,724,725,726,727,728,736];
			return(questvalidpagereps(win, fl, 10));
			break;

		case 11:        //pg 11 ok
			fl = [748,749,751,752,753,755,757,758,759,761,762,763,764,765,766,767,769,770,772,773,774,775,776,777,778,786];
			return(questvalidpagereps(win, fl, 11));
			break;

		case 12:        //pg 12
			fl = [798,799,801,802,803,805,807,808,809,811,812,813,814,815,816,817,819,820,822,823,824,825,826,827,828,836];
			return(questvalidpagereps(win, fl, 12));
			break;

		case 13:        //pg 13
			fl = [848,849,851,852,853,855,857,858,859,861,862,863,864,865,866,867,869,870,872,873,874,875,876,877,878,886];
			return(questvalidpagereps(win, fl, 13));
			break;

		case 14:        //pg 14
			fl = [898,899,901,902,903,905,907,908,909,911,912,913,914,915,916,917,919,920,922,923,924,925,926,927,928,936];
			return(questvalidpagereps(win, fl, 14));
			break;

		case 15:        //pg 15
			fl = [948,949,951,952,953,955,957,958,959,961,962,963,964,965,966,967,969,970,972,973,974,975,976,977,978,986];
			return(questvalidpagereps(win, fl, 15));
			break;

		case 16:        //pg 16
			fl = [998,999,1001,1002,1003,1005,1007,1008,1009,1011,1012,1013,1014,1015,1016,1017,1019,1020,1022,1023,1024,1025,1026,1027,1028,1036];
			return(questvalidpagereps(win, fl, 16));
			break;

		case 17:        //pg 17
			fl = [1048,1049,1051,1052,1053,1055,1057,1058,1059,1061,1062,1063,1064,1065,1066,1067,1069,1070,1072,1073,1074,1075,1076,1077,1078,1086];
			return(questvalidpagereps(win, fl, 17));
			break;

		case 18:        //pg 18
			fl = [1098,1099,1101,1102,1103,1105,1107,1108,1109,1111,1112,1113,1114,1115,1116,1117,1119,1120,1122,1123,1124,1125,1126,1127,1128,1136];
			return(questvalidpagereps(win, fl, 18));
			break;

		case 19:        //pg 19
			fl = [1148,1149,1151,1152,1153,1155,1157,1158,1159,1161,1162,1163,1164,1165,1166,1167,1169,1170,1172,1173,1174,1175,1176,1177,1178,1186];
			return(questvalidpagereps(win, fl, 19));
			break;

		case 20:        //pg 20
			fl = [1198,1199,1201,1202,1203,1205,1207,1208,1209,1211,1212,1213,1214,1215,1216,1217,1219,1220,1222,1223,1224,1225,1226,1227,1228,1236];
			return(questvalidpagereps(win, fl, 20));
			break;

		case 21:        //pg 21
			fl = [1248,1249,1251,1252,1253,1255,1257,1258,1259,1261,1262,1263,1264,1265,1266,1267,1269,1270,1272,1273,1274,1275,1276,1277,1278,1286];
			return(questvalidpagereps(win, fl, 21));
			break;

		case 22:        //pg 22
			fl = [1298,1299,1301,1302,1303,1305,1307,1308,1309,1311,1312,1313,1314,1315,1316,1317,1319,1320,1322,1323,1324,1325,1326,1327,1328,1336];
			return(questvalidpagereps(win, fl, 22));
			break;

		case 23:        //pg 23
			fl = [1348,1349,1351,1352,1353,1355,1357,1358,1359,1361,1362,1363,1364,1365,1366,1367,1369,1370,1372,1373,1374,1375,1376,1377,1378,1386];
			return(questvalidpagereps(win, fl, 23));
			break;

		case 24:        //pg 24
			fl = [1398,1399,1401,1402,1403,1405,1407,1408,1409,1411,1412,1413,1414,1415,1416,1417,1419,1420,1422,1423,1424,1425,1426,1427,1428,1436];
			return(questvalidpagereps(win, fl, 24));
			break;

		case 25:        //pg 25
			fl = [1448,1449,1451,1452,1453,1455,1457,1458,1459,1461,1462,1463,1464,1465,1466,1467,1469,1470,1472,1473,1474,1475,1476,1477,1478,1486];
			return(questvalidpagereps(win, fl, 25));
			break;

		case 26:        //pg 26
			fl = [1498,1499,1501,1502,1503,1505,1507,1508,1509,1511,1512,1513,1514,1515,1516,1517,1519,1520,1522,1523,1524,1525,1526,1527,1528,1536];
			return(questvalidpagereps(win, fl, 26));
			break;

		case 27:        //pg 27
			fl = [1548,1549,1551,1552,1553,1555,1557,1558,1559,1561,1562,1563,1564,1565,1566,1567,1569,1570,1572,1573,1574,1575,1576,1577,1578,1586];
			return(questvalidpagereps(win, fl, 27));
			break;

		case 28:        //pg 28
			fl = [1598,1599,1601,1602,1603,1605,1607,1608,1609,1611,1612,1613,1614,1615,1616,1617,1619,1620,1622,1623,1624,1625,1626,1627,1628,1636];
			return(questvalidpagereps(win, fl, 28));
			break;

		case 29:        //pg 29
			fl = [1648,1649,1651,1652,1653,1655,1657,1658,1659,1661,1662,1663,1664,1665,1666,1667,1669,1670,1672,1673,1674,1675,1676,1677,1678,1686];
			return(questvalidpagereps(win, fl, 29));
			break;

		case 30:        //pg 30
			fl = [1698,1699,1701,1702,1703,1705,1707,1708,1709,1711,1712,1713,1714,1715,1716,1717,1719,1720,1722,1723,1724,1725,1726,1727,1728,1736];
			return(questvalidpagereps(win, fl, 30));
			break;

		case 31:        //pg 31
			fl = [1748,1749,1751,1752,1753,1755,1757,1758,1759,1761,1762,1763,1764,1765,1766,1767,1769,1770,1772,1773,1774,1775,1776,1777,1778,1786];
			return(questvalidpagereps(win, fl, 31));
			break;
			
		case 32:        //pg 32
			if (getobj(win, "RAD", 1798).xval == 0 && getobj(win, "RAD", 1799).xval == 0 ) { _alertmsg1 = "Please answer properly the question Q33a."; return false; }
			if (getobj(win, "RAD", 1798).xval == 1)
			{
				if (getobj(win, "RAD", 1801).xval == 0 && getobj(win, "RAD", 1802).xval == 0 ) { _alertmsg1 = "Please answer properly the question Q33b."; return false; }
				a1 = [1805, 1806, 1807, 1808, 1809, 1810, 1811, 1812, 1813, 1814, 1815, 1816, 1817, 1818, 1819, 1820, 1821, 1822, 1823, 1824, 1825, 1826, 1827, 1828, 1830];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					//trace( a1[i], getobj(win, "CHK", a1[i]).xval)
					if ( getobj(win, "CHK", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = ( getobj(win, "CHK", 1828).xval == 1 && isempty(getobj(win, "INP", 1829).xval));
				if (!v1 || v2) { _alertmsg1 = "Please answer properly the question Q33c."; return false; }
				a1 = [1838, 1839, 1840, 1841, 1842, 1843];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "CHK", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = ( getobj(win, "CHK", 1843).xval == 1 && isempty(getobj(win, "INP", 1844).xval));
				if (!v1 || v2) { _alertmsg1 = "Please answer properly the question Q33c."; return false; }
				a1 = [1849, 1850, 1851, 1852, 1854];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "CHK", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = ( getobj(win, "CHK", 1852).xval == 1 && isempty(getobj(win, "INP", 1853).xval));
				if (!v1 || v2) { _alertmsg1 = "Please answer properly the question Q33c."; return false; }
			}
			if (getobj(win, "STA", 1863).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
			break;
			
		case 33:        //pg 33
			if (getobj(win, "RAD", 1875).xval == 0 && getobj(win, "RAD", 1876).xval == 0 ){_alertmsg1 = "Please answer properly the question Q33a."; return false; }
			if (getobj(win, "RAD", 1875).xval == 1)
			{
				if (getobj(win, "RAD", 1878).xval == 0 && getobj(win, "RAD", 1879).xval == 0 ){_alertmsg1 = "Please answer properly the question Q33b."; return false; }
				a1 = [1882, 1883, 1884, 1885, 1886, 1887, 1889, 1891, 1892];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "CHK", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = ( getobj(win, "CHK", 1892).xval == 1 && isempty(getobj(win, "INP", 1893).xval) );
				if (!v1 || v2) { _alertmsg1 = "Please answer properly the question Q33c."; return false; }
				
				a1 = [1897, 1898, 1899];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "RAD", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = (getobj(win, "RAD", 1897).xval == 1 && getobj(win, "INP", 1895).xval > 7) || (getobj(win, "RAD", 1898).xval == 1 && getobj(win, "INP", 1895).xval > 31) || (getobj(win, "RAD", 1899).xval == 1 && getobj(win, "INP", 1895).xval > 366)
				if (!v1 || v2) { _alertmsg1 = "Please answer properly the question Q33d."; return false; }
				
				a1 = [1901, 1902, 1903, 1904, 1905, 1906];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "CHK", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = (getobj(win, "CHK", 1906).xval == 1 && isempty(getobj(win, "INP", 1907).xval));
				if (!v1 || v2) { _alertmsg1 = "Please answer properly the question Q33e."; return false; }
				
				a1 = [1912, 1913, 1914, 1915, 1917];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "CHK", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = ( getobj(win, "CHK", 1915).xval == 1 && isempty(getobj(win, "INP", 1916).xval) );
				if(!v1 || v2){_alertmsg1 = "Please answer properly the question Q33f."; return false; }
			}
			if (getobj(win, "STA", 1926).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
			break;
			
		case 34:        //pg 34
			if (getobj(win, "RAD", 1938).xval == 0 && getobj(win, "RAD", 1939).xval == 0 ) { _alertmsg1 = "Please answer properly the question Q34a."; return false; }
			if (getobj(win, "RAD", 1938).xval == 1)
			{
				a1 = [1943, 1944, 1945];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "RAD", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = (getobj(win, "RAD", 1943).xval == 1 && getobj(win, "INP", 1941).xval > 7) || (getobj(win, "RAD", 1944).xval == 1 && getobj(win, "INP", 1941).xval > 31) || (getobj(win, "RAD", 1945).xval == 1 && getobj(win, "INP", 1941).xval > 366)
				if (!v1 || v2) { _alertmsg1 = "Please answer properly the question Q34b."; return false; }
				
				a1 = [1947, 1948, 1949, 1950, 1951, 1952];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "CHK", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = (getobj(win, "CHK", 1952).xval == 1 && isempty(getobj(win, "INP", 1953).xval));
				if (!v1 || v2) { _alertmsg1 = "Please answer properly the question Q34c."; return false; }
				
				a1 = [1955, 1956, 1957, 1958, 1960];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "CHK", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = ( getobj(win, "CHK", 1958).xval == 1 && isempty(getobj(win, "INP", 1959).xval) );
				if(!v1 || v2){_alertmsg1 = "Please answer properly the question Q34d."; return false; }
			}
			if (getobj(win, "STA", 1964).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
			break;
			
		case 35:        //pg 35
			if (getobj(win, "RAD", 1976).xval == 0 && getobj(win, "RAD", 1977).xval == 0 ) { _alertmsg1 = "Please answer properly the question Q35a."; return false; }
			if (getobj(win, "RAD", 1976).xval == 1)
			{
				a1 = [1979, 1980, 1981, 1982, 1983, 1984];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "CHK", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = (getobj(win, "CHK", 1984).xval == 1 && isempty(getobj(win, "INP", 1985).xval));
				if (!v1 || v2) { _alertmsg1 = "Please answer properly the question Q35b."; return false; }
				
				a1 = [1987, 1988, 1989, 1990, 1992];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "CHK", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = ( getobj(win, "CHK", 1990).xval == 1 && isempty(getobj(win, "INP", 1991).xval) );
				if (!v1 || v2) { _alertmsg1 = "Please answer properly the question Q35c."; return false; }
				if (getobj(win, "RAD", 1994).xval == 0 && getobj(win, "RAD", 1995).xval == 0 ) { _alertmsg1 = "Please answer properly the question Q35d."; return false; }
				if (getobj(win, "RAD", 1997).xval == 0 && getobj(win, "RAD", 1998).xval == 0 ) { _alertmsg1 = "Please answer properly the question Q35e."; return false; }
			}
			if (getobj(win, "STA", 2000).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
			break;
			
		case 36:        //pg 36
			if (getobj(win, "RAD", 2012).xval == 0 && getobj(win, "RAD", 2013).xval == 0 ) { _alertmsg1 = "Please answer properly the question Q36a."; return false; }
			if (getobj(win, "RAD", 2012).xval == 1)
			{
				a1 = [2015, 2016, 2017, 2018, 2019, 2020];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "CHK", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = (getobj(win, "CHK", 2020).xval == 1 && isempty(getobj(win, "INP", 2021).xval));
				if (!v1 || v2) { _alertmsg1 = "Please answer properly the question Q36b."; return false; }
				
				a1 = [2023, 2024, 2025, 2026, 2028];
				v1 = false;
				for (i = 0; i < a1.length; ++i)
				{
					if ( getobj(win, "CHK", a1[i]).xval == 1) { v1 = true; break; }
				}
				v2 = ( getobj(win, "CHK", 2026).xval == 1 && isempty(getobj(win, "INP", 2027).xval) );
				if (!v1 || v2) { _alertmsg1 = "Please answer properly the question Q36c."; return false; }
				if (getobj(win, "RAD", 2030).xval == 0 && getobj(win, "RAD", 2031).xval == 0 ) { _alertmsg1 = "Please answer properly the question Q36d."; return false; }
			}
			if (getobj(win, "STA", 2034).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
			break;

		case 37:        //pg 37
			if (getobj(win, "RAD", 2046).xval == 0 && getobj(win, "RAD", 2047).xval == 0 ) { _alertmsg1 = "Please answer properly the question Q37a."; return false; }
			break;

		default:
			break;
	}
	return true;
}

private function questvalidpagereps(wi, f, pg):Boolean
{
	//f = [548,549,551,552,553,555,557,558,559,561,562,563,564,565,566,567,569,570,572,573,574,575,576,577,578,586];
	var i, j, a, a1, a2, a3, o1, o2, t, v, v1, v2, v3;
	if (getobj(wi, "RAD", f[0]).xval == 0 && getobj(wi, "RAD", f[1]).xval == 0 )
	{ 
		_alertmsg1 = "Please answer correctly the question Q" + pg + "a."; return false; 
	}
	else
	{
		if (getobj(wi, "RAD", f[1]).xval == 0)
		{
			if (getobj(wi, "RAD", f[2]).xval == 0 && getobj(wi, "RAD", f[3]).xval == 0 ) { _alertmsg1 = "Please answer correctly the question Q" + pg + "b."; return false; }
			v1 = getobj(wi, "INP", f[4]).xval;
			if (getobj(wi, "RAD", f[2]).xval == 1 && isempty(v1) && pg != 25)  { _alertmsg1 = "Please answer correctly the question Q" + pg + "b."; return false; }
			if (!isempty(v1) && v1.length < 6) { _alertmsg1 = "Please answer correctly the question Q" + pg + "b."; return false; }
			v1 = getobj(wi, "INP", f[5]).xval;
			if ( isNaN(v1) ) 
			{ 
				_alertmsg1 = "Please answer correctly the question Q" + pg + "c."; return false; 
			}
			else
			{
				if (v1 <= 0)
				{ 
					_alertmsg1 = "Please answer correctly the question Q" + pg + "c."; return false; 
				}
				else 
				{
					if ((v1 > 7 && getobj(wi, "RAD", f[6]).xval == 1) || (v1 > 31 && getobj(wi, "RAD", f[7]).xval == 1) || (v1 > 365 && getobj(wi, "RAD", f[8]).xval == 1)) { _alertmsg1 = "Please answer correctly the question Q" + pg + "c."; return false; }
				}
			}
			v1 = false;
			for (i =  f[9]; i <=  f[14]; ++i)
			{
				if (getobj(wi, "CHK", i).xval == 1) { v1 = true; break; }
			}
			if (!v1) { _alertmsg1 = "Please check at least one option in question Q" + pg + "d."; return false; }
			if (getobj(wi, "CHK",  f[14]).xval == 1 && isempty(getobj(wi, "INP",  f[15]).xval)) { _alertmsg1 = "Please answer correctly the question Q" + pg + "d."; return false; }
			if (getobj(wi, "RAD",  f[16]).xval == 0 && getobj(wi, "RAD", f[17]).xval == 0) { _alertmsg1 = "Please answer correctly the question Q" + pg + "e."; return false; }
			a = [ f[18], f[19], f[20], f[21], f[23]];
			v1 = false;
			for (i = 0; i < 5; ++i)
			{
				if (getobj(wi, "CHK", a[i]).xval == 1) { v1 = true; break; }
			}
			if(!v1) { _alertmsg1 = "Please check at least one option in question Q" + pg + "f."; return false; }
			if (getobj(wi, "CHK", f[21]).xval == 1 && isempty(getobj(wi, "INP", f[22]).xval)) { _alertmsg1 = "Please answer correctly the question Q" + pg + "f."; return false; }
		}
		if (getobj(wi, "STA", f[25]).xval == 0) { _alertmsg1 = "Please check at least one star."; return false; }
	}
	return true;
}

private function questclearansw():void
{
	var i, l, s, v;
	l = _appcode.length;
	for (i = 0; i < l; ++i)
	{
		if (_appcode[i][0] >= _stqueobj) { s = i; break; }
	}
	for (i = s; i < l; ++i)
	{
		if (_appcode[i][5] != "")
		{
			if (_appcode[i][1] == "RAD" || _appcode[i][1] == "CHK" || _appcode[i][1] == "STA") { v = 0; } else { v = "---";}
			_appcode[i][64] = v;
		}
	}
}

private function questsaveansw(md):void
{
	var i, l, sep, ans, vn, va, la, pv;
	//md: "ABAN", "QUIT", "COMP"
	ans = "";
	sep = "";
	l = _appcode.length;
	for (i = 0; i < l; ++i)
	{
		if (i > 0) { sep = "|"; }
		if (_appcode[i][5] != "" && _appcode[i][0] >= _stqueobj)
		{
			vn = _appcode[i][5].split("-");			//variable name
			va = _appcode[i][64]; 			//answer value
			if (typeof(va) == "string")
			{
				if (isempty(va)) { va = ""; }
			}
			if (!isempty(_appcode[i][18])) { la = removehtmltags(_appcode[i][18]); la = txtreplace(la, "&apos;", "'"); } else { la = ""; }		//var. label (descriptor)
			ans += sep + _appcode[i][1] + "·" + _appcode[i][0] + "·" + vn[0] + "·" + vn[1] + "·" + vn[2] + "·" + va + "·" + la;							// + "·" + _appcode[i][65] + "·" + _appcode[i][66] + "·" + _appcode[i][67];
		}
	}
	//trace(_visquepgs)
	pv = "fn401¦" + _curquest + "¦" + _queparti[0] + "¦" + _queparti[1] + "¦" + ans + "¦" + _visquepgs + "¦" + _mapdata;
	trace(pv)
	actdbpost(_apppath + "dbactions.php", pv);
}

private function questfillansw(a):void
{
	var i, l, k, j, ans, s, v;
	l = _appcode.length;
	ans = a.split("|");
	k = ans.length;
	for (i = 0; i < k; ++i)
	{
		ans[i] = ans[i].split("·");
	}
	l = _appcode.length;
	for (i = 0; i < l; ++i)
	{
		if (_appcode[i][0] >= _stqueobj) { s = i; break; }
	}
	for (j = 0; j < k; ++j)
	{
		for (i = s; i < l; ++i)
		{
			if (ans[j][1] == _appcode[i][0])
			{
				v = ans[j][5];
				if (_appcode[i][1] == "RAD" || _appcode[i][1] == "CHK" || _appcode[i][1] == "STA") { v = int(v); }
				_appcode[i][64] = v;
				break;
			}
		}
	}
	_visquetim = new Date().getTime();
}

private function questansw(a):void
{

}

private function questshowansw(a):void
{

}

private function questupdateuser(wly, act, ova):void
{
	var pv = "fn600" + "¦" + _curuser[0] + "¦" + _queparti[0] + "¦" + act + "¦" + wly + "¦" + ova;
	trace("QUU: " + pv)
	actdbpost(_apppath + "dbactions.php", pv);
}


