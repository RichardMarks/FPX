package rmarks.fpx
{
	import flash.geom.*;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.tweens.misc.*;

	/**
	 * A useful helper Entity for putting text messages on the screen.
	 * You can give the text a life time to make messages disappear after some time passes
	 * 
	 * usage:
	 * 
	 * 		MobileMessageDisplay.Print("Hello World!", x, y, color, size, life, font);
	 * 
	 * @author Richard Marks
	 */
	public class MobileMessageDisplay extends MessageDisplay
	{
		/**
		 * helper function - creates a new MobileMessageDisplay and adds it to FP.world
		 * @param	msg - String of text to display
		 * @param	xPos - X coordinate
		 * @param	yPos - Y coordinate
		 * @param	color - color in RGB format
		 * @param	size - size in pixels of the text
		 * @param	life - how long to let the message live - use 0 for persistent messages (default)
		 * @param	font - name of the font to use "msgfont" is the default
		 * @return 	the MobileMessageDisplay object created
		 */
		static public function Print(msg:String, xPos:Number = 0, yPos:Number = 0, color:uint = 0xFF0000, size:Number = 8, life:Number = 0, font:String = "msgfont"):MobileMessageDisplay
		{
			var mdObj:MobileMessageDisplay = new MobileMessageDisplay(msg, xPos, yPos, color, size, life, font);
			FP.world.add(mdObj);
			return mdObj;
		}
		
		/**
		 * constructor
		 * @param	msg - String of text to display
		 * @param	xPos - X coordinate
		 * @param	yPos - Y coordinate
		 * @param	color - color in RGB format
		 * @param	size - size in pixels of the text
		 * @param	life - how long to let the message live - use 0 for persistent messages (default)
		 * @param	font - name of the font to use "msgfont" is the default
		 */
		public function MobileMessageDisplay(msg:String, xPos:Number = 0, yPos:Number = 0, color:uint = 0xFF0000, size:Number = 8, life:Number = 0, font:String = "msgfont") 
		{
			// use the parent class to set things up
			super(msg, xPos, yPos, color, size, font);
			
			// this message is locked to the world coordinate we give it
			t.scrollX = 0;
			t.scrollY = 0;
			
			// if we want this message to live a certain amount of time
			if (life != 0)
			{
				// the Kill function will be called when the message life is expired
				var lifeTimer:NumTween = new NumTween(Kill, Tween.ONESHOT);
				lifeTimer.tween(0, 1, life);
				addTween(lifeTimer, true);
			}
		}
		
		/**
		 * removes this entity from the world
		 */
		private function Kill():void 
		{
			FP.world.remove(this);
		}
		
		override public function render():void 
		{
			// render the text object correctly
			t.render(new Point((x - FP.camera.x), (y - FP.camera.y)), FP.camera);
		}
	}
}
