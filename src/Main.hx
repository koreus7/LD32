import com.haxepunk.Engine;
import com.haxepunk.HXP;
import flash.events.Event;

class Main extends Engine
{
	public static inline var kScreenWidth:Int = 800;
	public static inline var kScreenHeight:Int = 600;
	public static inline var kFrameRate:Int = 60;
	
	function new()
	{
		super(kScreenWidth, kScreenHeight, kFrameRate, false);	
	}

	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		
		HXP.screen.scale = 2;
		HXP.scene = new MainScene();
		
	}

	public static function main() { new Main(); }
	
	
	override private function onStage(e:Event = null):Void{
		super.onStage(e);
		
		this.onResize(new Event("resize"));
		HXP.stage.addEventListener(Event.RESIZE, this.onResize);
	}
	
	public function onResize(event:Event) : Void {
	HXP.width = HXP.stage.stageWidth;
	HXP.height = HXP.stage.stageHeight;
	
	HXP.screen.scaleX = HXP.screen.scaleY = 2;
	HXP.resize(HXP.stage.stageWidth, HXP.stage.stageHeight);
	
	//HXP.screen.resize();
	}

}