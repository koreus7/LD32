package ;

import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.HXP;
/**
 * ...
 * @author Leo Mahon
 */

 
class ScrollingEntity extends BaseWorldEntity
{
	
	private var scrollSpeed:Float;
	private var onScreenCallback:Dynamic;
	private var calledOnScreenCallBack:Bool;
	private var atatchPoint:Vector2D;
	
	public function new(x:Float=0, y:Float=0, onScreenCallback:Dynamic = null, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		scrollSpeed = Globals.scrollSpeed;
		
		this.onScreenCallback = onScreenCallback;
		
		calledOnScreenCallBack = false;
		this.atatchPoint = new Vector2D(0, 0);
		
	}
	
	override public function update():Void 
	{
		super.update();
		
		this.x -= scrollSpeed * HXP.elapsed;
		
		//Let the generator know to put the next thing in
		if (this.x + this.width < HXP.width + Globals.generationOffset && !calledOnScreenCallBack)
		{

			if (this.onScreenCallback != null && !calledOnScreenCallBack)
			{
				this.onScreenCallback(atatchPoint);
			}
			
			calledOnScreenCallBack = true;
		}
		
		
		//Ten is for padding
		if (this.x + this.width + 10 < 0)
		{
			this.die();
		}
	
	}
	
	public function die():Void
	{
		scene.remove(this);
	}
	
	
}