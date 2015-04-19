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
	private var speed:Vector2D;
	private var image:Image;
	
	public function new(x:Float=0, y:Float=0, speed:Vector2D, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		image = new Image("graphics/cross.png");
		
		
		var angle:Float = Utils.radToDeg(Math.atan(-speed.y / speed.x));
		if (speed.x < 0 )
		{
			angle += 180;
		}
		HXP.log(Std.string(angle));
		
		
		image.angle = angle;
		
		
		HXP.log ((Std.string(Math.atan(speed.y / speed.x))));
		
		this.graphic = image;
		

		
		this.speed = speed;
		
		this.setHitbox(8, 5, -13, -10);
		
	}
	
	override public function update():Void 
	{
		super.update();
		
		this.x += speed.x* HXP.elapsed;
		this.y += speed.y* HXP.elapsed;
		
		if (this.x > HXP.width || this.x + this.width + 10 < 0 || this.y + this.height + 10 < 0 || this.y > HXP.height)
		{
			scene.remove(this);
		}
	}
	
}