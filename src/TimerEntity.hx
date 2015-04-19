package ;

/**
 * ...
 * @author Leo Mahon
 */

import com.haxepunk.Entity;
import com.haxepunk.HXP; 


class TimerEntity extends Entity
{
	private var  _callback:Dynamic;
	
	private var time:Float;
	
	private var timeElapsed:Float;

	private var reusable:Bool;
		
	public function new(time:Float,_callback,reusable:Bool = false):Void
	{
		super();
		
		timeElapsed = 0;
		this.time = time;
		this._callback = _callback;
	
		this.reusable = reusable;
	}
	
	public function reset():Void
	{
		timeElapsed = 0;
	}
	
	override public function update():Void
	{

		timeElapsed += HXP.elapsed;
		
		if (timeElapsed >= time)
		{
			_callback();
			if (!reusable)
			{
				scene.remove(this);
			}
		}

	}
	
	public function running():Bool
	{
		return(timeElapsed < time);
	}
	
}