import com.haxepunk.graphics.Image;
import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Draw;
import com.haxepunk.Tween; 
import com.haxepunk.tweens.misc.VarTween;
import com.haxepunk.utils.Ease;

class MainScene extends BaseWorld
{
	
	private var nun:Nun;
	private var roadGenerator:RoadGenerator;
	var music:Sfx;
	public function new()
	{
		super();
		music = new Sfx("audio/tunes.mp3");
		music.play(1, 0, true); 
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
		
		if (Globals.first)
		{
			var startingScreen:StartingScreen = new StartingScreen( 0, - HXP.height);
			var tween:VarTween = new VarTween(null, TweenType.OneShot);
			tween.tween(startingScreen, "y" , 0, 2.0, Ease.bounceOut);
			startingScreen.addTween(tween);
			
			this.add(startingScreen);
		}
	}
	
 }