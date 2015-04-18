package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Mask;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import com.haxepunk.Tween.TweenType;
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
	private var jumpHeight:Float;
	private var skateBoard:SkateBoard;
	private var inTheAir:Bool;
	private var onSkateBoard:Bool;
	
	public function new(x:Float=100, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		y = HXP.height - 24;
		jumpHeight = 30;
		super(x, y, graphic, mask);
		
		animatedSprite  = new Spritemap("graphics/nun.png", 24, 24);
		
		animatedSprite.add("static", [0], 10);
		//animatedSprite.add("ollie", [0, 0,0,0,0, 14, 14, 14, 14, 14, 15, 15, 15], 20, false);
		animatedSprite.add("ollieUp", [14,14,14,14, 8,8,8,9,9,9], 33, false);
		animatedSprite.add("ollieDown", [15], 20, true);
		animatedSprite.add("idle", [0, 5], 8);
		animatedSprite.add("run", [1, 2, 3], 10);
		animatedSprite.add("jump", [1, 4], 10, false);
		animatedSprite.add("ollieWindup", [1, 4], 10, false);
		animatedSprite.play("idle");
		
		inTheAir = false;
		onSkateBoard = true;
		
		this.graphic = animatedSprite;
	}
	
	
	override public function update():Void 
	{
		
		super.update();
		if (Input.check(Key.UP))
		{
			inTheAir = true;
			this.startOllie();
		}
		
		if (animatedSprite.complete  && animatedSprite.currentAnim == "ollieWindup")
		{
			ollieUp();
		}
		
		if (onSkateBoard)
		{
			snapSkateboard();
		}
		
	}
	
	public function snapSkateboard():Void
	{
		this.skateBoard.x = x; 
		this.skateBoard.y = y;
	}
	
	public function startOllie():Void
	{
		animatedSprite.play("ollieWindup");
	}

	public function ollieUp():Void
	{
		animatedSprite.play("ollieUp");
		var tween:VarTween = new VarTween(this.finishOllieDown, TweenType.OneShot);
		tween.tween(this, "y", y - jumpHeight, 0.3, Ease.expoOut);
		this.addTween(tween, true);
	}
	
	public function finishOllieDown(data:Dynamic = null ):Void
	{
		
		animatedSprite.play("ollieDown");
		skateBoard.ollieDown();
		
		var tween:VarTween = new VarTween(landOllie, TweenType.OneShot);
		tween.tween(this, "y", y + jumpHeight, 0.16, Ease.quadOut);
		this.addTween(tween, true);
	}
	
	
	public function fall(data: Dynamic):Void
	{
		var tween:VarTween = new VarTween(goIdle, TweenType.OneShot);
		tween.tween(this, "y", y + jumpHeight, 0.1, Ease.quadOut);
		this.addTween(tween, true);
	}
	
	
	public function landOllie(data:Dynamic = null):Void
	{
		HXP.log("Landed");
		this.skateBoard.goStatic();
		goIdle();
	}
	
	public function goIdle(data: Dynamic = null):Void
	{
		animatedSprite.play("idle"); 
		inTheAir = false;
	}
	
	override public function firstUpdateCallback():Void 
	{
		super.firstUpdateCallback();
		
		this.skateBoard = new SkateBoard();
		scene.add(skateBoard);
	}
	
}