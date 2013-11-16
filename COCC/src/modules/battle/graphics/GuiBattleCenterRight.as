package modules.battle.graphics
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiBattleCenterRight extends BaseGui
    {
        public var labelMoney:TextField;
        private var money:int = 1;
        private static const BMP_FIND_BATTLE:String = "bmpFindBattle";

        public function GuiBattleCenterRight()
        {
            super(ResMgr.getInstance().getMovieClip("GuiCenterRightBattle"));
            autoAlign = AUTO_ALIGN_BOTTOM_CENTER;
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            var _loc_3:* = GameDataMgr.getInstance().myInfo.townHallLevel;
            this.money = JsonMgr.getInstance().findPrice[_loc_3]["gold"];
            this.labelMoney.text = Utility.numToStr(this.money);
            super.show(param1, param2);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            switch(param1)
            {
                case BMP_FIND_BATTLE:
                {
                    _loc_3 = GameDataMgr.getInstance().getMoney(MoneyType.GOLD);
                    _loc_4 = this.money - _loc_3;
                    if (_loc_4 > 0)
                    {
                        CityMgr.getInstance().guiBuyResource.showGuiBuyResource(MoneyType.GOLD, _loc_4, CityMgr.getInstance().acceptBuyResource, [MoneyType.GOLD, _loc_4, this.nextFind]);
                        return;
                    }
                    this.nextFind();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function nextFind() : void
        {
            ModuleMgr.getInstance().doFunction(CityMgr.SHOW_TRANSITION_EFF, CityMgr.getInstance().getBattleInfo);
            GameDataMgr.getInstance().addMoney(MoneyType.GOLD, -this.money);
            return;
        }// end function

    }
}
