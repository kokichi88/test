package modules.city.graphics.Others
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import component.*;
    import flash.display.*;
    import flash.text.*;
    import gameData.*;
    import utility.*;

    public class GuiNotify extends Sprite
    {
        public var listItem:Vector.<Object>;
        public static var startX:int = 200;
        public static var startY:int = 100;
        public static var maxLoop:int = 102;

        public function GuiNotify()
        {
            this.listItem = new Vector.<Object>;
            return;
        }// end function

        public function addNewNotify(param1:String, param2:String = "#FFFFFF") : void
        {
            this.mouseChildren = false;
            this.mouseEnabled = false;
            param1 = param1.toUpperCase();
            this.moveUpOtherItems();
            var _loc_3:* = new TooltipText(true, true, true);
            _loc_3.autoSize = TextFieldAutoSize.CENTER;
            _loc_3.htmlText = "<p align=\'center\'><font size=\'22\'color =\'" + param2 + "\'>" + param1 + "</font></p>";
            _loc_3.x = (GlobalVar.SCREEN_WIDTH - _loc_3.width) / 2;
            _loc_3.y = startY - _loc_3.height;
            this.addChild(_loc_3);
            TweenLite.to(_loc_3, 0.3, {y:startY});
            TweenLite.to(_loc_3, 1.8, {delay:1.5, alpha:0});
            var _loc_4:* = new Object();
            new Object().notify = _loc_3;
            _loc_4.numLoop = maxLoop;
            this.listItem.push(_loc_4);
            return;
        }// end function

        public function addNewNotifyText(param1:TooltipText) : void
        {
            param1.x = (GlobalVar.SCREEN_WIDTH - param1.width) / 2;
            param1.y = startY - param1.height;
            this.addChild(param1);
            TweenLite.to(param1, 0.3, {y:startY});
            TweenLite.to(param1, 1.8, {delay:1.5, alpha:0});
            var _loc_2:* = new Object();
            _loc_2.notify = param1;
            _loc_2.numLoop = maxLoop;
            this.listItem.push(_loc_2);
            return;
        }// end function

        public function addReceiveMoney(param1:MoneyType) : void
        {
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this.moveUpOtherItems();
            var _loc_2:* = new TooltipText(true, true, true);
            var _loc_3:* = Localization.getInstance().getString("ReceiveReward");
            var _loc_4:* = Localization.getInstance().getString(param1.type);
            _loc_2.htmlText = "<p align=\'center\'><font size=\'22\'>" + _loc_3.toUpperCase() + "</font>" + "<font size=\'22\' color=\'" + GlobalVar.MONEY_COLOR[param1.type] + "\'> " + param1.value + " " + _loc_4.toUpperCase() + "</font>" + "<font size=\'22\'> !</font></p>";
            _loc_2.x = (GlobalVar.SCREEN_WIDTH - _loc_2.width) / 2;
            _loc_2.y = startY - _loc_2.height;
            this.addChild(_loc_2);
            TweenLite.to(_loc_2, 0.3, {y:startY});
            TweenLite.to(_loc_2, 1.8, {delay:1.5, alpha:0});
            var _loc_5:* = new Object();
            new Object().notify = _loc_2;
            _loc_5.numLoop = maxLoop;
            this.listItem.push(_loc_5);
            return;
        }// end function

        public function moveUpOtherItems() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                TweenLite.to(this.listItem[_loc_1].notify, 0.3, {y:this.listItem[_loc_1].notify.y + this.listItem[_loc_1].notify.height});
                _loc_1++;
            }
            return;
        }// end function

        public function loop() : void
        {
            var _loc_2:Object = null;
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                var _loc_3:* = this.listItem[_loc_1];
                var _loc_4:* = this.listItem[_loc_1].numLoop - 1;
                _loc_3.numLoop = _loc_4;
                if (this.listItem[_loc_1].numLoop <= 0)
                {
                    _loc_2 = this.listItem[_loc_1];
                    this.removeChild(_loc_2.notify);
                    this.listItem.splice(_loc_1, 1);
                }
                _loc_1++;
            }
            return;
        }// end function

    }
}
