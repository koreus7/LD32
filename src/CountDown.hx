package ;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.tweens.misc.VarTween;
import com.haxepunk.Tween;
import com.haxepunk.utils.Ease;

/**
 * ...
 * @author Leo Mahon
 */
class CountDown extends Entity
{
	private var time:UInt;
	private var timeLeft:UInt;
	private var secondTimer:Float;
	
	private var baseWorld:BaseWorld;
	private var firstUpdate:Bool;
	private var numberGraphic:Text;
	private var countDownSound:Sfx;
	private var countDownFinishSound:Sfx;
	
	public function new() 
	{	
		super();
		time = 3;
		timeLeft = time;
		secondTimer = 0.7;
		numberGraphic = new Text(Std.string(timeLeft));
		
		countDownSound = new Sfx("sfx/countdown.wav");
		countDownFinishSound = new Sfx("sfx/countdownEnd.wav");
		firstUpdate = true;
		
		graphic = numberGraphic;
	}
	
	override public function update():Void
	{
		if ( firstUpdate )
		{
			this.baseWorld = cast(scene, BaseWorld);
			
			firstUpdate = false;
		}
		if (secondTimer > 0)
		{
			secondTimer -= HXP.elapsed;
		}
		else if(timeLeft >0)
		{
			countDownSound.play();
			baseWorld.shakeScreen(0.2);
			secondTimer = 0.7;
			numberGraphic = new Text (Std.string(timeLeft));
			numberGraphic.scale = 5.0;
			
			x = HXP.width;
			y = HXP.halfHeight  - (numberGraphic.height*numberGraphic.scale) / 2;
			
			
			var tween:VarTween = new VarTween(null, TweenType.Persist);
			tween.tween(this, "x", HXP.halfWidth -(numberGraphic.width * numberGraphic.scale)/2, 0.5, Ease.expoOut);
			this.addTween(tween, true);
			
			graphic = numberGraphic;
			
			timeLeft -= 1;
			
		}
		else
		{
			countDownFinishSound.play();
			numberGraphic = new Text("FIGHT!");
			baseWorld.startTrackingPlayers();
			numberGraphic.scale = 4.0;
			graphic = numberGraphic;
			
			x = HXP.halfWidth - (numberGraphic.width * numberGraphic.scale) / 2;
			y = HXP.halfHeight - (numberGraphic.height * numberGraphic.scale) / 2;
			
			
			var tween:VarTween = new VarTween(destroyThis, TweenType.Persist);
			tween.tween(this.numberGraphic, "alpha", 0.0, 0.4, Ease.expoOut);
			
			this.addTween(tween, true);
			
			
		}
		
		
	}
	
	public function destroyThis(data:Dynamic = null)
	{
		scene.remove(this);
	}
	
}