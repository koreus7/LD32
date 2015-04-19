package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Ease;

/**
 * ...
 * @author Leo Mahon
 */
class Explosion extends BaseWorldEntity
{
	private var lifeTime:Float;
	private var timeElapsed:Float;
	public var emitter:Emitter;
	public var numParticles:UInt;
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		

		
		lifeTime 		= 	0.3;
		timeElapsed 	= 	0;
		numParticles 	= 	100;
		
		emitter = new Emitter("graphics/explosion.png", 32, 32);
		
		emitter.newType("explode");
		
		emitter.setAlpha("explode", 0.5, 0, Ease.expoOut);
		
		emitter.setGravity("explode",1);
		
		emitter.setMotion("explode", 0, 16, 0.005, 360,16, 3,Ease.expoOut );
		
		emitter.setColor("explode", 0xff0000, 0xfcff00, Ease.expoOut);
		
		//this.graphic = emitter;
		
		emitter.x -= 50;
		emitter.y -= 50;
		
		for (i in 0...numParticles)
		{
			emitter.emit("explode", centerX + 8, centerY + 8);
		}
	}
	override public function firstUpdateCallback():Void 
	{
		super.firstUpdateCallback();

	}
	override public function update():Void
	{	
		timeElapsed += HXP.elapsed;
		if (!firstUpdate)
		{
			this.baseWorld.shakeScreen(0.2);
			
		}
		if (timeElapsed > lifeTime)
		{
			scene.remove(this);
		}
		
		//Emitter broken so here is a filthy hack
		var vel:Vector2D = new Vector2D(200.0 * Math.random() * Utils.randSign(), 20.0 * Math.random() * Utils.randSign());
		var b:BloodDrop = new BloodDrop(x,y, vel);
		b.graphic = new Image("graphics/explosion.png");
		scene.add(b);
	}
	
	
}