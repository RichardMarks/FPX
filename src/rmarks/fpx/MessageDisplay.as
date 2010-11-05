package rmarks.fpx
{
	import flash.geom.*;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	
	/**
	 * A useful helper Entity for putting static text messages on the screen
	 * 
	 * usage:
	 * 
	 * 		MessageDisplay.Print("Hello World!", x, y, color, size, font);
	 * 
	 * @author Richard Marks
	 */
	public class MessageDisplay extends Entity
	{
		// embed the font for flex3
		//[Embed(source = "msgfont.ttf", fontName = "msgfont")] private const MSGFONT:Class;
		
		// embed the font for flex4
		//[Embed(source = "msgfont.ttf", embedAsCFF = "false", fontName = "msgfont")] private const MSGFONT:Class;
		
		/**
		 * helper function - creates a new MessageDisplay and adds it to FP.world
		 * @param	msg - String of text to display
		 * @param	xPos - X coordinate
		 * @param	yPos - Y coordinate
		 * @param	color - color in RGB format
		 * @param	size - size in pixels of the text
		 * @param	font - name of the font to use "msgfont" is the default
		 * @return	the MessageDisplay object created
		 */
		static public function Print(msg:String, xPos:Number = 0, yPos:Number = 0, color:uint = 0xFF0000, size:Number = 8, font:String = "msgfont"):MessageDisplay
		{
			var mdObj:MessageDisplay = new MessageDisplay(msg, xPos, yPos, color, size, font);
			FP.world.add(mdObj);
			return mdObj;
		}
		
		// the text object
		protected var t:Text;
		public function get Txt():Text { return t; }
		
		/**
		 * constructor
		 * @param	msg - String of text to display
		 * @param	xPos - X coordinate
		 * @param	yPos - Y coordinate
		 * @param	color - color in RGB format
		 * @param	size - size in pixels of the text
		 * @param	font - name of the font to use "msgfont" is the default
		 */
		public function MessageDisplay(msg:String, xPos:Number = 0, yPos:Number = 0, color:uint = 0xFF0000, size:Number = 8, font:String = "msgfont") 
		{
			// set the font
			Text.font = font;
			
			// set the font size
			Text.size = size;
			
			// create the text object
			t = new Text(msg);
			
			// colorize the text object
			t.color = color;
			
			// set the position of the object
			x = xPos;
			y = yPos;
			
			// set the dimensions of the entity (in case you want to know the size of your text display)
			setHitbox(t.width, t.height);
		}
		
		override public function render():void 
		{
			// render the text object correctly
			t.render(new Point(FP.camera.x + x, FP.camera.y + y), FP.camera);
			super.render();
		}	
	}
}
