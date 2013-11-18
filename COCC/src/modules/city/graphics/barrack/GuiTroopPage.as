package modules.city.graphics.barrack
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.graphics.tutorial.*;
    import modules.city.logic.*;
    import modules.sound.*;
    import network.receive.*;
    import resMgr.*;
    import utility.*;

    public class GuiTroopPage extends BaseGui
    {
        public var bmpBarrack1:BitmapButton;
        public var bmpBarrack2:BitmapButton;
        public var bmpBarrack3:BitmapButton;
        public var bmpBarrack4:BitmapButton;
        public var bmpQuickFinish:BitmapButton;
        public var labelTmp1:TextField;
        public var labelTmp2:TextField;
        public var labelTmp3:TextField;
        public var labelBarrackName:TextField;
        public var labelTotalTime:TextField;
        public var labelTotalTroop:TextField;
        public var labelQuickFinish:TextField;
        public var imageArrow:Object;
        public var imageTabBarrck1:Object;
        public var imageTabBarrck2:Object;
        public var imageTabBarrck3:Object;
        public var imageTabBarrck4:Object;
        public var arrCtnTrain:Array;
        public var mouseDownTroopType:String = "";
        public var mouseDownType:String = "";
        public var mouseDownDelay:Number = 0;
        public var saveBarrackObject:MapObject;
        private var saveTroopType:String;
        public var needConfirm:Boolean;
        public var listTrainingItem:Vector.<GuiTrainingItem>;
        public var listTroopItem:Vector.<GuiTroopBase>;
        public var curBarrackId:int;
        public var barrackList:Vector.<BarrackObject>;
        public var imageBgSpellReady:MovieClip;
        private var nextBarrack:int;
        private static const BTN_CLOSE:String = "bmpClose";
        private static const BTN_BARRACK:String = "bmpBarrack";
        private static const BTN_PREV_BARRACK:String = "bmpPrevBarr";
        private static const BTN_NEXT_BARRACK:String = "bmpNextBarr";
        private static const BTN_QUICK_FINISH:String = "bmpQuickFinish";
        public static const MOUSE_DOWN_DELAY_TO_START:int = 500;
        private static const MOUSE_DOWN_DELAY:int = 100;
        public static const MOUSE_DOWN_TYPE_ADD:String = "mouseDownTypeAdd";
        public static const MOUSE_DOWN_TYPE_CANCEL:String = "mouseDownTypeCancel";
        private static const MAX_BARRACK:int = 4;
        private static const MAX_TROOP_TYPE_SHOW:int = 6;
        private static const ARM:String = "ARM";
        private static const ARM_TRAINING:String = "armTraining";
        private static const SEPARATE:String = "_";
        public static const TROOP_INFO:String = "troopInfo";
        public static var MAX_TROOP_TYPE:int;
        private static const startXFirt:int = 416;
        private static const startX:int = 404;
        private static const startY:int = 15;
        private static const padingX:int = -74;

        public function GuiTroopPage()
        {
            this.listTrainingItem = new Vector.<GuiTrainingItem>;
            this.listTroopItem = new Vector.<GuiTroopBase>;
            super(ResMgr.getInstance().getMovieClip("GuiTroopPage"));
            this.imageBgSpellReady.visible = false;
            this.labelTmp3.text = Localization.getInstance().getString("TotalTroopAfterTraining");
            this.addTroopConfig();
            return;
        }// end function

        private function addTroopConfig() : void
        {
            var _loc_2:int = 0;
            var _loc_3:String = null;
            var _loc_4:int = 0;
            var _loc_5:GuiTroopBase = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_1:* = JsonMgr.getInstance().getTroopBase();
            for (_loc_3 in _loc_1)
            {
                
                _loc_2++;
            }
            MAX_TROOP_TYPE = _loc_2;
            _loc_6 = 70;
            _loc_7 = 147;
            _loc_8 = 109;
            _loc_9 = 120;
            _loc_4 = 1;
            while (_loc_4 <= MAX_TROOP_TYPE)
            {
                
                _loc_5 = new GuiTroopBase();
                this.listTroopItem.push(_loc_5);
                addGui(_loc_5);
                if (_loc_4 == 6)
                {
                    _loc_6 = 70;
                    _loc_7 = _loc_7 + _loc_9;
                }
                _loc_5.setPos(_loc_6, _loc_7);
                _loc_6 = _loc_6 + _loc_8;
                _loc_4++;
            }
            return;
        }// end function

        public function setBarrack(param1:int) : void
        {
            this.barrackList = GameDataMgr.getInstance().barrackList;
            this.curBarrackId = param1;
            var _loc_2:int = 0;
            while (_loc_2 < this.listTroopItem.length)
            {
                
                this.listTroopItem[_loc_2].loadTroop(this.curBarrackId, (_loc_2 + 1));
                _loc_2++;
            }
            return;
        }// end function

        private function resetItemTroopNumber() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listTroopItem.length)
            {
                
                this.listTroopItem[_loc_1].labelNum.text = "";
                _loc_1++;
            }
            return;
        }// end function

        public function removeAllTrainingItem() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listTrainingItem.length)
            {
                
                this.listTrainingItem[_loc_1].destroyBaseGUI();
                this.listTrainingItem[_loc_1] = null;
                _loc_1++;
            }
            this.listTrainingItem.splice(0, this.listTrainingItem.length);
            this.listTrainingItem = new Vector.<GuiTrainingItem>;
            this.resetItemTroopNumber();
            return;
        }// end function

        private function getCurrentTraing() : void
        {
            var _loc_1:GuiTrainingItem = null;
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            this.removeAllTrainingItem();
            var _loc_2:* = GameDataMgr.getInstance().barrackList[this.curBarrackId];
            var _loc_3:* = _loc_2.getTrainingTroop();
            this.resetItemTroopNumber();
            _loc_4 = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4];
                _loc_1 = new GuiTrainingItem(_loc_5[BarrackObject.TYPE]);
                _loc_1.barrackId = this.curBarrackId;
                if (this.listTrainingItem.length <= 0)
                {
                    _loc_1.setPos(startXFirt, startY);
                }
                else
                {
                    _loc_1.setPos(startX + padingX * _loc_4, startY);
                }
                if (_loc_4 >= MAX_TROOP_TYPE_SHOW)
                {
                    _loc_1.img.visible = false;
                }
                addGui(_loc_1);
                this.listTrainingItem.push(_loc_1);
                this.updateTrainingItem(_loc_5[BarrackObject.TYPE]);
                _loc_4++;
            }
            if (_loc_3.length > 0)
            {
                if (_loc_2.canFinish())
                {
                    this.showTimeTraining(true);
                }
                else
                {
                    this.showTimeTraining(false);
                    this.imageArrow.visible = true;
                }
            }
            else
            {
                this.showTimeTraining(false);
            }
            return;
        }// end function

        public function showBarrack() : void
        {
            var _loc_2:BarrackObject = null;
            this.enableTroopInBarrack();
            this.getCurrentTraing();
            var _loc_1:* = GameDataMgr.getInstance().getTotalTroopCapacity();
            var _loc_3:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            var _loc_4:int = 0;
            while (_loc_4 < this.barrackList.length)
            {
                
                _loc_2 = this.barrackList[_loc_4];
                _loc_3 = _loc_3 + _loc_2.getTotalTroopTraining();
                _loc_4++;
            }
            this.labelTotalTroop.text = Utility.standardNumber(_loc_3) + " / " + Utility.standardNumber(_loc_1);
            this.updateQuickFinishButtonState();
            return;
        }// end function

        override public function onMouseDown(param1:String, param2:MouseEvent) : void
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            switch(param1)
            {
                default:
                {
                    if (param1.indexOf(ARM_TRAINING) == 0)
                    {
                        _loc_3 = param1.split(ARM_TRAINING);
                        _loc_4 = _loc_3[1].split(ARM)[1];
                        this.mouseDownTroopType = ARM + SEPARATE + _loc_4;
                        this.mouseDownType = MOUSE_DOWN_TYPE_CANCEL;
                    }
                    this.mouseDownDelay = Utility.getCurTime() * 1000 + MOUSE_DOWN_DELAY_TO_START;
                    break;
                    break;
                }
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            var _loc_3:int = 0;
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            switch(param1)
            {
                case BTN_QUICK_FINISH:
                {
                    _loc_3 = parseInt(this.labelQuickFinish.text, 10);
                    CityMgr.getInstance().prepareToQuickTraining(this.curBarrackId, _loc_3);
                    break;
                }
                default:
                {
                    if (param1.indexOf(TROOP_INFO) == 0)
                    {
                        _loc_4 = param1.split(TROOP_INFO);
                    }
                    else if (param1.indexOf(ARM) == 0)
                    {
                        this.prepareToTrainTroop(param1);
                    }
                    else if (param1.indexOf(ARM_TRAINING) == 0)
                    {
                        _loc_4 = param1.split(ARM_TRAINING);
                        _loc_6 = _loc_4[1].split(ARM)[1];
                        this.cancelTroop(ARM + SEPARATE + _loc_6);
                    }
                    break;
                    break;
                }
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            super.hide(param1);
            if (TutorialMgr.getInstance().isTutorial)
            {
                return;
            }
            if (param1)
            {
                CityMgr.getInstance().showBuildingActionGui(this.saveBarrackObject);
            }
            return;
        }// end function

        public function prepareToTrainTroop(param1:String) : void
        {
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_2:* = this.barrackList[this.curBarrackId];
            var _loc_3:* = JsonMgr.getInstance().getTroopBase();
            var _loc_4:* = _loc_3[param1]["housingSpace"];
            if (_loc_2.getTotalTroopTraining() + _loc_4 > _loc_2.getMaxCapacity())
            {
                return;
            }
            if (TutorialMgr.getInstance().isTutorial)
            {
                _loc_9 = GameDataMgr.getInstance().getCurrentHousingSpace();
                _loc_9 = _loc_9 + _loc_2.getTotalTroopTraining();
                if (_loc_9 == 20)
                {
                    return;
                }
            }
            var _loc_5:* = GameDataMgr.getInstance().getMoney(MoneyType.ELIXIR);
            var _loc_6:* = JsonMgr.getInstance().getTroop();
            var _loc_7:* = GameDataMgr.getInstance().getTroopLevel(param1);
            var _loc_8:* = _loc_6[param1][_loc_7]["trainingCost"];
            GameDataMgr.getInstance().curTroopType = param1;
            if (_loc_5 >= _loc_8)
            {
                this.trainTroop();
            }
            else
            {
                _loc_10 = _loc_8 - _loc_5;
                CityMgr.getInstance().guiBuyResource.showGuiBuyResource(MoneyType.ELIXIR, _loc_10, CityMgr.getInstance().acceptBuyResource, [MoneyType.ELIXIR, _loc_10, this.trainTroop]);
            }
            return;
        }// end function

        public function trainTroop() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().curTroopType;
            var _loc_2:* = this.barrackList[this.curBarrackId];
            var _loc_3:* = JsonMgr.getInstance().getTroopBase();
            var _loc_4:* = _loc_3[_loc_1]["housingSpace"];
            var _loc_5:* = _loc_2.getTotalTroopTraining();
            var _loc_6:* = _loc_2.getMaxCapacity();
            if (_loc_5 + _loc_4 > _loc_6)
            {
                return;
            }
            this.needConfirm = this.listTrainingItem.length == 0 || _loc_5 + _loc_4 == _loc_6;
            CityMgr.getInstance().sendTrainTroopCmd(_loc_2.autoId, _loc_1, 1);
            if (!this.needConfirm)
            {
                this.onGetTrainTroopMsg(-1);
            }
            return;
        }// end function

        public function cancelTroop(param1:String) : void
        {
            var _loc_6:String = null;
            if (this.listTrainingItem.length == 0)
            {
                return;
            }
            var _loc_2:* = JsonMgr.getInstance().getTroop();
            var _loc_3:* = GameDataMgr.getInstance().getTroopLevel(param1);
            var _loc_4:* = _loc_2[param1][_loc_3]["trainingCost"];
            if (GameDataMgr.getInstance().myInfo.elixir + _loc_4 > GameDataMgr.getInstance().getTotalResourceStorage(BuildingType.ELIXIR_STORAGE))
            {
                _loc_6 = Localization.getInstance().getString("NotEnoughResourceStorage2");
                _loc_6 = _loc_6.replace("@type@", Localization.getInstance().getString(MoneyType.ELIXIR));
                _loc_6 = _loc_6.replace("@type@", Localization.getInstance().getString(MoneyType.ELIXIR));
                CityMgr.getInstance().guiNotify.addNewNotify(_loc_6);
                return;
            }
            this.saveTroopType = param1;
            var _loc_5:* = this.barrackList[this.curBarrackId];
            CityMgr.getInstance().sendCancelTroopTrainCmd(_loc_5.autoId, param1, 1);
            return;
        }// end function

        public function finishTrain(param1:String) : void
        {
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:GuiTrainingItem = null;
            var _loc_2:* = this.barrackList[this.curBarrackId];
            if (_loc_2.getTotalTypeTraining() == 0)
            {
                this.showTimeTraining(false);
            }
            var _loc_3:* = this.getTrainingItem(param1);
            if (_loc_3 > -1)
            {
                this.updateTrainingItem(param1);
                if (_loc_2.getNumTroopByType(param1) <= 0)
                {
                    this.listTrainingItem[_loc_3].destroyBaseGUI();
                    this.listTrainingItem[_loc_3] = null;
                    this.listTrainingItem.splice(_loc_3, 1);
                    _loc_8 = _loc_2.getTotalTypeTraining();
                    if (_loc_8 > 0)
                    {
                        _loc_9 = 0;
                        while (_loc_9 < this.listTrainingItem.length)
                        {
                            
                            _loc_10 = this.listTrainingItem[_loc_9];
                            if (_loc_9 == 0)
                            {
                                _loc_10.setPos(startXFirt, startY);
                            }
                            else
                            {
                                _loc_10.setPos(startX + padingX * _loc_9, startY);
                            }
                            if (_loc_9 < MAX_TROOP_TYPE_SHOW)
                            {
                                _loc_10.img.visible = true;
                            }
                            _loc_9++;
                        }
                    }
                }
            }
            var _loc_4:* = this.barrackList[this.curBarrackId].getTotalTroopTraining();
            var _loc_5:* = this.barrackList[this.curBarrackId].getMaxCapacity();
            var _loc_6:* = Localization.getInstance().getString(BuildingType.BARRACK) + " " + (this.curBarrackId + 1) + " (" + _loc_4 + "/" + _loc_5 + ")";
            CityMgr.getInstance().guiTrainTroop2.labelBarrackName.text = _loc_6.toUpperCase();
            var _loc_7:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            if (TutorialMgr.getInstance().isTutorial && _loc_7 == 20)
            {
                this.hide(true);
                CityMgr.getInstance().guiMainBottom.show();
                TutorialMgr.getInstance().nextStep();
            }
            return;
        }// end function

        public function showTimeTraining(param1:Boolean) : void
        {
            this.labelTmp1.visible = param1;
            this.labelTmp2.visible = param1;
            this.labelTmp3.visible = param1;
            this.labelTotalTime.visible = param1;
            this.labelTotalTroop.visible = param1;
            this.labelQuickFinish.visible = param1;
            this.bmpQuickFinish.visible = param1;
            this.imageArrow.visible = param1;
            return;
        }// end function

        private function setAvaiableTroop() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().barrackList[this.curBarrackId];
            var _loc_2:int = 0;
            while (_loc_2 < this.listTroopItem.length)
            {
                
                this.listTroopItem[_loc_2].setNotAvaiable((_loc_2 + 1) <= _loc_1.level ? (0) : ((_loc_2 + 1)));
                _loc_2++;
            }
            return;
        }// end function

        public function enableTroopInBarrack() : void
        {
            var _loc_2:GuiTroopBase = null;
            var _loc_1:* = GameDataMgr.getInstance().barrackList[this.curBarrackId];
            var _loc_3:* = _loc_1.getTotalTroopTraining();
            var _loc_4:* = _loc_1.getMaxCapacity();
            var _loc_5:int = 0;
            while (_loc_5 < this.listTroopItem.length)
            {
                
                _loc_2 = this.listTroopItem[_loc_5];
                _loc_2.setNotAvaiable((_loc_5 + 1) <= _loc_1.level ? (0) : ((_loc_5 + 1)));
                if (_loc_3 + _loc_1.objConf[ARM + "_" + (_loc_5 + 1)]["housingSpace"] > _loc_4)
                {
                    _loc_2.setEnable(false);
                }
                _loc_5++;
            }
            return;
        }// end function

        public function disableTroopInBarrack() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < MAX_TROOP_TYPE)
            {
                
                this.listTroopItem[_loc_1].setEnable(false);
                _loc_1++;
            }
            return;
        }// end function

        public function getTrainHousingSpace() : int
        {
            var _loc_3:BarrackObject = null;
            var _loc_1:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            var _loc_2:int = 0;
            while (_loc_2 < this.barrackList.length)
            {
                
                _loc_3 = this.barrackList[_loc_2];
                _loc_1 = _loc_1 + _loc_3.getTotalTroopTraining();
                _loc_2++;
            }
            return _loc_1;
        }// end function

        private function updateHousingSpace() : void
        {
            var _loc_1:int = 0;
            var _loc_3:BarrackObject = null;
            var _loc_2:* = GameDataMgr.getInstance().getTotalTroopCapacity();
            var _loc_4:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            var _loc_5:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            _loc_1 = 0;
            while (_loc_1 < this.barrackList.length)
            {
                
                _loc_3 = this.barrackList[_loc_1];
                _loc_5 = _loc_5 + _loc_3.getTotalTroopTraining();
                _loc_1++;
            }
            this.labelTotalTroop.text = Utility.standardNumber(_loc_5) + " / " + Utility.standardNumber(_loc_2);
            return;
        }// end function

        public function updateQuickFinishButtonState() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().getTotalTroopCapacity();
            var _loc_2:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            var _loc_3:* = this.barrackList[this.curBarrackId];
            this.bmpQuickFinish.enable = _loc_3.getTotalTroopTraining() + _loc_2 <= _loc_1;
            return;
        }// end function

        public function updateTroopLevel(param1:String) : void
        {
            var _loc_2:* = param1.split("_");
            var _loc_3:* = this.listTroopItem[(parseInt(_loc_2[1], 10) - 1)];
            _loc_3.updateTroopLevel(param1);
            return;
        }// end function

        public function showStop() : void
        {
            if (this.listTrainingItem.length > 0)
            {
                this.listTrainingItem[0].labelTime.text = "DỪNG";
            }
            this.showTimeTraining(false);
            this.imageArrow.visible = true;
            return;
        }// end function

        public function updateTotalRemainTime(param1:int) : void
        {
            this.labelTotalTime.text = Utility.convertTimeToString(param1, true, true, true);
            var _loc_2:* = Utility.getCostToBuyTime(param1).value;
            this.labelQuickFinish.text = Utility.standardNumber(_loc_2);
            return;
        }// end function

        public function updateCtnTrainTroop(param1:int) : void
        {
            if (this.listTrainingItem.length > 0)
            {
                this.listTrainingItem[0].update(param1);
            }
            return;
        }// end function

        public function updateStartTime(param1:Number) : void
        {
            var _loc_2:* = this.barrackList[this.curBarrackId];
            var _loc_3:* = _loc_2.getCurrentTypeTraining();
            var _loc_4:* = JsonMgr.getInstance().getTroopBase();
            var _loc_5:int = 0;
            if (_loc_3 != "")
            {
                _loc_5 = _loc_4[_loc_3]["trainingTime"];
            }
            if (param1 < _loc_2.startTime + _loc_5)
            {
                _loc_2.startTime = param1;
            }
            else if (_loc_3 != "")
            {
                if (_loc_2.canFinish())
                {
                    _loc_2.finishTraining(param1);
                    if (this.bgImg.visible)
                    {
                        this.finishTrain(_loc_3);
                    }
                }
                else
                {
                    _loc_2.isStopped = true;
                    this.showStop();
                }
            }
            else
            {
                _loc_2.startTime = param1;
            }
            return;
        }// end function

        public function onGetTrainTroopMsg(param1:Number) : void
        {
            var _loc_7:GuiTrainingItem = null;
            var _loc_8:int = 0;
            if (param1 > -1)
            {
                this.updateStartTime(param1);
            }
            var _loc_2:* = this.barrackList[this.curBarrackId];
            var _loc_3:* = GameDataMgr.getInstance().curTroopType;
            if (this.bgImg.visible)
            {
                if (_loc_2.getTotalTroopTraining() <= 0)
                {
                    this.showTimeTraining(true);
                }
                if (_loc_2.getNumTroopByType(_loc_3) <= 0)
                {
                    _loc_8 = _loc_2.getTotalTypeTraining();
                    _loc_7 = new GuiTrainingItem(_loc_3);
                    _loc_7.barrackId = this.curBarrackId;
                    this.listTrainingItem.push(_loc_7);
                    addGui(_loc_7);
                    if (this.listTrainingItem.length < 1)
                    {
                        _loc_7.setPos(startXFirt, startY);
                    }
                    else
                    {
                        _loc_7.setPos(startX + padingX * _loc_8, startY);
                    }
                    if (_loc_8 >= MAX_TROOP_TYPE_SHOW)
                    {
                        _loc_7.img.visible = false;
                    }
                }
            }
            var _loc_4:* = JsonMgr.getInstance().getTroop();
            var _loc_5:* = GameDataMgr.getInstance().getTroopLevel(_loc_3);
            var _loc_6:* = _loc_4[_loc_3][_loc_5]["trainingCost"];
            GameDataMgr.getInstance().addMoney(MoneyType.ELIXIR, -_loc_6);
            SoundModule.getInstance().playSound(SoundModule.BUTTON_CLICK);
            _loc_2.trainTroop(_loc_3);
            this.updateTrainingItem(_loc_3);
            CityMgr.getInstance().guiTrainTroop2.updateBarrackName();
            return;
        }// end function

        public function updateTrainingItem(param1:String) : void
        {
            var _loc_2:* = this.getTrainingItem(param1);
            if (_loc_2 == -1)
            {
                return;
            }
            var _loc_3:* = this.listTrainingItem[_loc_2];
            var _loc_4:* = this.barrackList[this.curBarrackId];
            var _loc_5:* = this.barrackList[this.curBarrackId].getNumTroopByType(param1);
            _loc_3.labelNum.text = "x" + Utility.standardNumber(_loc_5);
            var _loc_6:* = param1.split("_");
            var _loc_7:* = this.listTroopItem[(parseInt(_loc_6[1], 10) - 1)];
            this.listTroopItem[(parseInt(_loc_6[1], 10) - 1)].updateTroopNumber(_loc_5);
            this.updateHousingSpace();
            this.updateQuickFinishButtonState();
            return;
        }// end function

        public function onGetCancelTrainTroopMsg(param1:CancelTroopTrainMsg) : void
        {
            var _loc_2:* = this.barrackList[this.curBarrackId];
            if (_loc_2.getNumTroopByType(this.saveTroopType) <= 0)
            {
                return;
            }
            var _loc_3:* = JsonMgr.getInstance().getTroop();
            var _loc_4:* = GameDataMgr.getInstance().getTroopLevel(this.saveTroopType);
            var _loc_5:* = _loc_3[this.saveTroopType][_loc_4]["trainingCost"];
            SoundModule.getInstance().playSound(SoundModule.BUTTON_CLICK);
            GameDataMgr.getInstance().addMoney(MoneyType.ELIXIR, _loc_5);
            _loc_2.cancelTroop(this.saveTroopType);
            this.finishTrain(this.saveTroopType);
            return;
        }// end function

        public function runHideEffect(param1:int = 1, param2:int = -1) : void
        {
            this.nextBarrack = param2;
            this.showEffectDone();
            TweenMax.to(bgImg, 0.2, {x:-15 * param1, alpha:0, onComplete:this.hideEffectDone});
            return;
        }// end function

        private function hideEffectDone() : void
        {
            bgImg.visible = false;
            if (this.nextBarrack != -1)
            {
                CityMgr.getInstance().guiTrainTroop2.listItem[this.nextBarrack].showEffectDone();
            }
            return;
        }// end function

        public function runShowEffect(param1:Boolean = false) : void
        {
            if (param1)
            {
                TweenMax.to(bgImg, 0, {delay:0.2, onComplete:this.showEffectDone});
            }
            else
            {
                this.showEffectDone();
            }
            return;
        }// end function

        public function showEffectDone() : void
        {
            bgImg.visible = true;
            bgImg.alpha = 1;
            bgImg.x = 9;
            return;
        }// end function

        private function getBarrack(param1:int) : BarrackObject
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.barrackList.length)
            {
                
                if (this.barrackList[_loc_2].autoId == param1)
                {
                    return this.barrackList[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        private function getTrainingItem(param1:String) : int
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.listTrainingItem.length)
            {
                
                if (this.listTrainingItem[_loc_2].curType == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

    }
}
