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
	
	private var firstUpdate:Bool;
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		this.baseWorld = cast(this.scene, BaseWorld);
		
		firstUpdate = true;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (firstUpdate)
		{
			firstUpdateCallback();
			firstUpdate = false;
		}
	}
	
	private function firstUpdateCallback():Void
	{
		//Override this
	}
	
}