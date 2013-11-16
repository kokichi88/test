package modules.battle.logic
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import flash.display.*;
    import flash.geom.*;
    import gameData.*;
    import map.*;
    import map.logic.*;
    import modules.battle.*;
    import resMgr.*;

    public class Wall extends DataHouse
    {
        public var pFavorite:int = 0;
        private var typeDamage:Boolean = true;
        private static const BONUS_FAVORITE1:int = 10000;
        private static const BONUS_FAVORITE2:int = 15;

        public function Wall()
        {
            objectType = DataObject.OBJTYPE_WALL;
            return;
        }// end function

        override public function setInfo(param1:String, param2:int) : void
        {
            var _loc_3:int = 1;
            bgImage = ResMgr.getInstance().getMovieClip("GRASS_" + _loc_3) as Sprite;
            var _loc_4:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
            var _loc_5:* = MapMgr.getInstance().battleMap.isoToPoint(mapObject.posX * 3, mapObject.posY * 3);
            bgImage.x = _loc_5.x - MapMgr.getInstance().cityMap.MaxHalfWidth * _loc_3;
            bgImage.y = _loc_5.y - MapMgr.getInstance().battleMap.MaxHalfHeight;
            bgImageWidth = bgImage.width;
            bgImageHeight = bgImage.height;
            _loc_4.addChild(bgImage);
            baseInfo.maxHp = mapObject["info"]["hitpoints"];
            baseInfo.curHp = baseInfo.maxHp;
            BattleModule.getInstance().battleData.imageList.push(bgImage);
            return;
        }// end function

        public function updateDir(param1:int = 0) : void
        {
            var _loc_5:int = 0;
            var _loc_6:DataObject = null;
            var _loc_7:int = 0;
            var _loc_8:DataObject = null;
            var _loc_2:* = MapMgr.getInstance().battleMap.cellToIso(move.curCell);
            var _loc_3:* = _loc_2.x / 3;
            var _loc_4:* = _loc_2.y / 3;
            if (MapMgr.getInstance().cityMap.getIsoType(_loc_3, (_loc_4 - 1)) == BaseMap.IS_WALL && MapMgr.getInstance().cityMap.getIsoType((_loc_3 - 1), _loc_4) == BaseMap.IS_WALL)
            {
                avatar.setAction(AnConst.STAND, 8);
            }
            else if (MapMgr.getInstance().cityMap.getIsoType((_loc_3 - 1), _loc_4) == BaseMap.IS_WALL)
            {
                avatar.setAction(AnConst.STAND, 7);
            }
            else if (MapMgr.getInstance().cityMap.getIsoType(_loc_3, (_loc_4 - 1)) == BaseMap.IS_WALL)
            {
                avatar.setAction(AnConst.STAND, 6);
            }
            else
            {
                avatar.setAction(AnConst.STAND, 5);
            }
            if (param1 < 2)
            {
                this.updatePFavorite();
            }
            if (param1 == 0)
            {
                if (MapMgr.getInstance().cityMap.getIsoType(_loc_3, (_loc_4 + 1)) == BaseMap.IS_WALL)
                {
                    _loc_5 = MapMgr.getInstance().battleMap.isoToCell(_loc_3 * 3, (_loc_4 + 1) * 3);
                    _loc_6 = BattleModule.getInstance().battleData.getObjectCell(_loc_5);
                    if (_loc_6 && _loc_6.objectType == DataObject.OBJTYPE_WALL)
                    {
                        Wall(_loc_6).updateDir(1);
                    }
                }
                if (MapMgr.getInstance().cityMap.getIsoType((_loc_3 + 1), _loc_4) == BaseMap.IS_WALL)
                {
                    _loc_7 = MapMgr.getInstance().battleMap.isoToCell((_loc_3 + 1) * 3, _loc_4 * 3);
                    _loc_8 = BattleModule.getInstance().battleData.getObjectCell(_loc_7);
                    if (_loc_8 && _loc_8.objectType == DataObject.OBJTYPE_WALL)
                    {
                        Wall(_loc_8).updateDir(1);
                    }
                }
            }
            return;
        }// end function

        private function updatePFavorite() : void
        {
            var _loc_1:* = MapMgr.getInstance().battleMap.cellToIso(move.curCell);
            var _loc_2:* = _loc_1.x / 3;
            var _loc_3:* = _loc_1.y / 3;
            if (MapMgr.getInstance().cityMap.getIsoType(_loc_2, (_loc_3 - 1)) == BaseMap.IS_WALL && MapMgr.getInstance().cityMap.getIsoType((_loc_2 - 1), _loc_3) == BaseMap.IS_WALL)
            {
                this.pFavorite = 0;
            }
            else if (MapMgr.getInstance().cityMap.getIsoType((_loc_2 - 1), _loc_3) == BaseMap.IS_WALL)
            {
                this.pFavorite = BONUS_FAVORITE2;
            }
            else if (MapMgr.getInstance().cityMap.getIsoType(_loc_2, (_loc_3 - 1)) == BaseMap.IS_WALL)
            {
                this.pFavorite = BONUS_FAVORITE2;
            }
            else
            {
                this.pFavorite = BONUS_FAVORITE1;
            }
            return;
        }// end function

        override public function death() : void
        {
            var _loc_8:DataObject = null;
            var _loc_1:* = MapMgr.getInstance().battleMap.cellToIso(move.curCell);
            var _loc_2:* = _loc_1.x / 3;
            var _loc_3:* = _loc_1.y / 3;
            var _loc_4:int = 0;
            if (MapMgr.getInstance().cityMap.getIsoType(_loc_2, (_loc_3 - 1)) == BaseMap.IS_WALL && MapMgr.getInstance().cityMap.getIsoType(_loc_2, (_loc_3 + 1)) == BaseMap.IS_WALL)
            {
                if (MapMgr.getInstance().cityMap.getIsoType((_loc_2 - 1), _loc_3) != BaseMap.IS_WALL || MapMgr.getInstance().cityMap.getIsoType((_loc_2 + 1), _loc_3) != BaseMap.IS_WALL)
                {
                    _loc_4 = 1;
                }
            }
            if (MapMgr.getInstance().cityMap.getIsoType((_loc_2 - 1), _loc_3) == BaseMap.IS_WALL && MapMgr.getInstance().cityMap.getIsoType((_loc_2 + 1), _loc_3) == BaseMap.IS_WALL)
            {
                if (MapMgr.getInstance().cityMap.getIsoType(_loc_2, (_loc_3 - 1)) != BaseMap.IS_WALL || MapMgr.getInstance().cityMap.getIsoType(_loc_2, (_loc_3 + 1)) != BaseMap.IS_WALL)
                {
                    _loc_4 = 2;
                }
            }
            MapMgr.getInstance().battleMap.setWall(_loc_1.x, _loc_1.y, 3, 3, BaseMap.CAN_MOVE);
            MapMgr.getInstance().rangeMap.setBuilding(_loc_2, _loc_3, 1, 1, -1, BuildingType.WALL, -1, false);
            var _loc_5:* = BattleModule.getInstance().battleData.objList;
            if (this.typeDamage == false)
            {
                _loc_4 = -1;
            }
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                _loc_8 = _loc_5[_loc_6];
                if (_loc_8.objectType == OBJTYPE_TROOP)
                {
                    _loc_8.updateStatus(1);
                }
                if (_loc_8.objectType == OBJTYPE_WALL)
                {
                    Wall(_loc_8).updateFavorite(_loc_2, _loc_3, _loc_4);
                }
                _loc_6++;
            }
            setAction(AnConst.DIE, curDir);
            var _loc_7:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            EffectDraw.play("wall_break", new Point(avatar.x, avatar.y), _loc_7);
            super.death();
            MapMgr.getInstance().cityMap.setBuilding(_loc_2, _loc_3, 1, 1, BaseMap.CAN_MOVE);
            return;
        }// end function

        public function updateFavorite(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = MapMgr.getInstance().battleMap.cellToIso(move.curCell);
            var _loc_5:* = MapMgr.getInstance().battleMap.cellToIso(move.curCell).x / 3;
            var _loc_6:* = _loc_4.y / 3;
            var _loc_7:int = 10;
            if (_loc_5 == param1)
            {
                if (_loc_6 > param2 - _loc_7 && _loc_6 < param2 + _loc_7 && param3 != 2 && param3 >= 0)
                {
                    if (_loc_6 > param2 && MapMgr.getInstance().cityMap.getIsoType(_loc_5, (_loc_6 - 1)) == BaseMap.IS_WALL)
                    {
                        this.pFavorite = BONUS_FAVORITE1;
                    }
                    if (_loc_6 < param2 && MapMgr.getInstance().cityMap.getIsoType(_loc_5, (_loc_6 + 1)) == BaseMap.IS_WALL)
                    {
                        this.pFavorite = BONUS_FAVORITE1;
                    }
                }
                if (_loc_6 == (param2 + 1))
                {
                    if (avatar.anSetting.currDir == 8)
                    {
                        avatar.setAction(AnConst.STAND, 7);
                    }
                    else if (avatar.anSetting.currDir == 6)
                    {
                        avatar.setAction(AnConst.STAND, 5);
                        this.pFavorite = BONUS_FAVORITE1;
                    }
                }
            }
            if (_loc_6 == param2)
            {
                if (_loc_5 > param1 - _loc_7 && _loc_5 < param1 + _loc_7 && param3 != 1 && param3 >= 0)
                {
                    if (_loc_5 > param1 && MapMgr.getInstance().cityMap.getIsoType((_loc_5 - 1), _loc_6) == BaseMap.IS_WALL)
                    {
                        this.pFavorite = BONUS_FAVORITE1;
                    }
                    if (_loc_5 < param1 && MapMgr.getInstance().cityMap.getIsoType((_loc_5 + 1), _loc_6) == BaseMap.IS_WALL)
                    {
                        this.pFavorite = BONUS_FAVORITE1;
                    }
                }
                if (_loc_5 == (param1 + 1))
                {
                    if (avatar.anSetting.currDir == 8)
                    {
                        avatar.setAction(AnConst.STAND, 6);
                    }
                    else if (avatar.anSetting.currDir == 7)
                    {
                        avatar.setAction(AnConst.STAND, 5);
                        this.pFavorite = BONUS_FAVORITE1;
                    }
                }
            }
            return;
        }// end function

        public function effectHideWall() : void
        {
            if (avatar.anSetting.currAction == AnConst.STAND)
            {
                TweenMax.to(avatar, 0.5, {scaleY:1, onComplete:this.onCompleteTween});
                avatar.setAction(AnConst.RUN, avatar.anSetting.currDir, 1, 0);
                avatar.anSetting.currFrame = 1;
            }
            return;
        }// end function

        public function onCompleteTween() : void
        {
            if (!avatar || !avatar.anSetting)
            {
                return;
            }
            avatar.addFrameScript();
            avatar.setAction(AnConst.ATTACK, avatar.anSetting.currDir, 1, 1);
            return;
        }// end function

        public function updateBonusFavorite() : void
        {
            var _loc_1:* = MapMgr.getInstance().battleMap.cellToIso(move.curCell);
            var _loc_2:* = _loc_1.x / 3;
            var _loc_3:* = _loc_1.y / 3;
            switch(avatar.anSetting.currDir)
            {
                case 5:
                {
                    if (MapMgr.getInstance().cityMap.getIsoType(_loc_2, (_loc_3 + 1)) == BaseMap.IS_WALL && MapMgr.getInstance().cityMap.getIsoType((_loc_2 + 1), _loc_3) == BaseMap.IS_WALL)
                    {
                        this.pFavorite = 0;
                    }
                    break;
                }
                case 6:
                {
                    if (MapMgr.getInstance().cityMap.getIsoType((_loc_2 + 1), _loc_3) == BaseMap.IS_WALL)
                    {
                        this.pFavorite = 0;
                    }
                    else if (MapMgr.getInstance().cityMap.getIsoType(_loc_2, (_loc_3 - 1)) != BaseMap.IS_WALL)
                    {
                        this.pFavorite = BONUS_FAVORITE1;
                    }
                    break;
                }
                case 7:
                {
                    if (MapMgr.getInstance().cityMap.getIsoType(_loc_2, (_loc_3 + 1)) == BaseMap.IS_WALL)
                    {
                        this.pFavorite = 0;
                    }
                    else if (MapMgr.getInstance().cityMap.getIsoType((_loc_2 - 1), _loc_3) != BaseMap.IS_WALL)
                    {
                        this.pFavorite = BONUS_FAVORITE1;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function setTypeDamage(param1:Boolean) : void
        {
            this.typeDamage = param1;
            return;
        }// end function

    }
}
