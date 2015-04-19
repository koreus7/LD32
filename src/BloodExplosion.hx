package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Ease;
import com.haxepunk.HXP;
/**
 * ...
 * @author Leo Mahon
 */
class BloodExplosion extends BaseWorldEntity
{

	private var lifeTime		:Float		;
	private var timeElapsed		:Float		;
	
	private var emitter			:Emitter	;
	
	private var numParticles	:UInt		;
	
	private var sound			:Sfx		;
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		layer = Layers.top;
		lifeTime 		= 0.4;
		timeElapsed 	= 0		;
		numParticles	= 500	;
		type = "bloodExplosion";
		
		emitter = new Emitter("graphics/bloodDrop.png", 4, 8 );
		
		emitter.newType("explode",[0]);
		
		emitter.setAlpha("explode", 1.0, 0, Ease.quadInOut);
		
		emitter.setGravity("explode",2);
		
		emitter.setMotion("explode", 0, 32, 3.0, 360,32, 3,Ease.expoOut);
		
		graphic = emitter;
		
		this.graphic = emitter;
		
		setHitbox(16, 16);
		
		for (i in 0...numParticles)
		{
			emitter.emit("explode", centerX , centerY);
		}
		
	}
	
	override public function update():Void
	{	
		timeElapsed += HXP.elapsed;
		
		if (timeElapsed > lifeTime)
		{
			scene.remove(this);
		}
		var vel:Vector2D = new Vector2D(200.0 * Math.random() * Utils.randSign(), 10.0 * Math.random() * Utils.randSign());
		var b:BloodDrop = new BloodDrop(x,y, vel);
		
		scene.add(b);
		vel = new Vector2D(200.0 * Math.random() * Utils.randSign(), 10.0 * Math.random() * Utils.randSign());
		b = new BloodDrop(x,y, vel);
		
		scene.add(b);
		
	}
	
}