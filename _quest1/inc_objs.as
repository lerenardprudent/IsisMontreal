
private function getobjprops(obn):Array
{
	var n, i, j, k, a;
	n = obn.split("_")
	a = [];
	if (n[0] == "select") { k = parseInt(n[3]); } else if (n[0] == "OBJ") { k = parseInt(n[2]); } else { return null; }
	for (i = 0; i < _appcode.length; ++i)
	{
		if (_appcode[i][0] == k)
		{
			for (j = 0; j < _appcode[i].length; ++j) { a[j] = _appcode[i][j]; }
			return a;
			break; 
		}
	}
	return null;
}

private function changelabtxt(ob:*, t:String, s:String):void
{
	var th = ob.labtext;
	var tp = new RegExp(t, "gi");
	th = th.replace(tp, s);
	ob.labtext = th;
}

private function disableobj(win, ot, oi):void
{
	var ox;
	ox = getobj(win, ot, oi);
	ox.mouseEnabled = false;
	ox.mouseChildren = false;
	ox.alpha = .4; 
}

private function getobid(ob):int
{
	var a = ob.name.split("_")
	return(parseInt(a[2]));
}

private function getobclass(ob):String
{
	var a = ob.name.split("_")
	return(a[1]);
}

private function getobj(win, ot, oi):*
{
	var hld;
	hld = win.getChildByName("holder");
	return hld.getChildByName("OBJ_" + ot + "_" + oi);
}

private function showobj(win, ot, oi, vis):void
{
	var hld, ob;
	hld = win.getChildByName("holder");
	ob = hld.getChildByName("OBJ_" + ot + "_" + oi);
	ob.visible = vis;
}

private function enableobj(win, ot, oi):void
{
	var ox, op;
	ox = getobj(win, ot, oi);
	ox.mouseEnabled = true;
	ox.mouseChildren = true;
	op = getobjprops("OBJ_" + ot + "_" + oi);
	ox.alpha = op[46] / 100;
}


//----------------------------------------------------------------------------	object functions


private function tofront(ob):void
{
	ob.parent.setChildIndex(ob, ob.parent.numChildren - 1);
}

private function toback(ob):void
{
	ob.parent.setChildIndex(ob, 0);
}

private function clone(ob:Object):*
{
	var b:ByteArray = new ByteArray();
	b.writeObject(ob);
	b.position = 0;
	return(b.readObject());
}

private function encodeobject(p:*):String			//* = Object
{
	var b = new ByteArray();
	b.writeObject(p);
	b = base64.encode(b);
	b = txtreplace(b, "+", "%2B");
	b = txtreplace(b, "/", "%2F");
	b = txtreplace(b, "=", "%3D");
	return b;
	
}

private function decodeobject(s:String):*			//* = Object
{
	var p = txtreplace(s, "%2B", "+");
	p = txtreplace(p, "%2F", "/");
	p = txtreplace(p, "%3D", "=");
	p = base64.decode(p)
	p.position = 0;
	return p.readObject();
}

/*
private function encodeobject(p:*):String			//* = Object
{
	var b = new ByteArray();
	b.writeObject(p);
	return(base64.encode(b));
}

private function decodeobject(s:String):*			//* = Object
{
	var p = base64.decode(s)
	p.position = 0;
	return p.readObject();
}
*/

