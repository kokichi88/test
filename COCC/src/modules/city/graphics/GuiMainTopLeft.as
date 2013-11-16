package modules.city.graphics
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

    public class GuiMainTopLeft extends BaseGui
    {
        public var labelUsername:TextField;
        public var labelTrophy:TextField;
        public var labelLevel:TextField;
        public var labelExp:TextField;
        public var imageExpBar:MovieClip;
        public var imageExpBg:MovieClip;
        public var imageTrophyBg:MovieClip;
        private var u:UserInfo;
        private var uName:String;
        private var trophy:int = -1;
        private var level:int = -1;
        private var exp:int = -1;
        private var confLevel:Object;

        public function GuiMainTopLeft()
        {
            super(ResMgr.getInstance().getMovieClip("MainGui_Left"));
            autoAlign = AUTO_ALIGN_TOP_LEFT;
            this.imageExpBg.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
            this.imageExpBg.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
            this.imageExpBar.mouseEnabled = false;
            this.imageExpBar.mouseChildren = false;
            this.imageTrophyBg.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
            this.imageTrophyBg.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
            return;
        }// end function

        private function onOut(event:MouseEvent) : void
        {
            ActiveTooltip.getInstance().clearTooltip();
            return;
        }// end function

        private function onOver(event:MouseEvent) : void
        {
            if (event.target == this.imageExpBg)
            {
                if (GlobalVar.state == GlobalVar.STATE_MYHOME)
                {
                    ActiveTooltip.getInstance().showNewTooltip(Utility.getTooltipLevelUser(GameDataMgr.getInstance().myInfo.level, GameDataMgr.getInstance().myInfo.exp), this.imageExpBg);
                }
            }
            else if (event.target == this.imageTrophyBg)
            {
                ActiveTooltip.getInstance().showNewTooltip(Utility.getTooltipString("Điểm danh vọng"), this.imageTrophyBg);
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            ModuleMgr.getInstance().doFunction(CityMgr.HIDE_BUILDING_ACTION_GUI);
            return;
        }// end function

        public function updateData() : void
        {
            this.u = GameDataMgr.getInstance().uInfo;
            this.confLevel = JsonMgr.getInstance().levelUser;
            if (this.uName != this.u.uName)
            {
                this.labelUsername.text = this.u.uName;
                this.uName = this.u.uName;
            }
            if (this.trophy != this.u.trophy)
            {
                this.labelTrophy.text = Utility.standardNumber(this.u.trophy);
                this.trophy = this.u.trophy;
            }
            if (this.level != this.u.level)
            {
                this.labelLevel.text = Utility.standardNumber(this.u.level);
                this.level = this.u.level;
            }
            if (this.exp != this.u.exp)
            {
                this.labelExp.text = Utility.standardNumber(this.u.exp);
                this.exp = this.u.exp;
                if (this.confLevel[(this.level + 1)] != null)
                {
                    this.imageExpBar.scaleX = Math.min(this.exp / this.confLevel[(this.level + 1)], 1);
                }
                else
                {
                    this.imageExpBar.scale = 1;
                }
            }
            return;
        }// end function

    }
}
