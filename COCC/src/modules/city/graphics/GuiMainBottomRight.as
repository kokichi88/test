package modules.city.graphics
{
    import com.greensock.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import gameData.*;
    import modules.*;
    import modules.city.*;
    import modules.city.graphics.tutorial.*;
    import resMgr.*;
    import utility.*;

    public class GuiMainBottomRight extends BaseGui
    {
        public var labelTroopNumber:TextField;
        public var bmpShop:BitmapButton;
        public var bmpFriendsList:BitmapButton;
        public var bmpAttack:BitmapButton;
        public var bmpMessage:BitmapButton;
        public var bmpAchievement:BitmapButton;
        public var imageMailNotice:MovieClip;
        public var labelMailNumber:TextField;
        private var arrow:Sprite = null;
        private var startPos:Point;
        private var endPos:Point;
        private static const BMP_ACTTACK:String = "bmpAttack";
        private static const BMP_SHOP:String = "bmpShop";
        private static const BMP_FRIEND_LIST:String = "bmpFriendsList";
        private static const BMP_MESSAGE:String = "bmpMessage";
        private static const BMP_ACHIEVEMENT:String = "bmpAchievement";

        public function GuiMainBottomRight()
        {
            this.startPos = new Point();
            this.endPos = new Point();
            super(ResMgr.getInstance().getMovieClip("MainGui_BottomRight"));
            setPos(GlobalVar.SCREEN_WIDTH - widthBg - 10, GlobalVar.SCREEN_HEIGHT - heightBg - 30);
            this.bmpShop.setTooltipDisplayObj(Utility.getTooltipString(Localization.getInstance().getString("TooltipBmp_2")));
            this.bmpAttack.setTooltipDisplayObj(Utility.getTooltipString(Localization.getInstance().getString("TooltipBmp_3")));
            this.bmpMessage.setTooltipDisplayObj(Utility.getTooltipString(Localization.getInstance().getString("TooltipBmp_4")));
            this.bmpFriendsList.setTooltipDisplayObj(Utility.getTooltipString(Localization.getInstance().getString("TooltipBmp_5")));
            this.bmpAchievement.setTooltipDisplayObj(Utility.getTooltipString(Localization.getInstance().getString("TooltipBmp_6")));
            this.bmpFriendsList.enable = false;
            this.imageMailNotice.visible = false;
            this.imageMailNotice.mouseEnabled = false;
            this.labelMailNumber.text = "";
            this.labelMailNumber.mouseEnabled = false;
            return;
        }// end function

        public function showArrow(param1:int, param2:int) : void
        {
            this.removeArrow();
            this.arrow = ResMgr.getInstance().getMovieClip("Tutorial_Arrow") as Sprite;
            this.arrow.x = param1 - this.arrow.width / 2;
            this.arrow.y = param2 - this.arrow.height;
            this.startPos.x = this.arrow.x;
            this.startPos.y = this.arrow.y;
            this.endPos.x = this.startPos.x;
            this.endPos.y = this.startPos.y - 20;
            this.img.addChild(this.arrow);
            this.startArrow();
            return;
        }// end function

        public function removeArrow() : void
        {
            if (this.arrow && this.arrow.parent != null)
            {
                this.arrow.parent.removeChild(this.arrow);
                this.arrow = null;
            }
            return;
        }// end function

        private function startArrow() : void
        {
            if (this.arrow == null)
            {
                return;
            }
            TweenLite.to(this.arrow, 0.3, {x:this.endPos.x, y:this.endPos.y, onComplete:this.endArrow});
            return;
        }// end function

        private function endArrow() : void
        {
            if (this.arrow == null)
            {
                return;
            }
            TweenLite.to(this.arrow, 0.3, {x:this.startPos.x, y:this.startPos.y, onComplete:this.startArrow});
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:String = null;
            var _loc_6:String = null;
            ModuleMgr.getInstance().doFunction(CityMgr.HIDE_BUILDING_ACTION_GUI);
            switch(param1)
            {
                case BMP_ACTTACK:
                {
                    _loc_3 = GameDataMgr.getInstance().getCurrentHousingSpace();
                    _loc_4 = GameDataMgr.getInstance().clanCastle.troopList.length;
                    if (_loc_3 > 0 || _loc_4 > 0)
                    {
                        CityMgr.getInstance().guiFindMath.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
                        if (TutorialMgr.getInstance().isTutorial)
                        {
                            TutorialMgr.getInstance().nextStep();
                        }
                    }
                    else
                    {
                        _loc_5 = Localization.getInstance().getString("Title_TB");
                        _loc_6 = Localization.getInstance().getString("NeedArmyToAttack");
                        CityMgr.getInstance().showMessage(_loc_5, _loc_6, "LUYỆN QUÂN", CityMgr.getInstance().showGuiTrainTroop, [-1]);
                    }
                    break;
                }
                case BMP_SHOP:
                {
                    CityMgr.getInstance().showShopGui();
                    if (TutorialMgr.getInstance().isTutorial)
                    {
                        TutorialMgr.getInstance().nextStep();
                    }
                    break;
                }
                case BMP_FRIEND_LIST:
                {
                    CityMgr.getInstance().showFriendsListGui();
                    break;
                }
                case BMP_MESSAGE:
                {
                    CityMgr.getInstance().showGuiLog();
                    break;
                }
                case BMP_ACHIEVEMENT:
                {
                    CityMgr.getInstance().showGuiRanking();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function showMailNotice(param1:int) : void
        {
            this.imageMailNotice.visible = true;
            this.labelMailNumber.text = param1.toString();
            return;
        }// end function

        public function hideMailNotice() : void
        {
            this.imageMailNotice.visible = false;
            this.labelMailNumber.text = "";
            return;
        }// end function

    }
}
