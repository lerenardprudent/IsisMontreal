package
{
	import flash.display.*
	//import flash.events.*;
	import flash.filters.*
	 
	public class apphead extends MovieClip
	{
		private var _apphead:*
		
		public function apphead():void
		{
			_apphead  = new head();
			addChild(_apphead);
			_apphead.filters = [new BlurFilter(0, 0, 1)];		//patch for alpha and masking
			_apphead.visible = true;
		}
		

		public function set xwidth(w):void
		{
			_apphead.back.width = w;
			_apphead.pwr.x = Math.round(w - _apphead.pwr.width - 20);
			_apphead.beanz.x = Math.round(w - _apphead.beanz.width - 20);
			//_apphead.redback.width = Math.round(w - _apphead.redback.x);
			//_apphead.pwr.visible = (w > _apphead.crd.x + _apphead.crd.width + _apphead.pwr.width + 20 );
			//_apphead.logosp.visible = (w > 760);
			//_apphead.logosp.x = Math.round(w - 20);
		}
		
		public function get xheight():Number
		{
			return _apphead.back.height;
		}

	}
}
