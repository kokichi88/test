package modules.city.logic
{
    import com.greensock.*;
    import component.avatar.controls.*;
    import component.avatar.things.*;
    import flash.geom.*;
    import modules.city.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class ObstacleObject extends MapObject
    {
        public var info:DataObctacle;
        private var aniEffect:AniEffect;

        public function ObstacleObject()
        {
            return;
        }// end function

        override public function loadConfigData() : void
        {
            this.info = JsonMgr.getInstance().getObstacleData(type);
            width = this.info.width;
            height = this.info.height;
            buildTimeNextLevel = this.info.removalTime;
            return;
        }// end function

        override public function loadAvatar() : void
        {
            var _loc_1:int = 0;
            super.loadAvatar();
            if (type == "OBS_1" || type == "OBS_10")
            {
                _loc_1 = Utility.randomNumber(1, 2);
                if (_loc_1 == 1)
                {
                    this.aniEffect = EffectDraw.play("butterfly", new Point(0, -30), avatar, 0);
                    CityMgr.getInstance().effectList.push(this.aniEffect);
                }
            }
            return;
        }// end function

        public function effectRemoveObstacle() : void
        {
            if (shadow && shadow.parent)
            {
                shadow.parent.removeChild(shadow);
                shadow.visible = false;
            }
            if (statusBar.isShowing)
            {
                statusBar.hide();
            }
            TweenMax.to(bgImage, 0.8, {alpha:0, onComplete:this.onComplete});
            TweenMax.to(avatar, 0.8, {alpha:0});
            if (this.aniEffect)
            {
                this.aniEffect.terminate();
            }
            return;
        }// end function

        private function onComplete() : void
        {
            destroy();
            return;
        }// end function

        override public function loop() : void
        {
            var _loc_1:Number = NaN;
            if (startTime > 0)
            {
                _loc_1 = Utility.getCurTime() - startTime;
                if (_loc_1 >= this.info.removalTime)
                {
                    this.finishRemoving();
                }
                else
                {
                    statusBar.showStatusBar(_loc_1, this.info.removalTime);
                    viewStatusBar();
                }
            }
            return;
        }// end function

        public function finishRemoving() : void
        {
            startTime = 0;
            statusBar.hide();
            CityMgr.getInstance().finishRemoveObstacle(type, autoId);
            return;
        }// end function

        override public function finishBuilding(param1:int) : void
        {
            return;
        }// end function

    }
}
