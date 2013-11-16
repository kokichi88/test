package modules.battle.logic
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.geom.*;
    import map.*;
    import map.logic.*;
    import modules.battle.*;
    import modules.battle.logic.bean.*;
    import resMgr.*;
    import resMgr.data.*;

    public class HouseClan extends DataHouse
    {
        private var dropTroop:Boolean = false;

        public function HouseClan()
        {
            numFindTarget = COUNT_DOWN_FIND_TARGET;
            listAreaTargets.push(DataObject.AREA_AIR);
            return;
        }// end function

        override public function setInfo(param1:String, param2:int) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getClanCastleData(param2);
            baseInfo.attackRange = _loc_3.range * BaseInfo.WIDTH_CELL;
            baseInfo.id = param1;
            baseInfo.level = param2;
            super.setInfo(param1, param2);
            this.loadIcon();
            return;
        }// end function

        public function loadIcon() : void
        {
            if (mapObject && mapObject.status == 2)
            {
                return;
            }
            if (BattleModule.getInstance().clanIconFriend < 0)
            {
                return;
            }
            var _loc_1:* = new Sprite();
            var _loc_2:* = ResMgr.getInstance().getMovieClip("ClanSymbol_Big_" + BattleModule.getInstance().clanIconFriend) as Sprite;
            _loc_1.addChildAt(_loc_2, 0);
            _loc_1.x = (-_loc_1.width) / 2;
            _loc_1.y = (-_loc_1.height) / 2 - 10;
            avatar.addChild(_loc_1);
            var _loc_3:* = new TooltipText(true, true);
            _loc_3.htmlText = "<font size=\'24\'>" + BattleModule.getInstance().clanNameFriend + "</font>";
            _loc_3.x = (_loc_1.width - _loc_3.textWidth) / 2;
            _loc_3.y = _loc_2.height - 15;
            _loc_1.addChild(_loc_3);
            BattleModule.getInstance().battleData.imageList.push(_loc_1);
            return;
        }// end function

        override public function loop() : void
        {
            super.loop();
            if (this.dropTroop)
            {
                return;
            }
            if (objId % DELAY_FRAME != BattleModule.getInstance().curLoop % DELAY_FRAME)
            {
                this.findTarget();
            }
            return;
        }// end function

        override public function findTarget() : void
        {
            var _loc_2:Vector2D = null;
            var _loc_1:* = MapMgr.getInstance().getObjectInAreaByType(this, new Point(this.move.x, this.move.y), this.baseInfo.attackRange, DataObject.OBJTYPE_TROOP, DataObject.AREA_GROUND);
            if (_loc_1.length > 0)
            {
                this.dropTroop = true;
                _loc_2 = MapMgr.getInstance().battleMap.cellToIso(this.getCurCell());
                _loc_2.x = _loc_2.x + 3;
                BattleModule.getInstance().dropTroopFromClanHouse(MapMgr.getInstance().battleMap.isoToCell(_loc_2.x, _loc_2.y));
            }
            return;
        }// end function

    }
}
