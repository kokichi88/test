package modules.city.graphics.clan.symbol
{
    import component.*;
    import flash.text.*;
    import resMgr.*;

    public class GuiClanSymbols extends BaseGui
    {
        public var currentIndex:int = 0;
        public var labelTextSymbol:TextField;
        public static var MAX_SYMBOLS:int = 28;
        public static var startX:Number = 40;
        public static var startY:Number = 65;
        public static var paddingX:Number = 28;
        public static var paddingY:Number = 37.1;
        public static var itemPerLine:int = 7;

        public function GuiClanSymbols()
        {
            super(ResMgr.getInstance().getMovieClip("ClanSymbolsGui"));
            this.labelTextSymbol.visible = false;
            this.loadSymBols();
            return;
        }// end function

        private function loadSymBols() : void
        {
            var _loc_2:ClanSymbolItem = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_1:int = 0;
            while (_loc_1 < MAX_SYMBOLS)
            {
                
                _loc_2 = new ClanSymbolItem();
                _loc_2.loadSymbol(_loc_1);
                _loc_3 = startX + (_loc_2.widthBg + paddingX) * int(_loc_1 % itemPerLine);
                _loc_4 = startY + (_loc_2.heightBg + paddingY) * int(_loc_1 / itemPerLine);
                _loc_2.setPos(_loc_3, _loc_4);
                addGui(_loc_2);
                _loc_1++;
            }
            return;
        }// end function

    }
}
