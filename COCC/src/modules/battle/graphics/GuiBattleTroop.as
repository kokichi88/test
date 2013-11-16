package modules.battle.graphics
{
    import __AS3__.vec.*;
    import component.*;
    import flash.filters.*;
    import modules.battle.*;
    import modules.battle.data.*;
    import resMgr.*;

    public class GuiBattleTroop extends BaseGui
    {
        private var listTroop:Vector.<Troop>;
        public var listItemTroop:Vector.<ItemBattleTroop>;
        public var glow:GlowFilter;

        public function GuiBattleTroop()
        {
            this.glow = new GlowFilter(65280, 1, 5, 5, 400, 1);
            super(ResMgr.getInstance().getMovieClip("GuiTroopBattle"));
            autoAlign = AUTO_ALIGN_BOTTOM_CENTER;
            return;
        }// end function

        public function setData(param1:Vector.<Troop>) : void
        {
            var _loc_6:int = 0;
            var _loc_7:ItemBattleTroop = null;
            var _loc_8:Troop = null;
            this.listTroop = param1;
            var _loc_2:int = 38;
            var _loc_3:int = -13;
            var _loc_4:Number = 90;
            if (this.listItemTroop)
            {
                _loc_6 = 0;
                while (_loc_6 < this.listItemTroop.length)
                {
                    
                    _loc_7 = this.listItemTroop[_loc_6];
                    if (_loc_7)
                    {
                        _loc_7.destroy();
                        _loc_7.destroyBaseGUI();
                        _loc_7 = null;
                    }
                    _loc_6++;
                }
            }
            this.listItemTroop = new Vector.<ItemBattleTroop>;
            var _loc_5:int = 0;
            while (_loc_5 < this.listTroop.length)
            {
                
                _loc_7 = new ItemBattleTroop();
                _loc_7.troop = this.listTroop[_loc_5];
                _loc_7.index = _loc_5;
                _loc_7.setPos(_loc_2 + _loc_5 * _loc_4, _loc_3);
                img.addChild(_loc_7.bgImg);
                this.listItemTroop.push(_loc_7);
                _loc_5++;
            }
            if (this.listItemTroop.length > 0)
            {
                this.listItemTroop[0].focus();
            }
            if (BattleModule.getInstance().hasClan)
            {
                _loc_7 = new ItemBattleTroop();
                _loc_8 = new Troop();
                _loc_8.num = 1;
                _loc_8.level = 1;
                _loc_8.type = "Clan";
                _loc_7.troop = _loc_8;
                _loc_7.setClan();
                _loc_7.index = this.listTroop.length;
                _loc_7.setPos(_loc_2 + this.listTroop.length * _loc_4, _loc_3);
                img.addChild(_loc_7.bgImg);
                this.listItemTroop.push(_loc_7);
            }
            return;
        }// end function

        public function subTroop(param1:String, param2:int) : void
        {
            var _loc_3:int = 0;
            var _loc_4:ItemBattleTroop = null;
            if (param1 != "Clan")
            {
                if (this.listItemTroop)
                {
                    _loc_3 = 0;
                    while (_loc_3 < this.listItemTroop.length)
                    {
                        
                        _loc_4 = this.listItemTroop[_loc_3];
                        if (_loc_4.troop.type == param1)
                        {
                            _loc_4.subTroop(param2);
                        }
                        _loc_3++;
                    }
                }
            }
            else
            {
                _loc_4 = this.listItemTroop[(this.listItemTroop.length - 1)];
                _loc_4.troop.num = 0;
                if (_loc_4.troop.type == param1)
                {
                    _loc_4.img.filters = [BitmapButton.disableFilter];
                }
            }
            return;
        }// end function

        public function focusTroop(param1:int) : void
        {
            var _loc_2:int = 0;
            var _loc_3:ItemBattleTroop = null;
            if (this.listItemTroop == null || param1 >= this.listItemTroop.length)
            {
                return;
            }
            _loc_2 = 0;
            while (_loc_2 < this.listItemTroop.length)
            {
                
                if (this.listItemTroop[_loc_2]._troop.num <= 0)
                {
                }
                else
                {
                    _loc_3 = this.listItemTroop[_loc_2];
                    if (_loc_2 != param1)
                    {
                        _loc_3.img.filters = null;
                    }
                    else
                    {
                        _loc_3.img.filters = [this.glow];
                    }
                }
                _loc_2++;
            }
            BattleModule.getInstance().curIdTroop = this.listItemTroop[param1].troop.type;
            return;
        }// end function

    }
}
