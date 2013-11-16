package modules.battle.logic
{
    import component.avatar.model.animation.*;
    import gameData.*;
    import modules.battle.*;
    import modules.battle.logic.bean.*;
    import modules.city.logic.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class HouseResources extends DataHouse
    {
        public var value:int = 1000;
        public var gold:int;
        public var elixir:int;
        public var darkElixir:int;
        public var maxGold:int;
        public var maxElixir:int;
        public var maxDarkElixir:int;

        public function HouseResources()
        {
            objectType = DataObject.OBJTYPE_RESOURCES;
            return;
        }// end function

        override public function setInfo(param1:String, param2:int) : void
        {
            var _loc_4:DataResources = null;
            var _loc_5:DataStorages = null;
            var _loc_6:DataTownHall = null;
            var _loc_3:* = Utility.getTypeObject(param1);
            switch(_loc_3)
            {
                case BuildingType.RES:
                {
                    _loc_4 = JsonMgr.getInstance().getResourcesData(param1, param2);
                    baseInfo.maxHp = _loc_4.hitpoints;
                    break;
                }
                case BuildingType.STO:
                {
                    _loc_5 = JsonMgr.getInstance().getStoragesData(param1, param2);
                    baseInfo.maxHp = _loc_5.hitpoints;
                    break;
                }
                case BuildingType.TOW:
                {
                    _loc_6 = JsonMgr.getInstance().getTownHallData(param2);
                    baseInfo.maxHp = _loc_6.hitpoints;
                    break;
                }
                default:
                {
                    break;
                }
            }
            baseInfo.curHp = baseInfo.maxHp;
            baseInfo.id = param1;
            baseInfo.level = param2;
            super.setInfo(param1, param2);
            return;
        }// end function

        override public function setDataHouse(param1:MapObject) : void
        {
            var _loc_2:DataStorages = null;
            var _loc_3:int = 0;
            var _loc_4:Number = NaN;
            var _loc_5:int = 0;
            super.setDataHouse(param1);
            this.gold = mapObject.gold;
            this.elixir = mapObject.elixir;
            this.darkElixir = mapObject.darkElixir;
            this.maxGold = this.gold;
            this.maxElixir = this.elixir;
            this.maxDarkElixir = this.darkElixir;
            if (Utility.getTypeObject(mapObject.type) == BuildingType.STO)
            {
                _loc_2 = StorageObject(mapObject).info;
                _loc_3 = Math.max(this.maxGold, this.maxElixir);
                _loc_3 = _loc_3 * 5;
                _loc_4 = _loc_3 / _loc_2.capacity * 100;
                _loc_5 = 5;
                if (_loc_4 <= 19)
                {
                    _loc_5 = 5;
                }
                else if (_loc_4 <= 45)
                {
                    _loc_5 = 6;
                }
                else if (_loc_4 <= 75)
                {
                    _loc_5 = 7;
                }
                else
                {
                    _loc_5 = 8;
                }
                avatar.setAction(avatar.anSetting.currAction, _loc_5);
            }
            return;
        }// end function

        override public function onDealDamage(param1:DataObject, param2:Number = 0, param3:int = -1) : void
        {
            var _loc_4:Number = NaN;
            var _loc_6:int = 0;
            var _loc_7:EffectHarvestResources = null;
            var _loc_8:EffectHarvestResources = null;
            var _loc_9:int = 0;
            if (this.objectStatus == AnConst.DIE)
            {
                return;
            }
            if (param2 == 0)
            {
                _loc_4 = getDamage(param1);
            }
            else
            {
                _loc_4 = param2;
            }
            if (_loc_4 > baseInfo.curHp)
            {
                _loc_4 = baseInfo.curHp;
            }
            var _loc_5:* = baseInfo.curHp / baseInfo.maxHp;
            if (this.gold > 0)
            {
                _loc_6 = _loc_5 * this.maxGold + 1;
                if (_loc_6 < this.gold)
                {
                    _loc_6 = this.gold - _loc_6;
                    this.gold = this.gold - _loc_6;
                    BattleModule.getInstance().addMoney(MoneyType.GOLD, _loc_6);
                    _loc_7 = new EffectHarvestResources();
                    _loc_9 = _loc_6 / 5;
                    _loc_9 = Math.max(1, _loc_9);
                    _loc_7.setInfo(MoneyType.GOLD, _loc_9, avatar.x, avatar.y);
                }
            }
            if (this.elixir > 0)
            {
                _loc_6 = _loc_5 * this.maxElixir + 1;
                if (_loc_6 < this.elixir)
                {
                    _loc_6 = this.elixir - _loc_6;
                    this.elixir = this.elixir - _loc_6;
                    BattleModule.getInstance().addMoney(MoneyType.ELIXIR, _loc_6);
                    _loc_8 = new EffectHarvestResources();
                    _loc_9 = _loc_6 / 5;
                    _loc_9 = Math.max(1, _loc_9);
                    _loc_8.setInfo(MoneyType.ELIXIR, _loc_9, avatar.x - 20, avatar.y - 20);
                }
            }
            if (this.darkElixir > 0)
            {
                _loc_6 = _loc_5 * this.maxDarkElixir + 1;
                if (_loc_6 < this.maxDarkElixir)
                {
                    _loc_6 = this.darkElixir - _loc_6;
                    this.darkElixir = this.darkElixir - _loc_6;
                    BattleModule.getInstance().addMoney(MoneyType.DARK_ELIXIR, _loc_6);
                    _loc_8 = new EffectHarvestResources();
                    _loc_8.setInfo(MoneyType.DARK_ELIXIR, _loc_6 / 4, avatar.x, avatar.y);
                }
            }
            if (baseInfo.curHp <= _loc_4)
            {
                if (this.gold > 0)
                {
                    _loc_6 = this.gold;
                    this.gold = this.gold - _loc_6;
                    BattleModule.getInstance().addMoney(MoneyType.GOLD, _loc_6);
                }
                if (this.elixir > 0)
                {
                    _loc_6 = this.elixir;
                    this.elixir = this.elixir - _loc_6;
                    BattleModule.getInstance().addMoney(MoneyType.ELIXIR, _loc_6);
                }
                if (this.darkElixir > 0)
                {
                    _loc_6 = this.darkElixir;
                    this.darkElixir = this.darkElixir - _loc_6;
                    BattleModule.getInstance().addMoney(MoneyType.DARK_ELIXIR, _loc_6);
                }
            }
            super.onDealDamage(param1, _loc_4);
            return;
        }// end function

        override public function death() : void
        {
            super.death();
            return;
        }// end function

    }
}
