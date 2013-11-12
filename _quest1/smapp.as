package
{
	//import adobe.utils.CustomActions;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.ui.*;
	import flash.filters.*;
	//import fl.controls.*
	import flash.net.*
	//import flash.system.System;
	//import flash.external.*;
	import flash.external.ExternalInterface;
	import base64;
	import com.greensock.TweenMax;
	import com.greensock.OverwriteManager;
	import com.greensock.easing.*;
	
	 
	public class smapp extends Sprite
	{
		private var _main:MovieClip;
		private var _apphead:*;
		private var _appheadob:Object;
		private var _blocker:MovieClip
		private var _preloader:*;
		private var _clock:* = new clock();
		private var _calendar:* = new cal();
		
		private var _cntxMenu:ContextMenu = new ContextMenu();	//context menu
		private var _zoom:Number = 1;
		private var _dblclick:int = 0;
		private var _sheet:StyleSheet = new StyleSheet();
		
		private var _xloader:*;
		private var _loader:URLLoader;
		private var _txtloader:*;
		private var _txtfile:String = "";
		private var _picloader:Loader;
		private var _picholder:*;
		private var _picfx:Array = ["", 1, 0, 0, "", "normal"];		//fit, alpha, blurX, blurY, tint, blendMode
		
		private var _apploader:*;
		
		private var _actloader:*;
				
		private var _obover:* = null;
		
		/*
		private const _dbpath = "";
		private const _apppath = "";
		*/
		private var _dbpath = "http://beanztreksoft.org/_quest1/";
		private var _apppath = "http://beanztreksoft.org/_quest1/";
		
		private var _appid:String = "BEANZ";
		private var _docid:String = "QUEST1";
		
		
		private var _wins:Array = [];					//all holders
		private var _winprops:Array = [];
		private var _appcode:Array = [];				//equiv SAUT pgcode: all the objects in the app
		//private var _defobj:Array = [0, "INP", 1, 0, 0, "", 1, 0, 1, 0, 0, 0, 1, "", 80, 20, 0, 0, "Text here " + 0, "0xfafafa,0xcacad2,1,1,90", "0xcacad2,0xfafafa,1,1,90", "0xcacad2,0xfafafa,1,1,90", "0x5c5c6d,1", "0xff0000,1", "0xff0000,1", "0x727287", "", "", "", "", "", "", "0x727287", "0x727287", "0x727287", 0, "", 0, 0, 1, "", "media/defpic.png", "", "", 0, 100, 100, "", "", 0, 0, 7, 3, 19, "", "", "30,50,20", "0,1,0", "T,N,O", "", "", "", "", "", "", "", "", ""];
		private var _nrarr:Array = [0, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 35, 37, 38, 39, 44, 45, 46, 49, 50, 51, 52, 53];		//props w/ numeric values
		private var _shiftx:int = 0;
		private var _shifty:int = -30;
		
		
		private var _objid:int = 0;
		private var _objtext:String = "";
		private var _tabndx:int = 0;
		private var _wholder:Sprite;
		private var _editon:Boolean = false;
		private var _scroller:* = null;
		private var _windrag:* = null;
		private var _objdone:int = 0;
		
		private var _logged:Boolean = false;
		private var _alertact:String = "";
		private var _alertmsg1:String = "";
		private var _alertmsg2:String = "";
		private var _keepblock:Boolean = false;		//do not keep blocker on hide blocker
		private var _lookuptg:Array = [];
		
		private var _timer:*;
		
		//application specific ---------
		
		private var _defuser = [0, "", "", "", "", "", "", "", "", "", "0000-00-00", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "0000-00-00", 0, 0, 0, "", "", "", "", "", "", "", "", "", "", 0, 0, 0, "", "", "", "", "", "", "", "", "", "", "", "0000-00-00", "0000-00-00", "", ""];
		private var _users:*;
		private var _assets:Array = []; 		//id, assname, type, status, etc.
		private var _varsarr:*;					//variables IDs and names
		private var _answsarr:*;				//object id, type, page, value, variable, x (if dragged), y (if dragged)
		private var _curuser:*;					//current user (other than parti: author, admin, interviewer, presenter)
		private var _ual:String					//user alias
		private var _upw:String					//user pass
		private var _curphase:String = "T-03";	//current phase
		//private var _curparti:*;				//parti id from parti windows
		private var _queparti:* = "";			//participant id for questionnaire
		private var _curquest:String = "";		//id of the questionnaire
		private var _curqpg:int = 0;			//current quest page
		private var _lastpg:int = 0;			//quit / abandon quest page
		private var _acttarget = "";			//action target
		private var _visquepgs = "";			//visited pages
		private var _visquetim = new Date().getTime();				//visited pages timer
		private var _stqueobj = 200;			//first object id of the questionnaire (quest id objects start at 400)
		//private var _qnav = [51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66];
		private var _qnavx = [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62]; 	//original (never changes)
		private var _qnav = [21, 22, 23, 24, 25, 26, 27, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62];	//actual (charged from original, modified by the questionnaire)
		private var _qnavkey = "";
		private var _questlabel = [];
		
		private var _mapgen = false;				//map generated once
		private var _mapon = false;					//map visibility
		private var _mapdata = "";					//map data all pages
		
		private var _dbpage:Array = [0,0,0,0,0];					//db page: 0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		private var _dbpagelen:Array = [16,16,16,5,8];				//db page length: 0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		//private var _dbrec:Array = [];							//records (item): 0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		private var _dbflt:Array = ["","","","",""];				//filters: 0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		private var _dbsort:Array = ["id","id","id","id",""];		//sort column: 0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		private var _dbsortdir:Array = ["","","","",""];			//sort direction: 0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		private var _dbrows:Array = [0, 0, 0, 4, 0];				//db total (filtered) rows:  0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		private var _dblookuptg:Array = [];
		private var _dbxfile:Array = ["","","","",""];
		
		//------------------------------

		private var _abbreta:Array = [["---",""],["INI","Initial"],["QUE","Questionnaire"],["FIN","Final"]];
		private var _abbrsta:Array = [["---", ""], ["INI", "Initial"], ["UWA", "Under way"], ["INT", "Interruption"], ["ABA", "Abandon"], ["COM", "Completed"], ["CAN", "Cancelled"]];
		private var _abbract:Array = [["---",""],["PLA", "Planned"], ["UWA", "Current"], ["ANN", "Cancelled"], ["FIN", "Finalized"]];
		private var _abbrcod:Array = [["---", ""], ["GEN", "Generic"], ["INV", "Device in stock"], ["ASS", "Device assigned"], ["ALI", "Device delivered"], ["AHS", "Device defective"], ["APV", "device lost/stolen"], ["AMR", "Device discarded"], ["SPA", "Suivi problème appareil"], ["DOR", "Données récupérées"], ["DOT", "Données transmises"], ["SCO", "Suivi courrier"], ["TEL", "Appel téléphonique"], ["FAX", "Message fax"], ["EMA", "Message courriel [e-mail]"], ["SMS", "Message SMS"], ["POS", "Lettre par la poste"]];
		private var _abbrass:Array = [["---", ""], ["INV", "Appareil en inventaire"], ["ASS", "Appareil assigné"], ["ALI", "Appareil livré"], ["AHS", "Appareil hors-service"], ["APV", "Appareil perdu / volé"], ["AMR", "Appareil mis au rebut"]];
		
		//------------------------------

		
		public function smapp():void
		{
			_cntxMenu.hideBuiltInItems();
			contextMenu = _cntxMenu;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.stageFocusRect = false;

			stage.addEventListener(MouseEvent.MOUSE_DOWN, stagedown, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stagemove, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageup, false, 0, true);
			stage.addEventListener(MouseEvent.CLICK, stageclick, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stagekeydown, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, stagewheel, false, 0, true);
			stage.addEventListener(Event.RESIZE, stageresize, false, 0, true);

			//ExternalInterface.addCallback("callbackjs", fncallbackjs);
			ExternalInterface.addCallback("callbackjs", map2quest);

			
			_main = new main();
			_main.x = _main.y = 0;
			_main.visible = false;
			this.addChild(_main);
			
			_blocker = new mainblocker();
			_blocker.visible = false;
			this.addChild(_blocker);
			
			_clock.visible = false;
			_clock.filters = [new DropShadowFilter(3, 45, 0x000000, .3, 3, 3, 1, 3)]
			this.addChild(_clock);
			
			_calendar.visible = false;
			_calendar.filters = [new DropShadowFilter(3, 45, 0x000000, .3, 3, 3, 1, 3)]
			this.addChild(_calendar);
			
			loadnet();
		}
		
		include "inc_stage.as";
		include "inc_funcs.as";
		include "inc_wins.as";
		include "inc_objs.as";
		include "inc_net.as";
		include "inc_layout.as";
		include "inc_quest.as";
		include "inc_actions.as";
		
		private function initapp():void
		{
			var i, wa, wpa, wlay, s, se, u, p;

			include "inc_winprops.as";
			
			/*
			0 - alert text ok (p1)
			1 - alert text ok / can (p2)
			2 - alert input (p3)
			3 - picpopup (p10)
			4 - menu (p11)
			5 - statusbar (p12)
			6 - login (p6)
			7 - help / terms (p4)
			8 - quest window (pg21)
			*/
			
			wlay = [1, 2, 3, 10, 11, 12, 6, 4, 21];
			for (i = 0; i < wlay.length; ++i)
			{
				if(_winprops[i][1] == "B"){makewin(i, _blocker);}else if(_winprops[i][1] == "M"){makewin(i, _main);}
			}
			for (i = 0; i < wlay.length; ++i) { makewinlayout(_wins[i], wlay[i]); _wins[i].visible = false; }			//load layout

			pozwin(_wins[0], true, true, 0, 0, false, 0);
			pozwin(_wins[1], true, true, 0, 0, false, 0);
			pozwin(_wins[2], true, true, 0, 0, false, 0);
			pozwin(_wins[3], true, true, 0, 0, false, 0);
			pozwin(_wins[4], false, false, 20, -10, false, 0);
			pozwin(_wins[5], false, false, 20, _main.back.height - 10, false, 0);
			pozwin(_wins[6], true, true, 0, 0, false, 0);
			pozwin(_wins[7], true, true, 0, 0, false, 0);
			pozwin(_wins[8], true, true, 0, 0, false, 0);
			//pozwin(_wins[29], true, true, 0, 0, false, 0);
			
			for (i = 46; i <= 51; ++i) { getobj(_wins[4], "BTN", i).visible = false; }
			_wins[4].visible = _wins[5].visible = true;			//menu + status bar
			actionresize(stage.stageWidth, stage.stageHeight);
			_preloader.visible = false;
			_preloader.gotoAndStop(1);

			
			//login process:
			_curquest = "BEANZ1";
			_queparti = "R002";		//R002 John Doe 21895, R005 Jane Doe 21898
			_curqpg = 0;		// or another start page
			u = "teddy";
			p = "iview";
			s = geturlparms();
			//s = "http://fuck.org?BjVHUE1ULVJfNTczOThfMF90ZWRkeV9tZWRkeQ%3D%3D";
			if (s != null)
			{
				if (s.indexOf("?") != -1)
				{
					s = s.split("?");
					s = decodeobject(s[1]);
					s = s.split("_");
					_curquest = s[0];
					_queparti = s[1];
					if (s[2] != null) { _curqpg = int(s[2]); }
					if (_curqpg < 0) { _curqpg = 0; }
					if (s[3] != null && s[4] != null)		//_curuser alias + pw
					{
						dbloginuser(s[3], s[4]);
					}
					else
					{
						pozwin(_wins[6], true, true, 0, 0, false, 0);		//login first time
						showwin(_wins[6], true, 0, 0);
						showblocker(true);
					}
				}
			}
			else
			{
				dbloginuser(u, p);
			}
			/*
			if(pwi)
			{
				pozwin(_wins[6], true, true, 0, 0, false, 0);		//login first time
				showwin(_wins[6], true, 0, 0);
				showblocker(true);
			}
			*/
		}
		
		private function fncallbackjs(par:String)
		{
			map2quest(par);
		}

	}
}
