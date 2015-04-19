package ;
import com.haxepunk.HXP;
/**
 * ...
 * @author Leo Mahon
 */
class Utils
{

	public function new() 
	{
		
	}
	
	public static inline function radToDeg(angle:Float):Float
	{
		return 57.2957795 * angle;
	}
		
	public static inline function randInt(max:Int):Int
	{
		return Math.floor(Math.random() * max);
	}
	
	public static function randSign():Int 
	{
		if (Math.random() > 0.5)
		{
			return -1;
		}
		else
		{
			return 1;
		}
	}
	
	public static inline function mod(value:Float):Float
	{
		return value < 0 ? -value : value;
	}
	
	public static inline function randomRange(lowerBound:Float, upperBound:Float):Float
	{
		return lowerBound + Math.random() * (upperBound - lowerBound + 1);
	}
	
	public static inline function onScreen(x, y, width, height)
	{
		return x > HXP.width || x + width < 0 || y + height  < 0 || y > HXP.height;
	}
	
	//Take a time in seconds and make it a string with minutes and seconds seperated by a colon
	public static function formatTime(value:Float):String
	{
		var valueString:String = "";
		
		valueString += Std.string( Math.floor(value / 60));
		valueString += ":";
		
		var seconds:String = Std.string(value - 60 * Math.floor(value / 60)); 
		
		if (seconds.length == 1)
		{
			seconds += "0";
		}
		else if (seconds.length > 1)
		{
			seconds = seconds.substr(0, 2);
		}
		
		valueString += seconds;
		
		return valueString;
	}
}