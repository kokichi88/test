package modules.city.graphics.clan
{
    import component.*;
    import flash.events.*;
    import flash.text.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class ClanMemberToolTipAction extends BaseGui
    {
        public var labelAction:TextField;
        public var actionId:int;

        public function ClanMemberToolTipAction()
        {
            super(ResMgr.getInstance().getMovieClip("ClanMemberToolTipItem"));
            return;
        }// end function

        public function setAction(param1:int) : void
        {
            this.actionId = param1;
            this.labelAction.autoSize = TextFieldAutoSize.CENTER;
            this.labelAction.height = this.labelAction.height + 20;
            this.labelAction.text = Localization.getInstance().getString("ClanAction" + param1).toUpperCase();
            this.labelAction.y = (this.heightBg - this.labelAction.height) / 2 - 2;
            if (this.labelAction.numLines == 1)
            {
                this.labelAction.y = this.labelAction.y - 3;
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            CityMgr.getInstance().guiToolTip.onItemClick(this.actionId);
            return;
        }// end function

    }
}
