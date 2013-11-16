package modules.replay.graphics
{
    import __AS3__.vec.*;
    import component.*;
    import flash.events.*;
    import flash.text.*;
	import modules.replay.data.LogBattleData;
    import resMgr.*;
    import utility.*;

    public class GuiBeenAttacked extends BaseGui
    {
        public var labelTrophy:TextField;
        public var labelTitle:TextField;
        private var listItem:Vector.<BeenAttackedItem>;

        public function GuiBeenAttacked()
        {
            this.listItem = new Vector.<BeenAttackedItem>;
            super(ResMgr.getInstance().getMovieClip("BeenAttackedGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            this.labelTitle.text = Localization.getInstance().getString("WarningTitle1");
            return;
        }// end function

        private function removeAllItem() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                this.listItem[_loc_1] = null;
                _loc_1++;
            }
            this.listItem.splice(0, this.listItem.length);
            this.listItem = new Vector.<BeenAttackedItem>;
            return;
        }// end function

        public function loadInfo(param1:Vector.<LogBattleData>) : void
        {
            var _loc_7:BeenAttackedItem = null;
            var _loc_2:Number = 136;
            var _loc_3:Number = 118;
            var _loc_4:Number = 5.05;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            while (_loc_6 < param1.length)
            {
                
                if (_loc_6 >= 4)
                {
                    break;
                }
                _loc_7 = new BeenAttackedItem();
                _loc_7.setInfo(param1[_loc_6].level, param1[_loc_6].uName, param1[_loc_6].endTime);
                _loc_7.setPos(_loc_2, _loc_3 + (_loc_7.heightBg + _loc_4) * _loc_6);
                addGui(_loc_7);
                this.listItem.push(_loc_7);
                _loc_5 = _loc_5 + param1[_loc_6].retTrophy;
                _loc_6++;
            }
            this.labelTrophy.text = _loc_5.toString();
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            hide(true);
            return;
        }// end function

    }
}
