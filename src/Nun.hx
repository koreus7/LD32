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
	private var ollieLandTimer:TimerEntity;
	private var jumpUpTime:Float; 
	
	public function new(x:Float=100, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		jumpHeight = 40;
		jumpUpTime = 0.7;
		super(x, y, graphic, mask);
		
		animatedSprite  = new Spritemap("graphics/nun.png", 24, 24);
		
		animatedSprite.add("static", [0], 10);
		//animatedSprite.add("ollie", [0, 0,0,0,0, 14, 14, 14, 14, 14, 15, 15, 15], 20, false);
		animatedSprite.add("ollieUp", [14,14,14,9, 9,9,8,8,8,8], 10/jumpUpTime, false);
		animatedSprite.add("ollieDown", [15,16,17,18,19], 31.25, false);
		animatedSprite.add("idle", [0, 5], 8);
		animatedSprite.add("run", [1, 2, 3], 10);
		animatedSprite.add("jump", [4], 10, false);
		animatedSprite.add("ollieWindup", [10], 5, false);
		animatedSprite.play("idle");
		
		inTheAir = false;
		onSkateBoard = true;
		
		this.graphic = animatedSprite;
		//this.visible = false;
		
		this.setHitbox(12, 20, -6, -3);
	}
	
	
	override public function update():Void 
	{
		
		super.update();
		if (Input.check(Key.UP) && !inTheAir)
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
		this.skateBoard.ollieUp();
		var tween:VarTween = new VarTween(this.finishOllieDown, TweenType.OneShot);
		tween.tween(this, "y", y - jumpHeight, jumpUpTime, Ease.quadOut);
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
		ollieLandTimer = new TimerEntity(0.08, balanceOllieAtFinish);
		scene.add(ollieLandTimer);
		
		var cross:Cross = new Cross(x, y);
		scene.add(cross);
		baseWorld.shakeScreen(0.15);

	}
	
	public function balanceOllieAtFinish(data:Dynamic = null):Void
	{
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