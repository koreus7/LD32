package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Scene;
import com.haxepunk.HXP;
import flash.display.BitmapData;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.gui.Button;
import flash.geom.Rectangle;
/**
 * ...
 * @author Leo Mahon
 */
class BaseWorld extends Scene
{
	
	private var paused:Bool;
	private var muted:Bool;
	private var panTargetX:Float;
	private var panTargetY:Float;
	private var basePanSpeed:Float;
	private var panSpeed:Float;
	
	private var zoomTarget:Float;
	private var currentZoom:Float;
	private var zoomSpeed:Float;
	
	private var shakeTimer:Float;
	private var shakeOffsetX:Float;
	private var shakeOffsetY:Float;
	

	public function new() 
	{
		super();

		shakeTimer = 0.0;
		shakeOffsetX = 0.0;
		shakeOffsetY = 0.0;
		zoomSpeed = 1.0;
		currentZoom = 1.0;
		zoomTarget = 1.0;
		
		panTargetX = 0.0;
		panTargetY = 0.0;
		basePanSpeed  = 325.0;
		panSpeed = basePanSpeed / currentZoom;

		muted = false;

	}
	
	
	public function goBack():Void
	{
		//TO DO
	}
	
	public function toggleMute(data:Dynamic):Void
	{
		muted = !muted;

		if (muted)
		{
			HXP.volume = 0.0;
		}
		else
		{
			HXP.volume = 1.0;
		}
	}
	
	override public function update():Void
	{
		super.update();
		

		this.updateScreenShake();
		if (Input.pressed(Key.ESCAPE))
		{
			if (paused)
			{
				this.unPause();
			}
			else
			{
				this.pause();
			}
		}
	}
	
	public function freezePlay():Void
	{

		//TO DO
	}
	
	public function unFreezePlay():Void
	{
		//TO DO
	}
	
	
	public function pause():Void
	{
		freezePlay();
		
		this.paused = true;
	}
	
	public function unPause():Void
	{
		unFreezePlay();
		
		this.paused = false;
	}

	public function shakeScreen(shakeTime:Float):Void 
	{
		if (shakeTime > shakeTimer)
		{
			shakeTimer = shakeTime;
		}
	}
	

	public function updateScreenShake():Void
	{
		if (shakeTimer > 0)
		{
			
			shakeOffsetX = Utils.randomRange( -shakeTimer, shakeTimer)*22.0/currentZoom;
			shakeOffsetY = Utils.randomRange( -shakeTimer, shakeTimer)*22.0/currentZoom;
			shakeTimer -= HXP.elapsed;			
		}
		else
		{
			shakeOffsetX = 0.0;
			shakeOffsetY = 0.0;
		}
		
		
		
		panSpeed = basePanSpeed / currentZoom;

		if (HXP.camera.x != panTargetX)
		{
			if ( Math.abs(HXP.camera.x - panTargetX) < HXP.elapsed * panSpeed)
			{
				HXP.camera.x = panTargetX;
			}
			else if (HXP.camera.x < panTargetX)
			{
				HXP.camera.x += HXP.elapsed * panSpeed;
			}
			else
			{
				HXP.camera.x -= HXP.elapsed * panSpeed;
			}
		}
		
		
		if (HXP.camera.y != panTargetY)
		{
			if ( Math.abs(HXP.camera.y - panTargetY) < HXP.elapsed * panSpeed)
			{
				HXP.camera.y = panTargetY;
			}
			else if (HXP.camera.y < panTargetY)
			{
				HXP.camera.y += HXP.elapsed * panSpeed;
			}
			else
			{
				HXP.camera.y -= HXP.elapsed * panSpeed;
			}
		}
	
		
		if (currentZoom  != zoomTarget)
		{
			if ( Math.abs(currentZoom - zoomTarget) <= zoomSpeed  * HXP.elapsed)
			{
				currentZoom = zoomTarget;
			}
			else if ( currentZoom < zoomTarget)
			{
				currentZoom += zoomSpeed * HXP.elapsed;
			}
			else
			{
				currentZoom -= zoomSpeed * HXP.elapsed;
			}
			
			setZoom(currentZoom);
		}
		
	}
	
	public function setZoomTarget(value:Float)
	{
		this.zoomTarget = value;
	}
	
	public function setPanTarget(x:Float, y:Float)
	{
		if (x < 0) x = 0;
		if (y < 0) y = 0;
		
		if (x + HXP.width > this.mapWidth())
		{
			x = this.mapWidth() - HXP.width;
		}
		
		if (y + HXP.height > this.mapHeight())
		{
			y = this.mapHeight() - HXP.height;
		}
		
		this.panTargetX = x + shakeOffsetX;
		this.panTargetY = y + shakeOffsetY;
	}
	
	public function setZoomSpeed(value:Float)
	{
		this.zoomSpeed = value;
	}
	
	
	public function setZoom(value:Float):Void
	{
		/*
		
		HXP.width = HXP.stage.stageWidth;
		HXP.height = HXP.stage.stageHeight;
		
		HXP.screen.scaleX = HXP.screen.scaleY = value;
		HXP.resize(HXP.stage.stageWidth, HXP.stage.stageHeight);*/
	}
	

	public function cancelCameraPan():Void
	{
		this.panTargetX = HXP.camera.x;
		this.panTargetY = HXP.camera.y;
	}
	
	public function mapWidth():Int
	{
		return HXP.width;
	}
	
	public function mapHeight():Int
	{
		return HXP.height;
	}
}