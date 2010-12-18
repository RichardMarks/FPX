package rmarks.fpx
{
	import flash.net.SharedObject;
	/**
	 * manages the SharedObject data for the game
	 * @author Richard Marks
	 */
	public class SystemData
	{
		static public var sharedObject:SharedObject;
		
		/**
		 * loads the specified system data - or creates a new file if it does not exist
		 * @param	dataPath - the path to the system data
		 */
		static public function Load(dataPath:String):void
		{
			SystemData.sharedObject = SharedObject.getLocal(dataPath + ".gamesav");
		}
		
		/**
		 * saves system data to disk
		 */
		static public function Save():void
		{
			if (null == SystemData.sharedObject)
			{
				return;
			}
			SystemData.sharedObject.flush();
		}
		
		/**
		 * deletes the system data from disk
		 */
		static public function Delete():void
		{
			if (null == SystemData.sharedObject)
			{
				return;
			}
			SystemData.sharedObject.clear();
		}
		
		/**
		 * store a value in the system data file
		 * @param	attribute - the attribute to store
		 * @param	value - the value to assign to the attribute
		 */
		static public function Set(attribute:*, value:*):void
		{
			if (null == SystemData.sharedObject)
			{
				return;
			}
			SystemData.sharedObject.data[attribute] = value;
		}
		
		/**
		 * retrieve a value from the system data file
		 * @param	attribute - the attribute to retrieve
		 * @return the Object stored in the system data file for the attribute or null
		 */
		static public function Get(attribute:*):Object
		{
			if (null == SystemData.sharedObject)
			{
				return null;
			}
			return SystemData.sharedObject.data[attribute];
		}
	}
}