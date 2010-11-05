package rmarks.fpx
{
	/**
	 * An extension to MobileMessageDisplay that lets the let rise up at a given speed
	 * other features are same as MobileMessageDisplay
	 * 
	 * usage:
	 * 
	 * 		MobileMessageDisplay.Print("Hello World!", x, y, color, size, life, riseSpeed, font);
	 * 
	 * @author Richard Marks
	 */
	public class RisingMobileMessageDisplay extends MobileMessageDisplay
	{
		/**
		 * helper function - creates a new MobileMessageDisplay and adds it to FP.world
		 * @param	msg - String of text to display
		 * @param	xPos - X coordinate
		 * @param	yPos - Y coordinate
		 * @param	color - color in RGB format
		 * @param	size - size in pixels of the text
		 * @param	life - how long to let the message live - use 0 for persistent messages (default)
		 * @param	riseSpeed - how fast to rise (1 is default)
		 * @param	font - name of the font to use "msgfont" is the default
		 */
		static public function Print(msg:String, xPos:Number = 0, yPos:Number = 0, color:uint = 0xFF0000, size:Number = 8, life:Number = 0, riseSpeed:Number = 1, font:String = "msgfont"):RisingMobileMessageDisplay
		{
			var mdObj:RisingMobileMessageDisplay = new RisingMobileMessageDisplay(msg, xPos, yPos, color, size, life, riseSpeed, font);
			FP.world.add(mdObj);
			return mdObj;
		}
		
		// speed at which the message will rise
		private var risingSpeed:Number = 1;
		
		/**
		 * constructor
		 * @param	msg - String of text to display
		 * @param	xPos - X coordinate
		 * @param	yPos - Y coordinate
		 * @param	color - color in RGB format
		 * @param	size - size in pixels of the text
		 * @param	life - how long to let the message live - use 0 for persistent messages (default)
		 * @param	riseSpeed - how fast to rise (1 is default)
		 * @param	font - name of the font to use "msgfont" is the default
		 */
		public function RisingMobileMessageDisplay(msg:String, xPos:Number = 0, yPos:Number = 0, color:uint = 0xFF0000, size:Number = 8, life:Number = 0, riseSpeed:Number = 1, font:String = "msgfont") 
		{
			// use the parent class to set things up
			super(msg, xPos, yPos, color, size, life);
			
			// set the rising speed
			risingSpeed = riseSpeed;
		}
		
		override public function update():void 
		{
			// move the message
			y -= risingSpeed;
			
			super.update();
		}
	}
}
