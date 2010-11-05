package rmarks.fpx 
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	/**
	 * implements a scrolling starfield
	 * starfield can be scrolled in four directions
	 * starfield can have any colors
	 * starfield can have up to 1000 stars
	 * 
	 * intended usage:
	 * 
	 * You should create a Starfield variable in your class that extends World.
	 * eg: private var field:Starfield = Starfield.New(200, Starfield.MOTION_TOP_TO_BOTTOM);
	 * 
	 * you should override the update() function in your class that extends World and call the .update()
	 * function of the starfield before super.update()
	 * eg: override update():void { field.update(); super.update(); }
	 * 
	 * you should override the render() function in your class that extends World and call the .render()
	 * function of the starfield before super.render()
	 * eg: override public function render():void { field.render(new Point, FP.camera); super.render(); }
	 * 
	 * @author Richard Marks
	 */
	public class Starfield extends Graphic
	{
		// starfield direction constants
		static public const MOTION_TOP_TO_BOTTOM:int = 0;
		static public const MOTION_LEFT_TO_RIGHT:int = 1;
		static public const MOTION_RIGHT_TO_LEFT:int = 2;
		static public const MOTION_BOTTOM_TO_TOP:int = 3;
		
		/**
		 * helper function to create a new Starfield object
		 * @param	density - total number of stars
		 * @param	motion - desired direction of motion
		 * @param	colors - color palette
		 * @return the created Starfield object
		 */
		static public function New(density:int = 400, motion:int = 3, colors:Array = null):Starfield
		{
			return new Starfield(density, motion, colors);
		}
		
		// stars is [star1, star2, star3, etc]
		// starN is [graphic, x, y, color, speed]
		private var stars:Array;
		
		// number of stars in the starfield 
		private var fieldDensity:int;
		
		// the motion of the starfield
		private var fieldMotion:int;
		
		// the colors for the starfield
		private var fieldColors:Array;
		
		// the active starfield update callback function
		private var fieldUpdate:Function;
		
		/**
		 * updates the starfield
		 */
		override public function update():void 
		{
			if (fieldUpdate is Function)
			{
				//trace("updating");
				fieldUpdate();
			}
			super.update();
		}
		
		/**
		 * renders the starfield
		 * @param	point - param for FP: use "new Point"
		 * @param	camera - param for FP: use "FP.camera"
		 */
		override public function render(point:Point, camera:Point):void 
		{
			// loop through each of the star-arrays in the stars array
			for each(var star:Array in stars)
			{
				// grab the star graphic
				var g:Image = (star[0] as Image);
				
				// draw the star
				g.render(new Point(star[1], star[2]), camera);
			}
		}
		
		/**
		 * creates the starfield stars array
		 */
		private function CreateField():void
		{
			stars = new Array;
			for (var i:int = 0; i < fieldDensity; i++)
			{
				// star is [graphic, x, y, color, speed]
				var star:Array = [null, null, null, null, null];
				
				// random position
				star[1] = Math.random() * FP.width;
				star[2] = Math.random() * FP.height;
				
				// random speed based on number of available colors
				star[4] = 1+Math.floor(Math.random() * fieldColors.length);
				
				// color based on speed
				star[3] = fieldColors[star[4]-1];
				
				// star graphic itself
				star[0] = Image.createRect(1, 1, star[3]);
				
				// add star to the stars array
				stars.push(star);
			}
		}
		
		/**
		 * sets the motion of the starfield
		 * @param	motion - any of the MOTION_* constants defined in Starfield.as
		 */
		public function SetMotion(motion:int):void
		{
			// prevent invalid values
			if (motion < MOTION_TOP_TO_BOTTOM || motion > MOTION_BOTTOM_TO_TOP)
			{
				motion = MOTION_BOTTOM_TO_TOP;
			}
			
			fieldMotion = motion;
			
			// assign the proper update function to use
			var funcs:Array = [UpdateTtB, UpdateLtR, UpdateRtL, UpdateBtT];
			fieldUpdate = (funcs[fieldMotion] as Function);
		}
		
		// move stars from the top of the screen to the bottom
		private function UpdateTtB():void 
		{
			for each(var star:Array in stars)
			{
				// add speed to the star
				star[2] += star[4];
				
				if (star[2] > FP.height)
				{
					// new random x position and warp back to top
					star[1] = Math.random() * FP.width;
					star[2] = 0;
				}
			}
		}
		
		// move stars from the bottom of the screen to the top
		private function UpdateBtT():void 
		{
			for each(var star:Array in stars)
			{
				// add speed to the star
				star[2] -= star[4];
				
				if (star[2] < 0)
				{
					// new random x position and warp back to bottom
					star[1] = Math.random() * FP.width;
					star[2] = FP.height;
				}
			}
		}
		
		// move stars from the left of the screen to the right
		private function UpdateLtR():void 
		{
			for each(var star:Array in stars)
			{
				// add speed to the star
				star[1] += star[4];
				
				if (star[1] > FP.width)
				{
					// new random y position and warp back to left
					star[2] = Math.random() * FP.width;
					star[1] = 0;
				}
			}
		}
		
		// move stars from the right of the screen to the left
		private function UpdateRtL():void 
		{
			for each(var star:Array in stars)
			{
				// add speed to the star
				star[1] -= star[4];
				
				if (star[1] < 0)
				{
					// new random y position and warp back to right
					star[2] = Math.random() * FP.width;
					star[1] = FP.width;
				}
			}
		}
		
		/**
		 * class constructor - creates the starfield
		 * @param	density - total number of stars
		 * @param	motion - desired direction of motion
		 * @param	colors - color palette
		 */
		public function Starfield(density:int = 400, motion:int = 3, colors:Array = null) 
		{
			if (colors == null)
			{
				colors = [0x444444, 0x999999, 0xBBBBBB, 0xFFFFFF];
			}
			
			SetMotion(motion);
			
			if (density > 1000)
			{
				density = 1000;
			}
			
			fieldDensity = density; 
			fieldColors = colors;
			
			CreateField();
			active = true;
			visible = true;
		}
	}
}
