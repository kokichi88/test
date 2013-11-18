package modules.city.logic
{
    import component.avatar.controls.*;
    import component.avatar.things.*;
    import flash.display.*;
    import flash.geom.*;
    import gameData.*;
    import modules.battle.data.*;
    import modules.city.*;
    import modules.city.graphics.barrack.*;
    import modules.city.graphics.build.*;
    import modules.city.graphics.sideQuest.*;
    import modules.sound.*;
    import network.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class BarrackObject extends MapObject
    {
        public var trainingTroop:Array;
        public var objConf:Object;
        public var info:DataBarrack;
        public var deltaPauseTime:Number;
        public var statusIcon:GuiStatusBuilding;
        private var aniEffect:AniEffect;
        public var isStopped:Boolean = false;
        public var hasSentFinishTroop:Boolean = false;
        public static const TYPE:String = "type";
        public static const NUM:String = "num";
        public static const ARM:String = "ARM";
        public static const SEPARATE:String = "_";

        public function BarrackObject()
        {
            this.trainingTroop = [];
            return;
        }// end function

        override public function loadConfigData() : void
        {
            this.info = JsonMgr.getInstance().getBarrackData(level);
            width = this.info.width;
            height = this.info.height;
            if ((level + 1) <= JsonMgr.getInstance().getConfigMaxLevel(type))
            {
                buildTimeNextLevel = JsonMgr.getInstance().barrack[BuildingType.BARRACK][(level + 1)]["buildTime"];
            }
            else
            {
                buildTimeNextLevel = 0;
            }
            this.objConf = JsonMgr.getInstance().getTroopBase();
            return;
        }// end function

        override public function loadAvatar() : void
        {
            super.loadAvatar();
            this.statusIcon = new GuiStatusBuilding();
            var _loc_1:* = (-this.statusIcon.widthBg) / 2;
            var _loc_2:* = -avatar.height - this.statusIcon.heightBg / 2;
            this.statusIcon.setPos(_loc_1, _loc_2);
            return;
        }// end function

        override public function finishBuilding(param1:int) : void
        {
            var _loc_2:* = status;
            super.finishBuilding(param1);
            if (_loc_2 == BUILDING)
            {
                CityMgr.getInstance().guiTrainTroop2.loadBarracks();
            }
            if (this.deltaPauseTime > 0)
            {
                startTime = Utility.getCurTime() - this.deltaPauseTime;
            }
            else
            {
                startTime = 0;
            }
            return;
        }// end function

        public function showStatusIcon(param1:int) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (param1 == GuiStatusBuilding.NONE || !this.bgImage.visible)
            {
                this.statusIcon.hide();
            }
            else
            {
                _loc_2 = avatar.x - this.statusIcon.widthBg / 2;
                _loc_3 = avatar.y - avatarHeight - this.statusIcon.heightBg / 2;
                this.statusIcon.setPos(_loc_2, _loc_3);
                this.statusIcon.setStatus(param1);
                if (!this.statusIcon.isShowing)
                {
                    this.statusIcon.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_INFO));
                }
            }
            return;
        }// end function

        public function trainTroop(param1:String, param2:int = 1) : void
        {
            var _loc_3:Object = null;
            var _loc_4:int = 0;
            _loc_4 = 0;
            while (_loc_4 < this.trainingTroop.length)
            {
                
                _loc_3 = this.trainingTroop[_loc_4];
                if (_loc_3[TYPE] == param1)
                {
                    _loc_3[NUM] = _loc_3[NUM] + param2;
                    return;
                }
                _loc_4++;
            }
            _loc_3 = new Object();
            _loc_3[TYPE] = param1;
            _loc_3[NUM] = param2;
            this.trainingTroop.push(_loc_3);
            return;
        }// end function

        public function cancelTroop(param1:String, param2:int = 1) : void
        {
            var _loc_3:Object = null;
            var _loc_4:int = 0;
            if (!this.trainingTroop)
            {
                return;
            }
            _loc_4 = 0;
            while (_loc_4 < this.trainingTroop.length)
            {
                
                _loc_3 = this.trainingTroop[_loc_4];
                if (_loc_3[TYPE] == param1)
                {
                    _loc_3[NUM] = _loc_3[NUM] - param2;
                    if (_loc_3[NUM] <= 0)
                    {
                        if (this.getCurrentTypeTraining() == _loc_3[TYPE])
                        {
                            startTime = Utility.getCurTime();
                        }
                        this.trainingTroop.splice(_loc_4, 1);
                    }
                    return;
                }
                _loc_4++;
            }
            return;
        }// end function

        public function getTotalTroopTraining() : int
        {
            var _loc_2:Object = null;
            var _loc_3:int = 0;
            if (!this.trainingTroop)
            {
                return 0;
            }
            var _loc_1:int = 0;
            _loc_3 = 0;
            while (_loc_3 < this.trainingTroop.length)
            {
                
                _loc_2 = this.trainingTroop[_loc_3];
                _loc_1 = _loc_1 + _loc_2[NUM] * this.objConf[_loc_2[TYPE]]["housingSpace"];
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public function getMaxCapacity() : int
        {
            var _loc_1:* = JsonMgr.getInstance().barrack[BuildingType.BARRACK][this.level]["queueLength"];
            return _loc_1;
        }// end function

        public function getTotalTypeTraining() : int
        {
            if (!this.trainingTroop)
            {
                return 0;
            }
            return this.trainingTroop.length;
        }// end function

        public function getNumTroopByType(param1:String) : int
        {
            var _loc_2:Object = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            _loc_3 = 0;
            while (_loc_3 < this.trainingTroop.length)
            {
                
                _loc_2 = this.trainingTroop[_loc_3];
                if (_loc_2[TYPE] == param1)
                {
                    _loc_4 = _loc_4 + _loc_2[NUM];
                }
                _loc_3++;
            }
            return _loc_4;
        }// end function

        public function getCurrentTypeTraining() : String
        {
            var _loc_1:Object = null;
            if (this.trainingTroop.length > 0)
            {
                _loc_1 = this.trainingTroop[0];
                return _loc_1[TYPE];
            }
            return "";
        }// end function

        public function getRemainTime() : Number
        {
            var _loc_2:int = 0;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_1:* = this.getCurrentTypeTraining();
            if (_loc_1 != "")
            {
                _loc_2 = this.objConf[_loc_1]["trainingTime"];
                _loc_3 = Utility.getCurTime();
                _loc_4 = startTime + _loc_2 - _loc_3;
                return _loc_4;
            }
            return 0;
        }// end function

        public function getTotalRemainTime() : Number
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_3:* = Utility.getCurTime();
            _loc_1 = 0;
            while (_loc_1 < this.trainingTroop.length)
            {
                
                _loc_5 = this.trainingTroop[_loc_1];
                _loc_2 = _loc_2 + _loc_5[NUM] * this.objConf[_loc_5[TYPE]]["trainingTime"];
                _loc_1++;
            }
            _loc_4 = startTime + _loc_2 - _loc_3;
            return _loc_4;
        }// end function

        public function getTrainingTroop() : Array
        {
            return this.trainingTroop;
        }// end function

        public function canFinish() : Boolean
        {
            var _loc_1:Object = null;
            _loc_1 = this.trainingTroop[0];
            if (!_loc_1)
            {
                return true;
            }
            var _loc_2:* = GameDataMgr.getInstance().getTotalTroopCapacity();
            var _loc_3:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            if (_loc_3 + this.objConf[_loc_1[TYPE]]["housingSpace"] > _loc_2)
            {
                return false;
            }
            return true;
        }// end function

        public function finishTraining(param1:Number) : void
        {
            var _loc_2:Object = null;
            var _loc_3:int = 0;
            _loc_2 = this.trainingTroop[0];
            var _loc_5:* = _loc_2;
            var _loc_6:* = NUM;
            var _loc_7:* = _loc_2[NUM] - 1;
            _loc_5[_loc_6] = _loc_7;
            var _loc_4:* = new Troop();
            _loc_4.type = _loc_2.type;
            _loc_4.num = 1;
            _loc_4.level = GameDataMgr.getInstance().getTroopLevel(_loc_2.type);
            Utility.addTroop(_loc_4, GameDataMgr.getInstance().troopList);
            startTime = param1;
            if (_loc_2[NUM] <= 0)
            {
                this.trainingTroop.splice(_loc_3, 1);
            }
            CityMgr.getInstance().guiTotalTroop.updateTroop();
            CityMgr.getInstance().finishTraining(_loc_4, posX, posY);
            SoundModule.getInstance().playSound(SoundModule.FINISH_TRAINING);
            return;
        }// end function

        public function getEndTimeForTrain() : Number
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:GuiTrainTroop2 = null;
            var _loc_6:Boolean = false;
            var _loc_7:Number = NaN;
            var _loc_8:int = 0;
            var _loc_9:Number = NaN;
            var _loc_1:* = Number.MAX_VALUE;
            if (status != PRODUCING)
            {
                return _loc_1;
            }
            var _loc_2:* = this.getCurrentTypeTraining();
            if (_loc_2 == "")
            {
                statusBar.hide();
                _loc_3 = GameDataMgr.getInstance().getCurrentHousingSpace();
                _loc_4 = GameDataMgr.getInstance().getTotalTroopCapacity();
                if (_loc_3 < _loc_4)
                {
                    this.showStatusIcon(GuiStatusBuilding.FREE);
                }
                else
                {
                    this.showStatusIcon(GuiStatusBuilding.NONE);
                }
                if (this.aniEffect)
                {
                    this.aniEffect.terminate();
                    this.aniEffect = null;
                }
            }
            else
            {
                if (_loc_2 != "")
                {
                    _loc_5 = CityMgr.getInstance().guiTrainTroop2;
                    _loc_6 = _loc_5.isShowing && _loc_5.curBarrackId != -1 && _loc_5.barrackList[_loc_5.curBarrackId] == this;
                    _loc_7 = this.getRemainTime();
                    _loc_8 = this.objConf[_loc_2]["trainingTime"];
                    if (_loc_6 && _loc_5.curBarrackId != -1 && _loc_5.barrackList[_loc_5.curBarrackId] == this)
                    {
                        _loc_5.updateCtnTrainTroop(_loc_7);
                        if (this.isStopped)
                        {
                            _loc_5.showStop();
                            return _loc_1;
                        }
                    }
                    if (_loc_7 <= 0)
                    {
                        if (this.canFinish())
                        {
                            _loc_1 = startTime + _loc_8;
                        }
                        else
                        {
                            this.isStopped = true;
                            if (_loc_6 && _loc_5.curBarrackId != -1 && _loc_5.barrackList[_loc_5.curBarrackId] == this)
                            {
                                _loc_5.showStop();
                            }
                        }
                    }
                    _loc_9 = this.getTotalRemainTime();
                    if (_loc_6)
                    {
                        _loc_5.updateTotalRemainTime(_loc_9);
                    }
                }
                if (this.canFinish())
                {
                    statusBar.showTroopStatus(_loc_2 + "_Research_Icon", _loc_7, _loc_8);
                    viewStatusBar();
                    this.showStatusIcon(GuiStatusBuilding.NONE);
                    if (this.aniEffect == null)
                    {
                        this.aniEffect = EffectDraw.play("barack_working_progress", new Point(55, 27), avatar, 0);
                        this.aniEffect.blendMode = BlendMode.SCREEN;
                        CityMgr.getInstance().effectList.push(this.aniEffect);
                    }
                }
                else
                {
                    statusBar.hide();
                    this.showStatusIcon(GuiStatusBuilding.OVERLOAD);
                }
            }
            return _loc_1;
        }// end function

        public function quickFinishTraining() : void
        {
            var _loc_4:Troop = null;
            var _loc_5:int = 0;
            var _loc_1:* = SideQuestMgr.getInstance().isQuestAvaiable(GlobalVar.SIDE_QUEST[0], Command.FINISH_TRAIN_TROOP);
            var _loc_2:* = SideQuestMgr.getInstance().questList[GlobalVar.SIDE_QUEST[0]].actionParam;
            var _loc_3:int = 0;
            while (_loc_3 < this.trainingTroop.length)
            {
                
                _loc_4 = new Troop();
                _loc_4.type = this.trainingTroop[_loc_3].type;
                _loc_4.num = this.trainingTroop[_loc_3].num;
                _loc_4.level = GameDataMgr.getInstance().getTroopLevel(_loc_4.type);
                Utility.addTroop(_loc_4, GameDataMgr.getInstance().troopList);
                _loc_5 = 0;
                while (_loc_5 < _loc_4.num)
                {
                    
                    CityMgr.getInstance().finishTraining(_loc_4, posX, posY);
                    _loc_5++;
                }
                if (_loc_4.type == _loc_2)
                {
                    _loc_1 = true;
                }
                _loc_3++;
            }
            this.trainingTroop.splice(0, this.trainingTroop.length);
            CityMgr.getInstance().guiMainTop.updateTotalTroop();
            return;
        }// end function

        override public function upgrade(param1:int) : void
        {
            this.showStatusIcon(GuiStatusBuilding.NONE);
            if (this.trainingTroop.length > 0)
            {
                this.deltaPauseTime = Utility.getCurTime() - startTime;
                statusBar.hide();
            }
            super.upgrade(param1);
            return;
        }// end function

        override public function hide() : void
        {
            super.hide();
            if (statusBar.isShowing)
            {
                statusBar.hide();
            }
            if (this.statusIcon.isShowing)
            {
                this.statusIcon.hide();
            }
            return;
        }// end function

        override public function destroy() : void
        {
            super.destroy();
            if (this.statusIcon)
            {
                this.statusIcon.destroyBaseGUI();
                this.statusIcon = null;
            }
            return;
        }// end function

    }
}
