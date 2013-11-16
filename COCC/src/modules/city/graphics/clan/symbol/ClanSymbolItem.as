package modules.city.graphics.clan.symbol
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import modules.city.*;
    import resMgr.*;

    public class ClanSymbolItem extends BaseGui
    {
        public var index:int = 0;

        public function ClanSymbolItem()
        {
            super(ResMgr.getInstance().getMovieClip("ClanSymbolItem"));
            return;
        }// end function

        public function loadSymbol(param1:int) : void
        {
            var _loc_2:Sprite = null;
            this.index = param1;
            _loc_2 = ResMgr.getInstance().getMovieClip("ClanSymbol_" + this.index) as Sprite;
            _loc_2.x = (this.widthBg - _loc_2.width) / 2;
            _loc_2.y = (this.heightBg - _loc_2.height) / 2;
            _loc_2.mouseChildren = false;
            _loc_2.mouseEnabled = false;
            this.img.addChild(_loc_2);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            CityMgr.getInstance().guiClan.guiCreateClan.curSymbolType = this.index;
            CityMgr.getInstance().guiClan.showCreateClan();
            return;
        }// end function

    }
}
