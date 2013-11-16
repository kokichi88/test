package com.swfdefender
{
    import flash.display.*;
    import flash.text.*;

    public class DomainMsg extends Sprite
    {

        public function DomainMsg(param1:Number, param2:Number, param3:String, param4:uint, param5:Boolean)
        {
            if (false)
            {
            }
            var _loc_8:* = undefined;
            if (!param5)
            {
                _loc_8 = new Sprite();
                _loc_8.graphics.beginFill(param4);
                _loc_8.graphics.drawRect(0, 0, param1, param2);
                _loc_8.graphics.endFill();
                this.addChild(_loc_8);
            }
            var _loc_6:* = new TextField();
            new TextField().width = param1;
            _loc_6.height = param2;
            _loc_6.multiline = true;
            _loc_6.wordWrap = true;
            _loc_6.selectable = false;
            _loc_6.htmlText = param3;
            _loc_6.autoSize = TextFieldAutoSize.CENTER;
            var _loc_7:* = new TextFormat();
            new TextFormat().align = TextFormatAlign.CENTER;
            _loc_6.setTextFormat(_loc_7);
            _loc_6.x = 0;
            _loc_6.y = param2 / 2 - _loc_6.height / 2;
            this.addChild(_loc_6);
            ;
            if (false)
            {
            }
            return;
        }// end function

        if (false)
        {
        }
        ;
        ;
    }
}
