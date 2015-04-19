package ;

import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
/**
 * ...
 * @author Leo Mahon
 */
class OrbBotControler extends BaseWorldEntity
{
	private var waitLength:Float;
	private var flashed:Bool;
	private var initiatedMovement:Bool;
	
	private var spawnPeriod:Float;
	private var spawnProbability:Float;
	private var flashSound:Sfx;
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		flashSound = new Sfx("audio/orbbotbeep.mp3");
		flashed = false;
		initiatedMovement = false;
		waitLength = 1.0;
		spawnPeriod = 5.0;
		spawnProbability  = 1.0;
	}
	
		
	override public function update():Void 
	{
		super.update();
		
		waitLength -= HXP.elapsed;
		
		if (initiatedMovement)
		{
			Globals.orbBotStopFlash = true;
			Globals.orbBotMove  = false;
			initiatedMovement  = false;
		}
		
		if (waitLength <= 1.0 && !flashed)
		{
			
			Globals.orbBotFlash = true;
			flashed = true;
			
		
		}
		
		if (waitLength <= 0)
		{
			flashSound.play();
			this.waitForDrop();
			flashed = false;
		}
		
		spawnPeriod -= HXP.elapsed;
		if (spawnPeriod <= 0)
		{
			spawnPeriod = 7 * (1.0 - Globals.orbotDificulty);
			for ( i in 0...5)
			{
				if (Math.random() < spawnProbability && !firstUpdate) 
				{
					var o:OrbBot = new OrbBot(Utils.randomRange(25, HXP.width), Utils.randomRange(0,10));
					scene.add(o);
				}
			}
		}
		
		
		
		Globals.orbotDificulty =  ((Globals.timeElapsed + 250)*(Globals.timeElapsed + 250))/ Globals.maxTime;
	
		
	}
	
		
	private function waitForDrop(data:Dynamic = null):Void
	{
		waitLength = (1 - Globals.orbotDificulty) * 5.0;
		Globals.orbBotStopFlash = true;
		Globals.orbBotMove = true;
		initiatedMovement = true;
	}
	
}