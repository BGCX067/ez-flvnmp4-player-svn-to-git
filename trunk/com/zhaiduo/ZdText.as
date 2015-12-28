package com.zhaiduo{
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

	public class ZdText extends Sprite{
		
		public var txt:TextField;
		public var format:TextFormat;
		public function ZdText(str:String="",mf:String="Verdana",mc:String="0xFF0000",ms:Number=10):void{
			txt = new TextField();
            txt.autoSize = TextFieldAutoSize.LEFT;
            txt.background = false;
            txt.border = false;

            format = new TextFormat();
            format.font = mf;
            format.color = mc;
            format.size = ms;
            format.underline = false;

            txt.defaultTextFormat = format;
           
            txt.text=(str)?str:"";
            addChild(txt);
            

		}
	}
}