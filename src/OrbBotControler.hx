package ;

import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.HXP;
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
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		flashed = false;
		initiatedMovement = false;
		waitLength = 4.0;
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
			this.waitForDrop();
			flashed = false;
		}
		
		spawnPeriod -= HXP.elapsed;
		if (spawnPeriod <= 0)
		{
			spawnPeriod = 50 * (1.0 - Globals.orbotDificulty);
			for ( i in 0...3)
			{
				if (Math.random() < spawnProbability && !firstUpdate) 
				{
					var o:OrbBot = new OrbBot(Utils.randomRange(HXP.width - 50, HXP.width), Utils.randomRange(0,10));
					scene.add(o);
				}
			}
		}
		
		
		
		Globals.orbotDificulty =  ((Globals.timeElapsed + 250)*(Globals.timeElapsed + 250))/ Globals.maxTime;
	
		
	}
	
		
	private function waitForDrop(data:Dynamic = null):Void
	{
		waitLength = (1 - Globals.orbotDificulty) * 15.0;
		Globals.orbBotStopFlash = true;
		Globals.orbBotMove = true;
		initiatedMovement = true;
	}
	
}