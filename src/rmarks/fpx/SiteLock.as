package rmarks.fpx 
{
	import net.flashpunk.*;
	/**
	 * implements basic site-locking
	 * 
	 * Note: I have not tested this yet. Feel free to test it and tell me if it works! :D
	 * @author Richard Marks
	 */
	public class SiteLock
	{
		/**
		 * tests for proper domain hosting to 'site-lock' your games
		 * @param	validDomains a list of valid domains or a single string containing a single valid domain
		 * @return true when the domain the file is running on matches a domain in the passed domain list
		 */
		static public function Test(validDomains:*):Boolean
		{
			if (null == FP.stage)
			{
				trace("FPX::SiteLock::Test Error: FP.stage is null");
				return false;
			}
			
			if (null == FP.stage.loaderInfo)
			{
				trace("FPX::SiteLock::Test Error: FP.stage.loaderInfo is null");
				return false;
			}
			
			var url:String = FP.stage.loaderInfo.url;
			var startCheck:int = url.indexOf("://") + 3;
			
			// local testing always OK
			if ("file://" == url.substr(0, startCheck))
			{
				trace("FPX::SiteLock::Test: Testing on localhost - sitelocking ignored");
				return true;
			}
			
			var domainLength:int = url.indexOf('/', startCheck) - startCheck;
			var host:String = url.substr(startCheck, domainLength);
			
			// make sure we are using an array of strings
			// if a single string is passed, convert to an array
			if (validDomains is String)
			{
				validDomains = [validDomains];
			}
			
			// test each domain
			for each(var domain:String in validDomains)
			{
				if (domain == host.substr( -domain.length, domain.length))
				{
					// valid domain
					return true;
				}
			}
			
			// invalid domain
			return false;
		}
		
		/**
		 * tests the domain you're running on and if its not valid, sets FP.world to the redirectWorld
		 * @param	validDomains - a list of valid domains or a single string containing a single valid domain
		 * @param	redirectWorldClassName - the name of the class that extends net.flashpunk.World you want to go to
		 */
		static function Lockdown(validDomains:*, redirectWorldClassName:Class):void 
		{
			if (SiteLock.Test(validDomains))
			{
				// site is OK - no redirect
				return;
			}
			
			// redirect to the specified class
			FP.world = new redirectWorldClassName;
		}
	}

}