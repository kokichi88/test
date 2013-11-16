package 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
        public class GSNLoader extends Sprite
        {
                private static var main:flash.display.Sprite;
                public function GSNLoader()
                {
                        this.Theme = GSNLoader_Theme;
                        this.theme = new this.Theme();
                        if(stage)
                        {
                                this.init(null);
                        }
                        else
                        {
                                addEventListener(Event.ADDED_TO_STAGE, this.init);
                        }
                }
                public var loader:Loader;
                //public var prg:MovieClip;
                public var Theme:Class;
                public var theme:flash.display.Sprite;
                private var isAfterLoading:Boolean;
                private var isLoaded:Boolean;
                private var timer:Timer;
                public function afterLoading():void
                {
                        this.isAfterLoading = true;
                }
                private function init(arg0:flash.events.Event):void
                {
                        removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.init);
                        addEventListener(flash.events.Event.ENTER_FRAME, this.loop);
                        Security.allowDomain('*');
                        addChild(this.theme);
                        //this.prg = flash.display.MovieClip(this.theme.getChildByName('progress'));
                        //this.prg.gotoAndStop(0);
                        var local0:* = 'http://cocc-static.apps.zing.vn/assets/protect_cocc1.swf';
                        this.loader = new flash.display.Loader();
						var obj:Object = stage.loaderInfo.parameters;
						Config.modifyConfig(obj);
                        if('configUrl' in obj)
                        {
                                local0 = obj['main'];
                        }
                        if(local0 != '')
                        {
                                this.loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.loadingFinished);
                                this.loader.contentLoaderInfo.addEventListener(flash.events.ProgressEvent.PROGRESS, this.progress);
                                this.loader.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.urlIoError);
                                this.loader.contentLoaderInfo.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.urlSecurityError);
                                this.loader.load(new URLRequest(local0));
                                this.timer = new flash.utils.Timer(1000, 1);
                                this.timer.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this.onFinishTimer);
                                this.timer.start();
                        }
                        else
                        {
                                return;
                        }
                        return;
                }
                private function loadingFinished(arg0:flash.events.Event):void
                {
                        //this.isLoaded = true;
                        var loaderInfo1:flash.display.LoaderInfo = flash.display.LoaderInfo(arg0.currentTarget);
						Main.parse(loaderInfo1.bytes);
                        //main = flash.display.Sprite(loaderInfo1.content);
                        //if(!(this.timer.running))
                        //{
                                //this.afterLoading();
                        //}
                }
                private function loop(arg0:flash.events.Event):void
                {
                        if(this.isAfterLoading)
                        {
                                this.theme.alpha = this.theme.alpha - 0.05;
                                if(this.theme.alpha <= 0)
                                {
                                        removeEventListener(flash.events.Event.ENTER_FRAME, this.loop);
                                        addChild(main);
										for ( var s:String in main)
										{
											trace(s, main[s]);
										}
                                }
                        }
                }
                private function onFinishTimer(arg0:flash.events.TimerEvent):void
                {
                        if(this.isLoaded)
                        {
                                this.afterLoading();
                        }
                }
                private function progress(arg0:flash.events.ProgressEvent):void
                {
                        var number1:Number = arg0.bytesLoaded / arg0.bytesTotal;
                        //this.prg.gotoAndStop(int(number1 * this.prg.totalFrames));
                }
                private function urlIoError(arg0:flash.events.IOErrorEvent):void
                {
                        
                }
                private function urlSecurityError(arg0:flash.events.SecurityErrorEvent):void
                {
                        
                }
        }
}