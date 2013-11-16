﻿package modules.city.graphics.barrack
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.graphics.tutorial.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class GuiTroopBase extends BaseGui
    {
        public var bmpTroop:BitmapButton;
        public var bmpInfo:BitmapButton;
        public var labelCost:TextField;
        public var labelRequire:TextField;
        public var imageElixir:MovieClip;
        public var imageBgStar:MovieClip;
        public var type:String;
        public var level:int;
        public static const BTN_TROOP:String = "bmpTroop";
        public static const BTN_INFO:String = "bmpInfo";

        public function GuiTroopBase()
        {
            super(ResMgr.getInstance().getMovieClip("ctnTroopBase"));
            this.labelRequire.visible = false;
            this.imageBgStar.visible = false;
            this.imageElixir.mouseEnabled = false;
            this.imageElixir.mouseChildren = false;
            this.imageBgStar.mouseEnabled = false;
            this.imageBgStar.mouseChildren = false;
            return;
        }// end function

        public function loadTroopType(param1:String) : void
        {
            var _loc_4:int = 0;
            this.type = param1;
            var _loc_2:* = ResMgr.getInstance().getMovieClip(this.type + "_Training_Icon");
            _loc_2.x = (this.widthBg - _loc_2.width) / 2;
            _loc_2.y = 6;
            this.bmpTroop.img.addChild(_loc_2);
            this.level = GameDataMgr.getInstance().getTroopLevel(this.type);
            if (this.level > 0)
            {
                this.imageBgStar.visible = true;
                _loc_4 = 0;
                while (_loc_4 < this.level)
                {
                    
                    this.addNewStar(_loc_4);
                    _loc_4++;
                }
            }
            var _loc_3:* = JsonMgr.getInstance().getInfoTroop(this.type, this.level);
            this.labelCost.text = Utility.standardNumber(_loc_3.trainingCost);
            return;
        }// end function

        private function addNewStar(param1:int) : void
        {
            var _loc_2:* = ResMgr.getInstance().getMovieClip("icLevel") as Sprite;
            _loc_2.x = 4.35 + (_loc_2.width + 1.3) * param1;
            _loc_2.y = 1.5;
            this.imageBgStar.addChild(_loc_2);
            return;
        }// end function

        public function updateTroopLevel(param1:String) : void
        {
            this.level = GameDataMgr.getInstance().getTroopLevel(param1);
            if (this.level == 2)
            {
                this.addNewStar(0);
            }
            this.addNewStar((this.level - 1));
            return;
        }// end function

        public function setEnable(param1:Boolean) : void
        {
            this.bmpTroop.enable = param1;
            this.labelCost.filters = param1 ? ([]) : ([BitmapButton.disableFilter]);
            this.imageElixir.enabled = param1;
            this.imageBgStar.enabled = param1;
            return;
        }// end function

        public function setNotAvaiable(param1:int) : void
        {
            var _loc_2:* = param1 == 0;
            this.labelCost.visible = _loc_2;
            this.imageElixir.visible = _loc_2;
            this.labelRequire.visible = !_loc_2;
            this.imageBgStar.visible = _loc_2;
            this.setEnable(_loc_2);
            if (param1 > 0)
            {
                this.labelRequire.text = Localization.getInstance().getString("LaboratoryReason0") + " " + param1;
                if (param1 >= 9)
                {
                    this.labelRequire.text = "Sắp ra mắt";
                    this.bmpInfo.visible = false;
                }
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BTN_TROOP:
                {
                    CityMgr.getInstance().guiTrainTroop.onMouseClick(this.type, null);
                    break;
                }
                case BTN_INFO:
                {
                    if (TutorialMgr.getInstance().isTutorial)
                    {
                        return;
                    }
                    CityMgr.getInstance().showTroopInfoGui(this.type, this.level);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function onMouseDown(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BTN_TROOP:
                {
                    CityMgr.getInstance().guiTrainTroop.mouseDownTroopType = this.type;
                    CityMgr.getInstance().guiTrainTroop.mouseDownType = GuiTrainTroop.MOUSE_DOWN_TYPE_ADD;
                    CityMgr.getInstance().guiTrainTroop.mouseDownDelay = Utility.getCurTime() * 1000 + GuiTrainTroop.MOUSE_DOWN_DELAY_TO_START;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
