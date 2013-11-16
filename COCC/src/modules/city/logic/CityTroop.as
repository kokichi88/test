package modules.city.logic
{
    import __AS3__.vec.*;
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import component.avatar.things.*;
    import flash.geom.*;
    import gameData.*;
    import map.*;
    import map.logic.*;
    import modules.battle.logic.*;
    import modules.battle.logic.bean.*;
    import modules.city.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class CityTroop extends Object
    {
        public var countIdle:int = 0;
        public var avatar:Avatar;
        public var troopId:String;
        public var troopLevel:int;
        public var isoAMC:Vector2D;
        public var move:BaseMoving;
        public var idAmryCamp:int;
        private var typeRun:int = 0;
        private var moveSpeed:int;
        private var curCellCity:int;
        public var troopIndex:int = 0;
        public var isBelongClan:Boolean = false;
        public static const COUNT_DOWN_IDLE:int = 120;

        public function CityTroop()
        {
            this.isoAMC = new Vector2D();
            this.move = new BaseMoving();
            this.countIdle = Utility.randomNumber(0, COUNT_DOWN_IDLE);
            return;
        }// end function

        public function setInfo(param1:String, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = JsonMgr.getInstance().getInfoTroop(param1, param2);
            this.moveSpeed = _loc_5.moveSpeed / 8 * GlobalVar.stage.frameRate;
            this.troopId = param1;
            this.troopLevel = param2;
            this.updateCellAMC(param3, param4);
            this.create(AnCategory.AVATAR, param1, param2);
            return;
        }// end function

        public function updateCellAMC(param1:int, param2:int, param3:int = 0) : void
        {
            this.typeRun = param3;
            this.isoAMC.x = param1 * 3;
            this.isoAMC.y = param2 * 3;
            if (param3 == 1)
            {
                this.autoRunAway();
            }
            return;
        }// end function

        public function create(param1:String, param2:String, param3:int) : void
        {
            var _loc_6:AniEffect = null;
            this.avatar = new Avatar();
            this.avatar.create(param1, param2, param3);
            var _loc_4:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME).addChild(this.avatar);
            var _loc_5:* = this.randomCell();
            this.move.curCell = MapMgr.getInstance().battleMap.isoToCell(_loc_5.x, _loc_5.y);
            this.avatar.mouseChildren = false;
            this.avatar.mouseEnabled = false;
            this.avatar.sprite.mouseChildren = false;
            this.avatar.sprite.mouseEnabled = false;
            if (this.troopId == DataObject.HEALER)
            {
                _loc_6 = EffectDraw.play("healeraura", new Point(0, -60), this.avatar, 0);
                CityMgr.getInstance().effectList.push(_loc_6);
            }
            return;
        }// end function

        public function randomCell() : Point
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_1:* = new Point();
            var _loc_2:* = Utility.randomNumber(0, 14);
            var _loc_3:* = Utility.randomNumber(0, 14);
            if (_loc_2 >= 5 && _loc_2 <= 9)
            {
                _loc_4 = Utility.randomNumber(0, 1);
                _loc_2 = _loc_4 == 0 ? (Utility.randomNumber(0, 4)) : (Utility.randomNumber(10, 14));
            }
            else if (_loc_3 >= 5 && _loc_3 <= 14)
            {
                _loc_5 = Utility.randomNumber(0, 1);
                _loc_3 = _loc_5 == 0 ? (Utility.randomNumber(0, 4)) : (Utility.randomNumber(10, 14));
            }
            _loc_1.x = this.isoAMC.x + _loc_2;
            _loc_1.y = this.isoAMC.y + _loc_3;
            return _loc_1;
        }// end function

        public function setAction(param1:int, param2:int, param3:int = -1) : void
        {
            if (this.avatar)
            {
                this.avatar.addFrameScript();
                switch(param1)
                {
                    case AnConst.RUN:
                    {
                        this.avatar.updatefrs(2);
                        break;
                    }
                    case AnConst.STAND:
                    {
                        this.avatar.updatefrs(4);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.avatar.setAction(param1, param2);
            }
            return;
        }// end function

        public function loop() : void
        {
            this.move.updateLogic();
            this.avatar.x = this.move.x;
            this.avatar.y = this.move.y;
            this.checkWall();
            if (this.avatar.anSetting.currDir != this.move.dir)
            {
                this.avatar.anSetting.currDir = this.move.dir;
            }
            if (this.move.status == AnConst.STAND)
            {
                if (this.avatar.anSetting.currAction != AnConst.STAND)
                {
                    this.setAction(AnConst.STAND, this.move.dir);
                }
            }
            if (this.avatar.anSetting.currAction != AnConst.STAND)
            {
                return;
            }
            if (this.isBelongClan)
            {
                CityMgr.getInstance().removeCityTroop(this.troopIndex);
                return;
            }
            var _loc_1:String = this;
            var _loc_2:* = this.countIdle - 1;
            _loc_1.countIdle = _loc_2;
            if (this.countIdle <= 0)
            {
                this.countIdle = COUNT_DOWN_IDLE;
                this.autoRunAway();
            }
            return;
        }// end function

        private function checkWall() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:WallObject = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            if (this.avatar.anSetting.currAction == AnConst.RUN)
            {
                _loc_1 = MapMgr.getInstance().cityMap.pointToCell(this.move.x, this.move.y);
                if (_loc_1 != this.curCellCity)
                {
                    this.curCellCity = _loc_1;
                    if (MapMgr.getInstance().cityMap.getCellType(_loc_1) == BaseMap.IS_WALL)
                    {
                        _loc_2 = 0;
                        while (_loc_2 < GameDataMgr.getInstance().wallList.length)
                        {
                            
                            _loc_3 = GameDataMgr.getInstance().wallList[_loc_2];
                            _loc_4 = MapMgr.getInstance().cityMap.isoToCell(_loc_3.posX, _loc_3.posY);
                            if (_loc_4 == this.curCellCity)
                            {
                                _loc_5 = _loc_3.avatar.parent.getChildIndex(_loc_3.avatar);
                                _loc_6 = this.avatar.parent.getChildIndex(this.avatar);
                                if (_loc_5 > _loc_6)
                                {
                                    this.avatar.parent.swapChildrenAt(_loc_5, _loc_6);
                                }
                                _loc_3.effectHideWall();
                                ;
                            }
                            _loc_2++;
                        }
                    }
                }
            }
            return;
        }// end function

        private function autoRunAway() : void
        {
            var _loc_1:* = this.randomCell();
            var _loc_2:* = new Vector.<int>;
            _loc_2 = MapMgr.getInstance().battleMap.pathTo(this.move.curCell, MapMgr.getInstance().battleMap.isoToCell(_loc_1.x, _loc_1.y), 2, false, false);
            if (_loc_2.length == 0)
            {
            }
            this.move.moveTo(_loc_2, this.moveSpeed);
            this.setAction(AnConst.RUN, this.move.dir);
            return;
        }// end function

        public function moveToIso(param1:Point) : void
        {
            var _loc_2:* = new Vector.<int>;
            _loc_2 = MapMgr.getInstance().battleMap.pathTo(this.move.curCell, MapMgr.getInstance().battleMap.isoToCell(param1.x, param1.y), 2, false, false);
            if (_loc_2.length == 0)
            {
            }
            this.move.moveTo(_loc_2, this.moveSpeed);
            this.setAction(AnConst.RUN, this.move.dir);
            return;
        }// end function

        public function destroy() : void
        {
            if (this.avatar != null && this.avatar.parent != null)
            {
                this.avatar.destroy();
                this.avatar.parent.removeChild(this.avatar);
                this.avatar.visible = false;
                this.avatar = null;
            }
            return;
        }// end function

    }
}
