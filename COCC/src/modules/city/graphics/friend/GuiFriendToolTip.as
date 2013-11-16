package modules.city.graphics.friend
{
    import component.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import resMgr.*;

    public class GuiFriendToolTip extends BaseGui
    {
        public var labelName:TextField;
        public var uId:int;
        private static const BMP_VISIT:String = "bmpVisit";
        private static const BMP_CHAT:String = "bmpChat";

        public function GuiFriendToolTip()
        {
            super(ResMgr.getInstance().getMovieClip("FriendToolTipGui"));
            return;
        }// end function

        public function setInfo(param1:FriendInfo) : void
        {
            this.labelName.text = param1.uName;
            this.uId = param1.uId;
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_VISIT:
                {
                    CityMgr.getInstance().setState(GlobalVar.STATE_FRIEND);
                    CityMgr.getInstance().showTransitionEff(CityMgr.getInstance().sendVisitFriend, this.uId);
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
