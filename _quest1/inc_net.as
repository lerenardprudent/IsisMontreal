private function getURL(url:String, target:String = null):void
{
	try{navigateToURL(new URLRequest(url), target);}catch(er){trace("[getURL] " + er);}
}

		
private function geturlparms():*
{
	var loc:String = ExternalInterface.call("window.location.href.toString");
	return loc;
}

private function loadnet():void
{
	_picholder = _main;
	_picfx = ["", .5, 0, 0, "", "normal"];
	loadpic("media/appback.swf");
	
	_xloader = new Loader();
	_xloader.contentLoaderInfo.addEventListener(Event.COMPLETE, appheadok, false, 0, true);
	_xloader.load(new URLRequest('media/apphead.swf'));
}



private function appheadok(e:Event):void
{
	_xloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, appheadok);
	//var linfo:LoaderInfo = e.target as LoaderInfo;
	//_appheadob = linfo.content;
	_apphead = e.target.content;
	_apphead.x = _apphead.y = 0;
	this.addChild(_apphead);
	this.setChildIndex(_apphead, 0);
	_xloader = null;
	_xloader = new Loader();
	_xloader.contentLoaderInfo.addEventListener(Event.COMPLETE, preloaderok, false, 0, true);
	_xloader.load(new URLRequest('media/preload.swf'));
}

private function preloaderok(e:Event):void
{
	_xloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, preloaderok);
	_preloader = e.target.content;
	_preloader.x = (stage.stageWidth - _preloader.width) * .5;
	_preloader.y = (stage.stageHeight - _preloader.height) * .5;
	this.addChild(_preloader);
	_preloader.play();
	_xloader = null;
	
	stagecenter();
	_main.visible = true;
	_txtfile = 	"smapp.css";
	txtload();
}

private function txtload():void
{
	//showpreloader();
	_txtloader = new URLLoader();
	_txtloader.addEventListener(Event.COMPLETE, txtloaded, false, 0, true);
	_txtloader.addEventListener(IOErrorEvent.IO_ERROR, txtioerror, false, 0, true);
	_txtloader.load(new URLRequest(_txtfile));
}

private function txtloaded(e:Event):void
{
	var d;
	//hidepreloader();
	d = e.target.data;
	_txtloader.removeEventListener(Event.COMPLETE, txtloaded);
	_txtloader.removeEventListener(IOErrorEvent.IO_ERROR, txtioerror);
	_txtloader = null;
	if (_txtfile == "smapp.css")						//css file
	{
		_sheet.parseCSS(d);
		_txtfile = "vars.txt"
		txtload();
	}
	else if (_txtfile == "vars.txt")					//vars array
	{
		var i, l;
		_varsarr = d.split("\r\n");
		l = _varsarr.length;
		for (i = 0; i < l; ++i) { _varsarr[i] = _varsarr[i].split("|");}
		_txtfile = "";
		appdbexec("dbapp", "lay~l~" + _appid + "~" + _docid);			//load document layout
	}
}

private function txtioerror(e:IOErrorEvent):void
{
	_txtloader.removeEventListener(Event.COMPLETE, txtloaded);
	_txtloader.removeEventListener(IOErrorEvent.IO_ERROR, txtioerror);
	_txtloader = null;
	if (_txtfile == "smapp.css")						//error css file
	{
		_txtfile = "vars.txt"
		txtload();
	}
	else if (_txtfile == "vars.txt")					//error vars array file
	{
		_txtfile = "";
		appdbexec("dbapp", "lay~l~" + _appid + "~" + _docid);			//load document layout
	}
}

private function loadpic(pic):void
{
	//showpreloader();
	_picloader = new Loader();
	_picloader.contentLoaderInfo.addEventListener(Event.COMPLETE,picloaded, false, 0, true);
	_picloader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, picioerror, false, 0, true);
	_picloader.load(new URLRequest(pic));
}

private function picloaded(e:Event):void
{
	var img, sc, iw, ih;
	//hidepreloader();
	_picloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, picloaded);
	_picloader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, picioerror);
	//img = Bitmap(_picloader.content);
	img = _picloader.content;
	_picloader = null;
	img.x = img.y = 0;
	iw = _picholder.width;
	ih = _picholder.height;
	if (_picfx[0] != "")			//fit
	{
		
	}
	img.scaleX = iw / img.width;
	img.scaleY = ih / img.height;
	img.alpha = _picfx[1];
	img.blendMode = _picfx[5];
	_picholder.addChild(img);
}

private function picioerror(e:Event):void
{
	//hidepreloader();
	_picloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, picloaded);
	_picloader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, picioerror);
}


//database functions ------------------------------------------------------------------------


private function appdbexec(df, par):void
{
	appdbload(_dbpath + df + ".php", par);
	//trace(_dbpath + df + ".php", par)
}

private function appdbload(purl:String, pv:String):void
{
	var rq, vs;
	//showpreloader();
	_apploader = new URLLoader();
	_apploader.dataFormat = URLLoaderDataFormat.TEXT;
	rq = new URLRequest();
	rq.method = URLRequestMethod.POST;
	vs = new URLVariables();
	vs.pvar = pv;
	rq.url = purl;
	rq.data = vs;
	_apploader.addEventListener(Event.COMPLETE, appdbloaded, false, 0, true);
	_apploader.addEventListener(IOErrorEvent.IO_ERROR, appdbioerror, false, 0, true);
	_apploader.load(rq);
}

private function appdbloaded(e:Event):void
{
	var i, a, d;
	d = e.target.data;
	_apploader.removeEventListener(Event.COMPLETE, appdbloaded);
	_apploader.removeEventListener(IOErrorEvent.IO_ERROR, appdbioerror);
	_apploader = null;
	//hidepreloader();
	if(d.substr(0,10) == "-lay-l-ok-")				//load layout
	{
		d = d.substr(10);
		splitlayout(d);
		d = null;
		initapp();											//START APP HERE !!!
	}
}

private function appdbioerror(e:IOErrorEvent):void
{
	//hidepreloader();
	_apploader.removeEventListener(Event.COMPLETE, appdbloaded);
	_apploader.removeEventListener(IOErrorEvent.IO_ERROR, appdbioerror);
	_apploader = null;
	alert(_wins[0], "<font face='Arial' size='11' color='#5c5c6d' letterspacing='0' kerning='0'>Database I/O error.</font>", "");
}


