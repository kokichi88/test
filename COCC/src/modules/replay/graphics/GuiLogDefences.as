package modules.replay.graphics
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.geom.*;
    import resMgr.*;

    public class GuiLogDefences extends BaseGui
    {
        private var scrollView:ScrollBar;
        public var imageBgBar:MovieClip;
        public var bmpTopArrow:BitmapButton;
        public var bmpBottomArrow:BitmapButton;
        public var bmpSlider:BitmapButton;
        private var listItemLog:Vector.<ItemLogDefences>;

        public function GuiLogDefences()
        {
            super(ResMgr.getInstance().getMovieClip("GuiLogDefences"));
            return;
        }// end function

        public function setInfo(param1:Vector.<LogBattleData>, param2:int) : void
        {
            var _loc_8:int = 0;
            var _loc_9:ItemLogDefences = null;
            this.createScrollBar();
            if (this.listItemLog)
            {
                _loc_8 = 0;
                while (_loc_8 < this.listItemLog.length)
                {
                    
                    _loc_9 = this.listItemLog[_loc_8];
                    _loc_9.bgImg.parent.removeChild(_loc_9.bgImg);
                    _loc_9.destroyBaseGUI();
                    _loc_9 = null;
                    _loc_8++;
                }
            }
            this.listItemLog = new Vector.<ItemLogDefences>;
            var _loc_3:Number = 0;
            var _loc_4:Number = 5;
            var _loc_5:Number = 120;
            var _loc_6:* = new Sprite();
            this.img.addChild(_loc_6);
            var _loc_7:int = 0;
            _loc_8 = 0;
            while (_loc_8 < param1.length)
            {
                
                if (param1[_loc_8].listTroop.length == 0)
                {
                }
                else
                {
                    _loc_9 = new ItemLogDefences();
                    _loc_9.bgImg.x = _loc_3;
                    _loc_9.bgImg.y = _loc_4 + _loc_5 * _loc_7;
                    _loc_7++;
                    _loc_6.addChild(_loc_9.bgImg);
                    this.listItemLog.push(_loc_9);
                    _loc_9.setInfo(param1[_loc_8], param2);
                }
                _loc_8++;
            }
            this.scrollView.setData(_loc_6, 0, 0, 311, this.bmpTopArrow.img.y + this.bmpTopArrow.img.height);
            return;
        }// end function

        public function addEvent() : void
        {
            if (this.scrollView)
            {
                this.scrollView.clean();
                this.scrollView.addEvent();
            }
            return;
        }// end function

        public function cleanEvent() : void
        {
            if (this.scrollView)
            {
                this.scrollView.clean();
            }
            return;
        }// end function

        private function createScrollBar() : void
        {
            var _loc_1:* = new Rectangle(0, 0, 614, 350);
            this.bmpSlider.img.height = 250;
            this.scrollView = new ScrollBar(this.imageBgBar, this.bmpSlider.img, this.bmpBottomArrow.img, this.bmpTopArrow.img, _loc_1);
            return;
        }// end function

    }
}
