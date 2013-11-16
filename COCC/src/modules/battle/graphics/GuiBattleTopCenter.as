package modules.battle.graphics
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import modules.battle.*;
    import resMgr.*;
    import utility.*;

    public class GuiBattleTopCenter extends BaseGui
    {
        public var bmpEndBattle:BitmapButton;
        public var labelTime:TextField;
        public var labelStatus:TextField;
        public var status:int;
        public var maxTime:int = 30;
        public var startTime:Number = 0;
        public var time:int;
        public var imageBg:MovieClip;
        private static const BMP_END_BATTLE:String = "bmpEndBattle";
        private static const TIME_WAIT:int = 30;
        private static const TIME_BATTLE:int = 180;

        public function GuiBattleTopCenter()
        {
            super(ResMgr.getInstance().getMovieClip("GuiTopCenterBattle"));
            autoAlign = AUTO_ALIGN_TOP_CENTER;
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_END_BATTLE:
                {
                    if (BattleModule.getInstance().status == 2)
                    {
                        BattleModule.getInstance().showPopupEndGame(BattleModule.REQUEST_END_BATTLE);
                    }
                    else
                    {
                        BattleModule.getInstance().endBattle(BattleModule.REQUEST_END_BATTLE);
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

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            super.show(param1);
            if (GlobalVar.state == GlobalVar.STATE_BATTLE)
            {
                this.maxTime = TIME_WAIT;
                this.startTime = Utility.getCurTime();
                this.status = 0;
                this.labelStatus.text = "Bắt đầu sau";
            }
            else
            {
                this.startTime = 0;
                this.labelStatus.text = "";
                this.labelTime.text = "";
            }
            this.bmpEndBattle.enable = true;
            return;
        }// end function

        override public function loop() : void
        {
            if (this.startTime == 0)
            {
                return;
            }
            this.time = this.maxTime - (Utility.getCurTime() - this.startTime);
            if (this.time <= 0)
            {
                if (this.status == 0)
                {
                    BattleModule.getInstance().startBattle();
                }
                else
                {
                    BattleModule.getInstance().endTime();
                }
            }
            this.time = Math.max(0, this.time);
            this.labelTime.text = Utility.convertTimeToShortString(this.time);
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            this.status = 0;
            this.startTime = 0;
            super.hide();
            return;
        }// end function

        public function startBattle() : void
        {
            this.status = 1;
            this.maxTime = TIME_BATTLE;
            this.startTime = Utility.getCurTime();
            this.labelStatus.text = "Kết thúc sau";
            return;
        }// end function

        public function hideAll() : void
        {
            this.labelStatus.visible = false;
            this.labelTime.visible = false;
            this.imageBg.visible = false;
            return;
        }// end function

        public function showAll() : void
        {
            this.labelStatus.visible = true;
            this.labelTime.visible = true;
            this.imageBg.visible = true;
            return;
        }// end function

    }
}
