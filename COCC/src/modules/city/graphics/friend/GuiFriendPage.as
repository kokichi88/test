package modules.city.graphics.friend
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import resMgr.*;

    public class GuiFriendPage extends BaseGui
    {
        public var bmpPrevFriend:BitmapButton;
        public var bmpNextFriend:BitmapButton;
        private var pageItem:PageMgr;
        private var listItem:Vector.<GuiFriendItem>;
        private var toolTip:GuiFriendToolTip;
        private static const BMP_PREVIOUS:String = "bmpPrevFriend";
        private static const BMP_NEXT:String = "bmpNextFriend";
        private static const BMP_FISRT_PAGE:String = "bmpFirstFriendPage";
        private static const BMP_LAST_PAGE:String = "bmpLastFriendPage";
        private static var pageSize:int = 5;

        public function GuiFriendPage()
        {
            this.listItem = new Vector.<GuiFriendItem>;
            super(ResMgr.getInstance().getMovieClip("FriendPageGui"));
            this.pageItem = new PageMgr(img);
            this.pageItem.x = 23;
            this.pageItem.y = -26;
            this.toolTip = new GuiFriendToolTip();
            this.toolTip.bgImg.visible = false;
            addGui(this.toolTip);
            return;
        }// end function

        public function initItem(param1:Vector.<FriendInfo>) : void
        {
            var _loc_7:GuiFriendItem = null;
            var _loc_2:Number = 1.5;
            var _loc_3:* = (69 + _loc_2) * pageSize;
            var _loc_4:Number = 95.5;
            var _loc_5:* = new Sprite();
            var _loc_6:int = 0;
            while (_loc_6 < param1.length)
            {
                
                _loc_7 = new GuiFriendItem();
                _loc_5.addChild(_loc_7.bgImg);
                _loc_7.setPos(_loc_6 * (_loc_7.widthBg + _loc_2), -4);
                _loc_7.index = _loc_6;
                _loc_7.setFriendInfo(param1[_loc_6]);
                this.listItem.push(_loc_7);
                _loc_6++;
            }
            this.pageItem.setData(_loc_5, _loc_3, _loc_4, _loc_2, PageMgr.HOZIRONTOL, true, 1);
            this.bmpPrevFriend.enable = false;
            return;
        }// end function

        public function showToolTip(param1:int) : void
        {
            var _loc_2:* = this.listItem[param1 % pageSize].getPos();
            var _loc_3:* = this.pageItem.x + _loc_2.x + (this.listItem[param1 % pageSize].widthBg - this.toolTip.widthBg) / 2;
            var _loc_4:* = _loc_2.y - this.toolTip.heightBg;
            this.toolTip.setInfo(this.listItem[param1].friendInfo);
            this.toolTip.setPos(_loc_3, _loc_4);
            this.toolTip.bgImg.visible = true;
            return;
        }// end function

        public function hideToolTip() : void
        {
            this.toolTip.bgImg.visible = false;
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_NEXT:
                {
                    this.pageItem.nextPage();
                    break;
                }
                case BMP_PREVIOUS:
                {
                    this.pageItem.prevPage();
                    break;
                }
                case BMP_FISRT_PAGE:
                {
                    this.pageItem.firstPage();
                    break;
                }
                case BMP_LAST_PAGE:
                {
                    this.pageItem.lastPage();
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.bmpNextFriend.enable = this.pageItem.canNext();
            this.bmpPrevFriend.enable = this.pageItem.canPrev();
            return;
        }// end function

        public function addEvent() : void
        {
            img.stage.addEventListener(MouseEvent.CLICK, this.onClickStage);
            return;
        }// end function

        private function onClickStage(event:MouseEvent) : void
        {
            var _loc_3:GuiFriendItem = null;
            var _loc_2:int = 0;
            while (_loc_2 < this.listItem.length)
            {
                
                _loc_3 = this.listItem[_loc_2];
                if (event.target == _loc_3.bmpVisitFriend.img)
                {
                    return;
                }
                _loc_2++;
            }
            this.hideToolTip();
            return;
        }// end function

    }
}
