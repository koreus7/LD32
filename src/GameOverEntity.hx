package ;

import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;
import com.haxepunk.Tween; 
import com.haxepunk.tweens.misc.VarTween;
import com.haxepunk.utils.Ease;

/**
 * ...
 * @author Leo Mahon
 */
class GameOverEntity extends BaseWorldEntity
{
	private var delay = 1.0;
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		Globals.first = false;
	}
	
	override public function update():Void 
	{
		super.update();
		
		delay -= HXP.elapsed;
		if ( delay <= 0 && Input.check(Key.X) )
		{
			Globals.started = false;
			Globals.timeElapsed = 0;
			Globals.score = 0;
			HXP.scene = new MainScene();
			

		}
	}
	
	override public function firstUpdateCallback():Void 
	{
		super.firstUpdateCallback();
		
					
			var startingScreen:StartingScreen = new StartingScreen( 0, - HXP.height);
			var tween:VarTween = new VarTween(null, TweenType.OneShot);
			tween.tween(startingScreen, "y" , 0, 2.0, Ease.bounceOut);
			startingScreen.addTween(tween);
			scene.add(startingScreen);

	}
	
}