package modules.city.logic
{
    import __AS3__.vec.*;
    import component.avatar.controls.*;
    import component.avatar.things.*;
    import flash.display.*;
    import flash.geom.*;
    import gameData.*;
    import modules.city.*;
    import modules.feed.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class LaboratoryObject extends MapObject
    {
        public var info:DataLaboratory;
        public var researchList:Vector.<DataResearch>;
        public var deltaPauseTime:int;
        public var troopType:String;
        public var researchTime:int;
        private var showEffect:Boolean = false;
        private var aniEffect:AniEffect;

        public function LaboratoryObject()
        {
            this.researchList = new Vector.<DataResearch>;
            type = BuildingType.LABORATORY;
            return;
        }// end function

        override public function loadConfigData() : void
        {
            this.info = JsonMgr.getInstance().getLaboratoryData(level);
            width = this.info.width;
            height = this.info.height;
            if ((level + 1) <= JsonMgr.getInstance().getConfigMaxLevel(type))
            {
                buildTimeNextLevel = JsonMgr.getInstance().laboratory[type][(level + 1)]["buildTime"];
            }
            else
            {
                buildTimeNextLevel = 0;
            }
            this.getResearchTime();
            return;
        }// end function

        override public function loadAvatar() : void
        {
            super.loadAvatar();
            avatar.updatefrs(6);
            return;
        }// end function

        public function getTroopLevel(param1:String) : int
        {
            var _loc_3:DataResearch = null;
            var _loc_2:int = 0;
            while (_loc_2 < this.researchList.length)
            {
                
                _loc_3 = this.researchList[_loc_2];
                if (_loc_3.researchType == param1)
                {
                    return _loc_3.researchLevel;
                }
                _loc_2++;
            }
            return 1;
        }// end function

        public function getResearchTime() : void
        {
            var _loc_1:int = 0;
            if (this.troopType != null && this.troopType != "" && startTime > 0)
            {
                _loc_1 = this.getTroopLevel(this.troopType);
                this.researchTime = GameDataMgr.getInstance().getResearchTime(this.troopType, (_loc_1 + 1));
            }
            return;
        }// end function

        override public function loop() : void
        {
            var _loc_1:Number = NaN;
            if (status == PRODUCING && this.troopType != "" && startTime > 0)
            {
                _loc_1 = startTime + this.researchTime - Utility.getCurTime();
                if (_loc_1 <= 0)
                {
                    this.finishResearch();
                }
                else
                {
                    if (GlobalVar.state == GlobalVar.STATE_MYHOME)
                    {
                        statusBar.showTroopStatus(this.troopType + "_Research_Icon", _loc_1, this.researchTime);
                        viewStatusBar();
                    }
                    this.showEffectRun();
                }
            }
            super.loop();
            return;
        }// end function

        private function showEffectRun() : void
        {
            if (this.showEffect)
            {
                return;
            }
            this.showEffect = true;
            this.aniEffect = EffectDraw.play("researching", new Point(0, -70), avatar, 0);
            var _loc_1:int = 2;
            this.aniEffect.scaleY = 2;
            this.aniEffect.scaleX = _loc_1;
            this.aniEffect.blendMode = BlendMode.SCREEN;
            CityMgr.getInstance().effectList.push(this.aniEffect);
            return;
        }// end function

        public function finishResearch() : void
        {
            GameDataMgr.getInstance().troopLevelUp(this.troopType);
            CityMgr.getInstance().guiTrainTroop.updateTroopLevel(this.troopType);
            var _loc_1:* = Localization.getInstance().getString("FinishResearch");
            _loc_1 = _loc_1.replace("@name@", Localization.getInstance().getString(this.troopType));
            _loc_1 = _loc_1.replace("@level@", GameDataMgr.getInstance().getTroopLevel(this.troopType));
            CityMgr.getInstance().guiNotify.addNewNotify(_loc_1);
            statusBar.hide();
            startTime = 0;
            this.troopType = "";
            this.aniEffect.terminate();
            this.showEffect = false;
            effectFinishBuilding();
            return;
        }// end function

        override public function upgrade(param1:int) : void
        {
            if (status == PRODUCING && startTime > 0)
            {
                this.deltaPauseTime = Utility.getCurTime() - startTime;
            }
            super.upgrade(param1);
            return;
        }// end function

        override public function finishBuilding(param1:int) : void
        {
            if (status == BUILDING)
            {
                FeedMgr.getInstance().sendRequestFeedWall(FeedMgr.BUILD_LAB_1);
            }
            super.finishBuilding(param1);
            if (this.deltaPauseTime > 0)
            {
                startTime = Utility.getCurTime() - this.deltaPauseTime;
                this.deltaPauseTime = 0;
            }
            return;
        }// end function

        override public function hide() : void
        {
            super.hide();
            if (statusBar.isShowing)
            {
                statusBar.hide();
            }
            return;
        }// end function

    }
}
