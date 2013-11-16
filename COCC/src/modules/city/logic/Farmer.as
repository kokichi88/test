package modules.city.logic
{
    import __AS3__.vec.*;
    import component.avatar.model.animation.*;
    import component.avatar.things.*;
    import flash.geom.*;
    import gameData.*;
    import map.*;
    import map.logic.*;
    import modules.battle.*;
    import modules.battle.logic.*;
    import modules.battle.logic.bean.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class Farmer extends Object
    {
        public var countIdle:int = 0;
        public var countWallHide:int = 0;
        public var avatar:Avatar;
        public var isoBuilding:Vector2D;
        public var move:BaseMoving;
        private var typeRun:int = 0;
        private var moveSpeed:int = 70;
        public var widthObj:int;
        public var heightObj:int;
        public var cellCenter:int = 0;
        public var deepLevel:int = 2;
        public var idFarmer:int;
        public var numHouse:int = 0;
        public var typeHouse:String;
        public var curCellCity:int;
        private var curWall:WallObject;
        private var hasReturn:Boolean = false;
        public static const COUNT_DOWN_IDLE:int = 120;
        public static const COUNT_HOUSE:int = 5;
        public static const COUNT_WALL_HIDE:int = 20;

        public function Farmer()
        {
            this.isoBuilding = new Vector2D();
            this.move = new BaseMoving();
            return;
        }// end function

        public function setInfo(param1:int) : void
        {
            this.idFarmer = param1;
            var _loc_2:* = this.getTowHall();
            this.updateCellBuilding(_loc_2);
            this.create(AnCategory.AVATAR, "FAR_1", 1);
            this.countIdle = 100;
            return;
        }// end function

        private function getTowHall() : MapObject
        {
            var _loc_1:MapObject = null;
            var _loc_2:int = 0;
            var _loc_3:DataObject = null;
            if (GlobalVar.state == GlobalVar.STATE_BATTLE)
            {
                _loc_1 = new MapObject();
                _loc_2 = 0;
                while (_loc_2 < BattleModule.getInstance().battleData.objList.length)
                {
                    
                    _loc_3 = BattleModule.getInstance().battleData.objList[_loc_2];
                    if (_loc_3.objectType == DataObject.OBJTYPE_TEMPLE)
                    {
                        return DataHouse(_loc_3).mapObject;
                    }
                    _loc_2++;
                }
            }
            else
            {
                return GameDataMgr.getInstance().townHall;
            }
            return new MapObject();
        }// end function

        public function create(param1:String, param2:String, param3:int) : void
        {
            this.avatar = new Avatar();
            this.avatar.create(param1, param2, param3);
            this.avatar.anSetting.currDir = 5;
            var _loc_4:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME).addChild(this.avatar);
            var _loc_5:* = this.randomCell();
            this.move.curCell = MapMgr.getInstance().battleMap.isoToCell(_loc_5.x, _loc_5.y);
            this.avatar.mouseChildren = false;
            this.avatar.mouseEnabled = false;
            this.avatar.sprite.mouseChildren = false;
            this.avatar.sprite.mouseEnabled = false;
            return;
        }// end function

        public function randomHouseStart() : void
        {
            var _loc_1:* = this.getRandomHouse();
            if (_loc_1 == null)
            {
                return;
            }
            this.updateCellBuilding(_loc_1);
            var _loc_2:* = this.randomCell();
            this.move.curCell = MapMgr.getInstance().battleMap.isoToCell(_loc_2.x, _loc_2.y);
            this.autoRunAway();
            return;
        }// end function

        public function updateCellBuilding(param1:MapObject, param2:int = 0) : void
        {
            this.typeHouse = param1.type;
            this.typeRun = param2;
            this.isoBuilding.x = param1.posX * 3;
            this.isoBuilding.y = param1.posY * 3;
            this.widthObj = param1.width * 3;
            this.heightObj = param1.height * 3;
            this.cellCenter = MapMgr.getInstance().battleMap.isoToCell(this.isoBuilding.x + this.widthObj / 2, this.isoBuilding.y + this.heightObj / 2);
            if (param2 == 1)
            {
                this.autoRunAway();
            }
            return;
        }// end function

        private function autoRunAway() : void
        {
            var _loc_1:* = this.getRandomHouse();
            if (_loc_1 == null)
            {
                return;
            }
            this.updateCellBuilding(_loc_1);
            var _loc_2:* = this.randomCell();
            var _loc_3:* = new Vector.<int>;
            _loc_3 = MapMgr.getInstance().battleMap.pathTo(this.move.curCell, MapMgr.getInstance().battleMap.isoToCell(_loc_2.x, _loc_2.y), this.deepLevel, false, false, true);
            if (this.typeRun == 0)
            {
                this.move.moveTo(_loc_3, this.moveSpeed);
            }
            else
            {
                this.typeRun = 0;
                this.move.moveTo(_loc_3, this.moveSpeed * 1);
            }
            this.setAction(AnConst.RUN, this.move.dir);
            return;
        }// end function

        public function returnHome() : void
        {
            this.hasReturn = true;
            return;
        }// end function

        private function getRandomHouse() : MapObject
        {
            var _loc_1:int = 0;
            var _loc_2:DataObject = null;
            var _loc_3:Vector.<MapObject> = null;
            var _loc_4:int = 0;
            if (GlobalVar.state == GlobalVar.STATE_BATTLE)
            {
                if (this.numHouse >= COUNT_HOUSE)
                {
                    return this.getTowHall();
                }
                _loc_3 = new Vector.<MapObject>;
                _loc_1 = 0;
                while (_loc_1 < BattleModule.getInstance().battleData.objList.length)
                {
                    
                    _loc_2 = BattleModule.getInstance().battleData.objList[_loc_1];
                    if (_loc_2.objectType == DataObject.OBJTYPE_HOUSE || _loc_2.objectType == DataObject.OBJTYPE_DEFENSES || _loc_2.objectType == DataObject.OBJTYPE_RESOURCES)
                    {
                        _loc_3.push(DataHouse(_loc_2).mapObject);
                    }
                    _loc_1++;
                }
                if (_loc_3.length > 0)
                {
                    _loc_4 = Math.random() * _loc_3.length;
                    return _loc_3[_loc_4];
                }
                return null;
            }
            else
            {
                this.numHouse++;
                if (this.numHouse >= COUNT_HOUSE)
                {
                    return this.getTowHall();
                }
                _loc_3 = GameDataMgr.getInstance().getHouseList();
                if (_loc_3 == null || _loc_3.length == 0)
                {
                    return null;
                }
                _loc_4 = Math.random() * _loc_3.length;
                if (_loc_4 >= _loc_3.length)
                {
                    return null;
                }
            }
            return _loc_3[_loc_4];
        }// end function

        public function randomCell() : Point
        {
            var _loc_1:Point = null;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:Number = NaN;
            if (this.typeHouse != BuildingType.TOWN_HALL)
            {
                _loc_1 = new Point();
                _loc_2 = Utility.randomNumber(0, this.widthObj);
                _loc_3 = Utility.randomNumber(0, this.heightObj);
                if (_loc_2 >= 1 && _loc_2 <= this.widthObj - 2)
                {
                    _loc_4 = Utility.randomNumber(0, 1);
                    _loc_2 = _loc_4 == 0 ? (0) : ((this.heightObj - 1));
                }
                _loc_1.x = this.isoBuilding.x + _loc_2;
                _loc_1.y = this.isoBuilding.y + _loc_3;
                return _loc_1;
            }
            else
            {
                if (this.hasReturn)
                {
                    _loc_1 = new Point();
                    _loc_1.x = this.isoBuilding.x + this.widthObj;
                    _loc_1.y = this.isoBuilding.y + this.heightObj / 2;
                    return _loc_1;
                }
                _loc_1 = new Point();
                _loc_2 = Utility.randomNumber(0, this.widthObj);
                _loc_3 = Utility.randomNumber(0, this.heightObj);
                _loc_5 = Utility.randomNumber(0, 1);
                if (_loc_5 < 0.5)
                {
                    _loc_2 = this.widthObj - 1;
                }
                else
                {
                    _loc_3 = this.heightObj - 1;
                }
                _loc_1.x = this.isoBuilding.x + _loc_2;
            }
            _loc_1.y = this.isoBuilding.y + _loc_3;
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
                    case AnConst.ATTACK:
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

        public function loop() : void
        {
            var _loc_1:int = 0;
            var _loc_2:Point = null;
            var _loc_3:int = 0;
            var _loc_4:DataObject = null;
            var _loc_5:int = 0;
            var _loc_6:WallObject = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            if (this.hasReturn)
            {
                this.numHouse = COUNT_HOUSE;
                this.moveSpeed = this.moveSpeed * 3;
                this.countIdle = 3;
                this.autoRunAway();
                this.hasReturn = false;
                return;
            }
            this.move.updateLogic();
            this.avatar.x = this.move.x;
            this.avatar.y = this.move.y;
            if (this.avatar.anSetting.currAction == AnConst.RUN && this.curWall == null)
            {
                _loc_1 = MapMgr.getInstance().cityMap.pointToCell(this.move.x, this.move.y);
                if (_loc_1 != this.curCellCity)
                {
                    this.curCellCity = _loc_1;
                    if (MapMgr.getInstance().cityMap.getCellType(_loc_1) == BaseMap.IS_WALL)
                    {
                        switch(GlobalVar.state)
                        {
                            case GlobalVar.STATE_MYHOME:
                            {
                                _loc_5 = 0;
                                while (_loc_5 < GameDataMgr.getInstance().wallList.length)
                                {
                                    
                                    _loc_6 = GameDataMgr.getInstance().wallList[_loc_5];
                                    _loc_7 = MapMgr.getInstance().cityMap.isoToCell(_loc_6.posX, _loc_6.posY);
                                    if (_loc_7 == this.curCellCity)
                                    {
                                        this.countWallHide = COUNT_WALL_HIDE;
                                        _loc_8 = _loc_6.avatar.parent.getChildIndex(_loc_6.avatar);
                                        _loc_9 = this.avatar.parent.getChildIndex(this.avatar);
                                        if (_loc_8 > _loc_9)
                                        {
                                            this.avatar.parent.swapChildrenAt(_loc_8, _loc_9);
                                        }
                                        _loc_6.effectHideWall();
                                        ;
                                    }
                                    _loc_5++;
                                }
                                break;
                            }
                            case GlobalVar.STATE_BATTLE:
                            {
                                _loc_2 = MapMgr.getInstance().battleMap.pointToIso(this.move.x, this.move.y);
                                _loc_2.x = int(_loc_2.x / 3) * 3;
                                _loc_2.y = int(_loc_2.y / 3) * 3;
                                _loc_3 = MapMgr.getInstance().battleMap.isoToCell(_loc_2.x, _loc_2.y);
                                _loc_4 = BattleModule.getInstance().battleData.getObjectCell(_loc_3);
                                if (_loc_4 is Wall)
                                {
                                    Wall(_loc_4).effectHideWall();
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                }
            }
            if (this.curWall)
            {
                this.countWallHide--;
                if (this.countWallHide <= 0)
                {
                    this.curWall.onCompleteTween();
                    this.curWall = null;
                }
            }
            if (this.avatar.anSetting.currDir != this.move.dir)
            {
                this.avatar.anSetting.currDir = this.move.dir;
            }
            if (this.move.status == AnConst.STAND)
            {
                if (this.avatar.anSetting.currAction != AnConst.ATTACK)
                {
                    if (this.typeHouse != BuildingType.TOWN_HALL)
                    {
                        _loc_10 = MapMgr.getInstance().battleMap.getDirToCell(this.move.curCell, this.cellCenter);
                    }
                    else
                    {
                        _loc_10 = 5;
                    }
                    this.move.dir = _loc_10;
                    this.setAction(AnConst.ATTACK, _loc_10);
                }
            }
            if (this.avatar.anSetting.currAction != AnConst.ATTACK)
            {
                return;
            }
            this.countIdle--;
            if (this.countIdle <= 0)
            {
                if (this.numHouse >= COUNT_HOUSE)
                {
                    CityMgr.getInstance().removeFarmer(this.idFarmer);
                }
                else
                {
                    this.countIdle = COUNT_DOWN_IDLE;
                    this.autoRunAway();
                }
            }
            return;
        }// end function

    }
}
