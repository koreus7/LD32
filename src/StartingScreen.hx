package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

/**
 * ...
 * @author Leo Mahon
 */
class StartingScreen extends BaseWorldEntity
{

	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		this.graphic = new Image("graphics/startScreen.png");
		
		
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (Input.pressed(Key.X))
		{
			Globals.started = true;
			scene.remove(this);
		}
	}
	
}