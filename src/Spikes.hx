package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;

/**
 * ...
 * @author Leo Mahon
 */
class Spikes extends ScrollingEntity
{

	private var image:Image;
	
	public function new(x:Float=0, y:Float=0, onScreenCallback:Dynamic=null, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, onScreenCallback, graphic, mask);
		
		image = new Image("graphics/spikes.png");
		this.graphic = image;
		
		this.setHitbox(image.width, image.height);
		
		
	}
	
}