package modules.city.logic
{
    import __AS3__.vec.*;
    import component.avatar.model.animation.*;
    import component.avatar.things.*;
    import flash.geom.*;
    import gameData.*;
    import map.*;
    import map.logic.*;
    import modules.battle.logic.bean.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class Builder extends Object
    {
        public var countIdle:int = 0;
        public var avatar:Avatar;
        public var isoBuilding:Vector2D;
        public var move:BaseMoving;
        public var idAmryCamp:int;
        private var typeRun:int = 0;
        private var moveSpeed:int = 100;
        public var builderHurtIndex:int;
        public var buildingAutoId:int;
        public var widthObj:int;
        public var heightObj:int;
        public var cellCenter:int = 0;
        public var returnHome:Boolean = false;
        public var curCellCity:int;
        public static const COUNT_DOWN_IDLE:int = 120;
        public static const COUNT_WALL_HIDE:int = 20;

        public function Builder()
        {
            this.isoBuilding = new Vector2D();
            this.move = new BaseMoving();
            return;
        }// end function

        public function updateBuilding(param1:MapObject) : void
        {
            this.buildingAutoId = param1.autoId;
            this.widthObj = param1.width * 3;
            this.heightObj = param1.height * 3;
            this.updateCellBuilding(param1.posX, param1.posY);
            this.autoRunAway();
            this.returnHome = false;
            return;
        }// end function

        public function returnBuildingHurt() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().builderHutList[this.builderHurtIndex];
            this.updateBuilding(_loc_1);
            this.autoRunAway();
            this.returnHome = true;
            return;
        }// end function

        public function setInfo(param1:int, param2:MapObject) : void
        {
            this.builderHurtIndex = param1;
            this.buildingAutoId = param2.autoId;
            this.widthObj = param2.width * 3;
            this.heightObj = param2.height * 3;
            this.create(AnCategory.AVATAR, "BD_1", 1);
            this.updateCellBuilding(param2.posX, param2.posY);
            return;
        }// end function

        public function create(param1:String, param2:String, param3:int) : void
        {
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
            return;
        }// end function

        public function updateCellBuilding(param1:int, param2:int, param3:int = 0) : void
        {
            this.typeRun = param3;
            this.isoBuilding.x = param1 * 3;
            this.isoBuilding.y = param2 * 3;
            this.cellCenter = MapMgr.getInstance().battleMap.isoToCell(this.isoBuilding.x + this.widthObj / 2, this.isoBuilding.y + this.heightObj / 2);
            if (param3 == 1)
            {
                this.autoRunAway();
            }
            return;
        }// end function

        private function autoRunAway() : void
        {
            var _loc_1:* = this.randomCell();
            var _loc_2:* = new Vector.<int>;
            _loc_2 = MapMgr.getInstance().battleMap.pathTo(this.move.curCell, MapMgr.getInstance().battleMap.isoToCell(_loc_1.x, _loc_1.y), 2, false, false);
            if (this.typeRun == 0)
            {
                this.move.moveTo(_loc_2, this.moveSpeed);
            }
            else
            {
                this.typeRun = 0;
                this.move.moveTo(_loc_2, this.moveSpeed * 1);
            }
            this.setAction(AnConst.RUN, this.move.dir);
            return;
        }// end function

        public function randomCell() : Point
        {
            var _loc_4:int = 0;
            var _loc_1:* = new Point();
            var _loc_2:* = Utility.randomNumber(0, this.widthObj);
            var _loc_3:* = Utility.randomNumber(0, this.heightObj);
            if (_loc_2 >= 1 && _loc_2 <= this.widthObj - 2)
            {
                _loc_4 = Utility.randomNumber(0, 1);
                _loc_2 = _loc_4 == 0 ? (0) : ((this.heightObj - 1));
            }
            _loc_1.x = this.isoBuilding.x + _loc_2;
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
                    {
                        this.avatar.updatefrs(2);
                        break;
                    }
                    case AnConst.ATTACK:
                    {
                        this.avatar.updatefrs(3);
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
                if (this.avatar.anSetting.currAction != AnConst.ATTACK)
                {
                    _loc_1 = MapMgr.getInstance().battleMap.getDirToCell(this.move.curCell, this.cellCenter);
                    this.move.dir = _loc_1;
                    this.setAction(AnConst.ATTACK, _loc_1);
                }
            }
            if (this.avatar.anSetting.currAction != AnConst.ATTACK)
            {
                return;
            }
            var _loc_2:String = this;
            var _loc_3:* = this.countIdle - 1;
            _loc_2.countIdle = _loc_3;
            if (this.returnHome)
            {
                CityMgr.getInstance().removeBuilder(this.builderHurtIndex);
                return;
            }
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

    }
}
