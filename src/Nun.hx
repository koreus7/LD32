package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Mask;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import com.haxepunk.tweens.misc.VarTween;
import com.haxepunk.tweens.motion.QuadMotion;
import com.haxepunk.utils.Ease;

/**
 * ...
 * @author Leo Mahon
 */
class Nun extends BaseWorldEntity
{

				
	private var animatedSprite:Spritemap;
	
	public function new(x:Float=100, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		y = HXP.height - 24;
		super(x, y, graphic, mask);
		
		animatedSprite  = new Spritemap("graphics/nun.png", 24, 24);
		
		animatedSprite.add("static", [0], 10);
		animatedSprite.add("idle", [0, 5], 8);
		animatedSprite.add("run", [1, 2, 3], 10);
		animatedSprite.add("jump", [1, 4], 10, false);
		animatedSprite.play("idle");
		
		this.graphic = animatedSprite;
	}
	
	override public function update():Void 
	{
		super.update();
		if (Input.check(Key.UP))
		{
			animatedSprite.play("jump");
			
			
		}
		
		if (animatedSprite.complete)
		{
			animatedSprite.play("static");
		}
		
	}
	
}