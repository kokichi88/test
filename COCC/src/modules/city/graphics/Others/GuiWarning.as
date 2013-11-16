package modules.city.graphics.Others
{
    import component.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiWarning extends BaseGui
    {
        public var labelTitle:TextField;
        public var labelMessage:TextField;
        public var labelTime:TextField;
        private var leftTime:int;
        private var timer:Timer;
        public var beingAttack:Boolean = false;
        private static var waitingTime:int = 240;

        public function GuiWarning()
        {
            super(ResMgr.getInstance().getMovieClip("WarningGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            this.beingAttack = false;
            return;
        }// end function

        public function showGui(param1:Number) : void
        {
            this.labelTitle.text = Localization.getInstance().getString("WarningTitle0");
            this.labelMessage.text = Localization.getInstance().getString("WarningMessage0");
            this.leftTime = waitingTime - (Utility.getCurTime() - param1);
            this.labelTime.text = Utility.convertTimeToShortString(this.leftTime);
            if (this.leftTime > 0 && this.leftTime <= waitingTime)
            {
                this.timer = new Timer(1000, int.MAX_VALUE);
                this.timer.start();
                this.timer.addEventListener(TimerEvent.TIMER, this.onTick);
                show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_LOADING));
                this.beingAttack = true;
            }
            return;
        }// end function

        private function onTick(event:TimerEvent) : void
        {
            var _loc_2:String = this;
            var _loc_3:* = this.leftTime - 1;
            _loc_2.leftTime = _loc_3;
            if (this.leftTime <= 1)
            {
                this.timer.stop();
                this.timer.removeEventListener(TimerEvent.TIMER, this.onTick);
                CityMgr.getInstance().reloadGame();
            }
            this.labelTime.text = Utility.convertTimeToShortString(this.leftTime);
            return;
        }// end function

    }
}
