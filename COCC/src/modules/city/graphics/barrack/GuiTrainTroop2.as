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
    import network.receive.*;
    import resMgr.*;
    import utility.*;

    public class GuiTrainTroop2 extends BaseGui
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
        public var listItem:Vector.<GuiTroopPage>;
        public var guiSpellPage:GuiSpellPage;
        public var spellFactory:SpellFactoryObject;
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

        public function GuiTrainTroop2()
        {
            this.listItem = new Vector.<GuiTroopPage>;
            super(ResMgr.getInstance().getMovieClip("GuiTrainTroop2"));
            enableDisableScreen = true;
            enableClickOutToClose = true;
            setPos((GlobalVar.SCREEN_WIDTH - this.widthBg) / 2, (GlobalVar.SCREEN_HEIGHT - this.heightBg) / 2);
            return;
        }// end function

        public function removeAllTrainingItem() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                this.listItem[_loc_1].destroyBaseGUI();
                this.listItem[_loc_1] = null;
                _loc_1++;
            }
            this.listItem.splice(0, this.listItem.length);
            this.listItem = new Vector.<GuiTroopPage>;
            return;
        }// end function

        public function loadBarracks() : void
        {
            var _loc_2:GuiTroopPage = null;
            this.removeAllTrainingItem();
            this.barrackList = GameDataMgr.getInstance().barrackList;
            var _loc_1:int = 0;
            while (_loc_1 < this.barrackList.length)
            {
                
                _loc_2 = new GuiTroopPage();
                _loc_2.setBarrack(_loc_1);
                _loc_2.setPos(9, 68);
                addGui(_loc_2);
                _loc_2.bgImg.visible = false;
                this.listItem.push(_loc_2);
                _loc_1++;
            }
            this.spellFactory = GameDataMgr.getInstance().spellFactory;
            if (this.spellFactory)
            {
                this.guiSpellPage = new GuiSpellPage();
                this.guiSpellPage.setPos(9, 68);
                addGui(this.guiSpellPage);
                this.guiSpellPage.bgImg.visible = false;
                this.guiSpellPage.getSpellInfo();
            }
            if (isShowing)
            {
                this.selectBarrack(this.curBarrackId);
            }
            return;
        }// end function

        public function showGui(param1:int) : void
        {
            if (this.curBarrackId >= 0 && this.curBarrackId < this.barrackList.length)
            {
                this.listItem[this.curBarrackId].bgImg.visible = false;
            }
            this.curBarrackId = -2;
            CityMgr.getInstance().sendGetCurTime();
            this.selectBarrack(param1);
            show(null, true);
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
            switch(param1)
            {
                case BTN_CLOSE:
                {
                    CityMgr.getInstance().guiMainBottom.show();
                    this.hide(true);
                    break;
                }
                case BTN_PREV_BARRACK:
                {
                    if (this.spellFactory && this.guiSpellPage.bgImg.visible)
                    {
                        this.selectBarrack((this.barrackList.length - 1));
                    }
                    else
                    {
                        this.selectBarrack((this.curBarrackId - 1));
                    }
                    break;
                }
                case BTN_NEXT_BARRACK:
                {
                    if (this.spellFactory && this.guiSpellPage.bgImg.visible)
                    {
                        this.selectBarrack(0);
                    }
                    else
                    {
                        this.selectBarrack((this.curBarrackId + 1));
                    }
                    break;
                }
                default:
                {
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

        override public function loop() : void
        {
            var _loc_1:int = 0;
            if (!isShowing || this.curBarrackId == -1)
            {
                return;
            }
            var _loc_2:* = this.barrackList[this.curBarrackId].getTotalTroopTraining();
            var _loc_3:* = this.barrackList[this.curBarrackId].getMaxCapacity();
            if (_loc_2 >= _loc_3)
            {
                this.listItem[this.curBarrackId].disableTroopInBarrack();
            }
            else
            {
                this.listItem[this.curBarrackId].enableTroopInBarrack();
            }
            if (GameInput.getInstance().isMouseDown)
            {
                if (this.mouseDownTroopType != "" && Utility.getCurTime() * 1000 > this.mouseDownDelay + MOUSE_DOWN_DELAY)
                {
                    if (this.mouseDownType == MOUSE_DOWN_TYPE_ADD)
                    {
                        this.listItem[this.curBarrackId].prepareToTrainTroop(this.mouseDownTroopType);
                    }
                    else if (this.mouseDownType == MOUSE_DOWN_TYPE_CANCEL)
                    {
                        this.listItem[this.curBarrackId].cancelTroop(this.mouseDownTroopType);
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

        public function selectBarrack(param1:int) : void
        {
            var _loc_2:int = 0;
            if (this.curBarrackId < param1)
            {
                _loc_2 = 1;
            }
            else
            {
                _loc_2 = -1;
            }
            if (param1 < 0)
            {
                if (this.spellFactory)
                {
                    this.selectSpellFactory();
                    return;
                }
                param1 = this.barrackList.length - 1;
            }
            if (param1 >= this.barrackList.length)
            {
                if (this.spellFactory)
                {
                    this.selectSpellFactory();
                    return;
                }
                param1 = 0;
            }
            var _loc_3:* = this.barrackList[param1];
            if (_loc_3.status != MapObject.PRODUCING)
            {
                this.selectBarrack(param1 + _loc_2);
                return;
            }
            var _loc_4:* = this.curBarrackId != -2;
            if (this.curBarrackId == -1)
            {
                if (this.spellFactory)
                {
                    this.guiSpellPage.runHideEffect();
                }
            }
            else if (_loc_4 && this.curBarrackId != param1)
            {
                this.listItem[this.curBarrackId].runHideEffect(_loc_2, param1);
            }
            this.curBarrackId = param1;
            _loc_3 = this.barrackList[this.curBarrackId];
            var _loc_5:* = this.barrackList[this.curBarrackId].getTotalTroopTraining();
            var _loc_6:* = this.barrackList[this.curBarrackId].getMaxCapacity();
            var _loc_7:* = Localization.getInstance().getString(BuildingType.BARRACK) + " " + (this.curBarrackId + 1) + " (" + _loc_5 + "/" + _loc_6 + ")";
            this.labelBarrackName.text = _loc_7.toUpperCase();
            this.listItem[this.curBarrackId].showBarrack();
            if (!_loc_4)
            {
                this.listItem[this.curBarrackId].showEffectDone();
            }
            return;
        }// end function

        public function selectSpellFactory() : void
        {
            if (this.curBarrackId >= 0 && this.curBarrackId < this.barrackList.length)
            {
                this.listItem[this.curBarrackId].bgImg.visible = false;
            }
            this.curBarrackId = -1;
            var _loc_1:int = 0;
            var _loc_2:int = 1;
            var _loc_3:* = Localization.getInstance().getString(BuildingType.SPELL_FACTORY) + " " + (this.curBarrackId + 1) + " (" + _loc_1 + "/" + _loc_2 + ")";
            this.labelBarrackName.text = _loc_3.toUpperCase();
            this.guiSpellPage.showSpellCreating();
            this.guiSpellPage.runShowEffect();
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

        public function finishAllTraining(param1:int) : void
        {
            this.listItem[param1].removeAllTrainingItem();
            this.listItem[param1].showTimeTraining(false);
            var _loc_2:* = this.barrackList[param1];
            _loc_2.quickFinishTraining();
            var _loc_3:* = this.barrackList[param1].getTotalTroopTraining();
            var _loc_4:* = this.barrackList[param1].getMaxCapacity();
            var _loc_5:* = Localization.getInstance().getString(BuildingType.BARRACK) + " " + (param1 + 1) + " (" + _loc_3 + "/" + _loc_4 + ")";
            this.labelBarrackName.text = _loc_5.toUpperCase();
            return;
        }// end function

        public function updateTroopLevel(param1:String) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.listItem.length)
            {
                
                this.listItem[_loc_2].updateTroopLevel(param1);
                _loc_2++;
            }
            return;
        }// end function

        public function showStop() : void
        {
            this.listItem[this.curBarrackId].showStop();
            return;
        }// end function

        public function updateTotalRemainTime(param1:int) : void
        {
            this.listItem[this.curBarrackId].updateTotalRemainTime(param1);
            return;
        }// end function

        public function updateCtnTrainTroop(param1:int) : void
        {
            this.listItem[this.curBarrackId].updateCtnTrainTroop(param1);
            return;
        }// end function

        public function updateStartTime(param1:Number, param2:int) : void
        {
            var _loc_3:* = this.barrackList[param2];
            var _loc_4:* = _loc_3.getCurrentTypeTraining();
            var _loc_5:* = JsonMgr.getInstance().getTroopBase();
            var _loc_6:int = 0;
            if (_loc_4 != "")
            {
                _loc_6 = _loc_5[_loc_4]["trainingTime"];
            }
            if (param1 < _loc_3.startTime + _loc_6)
            {
                _loc_3.startTime = param1;
            }
            else if (_loc_4 != "")
            {
                if (_loc_3.canFinish())
                {
                    _loc_3.finishTraining(param1);
                    if (isShowing && this.curBarrackId == param2)
                    {
                        this.listItem[param2].finishTrain(_loc_4);
                    }
                }
                else
                {
                    _loc_3.isStopped = true;
                    this.showStop();
                }
            }
            else
            {
                _loc_3.startTime = param1;
            }
            return;
        }// end function

        public function onGetTrainTroopMsg(param1:Number, param2:int) : void
        {
            var _loc_3:* = this.getBarrackId(param2);
            if (this.listItem[_loc_3].needConfirm)
            {
                this.listItem[_loc_3].onGetTrainTroopMsg(param1);
            }
            return;
        }// end function

        public function updateBarrackName() : void
        {
            var _loc_4:int = 0;
            var _loc_1:* = this.barrackList[this.curBarrackId].getTotalTroopTraining();
            var _loc_2:* = this.barrackList[this.curBarrackId].getMaxCapacity();
            var _loc_3:* = Localization.getInstance().getString(BuildingType.BARRACK) + " " + (this.curBarrackId + 1) + " (" + _loc_1 + "/" + _loc_2 + ")";
            this.labelBarrackName.text = _loc_3.toUpperCase();
            if (TutorialMgr.getInstance().isTutorial)
            {
                _loc_4 = GameDataMgr.getInstance().getCurrentHousingSpace();
                _loc_4 = _loc_4 + this.barrackList[this.curBarrackId].getTotalTroopTraining();
                TutorialMgr.getInstance().updateGuideText(_loc_4);
                if (TutorialMgr.getInstance().curStep == 51 && _loc_4 == 20)
                {
                    TutorialMgr.getInstance().nextStep();
                }
            }
            return;
        }// end function

        public function onGetCancelTrainTroopMsg(param1:CancelTroopTrainMsg) : void
        {
            this.listItem[this.curBarrackId].onGetCancelTrainTroopMsg(param1);
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
                    this.listItem[this.curBarrackId].finishTrain(_loc_4);
                }
                if (isShowing)
                {
                    this.listItem[this.curBarrackId].updateQuickFinishButtonState();
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

        private function getBarrackId(param1:int) : int
        {
            this.barrackList = GameDataMgr.getInstance().barrackList;
            var _loc_2:int = 0;
            while (_loc_2 < this.barrackList.length)
            {
                
                if (this.barrackList[_loc_2].autoId == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

    }
}
