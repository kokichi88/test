package modules.city.logic
{
    import component.avatar.effects.*;
    import component.avatar.model.animation.*;
    import flash.display.*;
    import flash.events.*;
    import gameData.*;
    import modules.battle.logic.bean.*;
    import modules.city.*;
    import modules.city.graphics.build.*;
    import modules.city.graphics.sideQuest.*;
    import modules.feed.*;
    import modules.sound.*;
    import network.*;
    import network.receive.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class ResourceObject extends MapObject
    {
        public var info:DataResources;
        public var harvestIcon:Sprite;
        private var minPercentToHarvest:int = 1;
        public var deltaPauseTime:Number;
        public var curResource:int;
        private var numLoop:int = 0;
        public var harvestBeforeUpgrade:Boolean = false;
        private var saveBuilderId:int;
        private static var NUM_LOOP_DELAY:int = 150;

        public function ResourceObject()
        {
            this.harvestIcon = new Sprite();
            return;
        }// end function

        override public function loadConfigData() : void
        {
            avatar.setAction(AnConst.STAND, 5);
            this.info = JsonMgr.getInstance().getResourcesData(type, level);
            width = this.info.width;
            height = this.info.height;
            if ((level + 1) <= JsonMgr.getInstance().getConfigMaxLevel(type))
            {
                buildTimeNextLevel = JsonMgr.getInstance().resource[type][(level + 1)]["buildTime"];
            }
            else
            {
                buildTimeNextLevel = 0;
            }
            this.harvestIcon.visible = false;
            return;
        }// end function

        override public function addToCity(param1:Boolean = false) : void
        {
            var _loc_2:Layer = null;
            var _loc_3:Sprite = null;
            var _loc_4:Sprite = null;
            var _loc_5:Sprite = null;
            super.addToCity(param1);
            if (this.harvestIcon.numChildren == 0)
            {
                _loc_2 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_INFO);
                _loc_3 = ResMgr.getInstance().getMovieClip("HarvestIcon");
                _loc_4 = ResMgr.getInstance().getMovieClip("Harvest_Full_Icon");
                this.harvestIcon.addChildAt(_loc_3, 0);
                this.harvestIcon.addChildAt(_loc_4, 1).visible = false;
                this.harvestIcon.x = avatar.x - this.harvestIcon.width / 2;
                this.harvestIcon.y = avatar.y - 146;
                _loc_2.addChild(this.harvestIcon);
                CityMgr.getInstance().spriteList.push(this.harvestIcon);
                _loc_5 = ResMgr.getInstance().getMovieClip(type + "_Big_Icon") as Sprite;
                _loc_5.x = (this.harvestIcon.width - _loc_5.width) / 2;
                _loc_5.y = (this.harvestIcon.height - 20 - _loc_5.height) / 2;
                this.harvestIcon.addChildAt(_loc_5, 2);
                this.harvestIcon.addEventListener(MouseEvent.CLICK, this.onHarvestIconClick);
            }
            this.harvestIcon.visible = false;
            return;
        }// end function

        private function onHarvestIconClick(event:MouseEvent) : void
        {
            this.prepareToHarvest();
            return;
        }// end function

        public function loadHarvestIcon(param1:Boolean) : void
        {
            if (this.harvestIcon)
            {
                if (this.harvestIcon.numChildren > 0)
                {
                    this.harvestIcon.getChildAt(0).visible = !param1;
                    this.harvestIcon.getChildAt(1).visible = param1;
                }
            }
            return;
        }// end function

        override public function finishBuilding(param1:int) : void
        {
            if (status == BUILDING)
            {
                switch(type)
                {
                    case BuildingType.DARK_ELIXIR_COLLECTOR:
                    {
                        FeedMgr.getInstance().sendRequestFeedWall(FeedMgr.BUILD_RES_3);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (this.deltaPauseTime > 0)
            {
                startTime = Utility.getCurTime() - this.deltaPauseTime;
            }
            var _loc_2:* = Math.min(Utility.getCurTime() - startTime, buildTimeNextLevel);
            var _loc_3:* = startTime + _loc_2;
            super.finishBuilding(param1);
            startTime = _loc_3;
            return;
        }// end function

        override public function loop() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Number = NaN;
            var _loc_3:Array = null;
            var _loc_4:GuiBuildingAction = null;
            var _loc_5:int = 0;
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            if (status == PRODUCING)
            {
                if (this.numLoop > 0)
                {
                    this.numLoop++;
                    if (this.numLoop == NUM_LOOP_DELAY)
                    {
                        this.numLoop = 0;
                    }
                }
                _loc_1 = Utility.getCurTime();
                _loc_2 = (Utility.getCurTime() - startTime) * this.info.productivity / 3600;
                if (_loc_2 > this.info.capacity)
                {
                    this.curResource = this.info.capacity;
                }
                else
                {
                    this.curResource = int(_loc_2);
                }
                _loc_3 = type.split("_");
                if (this.curResource / this.info.capacity * 100 >= this.minPercentToHarvest)
                {
                    if (avatar.visible)
                    {
                        this.harvestIcon.visible = true;
                    }
                }
                if (CityMgr.getInstance().guiBuildingInfo.isShowing && CityMgr.getInstance().guiBuildingInfo.curBuilding && CityMgr.getInstance().guiBuildingInfo.curBuilding.autoId == this.autoId)
                {
                    CityMgr.getInstance().guiBuildingInfo.updateResourceItem(this.curResource, this.info.capacity);
                }
                _loc_4 = CityMgr.getInstance().guiBuildingAction;
                if (_loc_4.isShowing && _loc_4.curObject && _loc_4.curObject.autoId == this.autoId)
                {
                    _loc_5 = _loc_4.getItemHarvest();
                    if (_loc_5 != -1)
                    {
                        if (_loc_4.listItem[_loc_5].bmpActionItem.enable != this.curResource > 0)
                        {
                            _loc_4.listItem[_loc_5].bmpActionItem.enable = this.curResource > 0;
                            _loc_4.listItem[_loc_5].alpha = this.curResource > 0 ? (1) : (0.6);
                        }
                    }
                }
                if (this.numLoop > 0)
                {
                    this.harvestIcon.visible = false;
                }
            }
            super.loop();
            return;
        }// end function

        override public function loadAvatar() : void
        {
            super.loadAvatar();
            avatar.updatefrs(4);
            avatar.setAction(AnConst.RUN, 5, -1, 1);
            return;
        }// end function

        public function prepareToHarvest() : void
        {
            var _loc_4:String = null;
            this.harvestBeforeUpgrade = false;
            var _loc_1:* = type.split("_");
            var _loc_2:* = GameDataMgr.getInstance().getTotalResourceStorage("STO_" + _loc_1[1]);
            var _loc_3:* = GameDataMgr.getInstance().getMoney(Localization.getInstance().getString(type + "_MONEY"));
            if (_loc_3 == _loc_2)
            {
                GameDataMgr.getInstance().showIconHarvest(true, type);
                _loc_4 = Localization.getInstance().getString("ReachMaxCapacity");
                _loc_4 = _loc_4.replace("@name@", Localization.getInstance().getString("STO_" + _loc_1[1]));
                CityMgr.getInstance().guiNotify.addNewNotify(_loc_4);
                this.numLoop = 1;
                this.harvestIcon.visible = false;
                return;
            }
            CityMgr.getInstance().sendHarvest(autoId, type);
            return;
        }// end function

        override public function onClick(event:MouseEvent) : void
        {
            if (!parent)
            {
                if (this.harvestIcon.visible && borderImage.visible)
                {
                    this.prepareToHarvest();
                }
            }
            return;
        }// end function

        public function receiveHarvest(param1:HarvestMsg) : void
        {
            var _loc_4:int = 0;
            var _loc_5:String = null;
            startTime = param1.startTime;
            var _loc_2:* = new EffectHarvestResources();
            var _loc_3:* = Localization.getInstance().getString(type + "_MONEY");
            _loc_2.setInfo(_loc_3, 10, bgImage.x + bgImage.width / 2, bgImage.y + bgImage.height / 2);
            if (type == BuildingType.ELIXIR_COLLECTOR)
            {
                _loc_4 = AttUpdateEffect.ELIXIR;
                SoundModule.getInstance().playSound(SoundModule.COLLECT_ELIXIR);
            }
            else
            {
                _loc_4 = AttUpdateEffect.GOLD;
                SoundModule.getInstance().playSound(SoundModule.COLLECT_GOLD);
            }
            AttUpdateEffect.play(avatar, _loc_4, param1.income, bgImage.y);
            GameDataMgr.getInstance().addMoney(_loc_3, param1.income);
            this.harvestIcon.visible = false;
            if (SideQuestMgr.getInstance().isQuestAvaiable(GlobalVar.SIDE_QUEST[0], Command.HARVEST))
            {
                _loc_5 = Localization.getInstance().getString(type + "_MONEY");
                SideQuestMgr.getInstance().updateQuest(Command.HARVEST, _loc_5.toLowerCase(), param1.income);
            }
            if (this.harvestBeforeUpgrade)
            {
                super.upgrade(this.saveBuilderId);
            }
            return;
        }// end function

        public function harvest() : void
        {
            var _loc_3:Number = NaN;
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:Number = NaN;
            var _loc_8:EffectHarvestResources = null;
            var _loc_9:String = null;
            var _loc_10:int = 0;
            var _loc_11:String = null;
            var _loc_12:int = 0;
            var _loc_1:* = (Utility.getCurTime() - startTime) * this.info.productivity / 3600;
            var _loc_2:int = 0;
            if (_loc_1 > this.info.capacity)
            {
                _loc_2 = this.info.capacity;
                _loc_3 = Math.floor(_loc_2 / this.info.productivity * 3600);
                startTime = Utility.getCurTime() - _loc_3;
            }
            else
            {
                _loc_2 = int(_loc_1);
            }
            if (_loc_2 > 0)
            {
                _loc_4 = type.split("_");
                _loc_5 = GameDataMgr.getInstance().getTotalResourceStorage("STO_" + _loc_4[1]);
                _loc_6 = GameDataMgr.getInstance().getMoney(Localization.getInstance().getString(type + "_MONEY"));
                if (_loc_6 == _loc_5)
                {
                    _loc_11 = Localization.getInstance().getString("ReachMaxCapacity");
                    _loc_11 = _loc_11.replace("@name@", Localization.getInstance().getString("STO_" + _loc_4[1]));
                    CityMgr.getInstance().guiNotify.addNewNotify(_loc_11);
                    this.harvestIcon.visible = false;
                    this.numLoop = 1;
                    return;
                }
                _loc_7 = 0;
                if (_loc_2 + _loc_6 > _loc_5)
                {
                    _loc_12 = _loc_2 + _loc_6 - _loc_5;
                    _loc_7 = Math.floor(_loc_12 / this.info.productivity * 3600);
                    _loc_2 = _loc_5 - _loc_6;
                }
                _loc_8 = new EffectHarvestResources();
                _loc_9 = Localization.getInstance().getString(type + "_MONEY");
                _loc_8.setInfo(_loc_9, 10, bgImage.x + bgImage.width / 2, bgImage.y + bgImage.height / 2);
                if (type == BuildingType.ELIXIR_COLLECTOR)
                {
                    _loc_10 = AttUpdateEffect.ELIXIR;
                    SoundModule.getInstance().playSound(SoundModule.COLLECT_ELIXIR);
                }
                else
                {
                    _loc_10 = AttUpdateEffect.GOLD;
                    SoundModule.getInstance().playSound(SoundModule.COLLECT_GOLD);
                }
                AttUpdateEffect.play(avatar, _loc_10, _loc_2, bgImage.y);
                GameDataMgr.getInstance().addMoney(_loc_9, _loc_2);
                startTime = Utility.getCurTime() - _loc_7;
                CityMgr.getInstance().sendHarvest(autoId, type);
                this.harvestIcon.visible = false;
            }
            return;
        }// end function

        override public function upgrade(param1:int) : void
        {
            var _loc_5:Number = NaN;
            var _loc_2:* = (Utility.getCurTime() - startTime) * this.info.productivity / 3600;
            var _loc_3:int = 0;
            if (_loc_2 > this.info.capacity)
            {
                _loc_3 = this.info.capacity;
                _loc_5 = Math.floor(_loc_3 / this.info.productivity * 3600);
                startTime = Utility.getCurTime() - _loc_5;
            }
            else
            {
                _loc_3 = int(_loc_2);
            }
            var _loc_4:* = Localization.getInstance().getString(type + "_MONEY");
            if (_loc_3 > 0 && !GameDataMgr.getInstance().isMaxResource(_loc_4))
            {
                this.harvestBeforeUpgrade = true;
                this.saveBuilderId = param1;
                CityMgr.getInstance().sendHarvest(autoId, type);
            }
            else
            {
                if (_loc_3 > 0)
                {
                    this.deltaPauseTime = Utility.getCurTime() - startTime;
                }
                this.harvestBeforeUpgrade = false;
                super.upgrade(param1);
            }
            return;
        }// end function

        override public function hide() : void
        {
            super.hide();
            this.harvestIcon.visible = false;
            return;
        }// end function

        override public function show() : void
        {
            super.show();
            this.harvestIcon.x = avatar.x - this.harvestIcon.width / 2;
            this.harvestIcon.y = avatar.y - 146;
            return;
        }// end function

        override public function destroy() : void
        {
            if (this.harvestIcon)
            {
                this.harvestIcon.removeEventListener(MouseEvent.CLICK, this.onHarvestIconClick);
            }
            super.destroy();
            return;
        }// end function

    }
}
