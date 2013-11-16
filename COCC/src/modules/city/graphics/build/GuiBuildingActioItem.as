package modules.city.graphics.build
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import gameData.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiBuildingActioItem extends Sprite
    {
        public var labelActionName:TooltipText;
        public var bmpActionItem:BitmapButton;
        public var typeAction:String;
        private var money:MoneyType;
        private static const BMP_ACTION:String = "bmpActionItem";
        public static const SEPARATE:String = "_";

        public function GuiBuildingActioItem()
        {
            this.money = new MoneyType();
            return;
        }// end function

        public function loadAction(param1:String, param2:MoneyType = null) : void
        {
            this.typeAction = param1;
            this.money = param2;
            this.bmpActionItem = new BitmapButton(ResMgr.getInstance().getMovieClip(param1 + "_Icon"), 1);
            this.bmpActionItem.img.addEventListener(MouseEvent.CLICK, this.onActionClick);
            this.addChild(this.bmpActionItem.img);
            if (param1 == BuildingActionType.REQUEST_TROOP)
            {
                this.bmpActionItem.enable = !GameDataMgr.getInstance().clanCastle.isFull;
            }
            return;
        }// end function

        public function addActionText() : void
        {
            var _loc_1:Sprite = null;
            var _loc_2:int = 0;
            var _loc_3:String = null;
            var _loc_4:TooltipText = null;
            var _loc_5:Sprite = null;
            this.labelActionName = new TooltipText(true, true, true);
            this.labelActionName.htmlText = "<font size=\'12\'> " + Localization.getInstance().getString(this.typeAction + "_Action").toUpperCase() + "</font>";
            this.labelActionName.x = 0;
            this.labelActionName.y = 0;
            this.labelActionName.x = this.bmpActionItem.width / 2 - this.labelActionName.textWidth / 2 - 3;
            this.labelActionName.y = this.bmpActionItem.height - this.labelActionName.textHeight / 3;
            addChild(this.labelActionName);
            if (this.money)
            {
                _loc_1 = new Sprite();
                addChild(_loc_1);
                _loc_2 = GameDataMgr.getInstance().getMoney(this.money.type);
                _loc_3 = _loc_2 >= this.money.value ? ("#FFFFFF") : ("#FF4040");
                _loc_4 = new TooltipText(true, true, true);
                _loc_4.htmlText = "<font size=\'11\' color=\'" + _loc_3 + "\'> " + Utility.standardNumber(this.money.value) + " </font>";
                _loc_1.addChild(_loc_4);
                _loc_4.x = 0;
                _loc_4.y = 0;
                _loc_5 = ResMgr.getInstance().getMovieClip(this.money.type + "_Smaller_Icon");
                _loc_5.x = _loc_4.x + _loc_4.textWidth + 3;
                _loc_5.y = _loc_4.y + (_loc_4.height - _loc_5.height) / 2;
                _loc_5.mouseChildren = false;
                _loc_5.mouseEnabled = false;
                _loc_1.addChild(_loc_5);
                _loc_1.x = (this.bmpActionItem.width - _loc_1.width) / 2;
                _loc_1.y = -_loc_1.height;
            }
            return;
        }// end function

        private function onActionClick(event:MouseEvent) : void
        {
            if (this.bmpActionItem.enable)
            {
                CityMgr.getInstance().guiBuildingAction.onItemClick(this.typeAction);
            }
            return;
        }// end function

        public function disableItem() : void
        {
            this.bmpActionItem.enable = false;
            return;
        }// end function

    }
}
