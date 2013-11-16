package modules.city.graphics.barrack
{
    import __AS3__.vec.*;
    import component.*;
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

    public class GuiTrainTroop extends BaseGui
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
        public var curBarrackId:int;
        public var barrackList:Vector.<BarrackObject>;
        public var arrCtnTrain:Array;
        public var mouseDownTroopType:String = "";
        public var mouseDownType:String = "";
        public var mouseDownDelay:Number = 0;
        public var saveBarrackObject:MapObject;
        private var saveTroopType:String;
        public var needConfirm:Boolean;
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

        public function GuiTrainTroop()
        {
            super(ResMgr.getInstance().getMovieClip("GuiTrainTroop"));
            enableDisableScreen = true;
            enableClickOutToClose = true;
            setPos((GlobalVar.SCREEN_WIDTH - this.widthBg) / 2, (GlobalVar.SCREEN_HEIGHT - this.heightBg) / 2);
            this.addTroopConfig();
            return;
        }// end function

        public function showGui(param1:int) : void
        {
            var _loc_2:int = 0;
            var _loc_3:BarrackObject = null;
            CityMgr.getInstance().sendGetCurTime();
            this.curBarrackId = param1;
            this.barrackList = GameDataMgr.getInstance().barrackList;
            this.arrCtnTrain = new Array();
            _loc_2 = 0;
            while (_loc_2 >= this.barrackList.length)
            {
                
                _loc_3 = this.barrackList[_loc_2];
                if (_loc_3.status >= MapObject.UPGRADING)
                {
                    this.barrackList.splice(_loc_2, 1);
                    _loc_2 = _loc_2 - 1;
                }
                _loc_2++;
            }
            this.saveBarrackObject = this.barrackList[param1];
            this.updateTroopInfo();
            this.selectBarrack(this.curBarrackId);
            show(null, true);
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

        override public function clickOutSideGui() : void
        {
            super.clickOutSideGui();
            CityMgr.getInstance().guiMainBottom.show();
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
                case BTN_CLOSE:
                {
                    CityMgr.getInstance().guiMainBottom.show();
                    this.hide(true);
                    break;
                }
                case BTN_QUICK_FINISH:
                {
                    _loc_3 = parseInt(this.labelQuickFinish.text, 10);
                    CityMgr.getInstance().prepareToQuickTraining(this.curBarrackId, _loc_3);
                    break;
                }
                case BTN_PREV_BARRACK:
                {
                    this.selectBarrack((this.curBarrackId - 1));
                    break;
                }
                case BTN_NEXT_BARRACK:
                {
                    this.selectBarrack((this.curBarrackId + 1));
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

        private function prepareToTrainTroop(param1:String) : void
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
            CityMgr.getInstance().sendTrainTroopCmd(_loc_2.autoId, _loc_1, 1);
            return;
        }// end function

        private function cancelTroop(param1:String) : void
        {
            var _loc_6:String = null;
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

        public function finishTrain(param1:String, param2:BarrackObject) : void
        {
            var _loc_3:GuiTrainingItem = null;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            if (param2.getTotalTypeTraining() == 0)
            {
                this.showTimeTraining(false);
            }
            _loc_3 = getGUI_Parent(ARM_TRAINING + param1) as GuiTrainingItem;
            if (_loc_3)
            {
                if (param2.getNumTroopByType(param1) <= 0)
                {
                    this.arrCtnTrain.splice(this.arrCtnTrain.indexOf(_loc_3), 1);
                    removeGui(_loc_3);
                    _loc_8 = param2.getTotalTypeTraining();
                    _loc_9 = 428;
                    _loc_10 = 80;
                    _loc_11 = -74;
                    if (_loc_8 > 0)
                    {
                        _loc_12 = 0;
                        while (_loc_12 < this.arrCtnTrain.length)
                        {
                            
                            _loc_3 = this.arrCtnTrain[_loc_12];
                            if (_loc_12 == 0)
                            {
                                _loc_3.setPos(440, 80);
                            }
                            else
                            {
                                _loc_3.setPos(_loc_9 + _loc_11 * _loc_12, _loc_10);
                            }
                            if (_loc_12 < MAX_TROOP_TYPE_SHOW)
                            {
                                _loc_3.img.visible = true;
                            }
                            _loc_12++;
                        }
                    }
                }
                else
                {
                    _loc_3.labelNum.text = "x" + Utility.standardNumber(param2.getNumTroopByType(param1));
                }
            }
            this.updateHousingSpace();
            this.updateQuickFinishButtonState();
            var _loc_4:* = this.barrackList[this.curBarrackId].getTotalTroopTraining();
            var _loc_5:* = this.barrackList[this.curBarrackId].getMaxCapacity();
            var _loc_6:* = Localization.getInstance().getString(BuildingType.BARRACK) + " " + (this.curBarrackId + 1) + " (" + _loc_4 + "/" + _loc_5 + ")";
            this.labelBarrackName.text = _loc_6.toUpperCase();
            var _loc_7:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            if (TutorialMgr.getInstance().isTutorial && _loc_7 == 20)
            {
                this.hide(true);
                CityMgr.getInstance().guiMainBottom.show();
                TutorialMgr.getInstance().nextStep();
            }
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
            _loc_6 = 75;
            _loc_7 = 215;
            _loc_8 = 109;
            _loc_9 = 120;
            _loc_4 = 1;
            while (_loc_4 <= MAX_TROOP_TYPE)
            {
                
                _loc_5 = new GuiTroopBase();
                addGUI_Parent(_loc_5, ARM + _loc_4, false);
                if (_loc_4 == 6)
                {
                    _loc_6 = 75;
                    _loc_7 = _loc_7 + _loc_9;
                }
                _loc_5.setPos(_loc_6, _loc_7);
                _loc_6 = _loc_6 + _loc_8;
                _loc_4++;
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

        public function updateBarrackTraining(param1:int) : void
        {
            return;
        }// end function

        override public function loop() : void
        {
            var _loc_1:int = 0;
            if (!isShowing)
            {
                return;
            }
            var _loc_2:* = this.barrackList[this.curBarrackId].getTotalTroopTraining();
            var _loc_3:* = this.barrackList[this.curBarrackId].getMaxCapacity();
            if (_loc_2 >= _loc_3)
            {
                this.disableTroopInBarrack(this.curBarrackId);
            }
            else
            {
                this.enableTroopInBarrack(this.curBarrackId);
            }
            if (GameInput.getInstance().isMouseDown)
            {
                if (this.mouseDownTroopType != "" && Utility.getCurTime() * 1000 > this.mouseDownDelay + MOUSE_DOWN_DELAY)
                {
                    if (this.mouseDownType == MOUSE_DOWN_TYPE_ADD)
                    {
                        this.prepareToTrainTroop(this.mouseDownTroopType);
                    }
                    else if (this.mouseDownType == MOUSE_DOWN_TYPE_CANCEL)
                    {
                        this.cancelTroop(this.mouseDownTroopType);
                    }
                    this.mouseDownDelay = Utility.getCurTime() * 1000;
                }
            }
            else
            {
                this.mouseDownTroopType = "";
            }
            return;
        }// end function

        private function enableTroopInBarrack(param1:int) : void
        {
            var _loc_3:GuiTroopBase = null;
            var _loc_2:* = this.barrackList[param1];
            var _loc_4:* = _loc_2.getTotalTroopTraining();
            var _loc_5:* = _loc_2.getMaxCapacity();
            var _loc_6:int = 1;
            while (_loc_6 <= MAX_TROOP_TYPE)
            {
                
                _loc_3 = getGUI_Parent(ARM + _loc_6) as GuiTroopBase;
                _loc_3.setNotAvaiable(_loc_6 <= _loc_2.level ? (0) : (_loc_6));
                if (_loc_4 + _loc_2.objConf[ARM + "_" + _loc_6]["housingSpace"] > _loc_5)
                {
                    _loc_3.setEnable(false);
                }
                _loc_6++;
            }
            return;
        }// end function

        private function disableTroopInBarrack(param1:int) : void
        {
            var _loc_2:GuiTroopBase = null;
            var _loc_3:int = 1;
            while (_loc_3 <= MAX_TROOP_TYPE)
            {
                
                _loc_2 = getGUI_Parent(ARM + _loc_3) as GuiTroopBase;
                _loc_2.setEnable(false);
                _loc_3++;
            }
            return;
        }// end function

        public function selectBarrack(param1:int) : void
        {
            var _loc_3:int = 0;
            var _loc_7:GuiTrainingItem = null;
            var _loc_13:BarrackObject = null;
            var _loc_15:String = null;
            var _loc_16:Object = null;
            if (param1 < 0)
            {
                param1 = this.barrackList.length - 1;
            }
            if (param1 >= this.barrackList.length)
            {
                param1 = 0;
            }
            var _loc_2:* = this.barrackList[param1];
            if (_loc_2.status != MapObject.PRODUCING)
            {
                if (this.curBarrackId < param1)
                {
                    this.selectBarrack((param1 + 1));
                }
                else
                {
                    this.selectBarrack((param1 - 1));
                }
                return;
            }
            this.curBarrackId = param1;
            _loc_2 = this.barrackList[this.curBarrackId];
            var _loc_4:* = this.barrackList[this.curBarrackId].getTotalTroopTraining();
            var _loc_5:* = this.barrackList[this.curBarrackId].getMaxCapacity();
            var _loc_6:* = Localization.getInstance().getString(BuildingType.BARRACK) + " " + (this.curBarrackId + 1) + " (" + _loc_4 + "/" + _loc_5 + ")";
            this.labelBarrackName.text = _loc_6.toUpperCase();
            this.enableTroopInBarrack(this.curBarrackId);
            _loc_3 = 0;
            while (_loc_3 < guiList.length)
            {
                
                _loc_15 = guiList[_loc_3].id;
                if (_loc_15.indexOf(ARM_TRAINING) >= 0)
                {
                    removeGuiById(_loc_15);
                    _loc_3 = _loc_3 - 1;
                }
                _loc_3++;
            }
            this.arrCtnTrain = [];
            var _loc_8:* = _loc_2.getTrainingTroop();
            var _loc_9:int = 428;
            var _loc_10:int = 80;
            var _loc_11:int = -74;
            _loc_3 = 0;
            while (_loc_3 < _loc_8.length)
            {
                
                _loc_16 = _loc_8[_loc_3];
                _loc_7 = new GuiTrainingItem(_loc_16[BarrackObject.TYPE]);
                addGUI_Parent(_loc_7, ARM_TRAINING + _loc_16[BarrackObject.TYPE]);
                if (this.arrCtnTrain.length <= 0)
                {
                    _loc_7.setPos(440, _loc_10);
                }
                else
                {
                    _loc_7.setPos(_loc_9 + _loc_11 * _loc_3, _loc_10);
                }
                this.arrCtnTrain.push(_loc_7);
                if (_loc_3 >= MAX_TROOP_TYPE_SHOW)
                {
                    _loc_7.img.visible = false;
                }
                _loc_7.labelNum.text = "x" + Utility.standardNumber(_loc_16[BarrackObject.NUM]);
                _loc_3++;
            }
            if (_loc_8.length > 0)
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
            var _loc_12:* = GameDataMgr.getInstance().getTotalTroopCapacity();
            var _loc_14:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            _loc_3 = 0;
            while (_loc_3 < this.barrackList.length)
            {
                
                _loc_13 = this.barrackList[_loc_3];
                _loc_14 = _loc_14 + _loc_13.getTotalTroopTraining();
                _loc_3++;
            }
            this.labelTotalTroop.text = Utility.standardNumber(_loc_14) + " / " + Utility.standardNumber(_loc_12);
            this.updateQuickFinishButtonState();
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

        private function updateQuickFinishButtonState() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().getTotalTroopCapacity();
            var _loc_2:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            var _loc_3:* = this.barrackList[this.curBarrackId];
            this.bmpQuickFinish.enable = _loc_3.getTotalTroopTraining() + _loc_2 <= _loc_1;
            return;
        }// end function

        public function finishAllTraining(param1:int) : void
        {
            var _loc_7:String = null;
            var _loc_2:int = 0;
            while (_loc_2 < guiList.length)
            {
                
                _loc_7 = guiList[_loc_2].id;
                if (_loc_7.indexOf(ARM_TRAINING) >= 0)
                {
                    removeGuiById(_loc_7);
                    _loc_2 = _loc_2 - 1;
                }
                _loc_2++;
            }
            this.arrCtnTrain = [];
            this.showTimeTraining(false);
            var _loc_3:* = this.barrackList[param1];
            _loc_3.quickFinishTraining();
            var _loc_4:* = this.barrackList[param1].getTotalTroopTraining();
            var _loc_5:* = this.barrackList[param1].getMaxCapacity();
            var _loc_6:* = Localization.getInstance().getString(BuildingType.BARRACK) + " " + (param1 + 1) + " (" + _loc_4 + "/" + _loc_5 + ")";
            this.labelBarrackName.text = _loc_6.toUpperCase();
            return;
        }// end function

        public function updateTroopInfo() : void
        {
            var _loc_2:String = null;
            var _loc_3:GuiTroopBase = null;
            var _loc_1:int = 1;
            while (_loc_1 <= MAX_TROOP_TYPE)
            {
                
                _loc_2 = ARM + SEPARATE + _loc_1;
                _loc_3 = getGUI_Parent(ARM + _loc_1) as GuiTroopBase;
                _loc_3.loadTroopType(_loc_2);
                _loc_1++;
            }
            return;
        }// end function

        public function updateTroopLevel(param1:String) : void
        {
            var _loc_2:* = param1.split("_");
            var _loc_3:* = getGUI_Parent(_loc_2[0] + _loc_2[1]) as GuiTroopBase;
            _loc_3.updateTroopLevel(param1);
            return;
        }// end function

        public function showStop() : void
        {
            var _loc_1:GuiTrainingItem = null;
            if (this.arrCtnTrain)
            {
                if (this.arrCtnTrain[0])
                {
                    _loc_1 = this.arrCtnTrain[0];
                    _loc_1.labelTime.text = "DỪNG";
                }
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
            var _loc_2:GuiTrainingItem = null;
            if (this.arrCtnTrain)
            {
                if (this.arrCtnTrain[0])
                {
                    _loc_2 = this.arrCtnTrain[0];
                    _loc_2.update(param1);
                }
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
                    this.finishTrain(_loc_3, _loc_2);
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
            var _loc_3:GuiTrainingItem = null;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:int = 0;
            var _loc_15:int = 0;
            var _loc_16:int = 0;
            this.updateStartTime(param1);
            var _loc_2:* = this.barrackList[this.curBarrackId];
            if (_loc_2.getTotalTroopTraining() <= 0)
            {
                this.showTimeTraining(true);
            }
            var _loc_4:* = GameDataMgr.getInstance().curTroopType;
            if (_loc_2.getNumTroopByType(_loc_4) <= 0)
            {
                _loc_12 = 428;
                _loc_13 = 80;
                _loc_14 = -74;
                _loc_15 = _loc_2.getTotalTypeTraining();
                _loc_3 = new GuiTrainingItem(_loc_4);
                addGUI_Parent(_loc_3, ARM_TRAINING + _loc_4);
                if (this.arrCtnTrain.length <= 0)
                {
                    _loc_3.setPos(440, _loc_13);
                }
                else
                {
                    _loc_3.setPos(_loc_12 + _loc_14 * _loc_15, _loc_13);
                }
                this.arrCtnTrain.push(_loc_3);
                if (_loc_15 >= MAX_TROOP_TYPE_SHOW)
                {
                    _loc_3.img.visible = false;
                }
            }
            var _loc_5:* = JsonMgr.getInstance().getTroop();
            var _loc_6:* = GameDataMgr.getInstance().getTroopLevel(_loc_4);
            var _loc_7:* = _loc_5[_loc_4][_loc_6]["trainingCost"];
            GameDataMgr.getInstance().addMoney(MoneyType.ELIXIR, -_loc_7);
            SoundModule.getInstance().playSound(SoundModule.BUTTON_CLICK);
            _loc_2.trainTroop(_loc_4);
            _loc_3 = getGUI_Parent(ARM_TRAINING + _loc_4) as GuiTrainingItem;
            var _loc_8:* = _loc_2.getNumTroopByType(_loc_4);
            _loc_3.labelNum.text = "x" + Utility.standardNumber(_loc_8);
            this.updateHousingSpace();
            this.updateQuickFinishButtonState();
            var _loc_9:* = this.barrackList[this.curBarrackId].getTotalTroopTraining();
            var _loc_10:* = this.barrackList[this.curBarrackId].getMaxCapacity();
            var _loc_11:* = Localization.getInstance().getString(BuildingType.BARRACK) + " " + (this.curBarrackId + 1) + " (" + _loc_9 + "/" + _loc_10 + ")";
            this.labelBarrackName.text = _loc_11.toUpperCase();
            if (TutorialMgr.getInstance().isTutorial)
            {
                _loc_16 = GameDataMgr.getInstance().getCurrentHousingSpace();
                _loc_16 = _loc_16 + this.barrackList[this.curBarrackId].getTotalTroopTraining();
                TutorialMgr.getInstance().updateGuideText(_loc_16);
                if (TutorialMgr.getInstance().curStep == 51 && _loc_16 == 20)
                {
                    TutorialMgr.getInstance().nextStep();
                }
            }
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
            this.finishTrain(this.saveTroopType, _loc_2);
            return;
        }// end function

        public function onGetFinishTrainTroop(param1:FinishTrainTroopMsg) : void
        {
            var _loc_3:Object = null;
            var _loc_4:String = null;
            var _loc_2:* = this.getBarrack(param1.barrackAutoId);
            if (!_loc_2)
            {
                return;
            }
            if (param1.errorCode == 0)
            {
                _loc_3 = _loc_2.trainingTroop[0];
                if (!_loc_3)
                {
                    return;
                }
                _loc_4 = _loc_3["type"];
                _loc_2.finishTraining(param1.startTime);
                if (isShowing && this.barrackList[this.curBarrackId].autoId == _loc_2.autoId)
                {
                    this.finishTrain(_loc_4, _loc_2);
                }
                if (isShowing)
                {
                    this.updateQuickFinishButtonState();
                }
            }
            else
            {
                this.updateStartTimeForBarrack(param1.startTime, param1.barrackAutoId);
            }
            GameDataMgr.getInstance().hasSentFinishTroop = false;
            return;
        }// end function

        public function updateStartTimeForBarrack(param1:Number, param2:int) : void
        {
            var _loc_3:* = this.getBarrack(param2);
            if (!_loc_3)
            {
                return;
            }
            _loc_3.startTime = param1;
            return;
        }// end function

        private function getBarrack(param1:int) : BarrackObject
        {
            this.barrackList = GameDataMgr.getInstance().barrackList;
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

    }
}
