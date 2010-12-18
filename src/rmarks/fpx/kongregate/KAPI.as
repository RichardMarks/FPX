package rmarks.fpx.kongregate 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	/**
	 * Kongregate API integration class
	 * version 1.0
	 * @author Richard Marks
	 */
	public class KAPI 
	{
		static public const INVALID_USER_ID:Number = -9999;
		static private var kongregate:* = null;
		static public var loaded:Boolean = false;
		static public var messages:Vector.<String> = new Vector.<String>();
		
		/**
		 * use to submit a statistic to kongregate
		 * @param	statName - name of the statistic you have setup in your game's dashboard on kongregate.com
		 * @param	statValue - numeric value to submit
		 */
		static public function SubmitStat(statName:String, statValue:Number):void
		{
			if (!loaded)
			{
				messages.push("SubmitStat() Kong API not loaded!");
				return;
			}
			
			kongregate.stats.submit(statName, statValue);
		}
		
		/**
		 * @return if the user is not logged into kongregate
		 */
		static public function IsGuest():Boolean
		{
			if (!loaded)
			{
				messages.push("IsGuest() Kong API not loaded!");
				return false;
			}
			
			return kongregate.services.isGuest();
		}
		
		/**
		 * @return the user name of the logged in user
		 */
		static public function GetUserName():String
		{
			if (!loaded)
			{
				messages.push("GetUserName() Kong API not loaded!");
				return "";
			}
			
			return kongregate.services.getUsername();
		}
		
		/**
		 * @return the user id of the logged in user
		 */
		static public function GetUserID():Number
		{
			if (!loaded)
			{
				messages.push("GetUserID() Kong API not loaded!");
				return INVALID_USER_ID;
			}
			
			return kongregate.services.getUserId();
		}
		
		/**
		 * @return the game authentication token
		 */
		static public function GetGameAuthenticationToken():String
		{
			if (!loaded)
			{
				messages.push("GetGameAuthenticationToken() Kong API not loaded!");
				return "";
			}
			
			return kongregate.services.getGameAuthToken();
		}
		
		/**
		 * loads the kongregate api
		 * To be used in your Preloader like this
		 * if (stage) { KAPI.Load(this, root.loaderInfo); }
		 * @param	parent - the preloader/parent movieclip instance
		 * @param	loaderInfo - the loaderinfo instance of the flash movie root
		 */
		static public function Load(parent:MovieClip, loaderInfo:LoaderInfo):void
		{
			messages.push("Loading Kong API");
			var paramsObj:Object = LoaderInfo(loaderInfo).parameters;
			var apiPath:String = paramsObj.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
			messages.push("API Path:", apiPath);
			Security.allowDomain(apiPath);
			var request:URLRequest = new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnKongLoadComplete);
			loader.load(request);
			parent.addChild(loader);
			trace(messages);
		}
		
		/**
		 * connects to kongregate's services
		 * called by Load() when the api is loaded
		 * @param	e
		 */
		static private function OnKongLoadComplete(e:Event):void
		{
			messages.push("Kong API Loaded");
			loaded = true;
			kongregate = e.target.content;
			kongregate.services.connect();
			messages.push("kongregate object:", kongregate);
			messages.push("connected: ", kongregate.connected);
			messages.push("services: ", kongregate.services);
			trace(messages);
		}	
	}
}