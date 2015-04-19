package ;

import com.haxepunk.Entity;
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
		
		var angle:Float = Utils.radToDeg(Math.atan( -speed.y / speed.x));
		
		
		HXP.log(Std.string(angle));
		
		if (speed.x < 0 )
		{
			if (angle > 45 && angle < 90 )
			{
				setHitbox(5, 7, 3, 5);
			}
			else if (angle < -45 )
			{
				setHitbox(5, 8, 3, 5);
			}
			else
			{
				setHitbox(8, 5, 8, 5);
			}
			
			angle += 180;	
		}
		else
		{
			if (angle > 45 && angle < 90 )
			{
				setHitbox(5, 8, 3, 5);
			}
			else if (angle < -45 )
			{
				setHitbox(5, 7, 3, 5);
			}
			else
			{
				setHitbox(8, 5, 0, 0);
			}
		}	
		image.angle = angle;
		
		this.graphic = image;
		

		
		this.speed = speed;
		
		
		
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
		
		var e:Entity = collide("orbbot", x, y);
		if (e != null)
		{
			var o:OrbBot = cast(e, OrbBot);
			o.explode();
			
		}
	}
	
}