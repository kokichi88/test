package modules.city.graphics.findmatch
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.graphics.tutorial.*;
    import resMgr.*;
    import utility.*;

    public class GuiFindMatch extends BaseGui
    {
        public var labelSinglePlayer:TextField;
        public var labelMultiPlayer:TextField;
        public var bmpSingleMap:BitmapButton;
        public var bmpBattleMap:BitmapButton;
        public var guiSingleMap:GuiSingleMap;
        public var imageMultiPlayer:MovieClip;
        public var imageSinglePlayer:MovieClip;
        public var imageGold:MovieClip;
        public var labelCost:TextField;
        private static var BMP_CLOSE:String = "bmpClose";
        private static var BMP_SINGLE_PLAYER:String = "bmpSingleMap";
        private static var BMP_MULTIPLAYER:String = "bmpBattleMap";

        public function GuiFindMatch()
        {
            super(ResMgr.getInstance().getMovieClip("FindMatchGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.labelSinglePlayer.mouseEnabled = false;
            this.labelMultiPlayer.mouseEnabled = false;
            this.guiSingleMap = new GuiSingleMap();
            this.guiSingleMap.initSingleMap();
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            var _loc_3:* = GameDataMgr.getInstance().myInfo.townHallLevel;
            var _loc_4:* = JsonMgr.getInstance().findPrice[_loc_3]["gold"];
            this.labelCost.text = Utility.standardNumber(_loc_4);
            this.labelCost.x = this.bmpBattleMap.img.x + (this.bmpBattleMap.width - this.labelCost.width - 5 - this.imageGold.width) / 2;
            this.imageGold.x = this.labelCost.x + this.labelCost.width / 2 + this.labelCost.textWidth / 2 + 5;
            super.show(param1, param2);
            return;
        }// end function

        private function onMouseOutImage(event:MouseEvent) : void
        {
            var _loc_2:Number = 1;
            TweenMax.to(this.imageSinglePlayer, 0.3, {scaleX:_loc_2, scaleY:_loc_2, alpha:1, delay:0.1, ease:Back.easeOut});
            return;
        }// end function

        private function onMouseOverImage(event:MouseEvent) : void
        {
            var _loc_2:Number = 1.05;
            TweenMax.to(this.imageSinglePlayer, 0.3, {scaleX:_loc_2, scaleY:_loc_2, alpha:1, delay:0.1, ease:Back.easeOut});
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_CLOSE:
                {
                    hide(true);
                    break;
                }
                case BMP_SINGLE_PLAYER:
                {
                    if (TutorialMgr.getInstance().isTutorial)
                    {
                        TutorialMgr.getInstance().nextStep();
                    }
                    this.guiSingleMap.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
                    hide();
                    break;
                }
                case BMP_MULTIPLAYER:
                {
                    this.prepareToFindMatch();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function loadSingleMap() : void
        {
            this.guiSingleMap.loadSingleMap();
            return;
        }// end function

        private function prepareToFindMatch() : void
        {
            var _loc_1:String = null;
            var _loc_2:String = null;
            if (Utility.getCurTime() < GameDataMgr.getInstance().myInfo.shieldTime)
            {
                _loc_1 = Localization.getInstance().getString("NoticeShieldTitle");
                _loc_2 = Localization.getInstance().getString("NoticeShieldMessage");
                CityMgr.getInstance().showMessage(_loc_1, _loc_2, "TIẾP TỤC", this.findMatch);
                return;
            }
            this.findMatch();
            return;
        }// end function

        private function findMatch() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().townHall.level;
            var _loc_2:* = GameDataMgr.getInstance().getMoney(MoneyType.GOLD);
            var _loc_3:* = JsonMgr.getInstance().findPrice[_loc_1]["gold"];
            var _loc_4:* = _loc_3 - _loc_2;
            if (_loc_3 - _loc_2 > 0)
            {
                CityMgr.getInstance().guiBuyResource.showGuiBuyResource(MoneyType.GOLD, _loc_4, CityMgr.getInstance().acceptBuyResource, [MoneyType.GOLD, _loc_4, this.findMatch]);
                return;
            }
            CityMgr.getInstance().setState(GlobalVar.STATE_BATTLE);
            CityMgr.getInstance().showTransitionEff(CityMgr.getInstance().getBattleInfo);
            GameDataMgr.getInstance().addMoney(MoneyType.GOLD, -_loc_3);
            return;
        }// end function

    }
}
