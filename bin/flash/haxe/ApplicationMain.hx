#if !macro


@:access(lime.Assets)


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	
	public static function create ():Void {
		
		var app = new lime.app.Application ();
		app.create (config);
		openfl.Lib.application = app;
		
		#if !flash
		var stage = new openfl.display.Stage (app.window.width, app.window.height, config.background);
		stage.addChild (openfl.Lib.current);
		app.addModule (stage);
		#end
		
		var display = new com.haxepunk.Preloader ();
		
		preloader = new openfl.display.Preloader (display);
		preloader.onComplete = init;
		preloader.create (config);
		
		#if (js && html5)
		var urls = [];
		var types = [];
		
		
		urls.push ("graphics/debug/console_debug.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/debug/console_hidden.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/debug/console_logo.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/debug/console_output.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/debug/console_pause.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/debug/console_play.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/debug/console_step.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/debug/console_visible.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/preloader/haxepunk.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("04b03");
		types.push (lime.Assets.AssetType.FONT);
		
		
		urls.push ("font/04B_03__.ttf.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/background.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/bloodDrop.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/concept.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/cross.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/enemy.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/explosion.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/nun.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/road.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/skateboard.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/spikes.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("graphics/startScreen.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("audio/ollie.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("audio/orbbotbeep.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("audio/orbotdie.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("audio/powerup.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("audio/squelch.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("audio/tunes.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("04b03");
		types.push (lime.Assets.AssetType.FONT);
		
		
		
		if (config.assetsPrefix != null) {
			
			for (i in 0...urls.length) {
				
				if (types[i] != lime.Assets.AssetType.FONT) {
					
					urls[i] = config.assetsPrefix + urls[i];
					
				}
				
			}
			
		}
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if (sys && !nodejs && !emscripten)
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (__) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		preloader = null;
		
		
		
		if (loaded == total) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			antialiasing: Std.int (0),
			background: Std.int (3355443),
			borderless: false,
			company: "",
			depthBuffer: false,
			file: "Main2",
			fps: Std.int (30),
			fullscreen: false,
			height: Std.int (600),
			orientation: "",
			packageName: "com.example.app",
			resizable: true,
			stencilBuffer: true,
			title: "HXPTest",
			version: "1.0.0",
			vsync: false,
			width: Std.int (800),
			
		}
		
		#if (js && html5)
		#if (munit || utest)
		openfl.Lib.embed (null, 800, 600, "333333");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		var hasMain = false;
		var entryPoint = Type.resolveClass ("Main");
		
		for (methodName in Type.getClassFields (entryPoint)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		lime.Assets.initialize ();
		
		if (hasMain) {
			
			Reflect.callMethod (entryPoint, Reflect.field (entryPoint, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			/*if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}*/
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		
	}
	
	
	#if neko
	@:noCompletion public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


@:build(DocumentClass.build())
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					openfl.Lib.current.addChild (this);
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end
