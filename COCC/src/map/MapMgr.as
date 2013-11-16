package map
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import component.*;
    import component.avatar.model.animation.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import gameData.*;
    import map.logic.*;
    import modules.*;
    import modules.battle.*;
    import modules.battle.logic.*;
    import modules.battle.logic.bean.*;
    import modules.city.*;
    import modules.city.graphics.tutorial.*;
    import modules.city.logic.*;
    import resMgr.*;
    import utility.*;

    public class MapMgr extends Object
    {
        public var cityMap:CityMap;
        public var battleMap:BattleMap;
        public var rangeMap:RangeMap;
        public var curMap:BaseMap;
        public var scaleLevel:Number = 0.5;
        public var zoomPosInMap:Point;
        private var zoomPosInStage:Point;
        private var saveFnCallBack:Function;
        private var bgTut:Sprite = null;
        public static const UN_SET_BUILDING:String = "unSetBuilding";
        private static var instance:MapMgr;
        public static var CHANGE_SCALE:Number = 0.1;
        public static const MAP_LOOP:String = "mapLoop";
        public static var curScale:Number;
        public static var acceleration:Number = 1;

        public function MapMgr()
        {
            return;
        }// end function

        public function init() : void
        {
            ModuleMgr.getInstance().regFunction(MAP_LOOP, this.loop);
            ModuleMgr.getInstance().regFunction(UN_SET_BUILDING, this.unSetBuilding);
            this.cityMap = new CityMap();
            this.battleMap = new BattleMap();
            this.rangeMap = new RangeMap();
            this.loadDataMap(null);
            return;
        }// end function

        public function loadDataMap(param1:Vector.<int>) : void
        {
            this.cityMap.loadMapData(param1);
            this.battleMap.loadMapData(param1);
            this.rangeMap.loadMapData(param1);
            return;
        }// end function

        public function initCity() : void
        {
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
            curScale = _loc_1.scaleX;
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
            this.cityMap.setInfo(_loc_2, "CityMap", 0, 0);
            this.curMap = this.cityMap;
            this.resetMapPos();
            this.battleMap.setInfo(_loc_2, "SingleMap", 0, 0);
            this.showCityMap();
            return;
        }// end function

        public function showCityMap() : void
        {
            this.cityMap.img.visible = true;
            this.battleMap.img.visible = false;
            this.curMap = this.cityMap;
            return;
        }// end function

        public function showSingleMap() : void
        {
            this.battleMap.img.visible = true;
            this.cityMap.img.visible = false;
            this.curMap = this.battleMap;
            return;
        }// end function

        public function zoomInMap(param1:Boolean = false) : void
        {
            var _loc_2:Layer = null;
            var _loc_3:int = 0;
            if (TutorialMgr.getInstance().isTutorial && TutorialMgr.getInstance().curStep != 11)
            {
                return;
            }
            if (this.scaleLevel < GlobalVar.MAX_SCALE)
            {
                _loc_2 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
                _loc_3 = this.scaleLevel * 100;
                _loc_3 = _loc_3 + Math.floor(CHANGE_SCALE * 100);
                this.scaleLevel = _loc_3 / 100;
                if (this.scaleLevel > GlobalVar.MAX_SCALE)
                {
                    this.scaleLevel = GlobalVar.MAX_SCALE;
                }
                if (!param1)
                {
                    this.zoomPosInMap = this.curMap.img.globalToLocal(MouseMgr.getInstance().mousePos);
                }
                else
                {
                    this.zoomPosInMap = this.curMap.img.globalToLocal(new Point(GlobalVar.SCREEN_WIDTH / 2, GlobalVar.SCREEN_HEIGHT / 2));
                }
                this.zoomPosInStage = this.curMap.img.localToGlobal(this.zoomPosInMap);
            }
            return;
        }// end function

        public function zoomOutMap(param1:Boolean = false) : void
        {
            var _loc_2:Layer = null;
            var _loc_3:int = 0;
            if (TutorialMgr.getInstance().isTutorial)
            {
                return;
            }
            if (this.scaleLevel > GlobalVar.MIN_SCALE)
            {
                _loc_2 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
                _loc_3 = this.scaleLevel * 100;
                _loc_3 = _loc_3 - Math.floor(CHANGE_SCALE * 100);
                if (GlobalVar.MAP_WIDTH * _loc_3 / 100 < GlobalVar.SCREEN_WIDTH)
                {
                    return;
                }
                this.scaleLevel = _loc_3 / 100;
                if (this.scaleLevel < GlobalVar.MIN_SCALE)
                {
                    this.scaleLevel = GlobalVar.MIN_SCALE;
                }
                if (!param1)
                {
                    this.zoomPosInMap = this.curMap.img.globalToLocal(MouseMgr.getInstance().mousePos);
                }
                else
                {
                    this.zoomPosInMap = this.curMap.img.globalToLocal(new Point(GlobalVar.SCREEN_WIDTH / 2, GlobalVar.SCREEN_HEIGHT / 2));
                }
                this.zoomPosInStage = this.curMap.img.localToGlobal(this.zoomPosInMap);
            }
            return;
        }// end function

        private function loop() : void
        {
            var _loc_1:Layer = null;
            var _loc_2:Number = NaN;
            var _loc_3:Point = null;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            if (this.curMap && curScale != this.scaleLevel)
            {
                _loc_1 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
                _loc_2 = Math.floor(this.scaleLevel * 10000) - Math.floor(curScale * 10000);
                if (_loc_2 == 0)
                {
                    curScale = this.scaleLevel;
                }
                curScale = curScale + _loc_2 / 30000;
                var _loc_6:* = curScale;
                _loc_1.scaleY = curScale;
                _loc_1.scaleX = _loc_6;
                _loc_3 = this.curMap.img.localToGlobal(this.zoomPosInMap);
                _loc_4 = this.zoomPosInStage.x - this.curMap.img.localToGlobal(this.zoomPosInMap).x;
                _loc_5 = this.zoomPosInStage.y - this.curMap.img.localToGlobal(this.zoomPosInMap).y;
                this.panMap(_loc_4, _loc_5, true);
            }
            if (this.rangeMap && GlobalVar.state == GlobalVar.STATE_MYHOME)
            {
                this.rangeMap.loop();
            }
            return;
        }// end function

        public function panMap(param1:Number, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
            var _loc_5:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE).x + param1;
            var _loc_6:* = _loc_4.y + param2;
            this.setMapPos(_loc_5, _loc_6);
            return;
        }// end function

        public function resetMapPos() : void
        {
            var _loc_1:* = (-(GlobalVar.MAP_WIDTH * curScale - GlobalVar.SCREEN_WIDTH)) / 2;
            var _loc_2:* = (-(GlobalVar.MAP_HEIGHT * curScale - GlobalVar.SCREEN_HEIGHT)) / 2;
            this.setMapPos(_loc_1, _loc_2);
            return;
        }// end function

        public function getMapPos() : Point
        {
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
            var _loc_2:* = new Point();
            _loc_2.x = _loc_1.x;
            _loc_2.y = _loc_1.y;
            return _loc_2;
        }// end function

        public function getBound() : Rectangle
        {
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
            var _loc_2:* = new Rectangle(GlobalVar.SCREEN_WIDTH - _loc_1.width, GlobalVar.SCREEN_HEIGHT - _loc_1.height, _loc_1.width - GlobalVar.SCREEN_WIDTH, _loc_1.height - GlobalVar.SCREEN_HEIGHT);
            return _loc_2;
        }// end function

        public function setMapPos(param1:Number, param2:Number) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            if (param1 > _loc_3)
            {
                param1 = _loc_3;
            }
            if (param2 > _loc_4)
            {
                param2 = _loc_4;
            }
            if (param1 < (-GlobalVar.MAP_WIDTH) * curScale + GlobalVar.SCREEN_WIDTH)
            {
                param1 = (-GlobalVar.MAP_WIDTH) * curScale + GlobalVar.SCREEN_WIDTH;
            }
            if (param2 < (-GlobalVar.MAP_HEIGHT) * curScale + GlobalVar.SCREEN_HEIGHT)
            {
                param2 = (-GlobalVar.MAP_HEIGHT) * curScale + GlobalVar.SCREEN_HEIGHT;
            }
            var _loc_5:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
            LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE).x = param1;
            _loc_5.y = param2;
            return;
        }// end function

        public function enableCityGridView() : void
        {
            var _loc_6:Point = null;
            var _loc_7:Point = null;
            var _loc_8:Point = null;
            var _loc_9:Point = null;
            var _loc_10:int = 0;
            var _loc_11:TextField = null;
            var _loc_12:Point = null;
            var _loc_1:* = new Shape();
            _loc_1.graphics.lineStyle(1, 16711680, 1);
            this.curMap.img.addChild(_loc_1);
            var _loc_2:* = new Point(0, 0);
            var _loc_3:int = 0;
            while (_loc_3 <= MapMgr.getInstance().cityMap.maxRow)
            {
                
                _loc_6 = MapMgr.getInstance().cityMap.isoToPoint(0, _loc_3);
                _loc_7 = MapMgr.getInstance().cityMap.isoToPoint(MapMgr.getInstance().cityMap.maxCol, _loc_3);
                _loc_1.graphics.moveTo(_loc_6.x - _loc_2.x, _loc_6.y - _loc_2.y);
                _loc_1.graphics.lineTo(_loc_7.x - _loc_2.x, _loc_7.y - _loc_2.y);
                _loc_3++;
            }
            var _loc_4:int = 0;
            while (_loc_4 <= MapMgr.getInstance().cityMap.maxCol)
            {
                
                _loc_8 = MapMgr.getInstance().cityMap.isoToPoint(_loc_4, 0);
                _loc_9 = MapMgr.getInstance().cityMap.isoToPoint(_loc_4, MapMgr.getInstance().cityMap.maxRow);
                _loc_1.graphics.moveTo(_loc_8.x - _loc_2.x, _loc_8.y - _loc_2.y);
                _loc_1.graphics.lineTo(_loc_9.x - _loc_2.x, _loc_9.y - _loc_2.y);
                _loc_4++;
            }
            var _loc_5:int = 0;
            while (_loc_5 < this.cityMap.maxRow)
            {
                
                _loc_10 = 0;
                while (_loc_10 < this.cityMap.maxRow)
                {
                    
                    _loc_11 = new TextField();
                    _loc_11.mouseEnabled = false;
                    if (this.rangeMap.areaMap.getNode(_loc_5, _loc_10).deepLv > 0)
                    {
                        _loc_11.text = this.rangeMap.areaMap.getNode(_loc_5, _loc_10).deepLv.toString();
                        _loc_12 = this.cityMap.isoToPoint(_loc_5, _loc_10);
                        _loc_11.x = _loc_12.x;
                        _loc_11.y = _loc_12.y + this.cityMap.MaxHalfHeight / 2;
                        this.curMap.img.addChild(_loc_11);
                    }
                    _loc_10++;
                }
                _loc_5++;
            }
            return;
        }// end function

        public function drawCell(param1:BaseMap, param2:int, param3:int) : void
        {
            var _loc_4:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
            this.bgTut = ResMgr.getInstance().getMovieClip("GREEN_" + param3);
            if (param1 == this.battleMap)
            {
                var _loc_6:Number = 0.333333;
                this.bgTut.scaleY = 0.333333;
                this.bgTut.scaleX = _loc_6;
            }
            _loc_4.addChild(this.bgTut);
            var _loc_5:* = param1.cellToPoint(param2);
            this.bgTut.x = _loc_5.x - this.bgTut.width / 2;
            this.bgTut.y = _loc_5.y;
            return;
        }// end function

        public function removeDrawCell() : void
        {
            if (this.bgTut && this.bgTut.parent)
            {
                this.bgTut.parent.removeChild(this.bgTut);
                this.bgTut = null;
            }
            return;
        }// end function

        public function enableBattleGridView() : void
        {
            var _loc_5:Point = null;
            var _loc_6:Point = null;
            var _loc_7:Point = null;
            var _loc_8:Point = null;
            var _loc_9:int = 0;
            var _loc_10:TextField = null;
            var _loc_11:Point = null;
            var _loc_1:* = new Shape();
            _loc_1.graphics.lineStyle(1, 8421504, 1);
            this.curMap.img.addChild(_loc_1);
            var _loc_2:int = 0;
            while (_loc_2 <= this.battleMap.maxRow)
            {
                
                _loc_5 = this.battleMap.isoToPoint(0, _loc_2);
                _loc_6 = this.battleMap.isoToPoint(this.battleMap.maxCol, _loc_2);
                _loc_1.graphics.moveTo(_loc_5.x, _loc_5.y);
                _loc_1.graphics.lineTo(_loc_6.x, _loc_6.y);
                _loc_2++;
            }
            var _loc_3:int = 0;
            while (_loc_3 <= this.battleMap.maxCol)
            {
                
                _loc_7 = this.battleMap.isoToPoint(_loc_3, 0);
                _loc_8 = this.battleMap.isoToPoint(_loc_3, this.battleMap.maxRow);
                _loc_1.graphics.moveTo(_loc_7.x, _loc_7.y);
                _loc_1.graphics.lineTo(_loc_8.x, _loc_8.y);
                _loc_3++;
            }
            var _loc_4:int = 0;
            while (_loc_4 < this.battleMap.maxRow)
            {
                
                _loc_9 = 0;
                while (_loc_9 < this.battleMap.maxRow)
                {
                    
                    _loc_10 = new TextField();
                    _loc_10.mouseEnabled = false;
                    _loc_10.text = this.battleMap.areaMap.getNode(_loc_4, _loc_9).idNode.toString();
                    _loc_11 = this.battleMap.isoToPoint(_loc_4, _loc_9);
                    _loc_10.x = _loc_11.x;
                    _loc_10.y = _loc_11.y + this.battleMap.MaxHalfHeight / 2;
                    this.curMap.img.addChild(_loc_10);
                    _loc_9++;
                }
                _loc_4++;
            }
            return;
        }// end function

        public function visibleBattleGridView() : void
        {
            this.curMap.img.removeChildren();
            return;
        }// end function

        public function addNewBuilding(param1:MapObject, param2:Boolean = false) : void
        {
            var _loc_3:* = copyMapObject(param1);
            if (!_loc_3)
            {
                return;
            }
            GameDataMgr.getInstance().updateList(_loc_3);
            _loc_3.addToCity(param2);
            this.updateMapLogic(_loc_3);
            this.updateWall(_loc_3);
            GameDataMgr.getInstance().tempObject = null;
            return;
        }// end function

        public function moveBuilding(param1:MapObject, param2:Boolean, param3:Boolean) : void
        {
            param1.setPos(param1.posX, param1.posY);
            param1.makePoints();
            if (!param2)
            {
                param1.showSelected();
            }
            this.updateMapLogic(param1);
            this.updateWall(param1);
            this.updateAroundOldWall();
            switch(param1.type)
            {
                case BuildingType.ARMY_CAMP:
                {
                    CityMgr.getInstance().updateIsoAmryCamp(param1.posX, param1.posY, param1.autoId);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1.status == MapObject.BUILDING || param1.status == MapObject.UPGRADING)
            {
                CityMgr.getInstance().updateIsoBuilder(param1.posX, param1.posY, param1.autoId);
            }
            GameDataMgr.getInstance().curObject = null;
            if (param3)
            {
                param1.playEffectDropHouse();
            }
            CityMgr.getInstance().renderObj(true);
            return;
        }// end function

        private function updateAroundOldWall() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().saveObjPosX;
            var _loc_2:* = GameDataMgr.getInstance().saveObjPosY;
            var _loc_3:* = this.getWallObject(_loc_1, (_loc_2 + 1));
            if (_loc_3)
            {
                _loc_3.updateStatus();
            }
            var _loc_4:* = this.getWallObject((_loc_1 + 1), _loc_2);
            if (this.getWallObject((_loc_1 + 1), _loc_2))
            {
                _loc_4.updateStatus();
            }
            return;
        }// end function

        public function updateMapLogic(param1:MapObject, param2:int = -1) : void
        {
            var _loc_4:int = 0;
            var _loc_3:* = Utility.getTypeObject(param1.type);
            switch(_loc_3)
            {
                case BuildingType.WAL:
                {
                    _loc_4 = BaseMap.IS_WALL;
                    break;
                }
                case BuildingType.OBS:
                {
                    _loc_4 = BaseMap.OBSTACLE;
                    break;
                }
                default:
                {
                    _loc_4 = BaseMap.IS_HOUSE;
                    break;
                    break;
                }
            }
            this.cityMap.setBuilding(param1.posX, param1.posY, param1.width, param1.height, _loc_4, param2);
            if (_loc_3 == BuildingType.TRA)
            {
                return;
            }
            param1.isUnset = false;
            if (Utility.getTypeObject(param1.type) != BuildingType.OBS)
            {
                this.rangeMap.setBuilding(param1.posX, param1.posY, param1.width, param1.height, BaseMap.CAN_MOVE, param1.type, param2);
            }
            var _loc_5:* = param1.type == BuildingType.WALL ? (BaseMap.IS_WALL) : (BaseMap.CANT_MOVE);
            switch(_loc_3)
            {
                case BuildingType.WAL:
                {
                    this.battleMap.setWall(param1.posX * 3, param1.posY * 3, param1.width * 3, param1.height * 3, _loc_5, param2);
                    break;
                }
                case BuildingType.AMC:
                {
                    if (GlobalVar.state != GlobalVar.STATE_BATTLE && GlobalVar.state != GlobalVar.STATE_SINGLE_MAP && GlobalVar.state != GlobalVar.STATE_REPLAY)
                    {
                        this.battleMap.setBuilding(param1.posX * 3, param1.posY * 3, param1.width * 3, param1.height * 3, _loc_5, 5, param2);
                    }
                    else
                    {
                        this.battleMap.setBuilding(param1.posX * 3, param1.posY * 3, param1.width * 3, param1.height * 3, _loc_5, 1, param2);
                    }
                    break;
                }
                case BuildingType.OBS:
                {
                    this.battleMap.setBuilding(param1.posX * 3, param1.posY * 3, param1.width * 3, param1.height * 3, _loc_5, 1, param2, 0);
                    break;
                }
                default:
                {
                    this.battleMap.setBuilding(param1.posX * 3, param1.posY * 3, param1.width * 3, param1.height * 3, _loc_5, 1, param2);
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function updateWall(param1:MapObject) : void
        {
            var _loc_2:WallObject = null;
            if (param1.type == BuildingType.WALL)
            {
                _loc_2 = param1 as WallObject;
                this.updateAroundWall(_loc_2);
            }
            return;
        }// end function

        public function unSetBuilding(param1:MapObject) : void
        {
            this.cityMap.setBuilding(param1.posX, param1.posY, param1.width, param1.height, BaseMap.CAN_BUILD);
            this.battleMap.setBuilding(param1.posX * 3, param1.posY * 3, param1.width * 3, param1.height * 3, BaseMap.CAN_MOVE, 1);
            param1.isUnset = true;
            if (Utility.getTypeObject(param1.type) != BuildingType.OBS)
            {
                this.rangeMap.setBuilding(param1.posX, param1.posY, param1.width, param1.height, -1, param1.type, -1, true, true);
                this.rangeMap.hideViewRange();
            }
            return;
        }// end function

        public function updateAroundWall(param1:WallObject) : void
        {
            param1.updateStatus();
            var _loc_2:* = this.getWallObject(param1.posX, (param1.posY + 1));
            if (_loc_2)
            {
                _loc_2.updateStatus();
            }
            var _loc_3:* = this.getWallObject((param1.posX + 1), param1.posY);
            if (_loc_3)
            {
                _loc_3.updateStatus();
            }
            return;
        }// end function

        public function getWallObject(param1:int, param2:int) : WallObject
        {
            var _loc_4:WallObject = null;
            var _loc_3:int = 0;
            while (_loc_3 < GameDataMgr.getInstance().wallList.length)
            {
                
                _loc_4 = GameDataMgr.getInstance().wallList[_loc_3];
                if (_loc_4.type == BuildingType.WALL && param1 == _loc_4.posX && param2 == _loc_4.posY)
                {
                    return _loc_4;
                }
                _loc_3++;
            }
            return null;
        }// end function

        public function clearMap() : void
        {
            this.battleMap.clearMap();
            this.cityMap.clearMap();
            this.rangeMap.clearMap();
            return;
        }// end function

        public function findWallNearest(param1:DataObject, param2:int = -1) : DataObject
        {
            var _loc_8:DataObject = null;
            var _loc_9:Point = null;
            var _loc_10:Point = null;
            var _loc_11:Number = NaN;
            var _loc_3:* = BattleModule.getInstance().battleData.objList;
            var _loc_4:* = Number.MAX_VALUE;
            var _loc_5:DataObject = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            while (_loc_7 < _loc_3.length)
            {
                
                _loc_6 = 0;
                _loc_8 = _loc_3[_loc_7];
                if (!this.checkCanAttack(param1, _loc_8, param2))
                {
                }
                else
                {
                    if (param1.team == 1)
                    {
                        if (!(_loc_8 is Wall))
                        {
                        }
                    }
                    else if (!(_loc_8 is DataTroop))
                    {
                    }
                    if (_loc_8.team == param1.team)
                    {
                    }
                    else
                    {
                        _loc_9 = this.battleMap.cellToPoint(_loc_8.getCurCell());
                        _loc_10 = this.battleMap.cellToPoint(param1.getCurCell());
                        _loc_11 = (_loc_10.x - _loc_9.x) * (_loc_10.x - _loc_9.x) + (_loc_10.y - _loc_9.y) * (_loc_10.y - _loc_9.y);
                        if (_loc_8 is Wall)
                        {
                            _loc_11 = _loc_11 + Wall(_loc_8).pFavorite * BaseInfo.WIDTH_CELL * BaseInfo.WIDTH_CELL;
                        }
                        if (_loc_11 < _loc_4)
                        {
                            _loc_4 = _loc_11;
                            _loc_5 = _loc_8;
                        }
                    }
                }
                _loc_7++;
            }
            return _loc_5;
        }// end function

        public function findNearestTarget(param1:DataObject, param2:int = -1, param3:Boolean = false) : DataObject
        {
            var _loc_9:DataObject = null;
            var _loc_10:Point = null;
            var _loc_11:Point = null;
            var _loc_12:Number = NaN;
            var _loc_4:* = BattleModule.getInstance().battleData.objList;
            var _loc_5:* = Number.MAX_VALUE;
            var _loc_6:DataObject = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            while (_loc_8 < _loc_4.length)
            {
                
                _loc_7 = 0;
                _loc_9 = _loc_4[_loc_8];
                if (!this.checkCanAttack(param1, _loc_9, param2))
                {
                }
                else
                {
                    if (!param3)
                    {
                        if (_loc_9.team == param1.team)
                        {
                        }
                    }
                    else
                    {
                        if (_loc_9.team != param1.team)
                        {
                        }
                        if (_loc_9.baseInfo.curHp != _loc_9.baseInfo.maxHp)
                        {
                            _loc_7 = 1000000;
                        }
                    }
                    _loc_10 = this.battleMap.cellToPoint(_loc_9.getCurCell());
                    _loc_11 = this.battleMap.cellToPoint(param1.getCurCell());
                    _loc_12 = (_loc_11.x - _loc_10.x) * (_loc_11.x - _loc_10.x) + (_loc_11.y - _loc_10.y) * (_loc_11.y - _loc_10.y);
                    if (param2 >= 0)
                    {
                        if (_loc_9.objectType == param2)
                        {
                            _loc_12 = _loc_12 - BaseMap.BONUS_FAVORITE;
                        }
                    }
                    if (param3)
                    {
                        _loc_12 = _loc_12 - _loc_7;
                    }
                    if (_loc_12 < _loc_5)
                    {
                        _loc_5 = _loc_12;
                        _loc_6 = _loc_9;
                    }
                }
                _loc_8++;
            }
            return _loc_6;
        }// end function

        private function checkCanAttack(param1:DataObject, param2:DataObject, param3:int) : Boolean
        {
            if (param2.objectStatus == AnConst.DIE || param2.objectType == DataObject.OBJTYPE_WALL && param3 != param2.objectType || param2.objectType == DataObject.OBJTYPE_TRAP || param2.objectType == DataObject.OBJTYPE_BULLET || param2.objectType == DataObject.OBJTYPE_OBSTACLE || !param1.checkTargetArea(param2.objectArea))
            {
                return false;
            }
            if (param2 is HouseClan)
            {
                if (HouseClan(param2).mapObject.status == 2)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public function findNearestTargetInRange(param1:DataObject, param2:int = -1) : DataObject
        {
            var _loc_9:DataObject = null;
            var _loc_10:Point = null;
            var _loc_11:Point = null;
            var _loc_12:Number = NaN;
            var _loc_3:* = BattleModule.getInstance().battleData.objList;
            var _loc_4:* = Number.MAX_VALUE;
            var _loc_5:DataObject = null;
            var _loc_6:* = param1.baseInfo.attackRange * param1.baseInfo.attackRange;
            var _loc_7:* = param1.baseInfo.minAttackRange * param1.baseInfo.minAttackRange;
            var _loc_8:int = 0;
            while (_loc_8 < _loc_3.length)
            {
                
                _loc_9 = _loc_3[_loc_8];
                if (!this.checkCanAttack(param1, _loc_9, param2))
                {
                }
                else if (_loc_9.team == param1.team)
                {
                }
                else
                {
                    _loc_10 = this.battleMap.cellToPoint(_loc_9.getCurCell());
                    _loc_11 = new Point(param1.move.x, param1.move.y);
                    _loc_12 = (_loc_11.x - _loc_10.x) * (_loc_11.x - _loc_10.x) + (_loc_11.y - _loc_10.y) * (_loc_11.y - _loc_10.y) * 1.77;
                    if (_loc_12 > _loc_6 || _loc_7 > 0 && _loc_12 < _loc_7)
                    {
                    }
                    else
                    {
                        if (param2 >= 0)
                        {
                            if (_loc_9.objectType == param2)
                            {
                                _loc_12 = _loc_12 - BaseMap.BONUS_FAVORITE;
                            }
                        }
                        if (_loc_12 < _loc_4)
                        {
                            _loc_4 = _loc_12;
                            _loc_5 = _loc_9;
                        }
                    }
                }
                _loc_8++;
            }
            return _loc_5;
        }// end function

        public function getObjectInAreaByType(param1:DataObject, param2:Point, param3:Number, param4:int, param5:int, param6:Boolean = false) : Vector.<DataObject>
        {
            var _loc_10:DataObject = null;
            var _loc_11:Point = null;
            var _loc_12:Number = NaN;
            var _loc_7:* = new Vector.<DataObject>;
            var _loc_8:* = BattleModule.getInstance().battleData.objList;
            var _loc_9:int = 0;
            while (_loc_9 < _loc_8.length)
            {
                
                _loc_10 = _loc_8[_loc_9];
                if (!param6)
                {
                    if (_loc_10.team == param1.team)
                    {
                    }
                }
                else if (_loc_10.team != param1.team)
                {
                }
                if (_loc_10.objectStatus == AnConst.DIE || _loc_10.objectType != param4 && param4 > 0 || !param1.checkTargetArea(_loc_10.objectArea))
                {
                }
                else
                {
                    _loc_11 = new Point(_loc_10.move.x, _loc_10.move.y);
                    _loc_12 = (param2.x - _loc_11.x) * (param2.x - _loc_11.x) + (param2.y - _loc_11.y) * (param2.y - _loc_11.y);
                    if (_loc_12 <= param3 * param3)
                    {
                        _loc_7.push(_loc_10);
                    }
                }
                _loc_9++;
            }
            return _loc_7;
        }// end function

        public function convertCellBattleToCellCity(param1:int) : int
        {
            var _loc_2:int = 0;
            var _loc_3:* = this.battleMap.cellToIso(param1);
            return this.cityMap.isoToCell(_loc_3.x / 3, _loc_3.y / 3);
        }// end function

        public function onMouseWheel(event:MouseEvent) : void
        {
            if (event.delta > 0)
            {
                this.zoomInMap();
            }
            else
            {
                this.zoomOutMap();
            }
            return;
        }// end function

        public function addLabelToIso(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = new TextField();
            new TextField().mouseEnabled = false;
            _loc_4.text = param3.toString();
            var _loc_5:* = this.rangeMap.isoToPoint(param1, param2);
            _loc_4.x = _loc_5.x;
            _loc_4.y = _loc_5.y + this.rangeMap.MaxHalfHeight / 2;
            this.curMap.img.addChild(_loc_4);
            return;
        }// end function

        public function dragMap(param1:Boolean) : void
        {
            if (TutorialMgr.getInstance().isTutorial)
            {
                return;
            }
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
            _loc_2.startDrag(false, MapMgr.getInstance().getBound());
            GameInput.getInstance().isMouseDrag = param1;
            return;
        }// end function

        public function movingMap(param1:Point, param2:Number, param3:Function = null) : void
        {
            this.saveFnCallBack = param3;
            TweenLite.to(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE), param2, {x:param1.x, y:param1.y, onComplete:this.movingDone});
            return;
        }// end function

        private function movingDone() : void
        {
            if (this.saveFnCallBack != null)
            {
                this.saveFnCallBack.apply();
            }
            MouseMgr.getInstance().update();
            return;
        }// end function

        public function focusObject(param1:int, param2:int, param3:Number, param4:Function = null, param5:Boolean = false) : void
        {
            this.saveFnCallBack = param4;
            var _loc_6:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
            if (param5)
            {
                _loc_6.scaleX = GlobalVar.INIT_SCALE + CHANGE_SCALE * 2;
                _loc_6.scaleY = GlobalVar.INIT_SCALE + CHANGE_SCALE * 2;
            }
            var _loc_7:* = this.cityMap.isoToPoint(param1, param2);
            var _loc_8:* = _loc_6.localToGlobal(_loc_7);
            var _loc_9:* = GlobalVar.SCREEN_WIDTH / 2 - _loc_8.x;
            var _loc_10:* = GlobalVar.SCREEN_HEIGHT / 2 - _loc_8.y;
            var _loc_11:* = this.getMapPos();
            if (param5)
            {
                _loc_6.scaleX = GlobalVar.INIT_SCALE;
                _loc_6.scaleY = GlobalVar.INIT_SCALE;
                TweenLite.to(_loc_6, param3, {x:_loc_11.x + _loc_9, y:_loc_11.y + _loc_10, scaleX:GlobalVar.INIT_SCALE + CHANGE_SCALE * 2, scaleY:GlobalVar.INIT_SCALE + CHANGE_SCALE * 2, onComplete:this.movingAndScaleDone});
            }
            else
            {
                TweenLite.to(_loc_6, param3, {x:_loc_11.x + _loc_9, y:_loc_11.y + _loc_10, onComplete:this.movingDone});
            }
            return;
        }// end function

        private function movingAndScaleDone() : void
        {
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
            TweenLite.to(_loc_1, 0.5, {onComplete:this.movingDone});
            return;
        }// end function

        public function traceMap(param1:int) : void
        {
            var _loc_2:BaseMap = null;
            var _loc_5:int = 0;
            switch(param1)
            {
                case 1:
                {
                    _loc_2 = this.cityMap;
                    break;
                }
                case 2:
                {
                    _loc_2 = this.rangeMap;
                    break;
                }
                case 3:
                {
                    _loc_2 = this.battleMap;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_3:String = "";
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2.areaMap.maxRow)
            {
                
                _loc_5 = 0;
                while (_loc_5 < _loc_2.areaMap.maxCol)
                {
                    
                    _loc_3 = _loc_3 + ("(" + _loc_2.areaMap.getNode(_loc_4, _loc_5).deepLv + "," + _loc_2.areaMap.getNode(_loc_4, _loc_5).idNode + ")");
                    _loc_5++;
                }
                _loc_3 = _loc_3 + "\n";
                _loc_4++;
            }
            return;
        }// end function

        public static function getInstance() : MapMgr
        {
            if (instance == null)
            {
                instance = new MapMgr;
            }
            return instance;
        }// end function

        public static function copyMapObject(param1:MapObject) : MapObject
        {
            var _loc_4:BarrackObject = null;
            var _loc_5:BarrackObject = null;
            var _loc_6:LaboratoryObject = null;
            var _loc_7:LaboratoryObject = null;
            var _loc_8:ClanObject = null;
            var _loc_9:ClanObject = null;
            var _loc_2:MapObject = null;
            var _loc_3:* = Utility.getTypeObject(param1.type);
            switch(_loc_3)
            {
                case BuildingType.AMC:
                {
                    _loc_2 = new ArmyCampObject();
                    break;
                }
                case BuildingType.WAL:
                {
                    _loc_2 = new WallObject();
                    break;
                }
                case BuildingType.TOW:
                {
                    _loc_2 = new TownHallObject();
                    break;
                }
                case BuildingType.BAR:
                {
                    _loc_4 = new BarrackObject();
                    _loc_5 = param1 as BarrackObject;
                    if (_loc_5)
                    {
                        _loc_4.trainingTroop = _loc_5.trainingTroop;
                        _loc_4.deltaPauseTime = _loc_5.deltaPauseTime;
                    }
                    _loc_2 = _loc_4;
                    break;
                }
                case BuildingType.RES:
                {
                    _loc_2 = new ResourceObject();
                    break;
                }
                case BuildingType.STO:
                {
                    _loc_2 = new StorageObject();
                    break;
                }
                case BuildingType.DEF:
                {
                    _loc_2 = new DefenseObject();
                    break;
                }
                case BuildingType.LAB:
                {
                    _loc_6 = new LaboratoryObject();
                    _loc_7 = param1 as LaboratoryObject;
                    if (_loc_7)
                    {
                        _loc_6.troopType = _loc_7.troopType;
                        _loc_6.researchList = _loc_7.researchList;
                        _loc_6.researchTime = _loc_7.researchTime;
                        _loc_6.deltaPauseTime = _loc_7.deltaPauseTime;
                    }
                    _loc_2 = _loc_6;
                    break;
                }
                case BuildingType.CAT:
                {
                    _loc_8 = new ClanObject();
                    _loc_9 = param1 as ClanObject;
                    if (_loc_9)
                    {
                        _loc_8.details = _loc_9.details;
                        _loc_8.title = _loc_9.title;
                        _loc_8.troopList = _loc_9.troopList;
                        _loc_8.lastRequestTime = _loc_9.lastRequestTime;
                    }
                    _loc_2 = _loc_8;
                    break;
                }
                case BuildingType.BH:
                {
                    _loc_2 = new BuilderObject();
                    break;
                }
                case BuildingType.OBS:
                {
                    _loc_2 = new ObstacleObject();
                    break;
                }
                case BuildingType.TRA:
                {
                    _loc_2 = new TrapObject();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2)
            {
                _loc_2.type = param1.type;
                _loc_2.posX = param1.posX;
                _loc_2.posY = param1.posY;
                _loc_2.level = param1.level;
                _loc_2.autoId = param1.autoId;
                _loc_2.startTime = param1.startTime;
                _loc_2.status = param1.status;
                _loc_2.isSelected = param1.isSelected;
                _loc_2.readyToMove = param1.readyToMove;
                _loc_2.isMouseOver = param1.isMouseOver;
                _loc_2.loadConfigData();
            }
            return _loc_2;
        }// end function

    }
}
