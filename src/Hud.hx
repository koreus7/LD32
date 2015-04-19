package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Text;
import com.haxepunk.Mask;

/**
 * ...
 * @author Leo Mahon
 */
class Hud extends BaseWorldEntity
{

	private var graphics:Graphiclist;
	private var scoreGraphic:Text;
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		layer = Layers.hud;
		
		scoreGraphic = new Text(Std.string(Globals.score), 50, 100);
		this.graphic = scoreGraphic;
	}
	
	override public function update():Void 
	{
		scoreGraphic.text = Std.string(Globals.score);
		super.update();
	}
	
}