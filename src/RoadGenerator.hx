package ;

import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.HXP;

/**
 * ...
 * @author Leo Mahon
 */
class RoadGenerator extends BaseWorldEntity
{

	public static inline var roadWidth = 16;
	public static inline var roadHeight = 32;
	
	//No once would play for over 72 hours, would they?
	private static inline var maxTime = 259200;
	
	public var timeElapsed: Float ;
	
	private var spikePeriod:Float;
	
	private var minimumSeperation:Float;
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		timeElapsed = 0;
		
		Globals.maxTime = maxTime;
		
		spikePeriod = 0.0;
		minimumSeperation = 32;
	}
	
	override public function update():Void 
	{
		super.update();
		timeElapsed += HXP.elapsed;
		Globals.timeElapsed = timeElapsed;
		
		if (spikePeriod > 0)
		{
			spikePeriod -= HXP.elapsed;
		}
		else if (!firstUpdate) 
		{
			var percentage:Float = ((timeElapsed + 200)*(timeElapsed + 200))/ RoadGenerator.maxTime;
			spikePeriod = Math.random() * 2.0 / percentage;
			// Minimum seperation.
			if (spikePeriod * Globals.scrollSpeed < minimumSeperation)
			{
				spikePeriod = 32 / Globals.scrollSpeed;
			}
			
			
			var s:Spikes = new Spikes(HXP.width + Globals.generationOffset, HXP.height - roadHeight - 4);
			scene.add(s);
			
		}
	}
	
	override public function firstUpdateCallback():Void 
	{
		super.firstUpdateCallback();
		
		//Generate starting road
		for (i in 0...Math.floor(((HXP.width + Globals.generationOffset) / roadWidth )))
		{
			var road:Road;			
			road = new Road(i * roadWidth, HXP.height - roadHeight);
			scene.add(road); 
		}
		
		var road:Road = new Road( Math.floor(((HXP.width + Globals.generationOffset) / roadWidth ))* roadWidth, HXP.height - roadHeight, this.generateNextBlock);
		scene.add(road);
	}
	
	public function generateNextBlock(atatchPoint:Vector2D):Void
	{
		var road = new Road(atatchPoint.x, atatchPoint.y, generateNextBlock);
		scene.add(road);
		
		//var percentage:Float = ((timeElapsed + 200)*(timeElapsed + 200))/ RoadGenerator.maxTime;
		/*if ( Math.random() < percentage || true)//&&!generatedSpikesLast)
		{
			var s:Spikes = new Spikes(atatchPoint.x , atatchPoint.y -4, null);
			scene.add(s);
		}*/
		
		
	}
	
	
	
}