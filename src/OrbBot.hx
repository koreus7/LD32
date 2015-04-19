package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Mask;

import com.haxepunk.Tween.TweenType;
import com.haxepunk.tweens.misc.VarTween;
import com.haxepunk.tweens.motion.QuadMotion;
import com.haxepunk.utils.Ease;
import com.haxepunk.HXP;
import com.haxepunk.utils.Draw;
/**
 * ...
 * @author Leo Mahon
 */
class OrbBot extends BaseWorldEntity
{

	private var animatedSprite:Spritemap;
	private var tweenTime:Float;
	private var inMotion:Bool;

	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		animatedSprite = new Spritemap("graphics/enemy.png", 24, 24);
		tweenTime = 5.0;
		animatedSprite.add("idle", [0], 1);
		animatedSprite.add("flash", [0, 1], 10, true);
		animatedSprite.play("idle");
		this.graphic = animatedSprite;
		
		type = "orbbot";
		
		this.setHitbox(10, 10);
		
		inMotion = false;
		
		Draw.circle(100, 100, 100);
	}

	override public function update():Void 
	{
		super.update();
		
		if (Globals.orbBotMove && !inMotion)
		{
			this.seekNun();
		}
		
		if (Globals.orbBotFlash)
		{
			this.flash();
		}
		
		if (Globals.orbBotStopFlash)
		{
			this.stopFlash();
		}
		
	}
	
	public function seekNun(data:Dynamic = null ):Void
	{
		seekPos(Globals.nunPos.x, Globals.nunPos.y);
	}

	
	private function flash():Void
	{
		this.animatedSprite.play("flash");
	}
	
	private function stopFlash(): Void
	{
		this.animatedSprite.play("idle");
	}
	
	public function seekPos(x: Float, y:Float):Void
	{

		var pos:Vector2D = new Vector2D(this.x, this.y);
		var distance:Float = pos.distance(new Vector2D(x, y));
		var offsetRange:Float;
		
		if ( distance < 60 )
		{
			var xtween:VarTween = new VarTween(endMotion, TweenType.OneShot);
			xtween.tween(this, "x", x + 5,tweenTime, Ease.quadOut);
			this.addTween(xtween, true);
			
			var ytween:VarTween = new VarTween(null, TweenType.OneShot);
			ytween.tween(this, "y", y + 5, tweenTime, Ease.bounceInOut);
			this.addTween(ytween, true);
			
			return;
			
		}
		else
		{
	
			
			x = x  * (0.5  + 0.0005 *(900 - distance));
			y = y  * (0.5  + 0.0005* (900 - distance));
			
			if (distance > 150)
			{
				x = 0.4 * x;
				y = 0.4 * y; 
				offsetRange = 50;
			}
			else if (distance > 100)
			{
				x = 0.5 * x;
				y = 0.5 * y; 
				offsetRange = 20;
			}
			else if (distance > 70)
			{
				offsetRange = 5;
			}
			else
			{
				offsetRange = 3;
			}
			
			var xtween:VarTween = new VarTween(endMotion , TweenType.OneShot);
			xtween.tween(this, "x", x + Utils.randomRange(-offsetRange,offsetRange) + Utils.randomRange(-offsetRange, offsetRange/10.0),tweenTime, Ease.quadOut);
			this.addTween(xtween, true);
			
			var ytween:VarTween = new VarTween(null, TweenType.OneShot);
			ytween.tween(this, "y", y + Utils.randomRange(-offsetRange,offsetRange) + Utils.randomRange(-offsetRange, offsetRange/10.0), tweenTime, Ease.bounceInOut);
			this.addTween(ytween, true);
		}
		
		inMotion = true;

	}
	
	private function endMotion(data:Dynamic = null ):Void
	{
		inMotion = false;
	}
	
	public function explode():Void
	{
		scene.remove(this);
	}
	
	
}