package modules.city.graphics.ranking
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import resMgr.*;

    public class PlayerItem extends BaseGui
    {
        public var curIndex:int;
        public var labelRank:TextField;
        public var labelMemberName:TextField;
        public var labelLevel:TextField;
        public var labelTrophy:TextField;
        public var labelClan:TextField;
        public var labelAttacksWon:TextField;
        public var labelDefensesWon:TextField;
        public var labelChangedRank:TextField;
        public var bmpPlayerItem:BitmapButton;
        private static const BMP_ITEM:String = "bmpPlayerItem";

        public function PlayerItem()
        {
            super(ResMgr.getInstance().getMovieClip("PlayersItem"));
            return;
        }// end function

        public function setInfo(param1:int, param2:PlayerInfo) : void
        {
            var _loc_5:Sprite = null;
            var _loc_6:Sprite = null;
            var _loc_7:String = null;
            this.curIndex = param1;
            this.labelRank.text = ((param1 + 1)).toString();
            this.labelMemberName.text = param2.cityName;
            this.labelLevel.text = param2.level.toString();
            this.labelTrophy.text = param2.trophy.toString();
            if (param2.clanId > 0)
            {
                this.labelClan.visible = true;
                this.labelClan.text = param2.clanName;
                _loc_5 = ResMgr.getInstance().getMovieClip("ClanSymbol_Small_" + param2.clanIcon);
                if (_loc_5)
                {
                    this.img.addChild(_loc_5);
                    var _loc_8:Number = 0.55;
                    _loc_5.scaleY = 0.55;
                    _loc_5.scaleX = _loc_8;
                    _loc_5.x = this.labelClan.x - _loc_5.width;
                    _loc_5.y = this.labelClan.y + (this.labelClan.height - _loc_5.height) / 2 + 3;
                }
            }
            else
            {
                this.labelClan.visible = false;
            }
            this.labelAttacksWon.text = param2.attacksWon.toString();
            this.labelDefensesWon.text = param2.defensesWon.toString();
            if (param1 < 3)
            {
                _loc_6 = ResMgr.getInstance().getMovieClip("imageBgTop" + (param1 + 1)) as Sprite;
                this.img.addChild(_loc_6);
                this.img.setChildIndex(_loc_6, this.img.getChildIndex(this.labelRank));
                _loc_6.x = this.labelRank.x + (this.labelRank.width - _loc_6.width) / 2;
                _loc_6.y = this.labelRank.y + (this.labelRank.height - _loc_6.height) / 2;
            }
            if (GameDataMgr.getInstance().myInfo.uId == param2.uId)
            {
                this.bmpPlayerItem.visible = false;
            }
            var _loc_3:String = "StableIcon";
            if (param2.changedRank > 0)
            {
                _loc_3 = "IncreaseIcon";
            }
            if (param2.changedRank < 0)
            {
                _loc_3 = "DecreaseIcon";
            }
            var _loc_4:* = ResMgr.getInstance().getMovieClip(_loc_3);
            if (!ResMgr.getInstance().getMovieClip(_loc_3))
            {
                return;
            }
            this.img.addChild(_loc_4);
            _loc_4.x = 66 - _loc_4.width / 2;
            _loc_4.y = (this.heightBg - _loc_4.height) / 2;
            this.labelChangedRank.visible = false;
            if (param2.changedRank != 0)
            {
                _loc_4.y = _loc_4.y - 7;
                this.labelChangedRank.visible = true;
                _loc_7 = param2.changedRank > 0 ? ("#768D25") : ("#E16430");
                this.labelChangedRank.htmlText = "<font color=\'" + _loc_7 + "\'>" + Math.abs(param2.changedRank) + " </font>";
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            CityMgr.getInstance().guiRanking.guiTopPlayers.onItemClick(this.curIndex);
            return;
        }// end function

    }
}
