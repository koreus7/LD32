import com.haxepunk.graphics.Image;
import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.utils.Draw;

class MainScene extends BaseWorld
{
	
	private var nun:Nun;
	private var roadGenerator:RoadGenerator;
	
	public function new()
	{
		super();
		
		var e:BaseWorldEntity = new BaseWorldEntity();
		e.graphic = new Image("graphics/background.png");
		e.layer = Layers.backBack;
		this.add(e);
		
		this.roadGenerator = new RoadGenerator();
		this.add(roadGenerator);
	
		this.nun = new Nun(50, HXP.height - 24 -RoadGenerator.roadHeight);
		this.add(nun);
		
		var oc:OrbBotControler = new OrbBotControler();
		this.add(oc);
		
		var hud:Hud = new Hud();
		this.add(hud);
	}
	
 }