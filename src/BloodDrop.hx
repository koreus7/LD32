package ;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
/**
 * ...
 * @author Leo Mahon
 */
class BloodDrop extends BaseWorldEntity
{

	private var velocity		:Vector2D;
	private var acceleration	:Vector2D;
	private var maxVelocity		:Vector2D;
	private var image			:Image;
	
	public function new(x:Float=0, y:Float=0, velocity:Vector2D, graphic:Graphic=null, mask:Mask=null) 
	{
		
		super(x, y, graphic, mask);
		acceleration	= new Vector2D(0, 0.2);
	    maxVelocity		= new Vector2D(3, 5);
		
		image = new Image("graphics/bloodDrop.png");
			
		this.graphic = image;
		
		layer = Layers.top;
		
		setHitbox(4, 4);
		
		this.velocity = velocity;
		
	}
	
	public function setVelocity(value:Vector2D):Void
	{
		velocity = value;
	}
	
	override public function update():Void
	{
		super.update();
		if (velocity.y < maxVelocity.y)
		{
			velocity.y += acceleration.y;
		}
		
		velocity.x *= HXP.elapsed * 10;
		
		if (this.x > HXP.width || this.x + this.width + 10 < 0 || this.y + this.height + 10 < 0 || this.y > HXP.height)
		{
			scene.remove(this);
		}
		
		x += velocity.x ;
		
		y += velocity.y ;
		
	}
}