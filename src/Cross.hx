package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.HXP;

/**
 * ...
 * @author Leo Mahon
 */
class Cross extends BaseWorldEntity
{
	private var speed:Float;
	
	public function new(x:Float=0, y:Float=0, speed:Float = 200, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		this.graphic = new Image("graphics/cross.png");
		
		this.speed = speed;
		
		this.setHitbox(8,5, -13, -10);
	}
	
	override public function update():Void 
	{
		super.update();
		
		this.x += speed* HXP.elapsed;
		
		if (this.x > HXP.width)
		{
			scene.remove(this);
		}
	}
	
}