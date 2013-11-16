package modules.city.graphics.clan
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import gameData.clan.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiListClan extends BaseGui
    {
        public var mouseDownTroopType:String = "";
        public var mouseDownType:String = "";
        public var mouseDownDelay:Number = 0;
        public var labelJoin:TextField;
        private var scrollView:ScrollBar;
        public var imageScrollBg:MovieClip;
        public var bmpDownArrow:BitmapButton;
        public var bmpUpArrow:BitmapButton;
        public var bmpSlider:BitmapButton;
        private var listItem:Vector.<GuiClanItem>;
        public var currentItem:int;
        public static const MOUSE_DOWN_DELAY_TO_START:int = 50;
        private static const MOUSE_DOWN_DELAY:int = 20;
        public static const MOUSE_DOWN:String = "mouseDown";
        public static const MOUSE_UP:String = "mouseUp";

        public function GuiListClan()
        {
            this.listItem = new Vector.<GuiClanItem>;
            super(ResMgr.getInstance().getMovieClip("ListClanGui"));
            this.init();
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:* = new Rectangle(45, 100, 595, 345);
            this.scrollView = new ScrollBar(this.imageScrollBg, this.bmpSlider.img, this.bmpDownArrow.img, this.bmpUpArrow.img, _loc_1);
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

        private function compare(param1:ClanInfo, param2:ClanInfo) : int
        {
            if (param1.memberSize > param2.memberSize)
            {
                return -1;
            }
            if (param1.memberSize < param2.memberSize)
            {
                return 1;
            }
            if (param1.memberSize > param2.memberSize)
            {
                return -1;
            }
            if (param1.memberSize < param2.memberSize)
            {
                return 1;
            }
            return 0;
        }// end function

        public function loadClans(param1:Vector.<ClanInfo>) : void
        {
            var _loc_4:GuiClanItem = null;
            this.removeAllItem();
            this.bmpSlider.img.height = 315;
            var _loc_2:* = new Sprite();
            this.img.addChild(_loc_2);
            param1.sort(this.compare);
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
            this.scrollView.setData(_loc_2, 45, 100, 315, this.bmpUpArrow.img.y + this.bmpUpArrow.img.height);
            return;
        }// end function

        public function onItemClick(param1:int) : void
        {
            this.currentItem = param1;
            CityMgr.getInstance().showDetailClan(this.listItem[param1].info.clanId);
            return;
        }// end function

        override public function onMouseDown(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case "bmpUpArrow":
                {
                    this.mouseDownType = MOUSE_UP;
                    this.mouseDownDelay = Utility.getCurTime() * 1000 + MOUSE_DOWN_DELAY_TO_START;
                    break;
                }
                case "bmpDownArrow":
                {
                    this.mouseDownType = MOUSE_DOWN;
                    this.mouseDownDelay = Utility.getCurTime() * 1000 + MOUSE_DOWN_DELAY_TO_START;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function loop() : void
        {
            if (GameInput.getInstance().isMouseDown)
            {
                if (this.mouseDownType != "" && Utility.getCurTime() * 1000 > this.mouseDownDelay + MOUSE_DOWN_DELAY)
                {
                    if (this.mouseDownType == MOUSE_DOWN)
                    {
                        this.scrollView.onDownDown(null);
                    }
                    else if (this.mouseDownType == MOUSE_UP)
                    {
                        this.scrollView.onDownUp(null);
                    }
                    this.mouseDownDelay = Utility.getCurTime() * 1000;
                }
            }
            else
            {
                this.mouseDownType = "";
            }
            return;
        }// end function

    }
}
