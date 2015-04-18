package ;

import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;

/**
 * ...
 * @author Leo Mahon
 */
class SkateBoard extends BaseWorldEntity
{

	private var animatedSprite:Spritemap;
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		animatedSprite  = new Spritemap("graphics/skateboard.png", 24, 24);
		
		animatedSprite.add("static", [0], 10);
		//animatedSprite.add("ollie", [0, 0,0,0,0, 14, 14, 14, 14, 14, 15, 15, 15], 20, false);
		animatedSprite.add("ollieUp", [14,14,1,1, 1,1,1,0,0,0], 33, false);
		animatedSprite.add("ollieDown", [15, 16], 12.25, true);
		animatedSprite.play("static");
		
		this.graphic = animatedSprite;
		
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (animatedSprite.currentAnim == "ollie" && animatedSprite.complete)
		{
			this.goStatic();
		}
	}
	
	public function ollieUp():Void
	{
		animatedSprite.play("ollieUp");
	}
	
	public function ollieDown():Void
	{
		animatedSprite.play("ollieDown");
	}
	
	public function goStatic():Void
	{
		animatedSprite.play("static");
	}
	
}