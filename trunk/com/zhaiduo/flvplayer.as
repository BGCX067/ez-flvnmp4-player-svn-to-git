package com.zhaiduo { //fp9 version

	import fl.video.FLVPlayback;
	import fl.video.FLVPlaybackCaptioning;
  import flash.display.Sprite;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.events.ProgressEvent;
  import fl.video.CaptionChangeEvent;
  import fl.video.VideoProgressEvent;
  import fl.video.VideoEvent;
	import flash.display.LoaderInfo;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageQuality;
	
	import com.adobe.images.JPGEncoder;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.net.URLLoader;
	import flash.net.FileReference;
	
	import flash.events.FullScreenEvent;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.display.StageDisplayState;
	import com.zhaiduo.ZdText;
	
	import flash.text.TextFormat;
	import fl.controls.Button;

	
	public class flvplayer extends MovieClip {
			
		private var box:Sprite;
		private var player:FLVPlayback;
		private var info:ZdText;
		private var fn:String;
		private var is_play:uint=0;
		private var is_full:uint=0;
		private var is_loaded:uint=0;
		private var loadinfo:String;
		private var xh:uint=0;
		private var b1:Button;
		private var captioningPath:String = "caption_video.xml";
		private var captioning:FLVPlaybackCaptioning = new FLVPlaybackCaptioning();

			public function flvplayer() {

			stage.quality = StageQuality.BEST;
	 		stage.scaleMode = "noScale"; 
			stage.showDefaultContextMenu = false; 
			stage.align = "TL";

			
			box=new Sprite();
			box.name="box";
			addChild(box);
			box.buttonMode=true;
			
			player=new FLVPlayback();
			//trace(FLVPlayback.VERSION);
			if(player.width > stage.stageWidth){
				player.width=stage.stageWidth;
			}
			if(player.height > stage.stageHeight){
        		player.height=stage.stageHeight;
      }
      trace(stage.stageWidth,stage.stageHeight);
        	
      if(loaderInfo.parameters.flv){
				fn=String(loaderInfo.parameters.flv);
				player.source = fn;
			}else{
				player.source = "default.mp4";
			}
			//trace(String(player.source));
			
     //player.autoPlay = false;
      player.skinBackgroundColor = 0xFFFFFF;
      player.skinBackgroundAlpha = 0;
      player.skinAutoHide=true;
      player.autoRewind=false;
      box.addChild(player);
			///*
			if(player.x < stage.stageWidth){
				player.x=stage.stageWidth/2-player.width/2;
			}else{
				player.x=0;
			}
			if(player.y < stage.stageHeight){
				player.y=stage.stageHeight/2-player.height/2;
			}else{
				player.y=0;
			}
			//*/
			player.addEventListener(VideoProgressEvent.PROGRESS, loadingBox2);
      player.addEventListener(VideoEvent.BUFFERING_STATE_ENTERED, loadingBox);
      player.addEventListener(VideoEvent.COMPLETE, loadedBox);
      
			box.addEventListener(MouseEvent.CLICK, clickHandler);
			//box.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);

			//addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			box.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			box.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			//addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			box.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			box.addEventListener(Event.ENTER_FRAME, playnow);
			
      player.addEventListener(MouseEvent.CLICK, toggleFullScreen);

      info=new ZdText("init...","Verdana","0xefefef");
      info.name="info";
			info.x=5;
			info.y=5;
			info.txt.text="init...";
			
			addChild(info);
			
		  b1 = new Button();
			b1.name="btn";
			//b1.label = "Print Screen("+xh+")";
			b1.label = "FULL SCREEN";
			//b1.setStyle("textFormat", new TextFormat("Georgia"));            
      b1.addEventListener(MouseEvent.CLICK, toggleFullScreen2);
      
      b1.y+=b1.height+2;
      addChild(b1);

			
			if(String(player.source)!='player.flv'){
				info.txt.text=(fn)?fn:"";
			}

			//captioning.flvPlayback = player;
      //captioning.source = captioningPath;
      //captioning.autoLayout = true;            
      //captioning.addEventListener(CaptionChangeEvent.CAPTION_CHANGE, onCaptionChange);
      
      
		}
		
		private function onCaptionChange(e:CaptionChangeEvent):void {
            var tf:* = e.target.captionTarget;
            trace(tf);
            //player = e.target.flvPlayback;
            // move the caption below the video
            //tf.y = 210;            
        }
		
		private function capture(i:uint){
			var jpgSource:BitmapData = new BitmapData (player.width, player.height);
			jpgSource.draw(player);
			var jpgEncoder:JPGEncoder = new JPGEncoder(100);
			var jpgStream:ByteArray = jpgEncoder.encode(jpgSource);
			//if(jpgStream.length>0){
				var jpgURLRequest:URLRequest = new URLRequest("jpg_encoder_download.php?id="+i+"&name"+player.source);
				var loader:URLLoader = new URLLoader();
				jpgURLRequest.contentType="application/octet-stream";
				jpgURLRequest.method = URLRequestMethod.POST;
				jpgURLRequest.data = jpgStream;
				//navigateToURL(jpgURLRequest,"_blank");
				try {            
	                //navigateToURL(jpgURLRequest,"_blank");
	                loader.load(jpgURLRequest);
	            }
	            catch (e:Error) {
	                trace(e.toString());
	            }
				
				//fp10
				//var _fr:FileReference = new FileReference;
				//_fr.save(jpgStream, "snap.jpg");

			//}
		}
		
		private function buttonClick(e:MouseEvent) {
            var button:Button = e.target as Button;
            //xh++;
            //capture(xh);
            //b1.label = "Print Screen("+xh+")";
            
    }
    
    
    private function doubleClickHandler(event:MouseEvent):void {
			if(is_loaded==1){
				if(is_play==1){
					is_play=0;
				}else{
					is_play=1;
				}
			}
		}
    
		private function clickHandler(event:MouseEvent):void {
			if(is_loaded==1){
				if(is_play==1){
					is_play=0;
				}else{
					is_play=1;
				}
			}
		}

		private function mouseOutHandler(event:MouseEvent):void {
			//trace("mouseOutHandler");
			//box.alpha=1;	
		}

		private function mouseOverHandler(event:MouseEvent):void {
			//trace("mouseOverHandler");
			//box.alpha=0.3;
		}

    private function mouseWheelHandler(event:MouseEvent):void {
			//trace("mouseWheelHandler delta: " + event.delta);
			var chg:Number=-event.delta*5;
			    player.width+=chg;
        	player.height+=chg;
        	player.x=stage.stageWidth/2 - player.width/2;
        	player.y=stage.stageHeight/2 - player.height/2;
		}
		
		private function toggleFullScreen2(event:MouseEvent):void {
            if(stage.displayState == StageDisplayState.NORMAL) {
                try {
                    stage.displayState = StageDisplayState.FULL_SCREEN;
                    is_full=1;
                 } catch (e:SecurityError) {
                    trace ("A security error occurred while switching to full screen: " + event);
                 }
            }
            trace("full: "+is_full);
    }
    
    private function toggleFullScreen(event:MouseEvent):void {
            if(stage.displayState == StageDisplayState.NORMAL) {
                try {
                    stage.displayState = StageDisplayState.FULL_SCREEN;
                    is_full=1;
                 } catch (e:SecurityError) {
                    trace ("A security error occurred while switching to full screen: " + event);
                 }
            }else {
                stage.displayState = StageDisplayState.NORMAL;
                is_full=0;

            }
            trace("full: "+is_full);
    }
	
		function loadingBox2(event:ProgressEvent):void {
            //var file:FileReference = FileReference(event.target);
            //trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
            if(event.bytesLoaded==event.bytesTotal){
				if(is_loaded==0){
					is_loaded=1;
					is_play=1;
				}
			}
            loadinfo=" Loading[" + Math.floor(100 * event.bytesLoaded / event.bytesTotal)+"%] "+Math.floor(100 * event.bytesTotal / (1024*1024))/100+" MB ("+Math.floor(100 * player.totalTime / 60)/100+" minutes) ";
            //
        }
	
		function loadingBox(EVENT:VideoEvent):void {
        	//trace(player.bytesLoaded);
        	//trace('loading...');
        	//info.txt.text="loading...";
        	//bytesTotal
        }
        
        function loadedBox(EVENT:VideoEvent):void {
        	//trace('loaded');
        	//info.txt.text="";
        	//player.playWhenEnoughDownloaded();
        }

		private function playnow(event:Event):void {
			var playtime:Number=Math.floor(player.playheadTime*10)/10;
			//trace(playtime);
			if(playtime==10){
				//capture(1);	
				//b1.label = "Print Screen(1)";
			}
			if(playtime==12){
				//capture(2);	
				//b1.label = "Print Screen(2)";
			}
			if(playtime==14){
				//capture(3);	
				//b1.label = "Print Screen(3)";
			}
			if(playtime==16){
				//capture(4);	
				//b1.label = "Print Screen(4)";
			}
			if(playtime==18){
				//capture(5);	
				//b1.label = "Print Screen(5)";	
			}
			if(is_loaded==1){
				if(is_play==1){
					player.play();
				}else{
					player.stop();
				}
			}
			info.txt.text=loadinfo + " =>  Now play: "+Math.floor(100 * player.playheadTime / 60)/100+" minutes";
		}

	}
}
	