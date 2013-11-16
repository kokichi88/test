package modules.city.graphics.troop
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import resMgr.*;

    public class GuiTroopTotal extends BaseGui
    {
        public var bmpNext:BitmapButton;
        public var bmpPrev:BitmapButton;
        public var labelTotal:TextField;
        private var pageItem:PageMgr;
        private var listItem:Vector.<TroopTotalItem>;
        private static const BMP_PREVIOUS:String = "bmpPrev";
        private static const BMP_NEXT:String = "bmpNext";
        private static var pading:int = 4;
        private static var itemPerPage:int = 6;

        public function GuiTroopTotal()
        {
            this.listItem = new Vector.<TroopTotalItem>;
            super(ResMgr.getInstance().getMovieClip("TroopTotalGui"));
            setPos((GlobalVar.SCREEN_WIDTH - this.widthBg) / 2, GlobalVar.SCREEN_HEIGHT - this.heightBg);
            this.pageItem = new PageMgr(img);
            this.pageItem.x = 58;
            this.pageItem.y = 41;
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
            this.listItem = new Vector.<TroopTotalItem>;
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            this.updateTroop();
            super.show(param1, true);
            return;
        }// end function

        public function loadTroopInside(param1:Vector.<Troop>) : void
        {
            var _loc_6:TroopTotalItem = null;
            this.removeAllItem();
            var _loc_2:* = new Sprite();
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_6 = new TroopTotalItem();
                _loc_6.setTroop(param1[_loc_3]);
                _loc_2.addChild(_loc_6.bgImg);
                _loc_6.setPos(_loc_3 * (_loc_6.widthBg + pading), 0);
                this.listItem.push(_loc_6);
                _loc_3++;
            }
            var _loc_4:* = (75 + pading) * itemPerPage;
            var _loc_5:int = 90;
            this.pageItem.setData(_loc_2, _loc_4, 90, 0, PageMgr.HOZIRONTOL, true, 1);
            this.bmpNext.enable = this.pageItem.canNext();
            this.bmpPrev.enable = this.pageItem.canPrev();
            return;
        }// end function

        public function updateTroop() : void
        {
            this.loadTroopInside(GameDataMgr.getInstance().troopList);
            var _loc_1:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            var _loc_2:* = GameDataMgr.getInstance().getTotalTroopCapacity();
            this.labelTotal.text = _loc_1 + "/" + _loc_2;
            CityMgr.getInstance().guiMainTop.updateTotalTroop();
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
