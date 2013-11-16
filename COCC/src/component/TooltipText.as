package component
{
    import flash.filters.*;
    import flash.text.*;

    public class TooltipText extends TextField
    {
        public var FILTERS:Array;

        public function TooltipText(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Object = null)
        {
            this.FILTERS = [new DropShadowFilter(1, 90, 0, 1, 2, 2, 4)];
            var _loc_5:* = new EmbedFormat(param4, null, param3);
            embedFonts = true;
            defaultTextFormat = _loc_5;
            mouseEnabled = false;
            if (!param1)
            {
                wordWrap = true;
                width = 300;
            }
            multiline = true;
            autoSize = TextFieldAutoSize.CENTER;
            if (param2)
            {
                this.filters = this.FILTERS;
            }
            return;
        }// end function

        public function setFilter(param1:Array) : void
        {
            this.filters = param1;
            return;
        }// end function

        public function setWidth(param1:int) : void
        {
            width = param1;
            return;
        }// end function

        public function setSize(param1:int) : void
        {
            this.defaultTextFormat.size = param1;
            return;
        }// end function

        public function setColor(param1:uint) : void
        {
            this.defaultTextFormat.color = param1;
            return;
        }// end function

    }
}
