package modules.replay.graphics
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.battle.data.*;
    import modules.battle.graphics.*;
    import modules.city.*;
    import modules.replay.*;
    import modules.replay.data.*;
    import resMgr.*;
    import utility.*;

    public class ItemLogDefences extends BaseGui
    {
        public var labelName:TextField;
        public var labelClanName:TextField;
        public var labelTropy:TextField;
        public var labelPlusTropy:TextField;
        public var labelResults:TextField;
        public var labelPercent:TextField;
        public var labelGold:TextField;
        public var labelElixir:TextField;
        public var labelTime:TextField;
        public var imageStar1:MovieClip;
        public var imageStar2:MovieClip;
        public var imageStar3:MovieClip;
        public var bmpReplay:BitmapButton;
        public var bmpReAttack:BitmapButton;
        public var bmpBack:BitmapButton;
        public var bmpNext:BitmapButton;
        public var logBattle:LogBattleData;
        public var type:int;
        public var imageBgWin:MovieClip;
        public var imageBgLost:MovieClip;
        public var pageItem:PageMgr;
        private static const BMP_REPLAY:String = "bmpReplay";
        private static const BMP_REATTACK:String = "bmpReAttack";
        private static const BMP_BACK:String = "bmpBack";
        private static const BMP_NEXT:String = "bmpNext";

        public function ItemLogDefences()
        {
            super(ResMgr.getInstance().getMovieClip("ItemLogDefences1"));
            this.pageItem = new PageMgr(img);
            this.pageItem.x = 162;
            this.pageItem.y = 30;
            return;
        }// end function

        public function setInfo(param1:LogBattleData, param2:int) : void
        {
            var _loc_8:Sprite = null;
            var _loc_9:int = 0;
            var _loc_10:Troop = null;
            var _loc_11:ItemBattleTroop = null;
            this.type = param2;
            this.logBattle = param1;
            this.labelName.text = param1.uName;
            this.labelClanName.text = param1.clanName;
            this.labelTropy.text = param1.trophy.toString();
            this.labelPlusTropy.text = param1.retTrophy.toString();
            this.labelPercent.text = param1.percentLife + "%";
            this.labelGold.text = Utility.numToStr(param1.gold);
            this.labelElixir.text = Utility.numToStr(param1.elixir);
            this.imageStar1.visible = false;
            this.imageStar2.visible = false;
            this.imageStar3.visible = false;
            this.imageBgLost.visible = false;
            this.imageBgWin.visible = false;
            if (param1.clanIcon >= 0)
            {
                _loc_8 = ResMgr.getInstance().getMovieClip("ClanSymbol_Small_" + param1.clanIcon) as Sprite;
                img.addChild(_loc_8);
                _loc_8.y = this.labelClanName.y;
                _loc_8.x = this.labelClanName.x - _loc_8.width + 4;
            }
            switch(this.type)
            {
                case 0:
                {
                    if (param1.nStar == 0)
                    {
                        this.labelResults.text = "Thủ thắng";
                        this.imageBgWin.visible = true;
                    }
                    else
                    {
                        this.labelResults.text = "Thủ thất bại";
                        this.imageBgLost.visible = true;
                        _loc_9 = 1;
                        while (_loc_9 <= param1.nStar)
                        {
                            
                            this["imageStar" + _loc_9].visible = true;
                            _loc_9++;
                        }
                    }
                    this.labelPlusTropy.text = param1.retTrophy.toString();
                    break;
                }
                case 1:
                {
                    if (param1.nStar != 0)
                    {
                        this.labelResults.text = "Công thắng";
                        this.imageBgWin.visible = true;
                        _loc_9 = 1;
                        while (_loc_9 <= param1.nStar)
                        {
                            
                            this["imageStar" + _loc_9].visible = true;
                            _loc_9++;
                        }
                    }
                    else
                    {
                        this.labelResults.text = "Công thất bại";
                        this.imageBgLost.visible = true;
                    }
                    this.labelPlusTropy.text = param1.retTrophy.toString();
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_3:* = Utility.getCurTime() - param1.endTime;
            this.labelTime.text = Utility.convertTimeToShortString(_loc_3);
            var _loc_4:Number = 0;
            var _loc_5:Number = 0;
            var _loc_6:Number = 47;
            var _loc_7:* = new Sprite();
            _loc_9 = 0;
            while (_loc_9 < param1.listTroop.length)
            {
                
                _loc_10 = param1.listTroop[_loc_9];
                _loc_11 = new ItemBattleTroop(2);
                _loc_11.iconClan = param1.clanIcon;
                _loc_11.troop = _loc_10;
                _loc_7.addChild(_loc_11.bgImg);
                _loc_11.setPos(_loc_4 + _loc_9 * _loc_6, _loc_5);
                _loc_9++;
            }
            this.pageItem.setData(_loc_7, 280, 51, 0, PageMgr.HOZIRONTOL, true, 1);
            this.checkStatusBmp();
            if (!param1.isReplay)
            {
                this.bmpReplay.visible = false;
            }
            if (!param1.isRevenge)
            {
                this.bmpReAttack.visible = false;
            }
            if (this.pageItem.totalPage < 2)
            {
                var _loc_12:Boolean = false;
                this.bmpBack.visible = false;
                this.bmpNext.visible = _loc_12;
            }
            return;
        }// end function

        private function checkStatusBmp() : void
        {
            this.bmpNext.enable = false;
            this.bmpBack.enable = false;
            if (this.pageItem.canNext())
            {
                this.bmpNext.enable = true;
            }
            if (this.pageItem.canPrev())
            {
                this.bmpBack.enable = true;
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_REPLAY:
                {
                    ReplayMgr.getInstance().showEffectReplayBattle(this.logBattle.keyLog, this.type);
                    break;
                }
                case BMP_REATTACK:
                {
                    this.sendReAttack();
                    break;
                }
                case BMP_NEXT:
                {
                    this.pageItem.nextPage();
                    this.checkStatusBmp();
                    break;
                }
                case BMP_BACK:
                {
                    this.pageItem.prevPage();
                    this.checkStatusBmp();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function sendReAttack() : void
        {
            var _loc_2:String = null;
            var _loc_3:String = null;
            var _loc_1:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            if (_loc_1 > 0)
            {
                if (Utility.getCurTime() < GameDataMgr.getInstance().myInfo.shieldTime)
                {
                    _loc_2 = Localization.getInstance().getString("NoticeShieldTitle");
                    _loc_3 = Localization.getInstance().getString("NoticeShieldMessage");
                    CityMgr.getInstance().showMessage(_loc_2, _loc_3, "TIẾP TỤC", this.findMatch);
                    return;
                }
                this.findMatch();
            }
            else
            {
                CityMgr.getInstance().guiNotify.addNewNotify(Localization.getInstance().getString("NeedArmyToAttack"));
            }
            return;
        }// end function

        private function findMatch() : void
        {
            ReplayMgr.getInstance().sendRevenge(this.logBattle.uId);
            return;
        }// end function

    }
}
