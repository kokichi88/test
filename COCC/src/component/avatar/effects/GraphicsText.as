package component.avatar.effects
{
    import component.*;
    import flash.display.*;
    import flash.text.*;

    public class GraphicsText extends Sprite
    {
        private static var pool:Object = new Object();
        private static var mapping:Object;

        public function GraphicsText()
        {
            return;
        }// end function

        public function set text(param1:String) : void
        {
            var _loc_3:EmbedFormat = null;
            var _loc_2:* = new TextField();
            _loc_3 = new EmbedFormat(null, null, true);
            _loc_3.size = 30;
            _loc_3.color = 16777215;
            _loc_2.embedFonts = true;
            _loc_2.setTextFormat(_loc_3);
            _loc_2.defaultTextFormat = _loc_3;
            _loc_2.antiAliasType = AntiAliasType.ADVANCED;
            _loc_2.autoSize = TextFieldAutoSize.CENTER;
            _loc_2.text = param1;
            _loc_2.x = 0;
            this.addChild(_loc_2);
            return;
        }// end function

    }
}
