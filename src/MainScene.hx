import com.haxepunk.graphics.Image;
import com.haxepunk.Scene;

class MainScene extends BaseWorld
{
	public function new()
	{
		super();
		
		var e:BaseWorldEntity = new BaseWorldEntity();
		e.graphic = new Image("graphics/background.png");
		this.add(e);
		this.add(new Nun());
	}
	  
 }