package modules.city.graphics.sideQuest
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiSideQuestBoard extends BaseGui
    {
        public var labelBoardName:TextField;
        public var labelPhanThuong:TextField;
        public var labelQuestName:TextField;
        public var labelQuestDetail:TextField;
        public var labelReward:TextField;
        public var labelStatus:TextField;
        public var labelReceive:TextField;
        public var bmpReceiveReward:BitmapButton;
        public var bmpClose:BitmapButton;
        public var iconReward:Sprite = null;
        public var curQuestType:String = "";
        private var curQuestId:int = 0;
        private static var BMP_CLOSE:String = "bmpClose";
        private static var BMP_RECEIVE:String = "bmpReceiveReward";

        public function GuiSideQuestBoard()
        {
            super(ResMgr.getInstance().getMovieClip("GuiSideQuestBoard"));
            this.labelPhanThuong.htmlText = "<u>Phần thưởng:</u>";
            return;
        }// end function

        private function hideComponents() : void
        {
            this.bmpReceiveReward.visible = false;
            this.labelReceive.visible = false;
            return;
        }// end function

        public function getQuestStatus(param1:String) : void
        {
            this.labelBoardName.text = Localization.getInstance().getString(param1 + "_NAME");
            this.hideComponents();
            var _loc_2:* = SideQuestMgr.getInstance().questList[param1];
            this.curQuestId = _loc_2.id;
            this.curQuestType = _loc_2.questType;
            this.labelQuestName.text = _loc_2.questName;
            this.labelStatus.visible = true;
            _loc_2.currentAmount = Math.min(_loc_2.currentAmount, _loc_2.requiredAmount);
            this.labelStatus.text = _loc_2.currentAmount + "/" + _loc_2.requiredAmount;
            if (_loc_2.currentAmount >= _loc_2.requiredAmount)
            {
                this.labelReceive.visible = true;
                this.bmpReceiveReward.visible = true;
            }
            if (this.iconReward && this.iconReward.parent != null)
            {
                this.iconReward.parent.removeChild(this.iconReward);
                this.iconReward = null;
            }
            var _loc_3:* = _loc_2.coin > 0 ? ("Coin") : ("Exp");
            var _loc_4:* = _loc_2.coin > 0 ? (Utility.standardNumber(_loc_2.coin)) : (Utility.standardNumber(_loc_2.exp));
            this.labelReward.htmlText = "<font color=\'" + GlobalVar.MONEY_COLOR[_loc_3] + "\'>" + _loc_4 + "x" + "</font>";
            this.iconReward = ResMgr.getInstance().getMovieClip("image_" + _loc_3) as Sprite;
            this.img.addChild(this.iconReward);
            this.iconReward.x = this.labelReward.x + this.labelReward.width / 2 + this.labelReward.textWidth / 2 + 5;
            this.iconReward.y = this.labelReward.y + (this.labelReward.height - this.iconReward.height) / 2 + 2;
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_CLOSE:
                {
                    this.bgImg.visible = false;
                    SideQuestMgr.getInstance().curQuest = null;
                    break;
                }
                case BMP_RECEIVE:
                {
                    this.bgImg.visible = false;
                    CityMgr.getInstance().sendClaimRewardCmd(this.curQuestType, this.curQuestId);
                    break;
                }
                default:
                {
                    break;
                }
            }
            CityMgr.getInstance().guiSideQuest.refreshButtons();
            return;
        }// end function

    }
}
