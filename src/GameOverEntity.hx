package ;

import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;
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
	}
	
	override public function update():Void 
	{
		super.update();
		
		delay -= HXP.elapsed;
		if ( delay <= 0 && Input.check(Key.X) )
		{
			Globals.timeElapsed = 0;
			Globals.score = 0;
			HXP.scene = new MainScene();
		}
	}
	
}