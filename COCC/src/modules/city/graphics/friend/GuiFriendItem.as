package modules.city.graphics.friend
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import resMgr.*;

    public class GuiFriendItem extends BaseGui
    {
        public var imageNotice:MovieClip;
        public var labelName:TextField;
        public var labelLevel:TextField;
        public var index:int;
        public var friendInfo:FriendInfo;
        public var bmpVisitFriend:BitmapButton;
        private var currentImg:MovieClip;
        private static const BMP_VISIT_FRIEND:String = "bmpVisitFriend";

        public function GuiFriendItem()
        {
            super(ResMgr.getInstance().getMovieClip("FriendItemGui"));
            return;
        }// end function

        public function setFriendInfo(param1:FriendInfo) : void
        {
            this.labelName.text = param1.uName;
            this.labelLevel.text = param1.level.toString();
            this.friendInfo = param1;
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_VISIT_FRIEND:
                {
                    CityMgr.getInstance().showFriendToolTip(this.index);
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
