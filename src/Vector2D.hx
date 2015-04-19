package ;

/**
 * ...
 * @author Leo Mahon
 */
class Vector2D
{
	public var x:Float;
	public var y:Float;

		
	public function new(x:Float,y:Float) 
	{
		this.x = x;
		this.y = y;
	}
	
	public function add(v : Vector2D) : Void
	{
		x += v.x;
		y += v.y;
	}
	
	public function scale(k: Float) : Void
	{
		x *= k;
		y *= k;
	}
	
	public function returnScaled(k: Float) : Vector2D
	{
		return new Vector2D(x * k, y * k);
	}
}