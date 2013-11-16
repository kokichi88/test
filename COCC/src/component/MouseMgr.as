package component
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.ui.*;
    import gameData.*;
    import map.*;
    import map.logic.*;
    import modules.city.*;
    import modules.city.logic.*;
    import modules.sound.*;

    public class MouseMgr extends Object
    {
        public var mousePos:Point;
        public var parent:Sprite;
        private var curMouseName:String;
        public var isShopIcon:Boolean = false;
        public var _curMouseId:String = "";
        public var mouseIcon:ImgMouse;
        public var isGridView:Boolean;
        public static var hasInit:Boolean = false;
        private static var instance:MouseMgr;

        public function MouseMgr(param1:Sprite)
        {
            this.mousePos = new Point();
            if (instance != null)
            {
                throw new Error("Single cases of class instantiation error-MouseMgr");
            }
            this.parent = param1;
            hasInit = true;
            return;
        }// end function

        public function changeMouse(param1:String, param2:int = -1) : void
        {
            if (this.curMouseName == param1 && this.mouseIcon != null)
            {
                this.mouseIcon.gotoAndStop(param2);
            }
            else
            {
                if (this.mouseIcon != null)
                {
                    this.parent.removeChild(this.mouseIcon);
                }
                if (param1 != "")
                {
                    if (param2 >= 0)
                    {
                        this.mouseIcon.gotoAndStop(param2);
                    }
                    Mouse.hide();
                }
                else
                {
                    Mouse.show();
                    this.mouseIcon = null;
                }
            }
            return;
        }// end function

        public function set curMouseId(param1:String) : void
        {
            this._curMouseId = param1;
            return;
        }// end function

        public function get curMouseId() : String
        {
            return this._curMouseId;
        }// end function

        public function update() : void
        {
            if (!hasInit)
            {
                return;
            }
            var _loc_1:* = this.parent.globalToLocal(this.mousePos);
            var _loc_2:* = MapMgr.getInstance().cityMap.pointToIso(_loc_1.x, _loc_1.y);
            this.mousePos.x = this.parent.stage.mouseX - GlobalVar.rootSprite.x;
            this.mousePos.y = this.parent.stage.mouseY - GlobalVar.rootSprite.y;
            var _loc_3:* = this.parent.globalToLocal(this.mousePos);
            var _loc_4:* = MapMgr.getInstance().cityMap.pointToIso(_loc_3.x, _loc_3.y);
            if (GameDataMgr.getInstance().curObject != null)
            {
                if (this.mouseIcon != null && (_loc_2.x != _loc_4.x || _loc_2.y != _loc_4.y) && GameInput.getInstance().isMouseDown && !GameInput.getInstance().isMouseDrag)
                {
                    this.updateMouseIconPosition(_loc_4.x, _loc_4.y);
                }
            }
            else if (this.mouseIcon != null && (_loc_2.x != _loc_4.x || _loc_2.y != _loc_4.y))
            {
                this.updateMouseIconPosition(_loc_4.x, _loc_4.y);
            }
            return;
        }// end function

        public function updateMouseIconPosition(param1:int, param2:int, param3:Boolean = false) : void
        {
            var _loc_4:Point = null;
            if (param3)
            {
                _loc_4 = MapMgr.getInstance().cityMap.isoToPoint(param1 + Math.floor(this.mouseIcon.mapObject.width / 2), param2 + Math.floor(this.mouseIcon.mapObject.height / 2));
            }
            else
            {
                _loc_4 = MapMgr.getInstance().cityMap.isoToPoint(param1, param2);
            }
            if (this.mouseIcon.mapObject.width % 2 == 1)
            {
                _loc_4.y = _loc_4.y + MapMgr.getInstance().cityMap.MaxHalfHeight;
            }
            this.mouseIcon.x = _loc_4.x;
            this.mouseIcon.y = _loc_4.y;
            this.mouseIcon.updateBg();
            return;
        }// end function

        public function isValidToBuild() : Boolean
        {
            if (!this.mouseIcon)
            {
                return false;
            }
            return this.mouseIcon.currentState == BaseMap.CAN_BUILD;
        }// end function

        public function changeBuildingMouseIcon(param1:MapObject, param2:Boolean = false) : void
        {
            var _loc_3:Point = null;
            var _loc_4:Point = null;
            if (this.mouseIcon)
            {
                this.parent.removeChild(this.mouseIcon);
            }
            this.isShopIcon = param2;
            this.mouseIcon = new ImgMouse();
            this.mouseIcon.setData(param1);
            this.parent.addChild(this.mouseIcon);
            if (param2)
            {
                this.mousePos.x = this.parent.stage.mouseX - GlobalVar.rootSprite.x;
                this.mousePos.y = this.parent.stage.mouseY - GlobalVar.rootSprite.y;
                _loc_3 = this.parent.globalToLocal(this.mousePos);
                _loc_4 = MapMgr.getInstance().cityMap.pointToIso(_loc_3.x, _loc_3.y);
                this.updateMouseIconPosition(_loc_4.x, _loc_4.y);
            }
            else
            {
                this.updateMouseIconPosition(param1.posX, param1.posY, true);
            }
            return;
        }// end function

        public function changeListWallIcon(param1:MapObject) : void
        {
            if (this.mouseIcon)
            {
                this.parent.removeChild(this.mouseIcon);
            }
            this.mouseIcon = new ImgMouse();
            var _loc_2:* = CityMgr.getInstance().getWallList(param1, 0);
            this.mouseIcon.setDataWall(_loc_2);
            this.parent.addChild(this.mouseIcon);
            return;
        }// end function

        public function removeMouseIcon() : void
        {
            if (this.mouseIcon)
            {
                this._curMouseId = "";
                this.parent.removeChild(this.mouseIcon);
                this.mouseIcon.destroy();
                this.mouseIcon = null;
            }
            this.isShopIcon = false;
            return;
        }// end function

        public function buildSomethings() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().curObject;
            var _loc_2:* = this.mouseIcon.mapObject.posX != GameDataMgr.getInstance().saveObjPosX || this.mouseIcon.mapObject.posY != GameDataMgr.getInstance().saveObjPosY;
            if (MouseMgr.getInstance().isValidToBuild())
            {
                if (_loc_1)
                {
                    _loc_1.posX = this.mouseIcon.mapObject.posX;
                    _loc_1.posY = this.mouseIcon.mapObject.posY;
                    _loc_1.readyToMove = false;
                    MouseMgr.getInstance().removeMouseIcon();
                    CityMgr.getInstance().moveBuilding(_loc_1, _loc_2);
                    SoundModule.getInstance().playSound(SoundModule[_loc_1.type + "_PLACE"]);
                }
                else
                {
                    _loc_1 = MapMgr.copyMapObject(this.mouseIcon.mapObject);
                    _loc_1.readyToMove = false;
                    MouseMgr.getInstance().removeMouseIcon();
                    CityMgr.getInstance().prepareToBuyBuilding(_loc_1);
                }
                GameDataMgr.getInstance().saveObjPosX = -1;
                GameDataMgr.getInstance().saveObjPosY = -1;
            }
            return;
        }// end function

        public function rollBackMoveBuilding() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().curObject;
            if (!MouseMgr.getInstance().isValidToBuild())
            {
                if (_loc_1)
                {
                    _loc_1.posX = GameDataMgr.getInstance().saveObjPosX;
                    _loc_1.posY = GameDataMgr.getInstance().saveObjPosY;
                    _loc_1.readyToMove = false;
                    MouseMgr.getInstance().removeMouseIcon();
                    CityMgr.getInstance().setBuildingToMap(_loc_1, true);
                    SoundModule.getInstance().playSound(SoundModule[_loc_1.type + "_PLACE"]);
                    GameDataMgr.getInstance().saveObjPosX = -1;
                    GameDataMgr.getInstance().saveObjPosY = -1;
                }
                else
                {
                    CityMgr.getInstance().guiShop.cancelPlaceBuilding();
                }
                SoundModule.getInstance().playSound(SoundModule.ILLEGAN_MOVE);
            }
            return;
        }// end function

        public static function getInstance(param1:Sprite = null) : MouseMgr
        {
            if (instance == null)
            {
                instance = new MouseMgr(param1);
            }
            return instance;
        }// end function

        public static function clear() : void
        {
            hasInit = false;
            instance = null;
            return;
        }// end function

    }
}
