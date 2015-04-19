package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Mask;

/**
 * ...
 * @author Leo Mahon
 */
class Spikes extends ScrollingEntity
{

	private var image:Image;
	private var animatedSprite:Spritemap;
	
	public function new(x:Float=0, y:Float=0, onScreenCallback:Dynamic=null, graphic:Graphic=null, mask:Mask=null) 
	{

		super(x, y + 6, onScreenCallback, graphic, mask);
		
		type = "spikes";
		
		animatedSprite = new Spritemap("graphics/spikes.png", 4, 4);
		animatedSprite.add("flash", [0, 1], 20);
		animatedSprite.play("flash");
		
		this.graphic = animatedSprite;
		
		this.setHitbox(4, 4);
		
		
		
	}
	
}