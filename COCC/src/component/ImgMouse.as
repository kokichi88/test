package component
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import gameData.*;
    import map.*;
    import map.logic.*;
    import modules.battle.logic.bean.*;
    import modules.city.logic.*;
    import modules.sound.*;
    import resMgr.*;
    import utility.*;

    public class ImgMouse extends MovieClip
    {
        public var id:String;
        public var mapObject:MapObject = null;
        public var currentState:int;
        private var signCastRange:Sprite;
        private var signSafeZone:Sprite;

        public function ImgMouse()
        {
            return;
        }// end function

        public function addBgImage(param1:String, param2:int) : void
        {
            var _loc_3:* = ResMgr.getInstance().getMovieClip("GREEN_" + param2) as Sprite;
            this.mapObject.bgImage.addChild(_loc_3);
            var _loc_4:* = ResMgr.getInstance().getMovieClip("RED_" + param2) as Sprite;
            this.mapObject.bgImage.addChild(_loc_4);
            _loc_4.visible = false;
            addChild(this.mapObject.bgImage);
            var _loc_5:* = this.mapObject.bgImage.width;
            var _loc_6:* = this.mapObject.bgImage.height;
            this.mapObject.parent = this;
            this.mapObject.bgImage.x = this.mapObject.bgImage.x - this.mapObject.bgImage.width / 2;
            this.mapObject.bgImage.y = this.mapObject.bgImage.y - this.mapObject.bgImage.height / 2;
            if (Utility.getTypeObject(this.mapObject.type) == BuildingType.DEF)
            {
                DefenseObject(this.mapObject).loadMouseAvatar();
            }
            else
            {
                this.mapObject.loadAvatar();
            }
            addChild(this.mapObject.avatar);
            if (this.mapObject.type == BuildingType.ARMY_CAMP)
            {
                this.mapObject.avatar.alpha = 0.5;
            }
            this.mapObject.avatar.x = this.mapObject.bgImage.x + this.mapObject.bgImage.width / 2;
            this.mapObject.avatar.y = this.mapObject.bgImage.y + this.mapObject.bgImage.height / 2;
            this.mapObject.addEventToBgImage();
            if (this.mapObject.chooseImage && this.mapObject.chooseImage.parent == this)
            {
                this.removeChild(this.mapObject.chooseImage);
            }
            this.mapObject.chooseImage = ResMgr.getInstance().getMovieClip("arrow_select_" + this.mapObject.width) as Sprite;
            this.mapObject.chooseImage.x = this.mapObject.bgImage.x + _loc_3.width / 2;
            this.mapObject.chooseImage.y = this.mapObject.bgImage.y + _loc_3.height / 2;
            this.mapObject.chooseImage.mouseChildren = false;
            this.mapObject.chooseImage.mouseEnabled = false;
            addChild(this.mapObject.chooseImage);
            return;
        }// end function

        private function changeBgImage(param1:int) : void
        {
            var _loc_2:* = this.mapObject.bgImage.getChildAt(0) as Sprite;
            _loc_2.visible = param1 == 0;
            _loc_2 = this.mapObject.bgImage.getChildAt(1) as Sprite;
            _loc_2.visible = param1 == 1;
            return;
        }// end function

        public function setData(param1:MapObject) : void
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            this.currentState = BaseMap.CAN_BUILD;
            this.mapObject = MapMgr.copyMapObject(param1);
            this.addBgImage("GREEN", this.mapObject.width);
            var _loc_2:* = Utility.getTypeObject(this.mapObject.type);
            if (_loc_2 == BuildingType.DEF || _loc_2 == BuildingType.TRA || _loc_2 == BuildingType.CLAN)
            {
                this.createAttackRange();
                this.addChild(this.signCastRange);
                this.signCastRange.mouseChildren = false;
                this.signCastRange.mouseEnabled = false;
                this.signCastRange.x = this.mapObject.avatar.x;
                this.signCastRange.y = this.mapObject.avatar.y;
                this.signCastRange.alpha = 0.5;
                _loc_3 = 0;
                _loc_4 = 0;
                switch(_loc_2)
                {
                    case BuildingType.DEF:
                    {
                        _loc_4 = DefenseObject(this.mapObject).info.maxRange;
                        _loc_3 = DefenseObject(this.mapObject).info.minRange;
                        break;
                    }
                    case BuildingType.TRA:
                    {
                        _loc_4 = TrapObject(this.mapObject).info.triggerRadius;
                        _loc_3 = 0;
                        break;
                    }
                    case BuildingType.CLAN:
                    {
                        _loc_4 = ClanObject(this.mapObject).info.range;
                        _loc_3 = 0;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_5 = _loc_4 * BaseInfo.WIDTH_CELL * BaseInfo.SCALE_MAP * 2 / this.signCastRange.width;
                var _loc_6:* = _loc_5;
                this.signCastRange.scaleY = _loc_5;
                this.signCastRange.scaleX = _loc_6;
                if (_loc_3 > 0)
                {
                    this.signSafeZone = new Sprite();
                    this.signSafeZone = ResMgr.getInstance().getMovieClip("ViewSafeRange") as Sprite;
                    _loc_5 = _loc_3 * BaseInfo.WIDTH_CELL * BaseInfo.SCALE_MAP * 2 / this.signSafeZone.width;
                    var _loc_6:* = _loc_5;
                    this.signSafeZone.scaleY = _loc_5;
                    this.signSafeZone.scaleX = _loc_6;
                    this.addChild(this.signSafeZone);
                    this.signSafeZone.mouseChildren = false;
                    this.signSafeZone.mouseEnabled = false;
                    this.signSafeZone.x = this.mapObject.avatar.x;
                    this.signSafeZone.y = this.mapObject.avatar.y;
                    this.signSafeZone.alpha = 0.5;
                }
            }
            return;
        }// end function

        public function createAttackRange() : void
        {
            if (this.signCastRange == null)
            {
                this.signCastRange = new Sprite();
                this.signCastRange = ResMgr.getInstance().getMovieClip("ViewCastRange") as Sprite;
            }
            return;
        }// end function

        public function updateBg() : void
        {
            if (GameInput.getInstance().isMouseDown)
            {
            }
            else
            {
                this.mouseChildren = true;
                this.mouseEnabled = true;
            }
            var _loc_1:* = MapMgr.getInstance().cityMap.pointToIso(this.x + this.mapObject.bgImage.x + this.mapObject.bgImage.width / 2, this.y + this.mapObject.bgImage.y + MapMgr.getInstance().cityMap.MaxHalfHeight);
            SoundModule.getInstance().playSound(SoundModule.MOVING);
            if (MapMgr.getInstance().cityMap.checkValidBuilding(_loc_1.x, _loc_1.y, this.mapObject.width, this.mapObject.height) == BaseMap.CAN_BUILD)
            {
                if (this.currentState != BaseMap.CAN_BUILD)
                {
                    this.changeBgImage(0);
                    this.currentState = BaseMap.CAN_BUILD;
                }
                if (this.mapObject.type == BuildingType.WALL)
                {
                }
            }
            else if (this.currentState == BaseMap.CAN_BUILD)
            {
                this.changeBgImage(1);
                this.currentState = BaseMap.IS_HOUSE;
            }
            this.mapObject.posX = _loc_1.x;
            this.mapObject.posY = _loc_1.y;
            return;
        }// end function

        public function destroy() : void
        {
            while (this.mapObject.bgImage.numChildren > 0)
            {
                
                this.mapObject.bgImage.removeChildAt(0);
            }
            this.mapObject.destroy();
            this.mapObject = null;
            return;
        }// end function

        public function setDataWall(param1:Vector.<WallObject>) : void
        {
            var _loc_3:MapObject = null;
            this.currentState = BaseMap.CAN_BUILD;
            this.mapObject = MapMgr.copyMapObject(param1[param1.length / 2]);
            this.addBgImage("GREEN", this.mapObject.width);
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                param1[_loc_2].hide();
                if (_loc_2 == param1.length / 2)
                {
                }
                else
                {
                    _loc_3 = MapMgr.copyMapObject(param1[_loc_2]);
                }
                _loc_2++;
            }
            return;
        }// end function

    }
}
