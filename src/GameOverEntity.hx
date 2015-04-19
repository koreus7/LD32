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
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
	}
	
	override public function update():Void 
	{
		super.update();
		
		if ( Input.check(Key.X) )
		{
			Globals.timeElapsed = 0;
			HXP.scene = new MainScene();
		}
	}
	
}