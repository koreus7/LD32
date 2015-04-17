package ;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.utils.Key;
/**
 * ...
 * @author ...
 */

 
class Glow extends BaseWorldEntity
{

	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		this.graphic = new Image("graphics/player.png");
		
	}
	
	override public function update():Void
	{
		if (Input.check(Key.RIGHT))
		{
			this.x += 200 * HXP.elapsed;
		}
	}
}