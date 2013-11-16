package modules.city.graphics.friend
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
	import gameData.FriendInfo;
    import modules.city.*;
    import resMgr.*;

    public class GuiFriendsList extends BaseGui
    {
        private var friendPage:GuiFriendPage;
        private static const BMP_CLOSE:String = "bmpClose";

        public function GuiFriendsList()
        {
            super(ResMgr.getInstance().getMovieClip("FriendsListGui"));
            this.friendPage = new GuiFriendPage();
            this.friendPage.setPos(130, 66);
            addGui(this.friendPage);
            autoAlign = AUTO_ALIGN_BOTTOM_CENTER;
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_CLOSE:
                {
                    this.hide();
                    CityMgr.getInstance().guiMainBottom.show();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getFriendsList(param1:Vector.<FriendInfo>) : void
        {
            this.friendPage.initItem(param1);
            return;
        }// end function

        public function showToolTip(param1:int) : void
        {
            this.friendPage.showToolTip(param1);
            return;
        }// end function

        public function hideToolTip() : void
        {
            this.friendPage.hideToolTip();
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            super.show(param1);
            this.friendPage.addEvent();
            return;
        }// end function

        override public function hide(param1:Boolean = true) : void
        {
            if (!isShowing)
            {
                return;
            }
            super.hide(param1);
            return;
        }// end function

    }
}
