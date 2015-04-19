package ;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Mask;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.Tween;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import com.haxepunk.Tween.TweenType;
import com.haxepunk.tweens.misc.VarTween;
import com.haxepunk.tweens.motion.QuadMotion;
import com.haxepunk.utils.Ease;
import com.haxepunk.utils.Draw;
import com.haxepunk.graphics.Image;
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
	private var exploded:Bool;
	
	private var ollieUpTween:VarTween; 
	private var ollieDownTween:VarTween; 
	private var groundDistance:Float;
	private var crossSound:Sfx;
	private var dieSound:Sfx;
	private var ollieSound:Sfx;
	
	public function new(x:Float=100, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		
		ollieSound = new Sfx("audio/ollie.mp3");

		crossSound = new Sfx("audio/crossThrow.mp3");
		dieSound = new Sfx("audio/squelch.mp3");
		super(x, y, graphic, mask);
		
		jumpHeight = 50;
		jumpUpTime = 0.6;
		groundDistance = 0;

		exploded = false;
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
		
		groundDistance = (HXP.height - 32) - (this.y + this.height) + 2;
		
		if (Input.check(Key.X))
		{
			if (!inTheAir)
			{
				inTheAir = true;
				this.startOllie();
				ollieSound.play();
			}
		}
		else if (inTheAir &&  this.animatedSprite.currentAnim == "ollieUp")
		{
			ollieUpTween.cancel(); 
			this.finishOllieDown();
		}
		
		if (animatedSprite.complete  && animatedSprite.currentAnim == "ollieWindup")
		{
			ollieUp();
		}
		
		if (onSkateBoard)
		{
			snapSkateboard();
		}
		
		Globals.nunPos.x = x;
		Globals.nunPos.y = y;
		
		if (collide("spikes", x, y) != null && !exploded ) 
		{
			explode();
			this.exploded = true;
			
		}
		
		var e:Entity = collide("orbbot", x, y);
		
		if ( e != null)
		{
			var o:OrbBot = cast(e, OrbBot);
			o.explode();
			this.explode();
		}

	}
	
	public function explode():Void
	{
		var b:BloodExplosion = new BloodExplosion(x + 10, y + 10);
		b.layer = Layers.top;
		scene.add(b);
		dieSound.play();
		die();
	}
	
	public function die():Void
	{
		scene.remove(this);
		scene.add(new GameOverEntity());
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
		
		
		ollieUpTween =   new VarTween(this.finishOllieDown, TweenType.OneShot);	
		ollieUpTween.tween(this, "y", y - jumpHeight, jumpUpTime, Ease.quadOut);
		this.addTween(ollieUpTween, true);
	}
	
	public function finishOllieDown(data:Dynamic = null ):Void
	{
		
		animatedSprite.play("ollieDown");
		skateBoard.ollieDown();
		ollieDownTween = new VarTween(landOllie, TweenType.OneShot);
		ollieDownTween.tween(this, "y", y + groundDistance, 0.16, Ease.quadOut);
		this.addTween(ollieDownTween, true);
	}
	
	
	public function fall(data: Dynamic):Void
	{
		var tween:VarTween = new VarTween(goIdle, TweenType.OneShot);
		tween.tween(this, "y", y + jumpHeight, 0.1, Ease.quadOut);
		this.addTween(tween, true);
	}
	
	
	public function landOllie(data:Dynamic = null):Void
	{
		ollieSound.play();
		ollieLandTimer = new TimerEntity(0.08, balanceOllieAtFinish);
		
		scene.add(ollieLandTimer);
		
		var xOff:Float = 0.0;
		var yOff:Float = 0.0;
		
		if (Input.mouseX - (x + halfWidth) < 0)
		{
			yOff = 3.0;
		}
		else
		{
			yOff = -3.0;
		}
		
		var vel:Vector2D = new Vector2D(Input.mouseX - (x + halfWidth) + xOff, Input.mouseY - (y + halfHeight) + yOff);
		vel.scale(1.0);
		
		
		//TO DO 
		//Draw.line(Math.floor(x + 14), Math.floor(y + 12), Math.floor(vel.x), Math.floor(vel.y));
		
		
		var cross:Cross = new Cross(x + 14, y + 12, vel);
		cross.layer = Layers.top;
		scene.add(cross);
		baseWorld.shakeScreen(0.15);
		crossSound.play();
		

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