package ;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;

/**
 * ...
 * @author ...
 */
class BaseWorldEntity extends Entity
{
	
	private var baseWorld:BaseWorld;
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		this.baseWorld = cast(this.scene, BaseWorld);
		
	}
	
}