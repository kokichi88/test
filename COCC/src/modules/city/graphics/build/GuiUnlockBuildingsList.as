package modules.city.graphics.build
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import gameData.*;
    import resMgr.*;

    public class GuiUnlockBuildingsList extends BaseGui
    {
        public var bmpNext:BitmapButton;
        public var bmpPrev:BitmapButton;
        private var pageItem:PageMgr;
        private var listItem:Vector.<GuiUpgradeBuildingUnlockItem>;
        private static const BMP_PREVIOUS:String = "bmpPrev";
        private static const BMP_NEXT:String = "bmpNext";
        private static var pading:int = 8;

        public function GuiUnlockBuildingsList()
        {
            this.listItem = new Vector.<GuiUpgradeBuildingUnlockItem>;
            super(ResMgr.getInstance().getMovieClip("UnlockListGui"));
            this.pageItem = new PageMgr(img);
            this.pageItem.x = 36;
            this.pageItem.y = 0;
            return;
        }// end function

        private function removeAllItem() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                this.listItem[_loc_1].destroyBaseGUI();
                this.listItem[_loc_1] = null;
                _loc_1++;
            }
            this.listItem.splice(0, this.listItem.length);
            this.listItem = new Vector.<GuiUpgradeBuildingUnlockItem>;
            return;
        }// end function

        public function loadUnlockBuildingItems(param1:int) : void
        {
            var _loc_4:String = null;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:GuiUpgradeBuildingUnlockItem = null;
            this.removeAllItem();
            this.bmpNext.visible = true;
            this.bmpPrev.visible = true;
            var _loc_2:* = JsonMgr.getInstance().townHall[BuildingType.TOWN_HALL][(param1 - 1)];
            var _loc_3:* = JsonMgr.getInstance().townHall[BuildingType.TOWN_HALL][param1];
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:* = new Vector.<String>;
            var _loc_8:* = new Sprite();
            var _loc_9:* = JsonMgr.getInstance().buildCap;
            for (_loc_4 in _loc_2)
            {
                
                if (_loc_16[_loc_15] == _loc_4.toUpperCase())
                {
                    _loc_12 = _loc_2[_loc_4];
                    _loc_13 = _loc_3[_loc_4];
                    if (_loc_13 > _loc_12)
                    {
                        if (_loc_9[_loc_4])
                        {
                            _loc_14 = new GuiUpgradeBuildingUnlockItem();
                            _loc_14.loadUnlockBuildingItem(_loc_4, _loc_13 - _loc_12);
                            _loc_8.addChild(_loc_14.bgImg);
                            _loc_14.setPos(_loc_6 * (_loc_14.widthBg + pading), -4);
                            this.listItem.push(_loc_14);
                            _loc_6++;
                        }
                    }
                }
            }
            _loc_10 = (61 + pading) * 5;
            _loc_11 = 73;
            this.pageItem.setData(_loc_8, _loc_10, 73, 0, PageMgr.HOZIRONTOL, true, 1);
            this.bmpNext.enable = this.pageItem.canNext();
            this.bmpPrev.enable = this.pageItem.canPrev();
            return;
        }// end function

        public function loadUnlockWarrior(param1:String) : void
        {
            this.removeAllItem();
            this.bmpNext.visible = false;
            this.bmpPrev.visible = false;
            var _loc_2:* = new GuiUpgradeBuildingUnlockItem();
            _loc_2.loadUnlockWarrior(param1);
            this.img.addChild(_loc_2.bgImg);
            var _loc_3:* = (this.widthBg - _loc_2.widthBg) / 2;
            var _loc_4:* = (this.heightBg - _loc_2.heightBg) / 2;
            _loc_2.setPos(_loc_3, _loc_4);
            this.listItem.push(_loc_2);
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
                default:
                {
                    break;
                }
            }
            this.bmpNext.enable = this.pageItem.canNext();
            this.bmpPrev.enable = this.pageItem.canPrev();
            return;
        }// end function

    }
}
