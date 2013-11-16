package modules.city.graphics.clan
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;
    import gameData.*;
    import gameData.clan.*;
    import modules.city.*;
    import modules.city.logic.*;
    import resMgr.*;
    import utility.*;

    public class GuiSearchClan extends BaseGui
    {
        private var scrollView:ScrollBar;
        public var imageScrollBg:MovieClip;
        public var bmpDownArrow:BitmapButton;
        public var bmpUpArrow:BitmapButton;
        public var bmpSlider:BitmapButton;
        private var listItem:Vector.<GuiClanItem>;
        public var currentItem:int;
        public var labelClanNameInput:TextField;
        public var labelNoResult:TextField;
        private static const BMP_SEARCH:String = "bmpSearch";

        public function GuiSearchClan()
        {
            this.listItem = new Vector.<GuiClanItem>;
            super(ResMgr.getInstance().getMovieClip("SearchClanGui"));
            this.labelClanNameInput.type = TextFieldType.INPUT;
            this.labelClanNameInput.mouseEnabled = true;
            this.labelClanNameInput.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            this.init();
            this.refresh();
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:* = new Rectangle(45, 160, 595, 285);
            this.scrollView = new ScrollBar(this.imageScrollBg, this.bmpSlider.img, this.bmpDownArrow.img, this.bmpUpArrow.img, _loc_1);
            return;
        }// end function

        public function refresh() : void
        {
            this.loadClans(new Vector.<ClanInfo>);
            this.labelNoResult.visible = true;
            this.labelNoResult.text = "NHẬP TÊN BANG HỘI CẦN TÌM KIẾM";
            this.labelClanNameInput.text = "";
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
            this.listItem = new Vector.<GuiClanItem>;
            return;
        }// end function

        public function loadClans(param1:Vector.<ClanInfo>) : void
        {
            var _loc_4:GuiClanItem = null;
            this.removeAllItem();
            this.bmpSlider.img.height = this.imageScrollBg.height;
            var _loc_2:* = new Sprite();
            this.img.addChild(_loc_2);
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = new GuiClanItem();
                _loc_2.addChild(_loc_4.bgImg);
                _loc_4.setPos(4, _loc_3 * (_loc_4.heightBg - 4));
                _loc_4.setInfo(_loc_3, param1[_loc_3]);
                this.listItem.push(_loc_4);
                _loc_3++;
            }
            this.scrollView.setData(_loc_2, 45, 160, this.imageScrollBg.height, this.bmpUpArrow.img.y + this.bmpUpArrow.img.height);
            this.labelNoResult.visible = param1.length == 0;
            if (param1.length == 0)
            {
                this.labelNoResult.text = "KHÔNG TÌM THẤY BANG HỘI PHÙ HỢP";
            }
            return;
        }// end function

        public function onItemClick(param1:int) : void
        {
            this.currentItem = param1;
            CityMgr.getInstance().showDetailClan(this.listItem[param1].info.clanId);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_SEARCH:
                {
                    this.search();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case Keyboard.ENTER:
                {
                    this.search();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function search() : void
        {
            var _loc_2:String = null;
            var _loc_3:String = null;
            if (GameDataMgr.getInstance().clanCastle.status == MapObject.BROKEN)
            {
                _loc_2 = Localization.getInstance().getString("Title_TB");
                _loc_3 = Localization.getInstance().getString("ClanMsg3");
                CityMgr.getInstance().showMessage(_loc_2, _loc_3, "ĐỒNG Ý", null);
                return;
            }
            if (this.labelClanNameInput.text == "")
            {
                return;
            }
            var _loc_1:* = this.labelClanNameInput.text;
            _loc_1 = _loc_1.replace("\r", "");
            CityMgr.getInstance().sendSearchClan(_loc_1);
            this.labelClanNameInput.text = _loc_1;
            return;
        }// end function

    }
}
