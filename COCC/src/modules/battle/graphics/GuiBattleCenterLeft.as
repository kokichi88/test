package modules.battle.graphics
{
    import component.*;
    import flash.display.*;
    import flash.text.*;
    import modules.battle.*;
    import resMgr.*;
    import utility.*;

    public class GuiBattleCenterLeft extends BaseGui
    {
        public var labelGold:TextField;
        public var labelElixir:TextField;
        public var labelTroopyWin:TextField;
        public var labelTroopyLost:TextField;
        public var imageTroopWin:MovieClip;
        public var imageTroopLost:MovieClip;
        public var labelLose:TextField;

        public function GuiBattleCenterLeft()
        {
            super(ResMgr.getInstance().getMovieClip("GuiCenterLeftBattle"));
            autoAlign = AUTO_ALIGN_LEFT_CENTER;
            return;
        }// end function

        public function setInfo() : void
        {
            this.labelGold.text = Utility.numToStr(BattleModule.getInstance().gold);
            this.labelElixir.text = Utility.numToStr(BattleModule.getInstance().elixir);
            this.labelTroopyWin.text = Utility.numToStr(BattleModule.getInstance().trophyReceive);
            if (BattleModule.getInstance().trophyLost > 0)
            {
                this.labelTroopyLost.text = "-" + Utility.numToStr(BattleModule.getInstance().trophyLost);
            }
            else
            {
                this.labelTroopyLost.text = "0";
            }
            if (GlobalVar.state == GlobalVar.STATE_BATTLE)
            {
                var _loc_1:Boolean = true;
                this.labelLose.visible = true;
                var _loc_1:* = _loc_1;
                this.labelTroopyLost.visible = _loc_1;
                var _loc_1:* = _loc_1;
                this.labelTroopyWin.visible = _loc_1;
                var _loc_1:* = _loc_1;
                this.imageTroopLost.visible = _loc_1;
                this.imageTroopWin.visible = _loc_1;
            }
            else if (GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
            {
                var _loc_1:Boolean = false;
                this.labelLose.visible = false;
                var _loc_1:* = _loc_1;
                this.labelTroopyLost.visible = _loc_1;
                var _loc_1:* = _loc_1;
                this.labelTroopyWin.visible = _loc_1;
                var _loc_1:* = _loc_1;
                this.imageTroopLost.visible = _loc_1;
                this.imageTroopWin.visible = _loc_1;
            }
            return;
        }// end function

        override public function loop() : void
        {
            this.labelGold.text = Utility.numToStr(BattleModule.getInstance().gold);
            this.labelElixir.text = Utility.numToStr(BattleModule.getInstance().elixir);
            return;
        }// end function

    }
}
