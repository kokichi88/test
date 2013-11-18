package modules.city.graphics.troop
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
	import modules.battle.data.Troop;
    import resMgr.*;

    public class GuiTroopInside extends BaseGui
    {
        public var bmpNext:BitmapButton;
        public var bmpPrev:BitmapButton;
        public var labelTitleInside:TextField;
        private var pageItem:PageMgr;
        public var listItem:Vector.<GuiTroopItem>;
        private static const BMP_PREVIOUS:String = "bmpPrev";
        private static const BMP_NEXT:String = "bmpNext";
        private static var pading:Number = 3.1;
        private static var itemPerPage:int = 5;

        public function GuiTroopInside()
        {
            this.listItem = new Vector.<GuiTroopItem>;
            super(ResMgr.getInstance().getMovieClip("TroopInsideGui"));
            this.pageItem = new PageMgr(img);
            this.pageItem.x = 34;
            this.pageItem.y = 29;
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
            this.listItem = new Vector.<GuiTroopItem>;
            return;
        }// end function

        public function loadTroopInside(param1:Vector.<Troop>) : void
        {
            var _loc_6:GuiTroopItem = null;
            this.labelTitleInside.text = "Quân đội:";
            this.removeAllItem();
            var _loc_2:* = new Sprite();
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_6 = new GuiTroopItem();
                _loc_6.setTroop(param1[_loc_3]);
                _loc_2.addChild(_loc_6.bgImg);
                _loc_6.setPos(_loc_3 * (_loc_6.widthBg + pading), 0);
                this.listItem.push(_loc_6);
                _loc_3++;
            }
            var _loc_4:int = 325;
            var _loc_5:int = 63;
            this.pageItem.setData(_loc_2, _loc_4, 63, 0, PageMgr.HOZIRONTOL, true, 1);
            var _loc_7:* = this.pageItem.totalPage > 1;
            this.bmpPrev.visible = this.pageItem.totalPage > 1;
            this.bmpNext.visible = _loc_7;
            this.bmpNext.enable = this.pageItem.canNext();
            this.bmpPrev.enable = this.pageItem.canPrev();
            return;
        }// end function

        public function loadSpellInside(param1:Vector.<Troop>) : void
        {
            var _loc_6:GuiTroopItem = null;
            this.removeAllItem();
            var _loc_2:* = new Sprite();
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_6 = new GuiTroopItem();
                _loc_6.setTroop(param1[_loc_3]);
                _loc_2.addChild(_loc_6.bgImg);
                _loc_6.setPos(_loc_3 * (_loc_6.widthBg + pading), 0);
                this.listItem.push(_loc_6);
                _loc_3++;
            }
            var _loc_4:int = 325;
            var _loc_5:int = 63;
            this.pageItem.setData(_loc_2, _loc_4, 63, 0, PageMgr.HOZIRONTOL, true, 1);
            var _loc_7:* = this.pageItem.totalPage > 1;
            this.bmpPrev.visible = this.pageItem.totalPage > 1;
            this.bmpNext.visible = _loc_7;
            this.bmpNext.enable = this.pageItem.canNext();
            this.bmpPrev.enable = this.pageItem.canPrev();
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
