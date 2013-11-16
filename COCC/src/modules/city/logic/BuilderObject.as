package modules.city.logic
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.utils.*;
    import modules.city.graphics.effectSeed.*;
    import resMgr.*;
    import resMgr.data.*;

    public class BuilderObject extends MapObject
    {
        public var info:DataBuilderHut;
        public var isBusy:Boolean = false;
        private var delayOneZ:int = 1;
        private var numberZ:int = 3;
        private var delayNextEffect:int = 10;
        private var countLoop:int = 0;
        private var countZ:int = 0;
        private var listSeed:Vector.<IdleEffectSeed>;
        private var timer:Timer;

        public function BuilderObject()
        {
            this.listSeed = new Vector.<IdleEffectSeed>;
            width = 2;
            height = 2;
            buildTimeNextLevel = 0;
            return;
        }// end function

        override public function loadConfigData() : void
        {
            this.info = JsonMgr.getInstance().getBuilderHutData(level);
            return;
        }// end function

        private function initEffect() : void
        {
            var _loc_2:IdleEffectSeed = null;
            this.timer = new Timer(4000, int.MAX_VALUE);
            var _loc_1:int = 0;
            while (_loc_1 < this.numberZ)
            {
                
                _loc_2 = new IdleEffectSeed();
                _loc_2.setInfo(bgImage.x + bgImageWidth / 2 - 25, bgImage.y, 0.25 * _loc_1, 0.08 * _loc_1);
                this.listSeed.push(_loc_2);
                _loc_1++;
            }
            return;
        }// end function

        override public function setPos(param1:int, param2:int) : void
        {
            var _loc_4:IdleEffectSeed = null;
            super.setPos(param1, param2);
            var _loc_3:int = 0;
            while (_loc_3 < this.listSeed.length)
            {
                
                _loc_4 = this.listSeed[_loc_3];
                _loc_4.setInfo(bgImage.x + bgImageWidth / 2 - 25, bgImage.y, 0.25 * _loc_3, 0.08 * _loc_3);
                _loc_3++;
            }
            return;
        }// end function

        override public function hide() : void
        {
            super.hide();
            this.hideIdleEffect();
            return;
        }// end function

        override public function show() : void
        {
            super.show();
            this.showIdleEffect();
            return;
        }// end function

        public function showIdleEffect() : void
        {
            return;
        }// end function

        private function onTick(event:TimerEvent) : void
        {
            this.runIdleEffect();
            return;
        }// end function

        public function runIdleEffect() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.numberZ)
            {
                
                this.listSeed[_loc_1].runEffect();
                _loc_1++;
            }
            return;
        }// end function

        public function hideIdleEffect() : void
        {
            if (!this.timer)
            {
                return;
            }
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER, this.onTick);
            var _loc_1:int = 0;
            while (_loc_1 < this.numberZ)
            {
                
                this.listSeed[_loc_1].stop();
                _loc_1++;
            }
            return;
        }// end function

    }
}
