package utility
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;

    public class LoadingScreen extends Sprite
    {
        private var theme:Sprite;
        private var loadingBar:MovieClip;
        private var txtPercent:TextField;
        public var afterLoading:Function;
        private var isFinish:Boolean = false;
        private var timer:Timer;
        public var FILTERS:Array;

        public function LoadingScreen()
        {
            this.txtPercent = new TextField();
            this.FILTERS = [new DropShadowFilter(1, 90, 0, 1, 2, 2, 4)];
            var _loc_1:* = LoadingScreen_ThemeSmall;
            var _loc_2:* = LoadingScreen_ThemeBig;
            var _loc_3:* = LoadingScreen_ProgressSmall;
            var _loc_4:* = LoadingScreen_ProgressBig;
            if (GlobalVar.SCREEN_WIDTH < 1500 || GlobalVar.SCREEN_HEIGHT < 760)
            {
                this.theme = new _loc_1;
                this.loadingBar = new _loc_3;
            }
            else
            {
                this.theme = new _loc_2;
                this.loadingBar = new _loc_4;
            }
            addChild(this.theme);
            addChild(this.loadingBar);
            this.theme.x = (GlobalVar.SCREEN_WIDTH - this.theme.width) / 2;
            this.theme.y = (GlobalVar.SCREEN_HEIGHT - this.theme.height) / 2;
            this.loadingBar.x = (this.width - this.loadingBar.width) / 2;
            this.loadingBar.y = GlobalVar.SCREEN_HEIGHT - this.loadingBar.height - 30;
            var _loc_5:* = new EmbedFormat(15, 16777215);
            _loc_5.align = "center";
            this.txtPercent.text = "";
            this.txtPercent.autoSize = TextFieldAutoSize.CENTER;
            this.txtPercent.embedFonts = true;
            this.txtPercent.wordWrap = true;
            this.txtPercent.width = 500;
            this.txtPercent.setTextFormat(_loc_5);
            this.txtPercent.defaultTextFormat = _loc_5;
            this.txtPercent.x = this.loadingBar.x + 10;
            this.txtPercent.y = this.loadingBar.y + 80;
            this.txtPercent.width = this.loadingBar.width - 130;
            this.txtPercent.filters = this.FILTERS;
            this.txtPercent.borderColor = 16777215;
            this.addChild(this.txtPercent);
            this.randomTip();
            this.timer = new Timer(1500, 1);
            this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onFinish);
            this.timer.start();
            return;
        }// end function

        private function onFinish(event:TimerEvent) : void
        {
            if (this.isFinish)
            {
                this.afterLoading();
            }
            return;
        }// end function

        public function randomTip() : void
        {
            var _loc_1:* = int(Localization.getInstance().getString("NumTip"));
            this.txtPercent.text = Localization.getInstance().getString("Tip" + (1 + Math.floor(Math.random() * _loc_1)));
            return;
        }// end function

        public function setPercent(param1:Number, param2:Function = null) : void
        {
            var _loc_3:* = int(param1 * this.loadingBar.totalFrames);
            this.loadingBar.gotoAndStop(_loc_3);
            return;
        }// end function

        public function onLoading(param1:Number) : void
        {
            this.setPercent(param1);
            return;
        }// end function

        public function onFinishLoading() : void
        {
            this.isFinish = true;
            if (!this.timer.running)
            {
                this.afterLoading();
            }
            return;
        }// end function

    }
}
