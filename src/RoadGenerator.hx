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

	public static inline var roadWidth = 32;
	public static inline var roadHeight = 32;
	
	//No once would play for over 72 hours, would they?
	private static inline var maxTime = 259200;
	
	private var generatedSpikesLast:Bool;
	
	public var timeElapsed: Float ;
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		timeElapsed = 0;
		generatedSpikesLast = false;
	}
	
	override public function update():Void 
	{
		super.update();
		
		timeElapsed += HXP.elapsed;
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
		
		var percentage:Float = ((timeElapsed + 200)*(timeElapsed + 200))/ RoadGenerator.maxTime;
		HXP.log(Std.string(percentage));
		if ( Math.random() < percentage && !generatedSpikesLast)
		{
			var s:Spikes = new Spikes(atatchPoint.x , atatchPoint.y -4, null);
			scene.add(s);
			generatedSpikesLast = true;
		}
		else
		{
			generatedSpikesLast = false;
		}
		
		
	}
	
	
	
}