package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;

/**
 * ...
 * @author Leo Mahon
 */
class Road extends ScrollingEntity
{

	private var image:Image;
	
	public function new(x:Float=0, y:Float=0, onScreenCallback:Dynamic = null, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, onScreenCallback, graphic, mask);
		
		image = new Image("graphics/road.png");
		
		this.graphic = image;
		
		this.setHitbox(image.width, image.height);
		
	}
	
	override public function update():Void 
	{
		super.update();
		
		//Padding
		this.atatchPoint.x = this.x + this.width - 2;
		
		this.atatchPoint.y = this.y;
	}
	
}