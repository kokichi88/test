package modules.city.logic
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import component.*;
    import component.avatar.controls.*;
    import component.avatar.effects.*;
    import component.avatar.model.animation.*;
    import component.avatar.things.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import gameData.*;
    import map.*;
    import modules.battle.logic.bean.*;
    import modules.city.*;
    import modules.city.graphics.build.*;
    import modules.city.graphics.tutorial.*;
    import modules.sound.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class MapObject extends Object
    {
        public var autoId:int = 0;
        public var level:int;
        public var posX:int;
        public var posY:int;
        public var type:String;
        public var startTime:Number = 0;
        public var status:int;
        public var gold:int;
        public var elixir:int;
        public var darkElixir:int;
        public var width:int;
        public var height:int;
        public var avatar:Avatar;
        public var bgImage:InteractivePNG;
        public var holderImage:Sprite;
        public var parent:Object;
        public var statusBar:BuildingStatusBarGui;
        public var buildTimeNextLevel:int;
        public var countDownRun:int = 0;
        public var borderImage:Sprite;
        private var points:Vector.<Point>;
        private var saveScaleX:Number;
        private var saveScaleY:Number;
        public var chooseImage:Sprite;
        public var isMouseOver:Boolean;
        public var bgImageWidth:Number;
        public var bgImageHeight:Number;
        public var avatarWidth:Number;
        public var avatarHeight:Number;
        public var isSelected:Boolean;
        public var shadow:Sprite;
        public var upgradingImage:Sprite;
        public var isUnset:Boolean = false;
        public var readyToMove:Boolean = false;
        private var dxStatusBar:Number;
        private var dyStatusBar:Number;
        public var hasSent:Boolean = false;
        public var finishType:int = 0;
        private var saveTween:TweenMax = null;
        private var alphaNext:Number;
        public var imgTooltip:DisplayObject;
        private var dy:Number = 0;
        private var dx:Number = 0;
        public var hasColorMatrixFilter:Boolean = false;
        public static var BROKEN:int = 0;
        public static var BUILDING:int = 1;
        public static var PRODUCING:int = 2;
        public static var UPGRADING:int = 3;
        public static var RESEACHING:int = 4;
        public static var NUM_LOOP_RUN:int = 90;

        public function MapObject()
        {
            this.points = new Vector.<Point>;
            this.avatar = new Avatar();
            this.bgImage = new InteractivePNG();
            this.statusBar = new BuildingStatusBarGui();
            this.dxStatusBar = (-this.statusBar.widthBg) / 2;
            this.dyStatusBar = -this.avatar.height - this.statusBar.heightBg;
            return;
        }// end function

        public function loadConfigData() : void
        {
            return;
        }// end function

        public function loadAvatar() : void
        {
            this.avatar.create(AnCategory.HOUSE, this.type, this.level);
            return;
        }// end function

        public function loop() : void
        {
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            if (this.startTime > 0 && (this.status == BUILDING || this.status == UPGRADING))
            {
                this.showStatusBar();
            }
            return;
        }// end function

        public function hideStatusBar() : void
        {
            this.statusBar.hide();
            return;
        }// end function

        public function showStatusBar() : void
        {
            var _loc_1:* = Utility.getCurTime() - this.startTime;
            if (_loc_1 >= this.buildTimeNextLevel)
            {
                this.finishType = _loc_1 - this.buildTimeNextLevel > 2 ? (0) : (1);
                if (!this.hasSent)
                {
                    this.hasSent = true;
                    CityMgr.getInstance().sendFinishBuilding(this.type, this.autoId);
                }
            }
            else if (this.type != BuildingType.WALL)
            {
                this.statusBar.showStatusBar(_loc_1, this.buildTimeNextLevel);
                this.viewStatusBar();
            }
            return;
        }// end function

        public function viewStatusBar() : void
        {
            if (this.statusBar.isShowing || !this.avatar.visible)
            {
                return;
            }
            var _loc_1:* = this.bgImage.x + (this.bgImageWidth - this.statusBar.widthBg) / 2;
            var _loc_2:* = this.bgImage.y - this.statusBar.heightBg;
            this.statusBar.setPos(_loc_1, _loc_2);
            this.statusBar.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_INFO));
            return;
        }// end function

        private function showFinishedMessage(param1:int) : void
        {
            var _loc_2:String = null;
            if (Utility.getTypeObject(this.type) != BuildingType.OBS)
            {
                _loc_2 = Localization.getInstance().getString("FinishBuilding");
                _loc_2 = _loc_2.replace("@action@", this.status == BUILDING ? ("xây dựng") : ("nâng cấp"));
                _loc_2 = _loc_2.replace("@name@", Localization.getInstance().getString(this.type).toLowerCase());
            }
            else
            {
                _loc_2 = Localization.getInstance().getString("FinishClean");
                _loc_2 = _loc_2.replace("@name@", Localization.getInstance().getString(this.type).toLowerCase());
            }
            _loc_2 = _loc_2.replace("@level@", this.status == BUILDING ? (this.level.toString()) : ((this.level + 1) + ""));
            if (param1)
            {
                if (this.type != BuildingType.WALL && Utility.getTypeObject(this.type) != BuildingType.TRA)
                {
                    CityMgr.getInstance().guiNotify.addNewNotify(_loc_2);
                    this.effectFinishBuilding();
                }
                SoundModule.getInstance().playSound(SoundModule.BUILDING_FINISH);
            }
            CityMgr.getInstance().builderReturnHome(this.autoId);
            var _loc_3:* = Math.floor(Math.sqrt(this.buildTimeNextLevel));
            if (_loc_3 > 0)
            {
                GameDataMgr.getInstance().addExp(_loc_3);
                this.showExpEffect(_loc_3);
            }
            return;
        }// end function

        public function finishBuilding(param1:int) : void
        {
            this.showFinishedMessage(param1);
            if (this.status == UPGRADING)
            {
                
                this.level++;
                this.loadConfigData();
                this.status = PRODUCING;
                this.upgradeAvatar();
            }
            this.statusBar.hide();
            this.status = PRODUCING;
            this.startTime = 0;
            GameDataMgr.getInstance().freeBuilder(this.autoId);
            if (this.upgradingImage)
            {
                this.upgradingImage.visible = false;
            }
            if (TutorialMgr.getInstance().isTutorial)
            {
                TutorialMgr.getInstance().hideGuis();
                TutorialMgr.getInstance().nextStep(1);
            }
            this.hasSent = false;
            if (this.imgTooltip)
            {
                this.imgTooltip = null;
                this.imgTooltip = Utility.getTooltipMapObject(this.type, this.level);
            }
            if (CityMgr.getInstance().guiBuildingAction.curObject == this)
            {
                CityMgr.getInstance().guiBuildingAction.curObject = null;
                CityMgr.getInstance().showBuildingActionGui(this);
            }
            return;
        }// end function

        public function effectFinishBuilding() : void
        {
            if (Utility.getTypeObject(this.type) == BuildingType.OBS)
            {
                return;
            }
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            this.createSeedEffect();
            var _loc_2:* = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/lightpole.png");
            _loc_2.mouseChildren = false;
            _loc_2.mouseEnabled = false;
            _loc_2.blendMode = BlendMode.ADD;
            _loc_2.x = this.bgImage.x + this.bgImageWidth / 2 - 100;
            _loc_2.y = this.bgImage.y + this.bgImageHeight / 2 - 420;
            _loc_1.addChild(_loc_2);
            this.alphaNext = 0.4;
            _loc_2.alpha = 0.5;
            this.lightPole(_loc_2, this.alphaNext);
            var _loc_3:* = new Avatar();
            _loc_3.create(AnCategory.EFFECT, "lvupaura", 0);
            _loc_3.mouseChildren = false;
            _loc_3.mouseEnabled = false;
            this.bgImage.addChildAt(_loc_3, 0);
            _loc_3.x = this.bgImageWidth / 2;
            _loc_3.y = this.bgImageHeight / 2;
            var _loc_4:Number = 0.2;
            _loc_3.scaleY = 0.2;
            _loc_3.scaleX = _loc_4;
            TweenMax.to(_loc_3, 0.7, {scaleX:2, scaleY:2, alpha:0, ease:Linear.easeNone, onComplete:this.compSpLevel, onCompleteParams:[_loc_3]});
            return;
        }// end function

        private function compSpLevel(param1:Avatar) : void
        {
            param1.destroy();
            param1.parent.removeChild(param1);
            param1.visible = false;
            param1 = null;
            return;
        }// end function

        private function createSeedEffect() : void
        {
            var _loc_3:EffectHarvestResources = null;
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            EffectDraw.play("contrusts_levelup", new Point(this.bgImage.x + this.bgImageWidth / 2, this.bgImage.y + this.bgImageHeight / 2), _loc_1);
            var _loc_2:int = 0;
            while (_loc_2 < 42)
            {
                
                _loc_3 = new EffectHarvestResources();
                _loc_3.setInfo("upLevelBuilding", 1, this.bgImage.x + this.bgImageWidth / 2 + Utility.randomNumber(-100, 100), this.bgImage.y + this.bgImage.height / 2 + Utility.randomNumber(-50, 10));
                _loc_2++;
            }
            return;
        }// end function

        private function lightPole(param1:Sprite, param2:Number) : void
        {
            var _loc_3:Number = NaN;
            if (param2 == -1)
            {
                if (param1.parent)
                {
                    param1.parent.removeChild(param1);
                    param1.visible = false;
                    param1 = null;
                }
                return;
            }
            if (param2 < 0.5)
            {
                this.alphaNext = this.alphaNext - 0.15;
                _loc_3 = 0.5;
            }
            else
            {
                _loc_3 = this.alphaNext;
            }
            if (this.alphaNext > 0)
            {
                TweenMax.to(param1, 0.5, {alpha:param2, ease:Linear.easeNone, onComplete:this.lightPole, onCompleteParams:[param1, _loc_3]});
            }
            else
            {
                TweenMax.to(param1, 0.5, {alpha:0, ease:Linear.easeNone, onComplete:this.lightPole, onCompleteParams:[param1, -1]});
            }
            return;
        }// end function

        public function setBgImage(param1:String, param2:int) : void
        {
            var _loc_4:String = null;
            var _loc_5:String = null;
            var _loc_3:* = Utility.getTypeObject(this.type);
            if (_loc_3 == BuildingType.OBS)
            {
                _loc_4 = "OBS_" + param1 + "_" + this.width;
                this.bgImage.setImage(_loc_4);
            }
            else
            {
                this.bgImage.setImage(param1 + "_" + this.width);
            }
            if (param2 > 1 && param2 < 5 && param1 == "GRASS")
            {
                _loc_5 = param1 + "_" + this.width + "_Shadow";
                switch(this.type)
                {
                    case BuildingType.MOTAR:
                    case BuildingType.ELIXIR_STORAGE:
                    case BuildingType.GOLD_STORAGE:
                    case BuildingType.AIR_DEFENSES:
                    {
                        _loc_5 = param1 + "_5_Shadow";
                        break;
                    }
                    case BuildingType.CANON:
                    case BuildingType.WIZARD_TOWER:
                    case BuildingType.ACHER_TOWER:
                    {
                        _loc_5 = "";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (_loc_3 == BuildingType.OBS)
                {
                    _loc_5 = "";
                }
                if (_loc_5 != "")
                {
                    this.shadow = ResMgr.getInstance().getMovieClip(_loc_5) as Sprite;
                    this.bgImage.addChild(this.shadow);
                }
            }
            return;
        }// end function

        public function hide() : void
        {
            this.avatar.visible = false;
            if (this.bgImage)
            {
                this.bgImage.visible = false;
            }
            if (this.statusBar)
            {
                this.statusBar.hide();
            }
            return;
        }// end function

        public function show() : void
        {
            this.avatar.visible = true;
            if (this.bgImage)
            {
                this.bgImage.visible = true;
            }
            return;
        }// end function

        public function addToCity(param1:Boolean = false) : void
        {
            var _loc_5:int = 0;
            var _loc_6:DataBuildingInfo = null;
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
            var _loc_3:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            var _loc_4:* = MapMgr.getInstance().cityMap.isoToPoint(this.posX, this.posY);
            this.setBgImage("GRASS", this.width);
            this.bgImage.enableInteractivePNG();
            this.addEventToBgImage();
            this.bgImage.mapObject = this;
            this.bgImage.visible = true;
            this.bgImage.x = _loc_4.x - MapMgr.getInstance().cityMap.MaxHalfWidth * this.width;
            this.bgImage.y = _loc_4.y;
            _loc_2.addChild(this.bgImage);
            this.bgImageWidth = this.bgImage.width;
            this.bgImageHeight = this.bgImage.height;
            this.borderImage = ResMgr.getInstance().getMovieClip("image_select_" + this.width) as Sprite;
            _loc_2.addChild(this.borderImage);
            CityMgr.getInstance().spriteList.push(this.borderImage);
            this.borderImage.visible = false;
            this.borderImage.x = this.bgImage.x + this.bgImageWidth / 2;
            this.borderImage.y = this.bgImage.y + this.bgImageHeight / 2;
            this.borderImage.mouseEnabled = false;
            this.borderImage.mouseChildren = false;
            this.loadAvatar();
            this.avatar.x = this.bgImage.x + this.bgImageWidth / 2;
            this.avatar.y = this.bgImage.y + this.bgImageHeight / 2;
            this.avatarWidth = this.avatar.width;
            this.avatarHeight = this.avatar.height;
            if (this.type == BuildingType.ARMY_CAMP)
            {
                _loc_3.addChildAt(this.avatar, 0);
            }
            else
            {
                _loc_5 = CityMgr.getInstance().getIndexAvatar(this.avatar);
                if (_loc_5 < 0)
                {
                    _loc_3.addChild(this.avatar);
                }
                else
                {
                    _loc_3.addChildAt(this.avatar, _loc_5);
                }
            }
            if (this.type != BuildingType.WALL && this.type != BuildingType.BUILDER_HUT && this.type.indexOf(BuildingType.TRA) == -1)
            {
                this.addUpgradingImage();
                this.setCurrentStatus();
            }
            this.createChooseImage();
            CityMgr.getInstance().renderObj(true);
            this.hasSent = false;
            if (this.status == BUILDING)
            {
                _loc_6 = Utility.getInfoToBuild(this.type, 1);
                this.buildTimeNextLevel = _loc_6.buildTime;
                this.scaleClick(false);
            }
            return;
        }// end function

        private function addUpgradingImage() : void
        {
            this.upgradingImage = ResMgr.getInstance().getMovieClip("Image_Upgrading") as Sprite;
            this.upgradingImage.x = (-this.upgradingImage.width) / 2;
            this.upgradingImage.y = -15;
            this.avatar.addChild(this.upgradingImage);
            this.upgradingImage.visible = false;
            this.upgradingImage.mouseChildren = false;
            this.upgradingImage.mouseEnabled = false;
            return;
        }// end function

        public function upgradeAvatar() : void
        {
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            var _loc_2:* = _loc_1.getChildIndex(this.avatar);
            this.removeAvatar();
            this.avatar = new Avatar();
            this.loadAvatar();
            this.avatar.x = this.bgImage.x + this.bgImageWidth / 2;
            this.avatar.y = this.bgImage.y + this.bgImageHeight / 2;
            _loc_1.addChildAt(this.avatar, _loc_2);
            this.addEventToBgImage();
            this.setCurrentStatus();
            if (this.type != BuildingType.WALL && this.type != BuildingType.BUILDER_HUT)
            {
                this.addUpgradingImage();
            }
            return;
        }// end function

        public function addEventToBgImage() : void
        {
            this.removeEventFromBgImage();
            this.removeEventFromAvatar();
            if (this.bgImage)
            {
                this.avatar.mouseEnabled = false;
                this.avatar.mouseChildren = false;
                this.bgImage.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
                this.bgImage.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
                this.bgImage.addEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
                this.bgImage.addEventListener(MouseEvent.MOUSE_UP, this.onUp);
                this.bgImage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMove);
                this.bgImage.addEventListener(MouseEvent.CLICK, this.onClick);
                this.bgImage.mouseEnabled = true;
            }
            return;
        }// end function

        public function addEventToAvatar() : void
        {
            this.removeEventFromBgImage();
            this.removeEventFromAvatar();
            this.avatar.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
            this.avatar.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
            this.avatar.addEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
            this.avatar.addEventListener(MouseEvent.MOUSE_UP, this.onUp);
            this.avatar.addEventListener(MouseEvent.MOUSE_MOVE, this.onMove);
            this.avatar.addEventListener(MouseEvent.CLICK, this.onClick);
            return;
        }// end function

        public function setCurrentStatus() : void
        {
            if (this.type == BuildingType.BUILDER_HUT)
            {
                this.status = PRODUCING;
            }
            if (this.status == BUILDING || this.status == UPGRADING)
            {
                if (this.type != BuildingType.WALL)
                {
                    this.upgradingImage.visible = true;
                }
            }
            return;
        }// end function

        public function setPos(param1:int, param2:int) : void
        {
            this.posX = param1;
            this.posY = param2;
            var _loc_3:* = MapMgr.getInstance().cityMap.isoToPoint(this.posX, this.posY);
            if (this.bgImage)
            {
                this.bgImage.x = _loc_3.x - MapMgr.getInstance().cityMap.MaxHalfWidth * this.width;
                this.bgImage.y = _loc_3.y;
            }
            if (this.borderImage)
            {
                this.borderImage.x = this.bgImage.x + this.bgImageWidth / 2;
                this.borderImage.y = this.bgImage.y + this.bgImageHeight / 2;
            }
            if (this.avatar)
            {
                this.avatar.x = this.bgImage.x + this.bgImageWidth / 2;
                this.avatar.y = this.bgImage.y + this.bgImageHeight / 2;
            }
            if (this.upgradingImage)
            {
            }
            if (this.chooseImage)
            {
                this.chooseImage.x = this.bgImage.x + this.bgImageWidth / 2;
                this.chooseImage.y = this.bgImage.y + this.bgImageHeight / 2;
            }
            this.show();
            return;
        }// end function

        private function isMouseOnGrass() : Boolean
        {
            var _loc_1:* = MouseMgr.getInstance().mousePos;
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
            _loc_1 = _loc_2.globalToLocal(_loc_1);
            if (Utility.insidePolygon(this.points, _loc_1))
            {
                return true;
            }
            return false;
        }// end function

        protected function onOver(event:MouseEvent) : void
        {
            this.isMouseOver = true;
            return;
        }// end function

        public function showTooltip() : void
        {
            if (GlobalVar.state != GlobalVar.STATE_MYHOME && GlobalVar.state != GlobalVar.STATE_FRIEND && GlobalVar.state != GlobalVar.STATE_GUEST)
            {
                return;
            }
            if (this.imgTooltip == null)
            {
                this.imgTooltip = Utility.getTooltipMapObject(this.type, this.level);
            }
            ActiveTooltip.getInstance().showNewTooltip(this.imgTooltip, this.bgImage);
            return;
        }// end function

        protected function onOut(event:MouseEvent) : void
        {
            this.isMouseOver = false;
            if (!this.borderImage)
            {
                return;
            }
            this.borderImage.visible = false;
            ActiveTooltip.getInstance().clearTooltip();
            return;
        }// end function

        protected function onMove(event:MouseEvent) : void
        {
            var _loc_2:Layer = null;
            if (this.isMouseOver)
            {
                if (this.readyToMove)
                {
                    CityMgr.getInstance().showLayerGui(false);
                }
                if (!this.borderImage)
                {
                    return;
                }
                _loc_2 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
                _loc_2.setChildIndex(this.borderImage, (_loc_2.numChildren - 1));
                this.borderImage.visible = true;
                this.showTooltip();
            }
            return;
        }// end function

        public function onDown(event:MouseEvent) : void
        {
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                MapMgr.getInstance().dragMap(true);
                return;
            }
            if (this.isSelected && !MouseMgr.getInstance().isShopIcon)
            {
                this.readyToMove = true;
                this.changeMovingMode();
            }
            else
            {
                MapMgr.getInstance().dragMap(true);
            }
            return;
        }// end function

        public function onUp(event:MouseEvent) : void
        {
            this.readyToMove = false;
            CityMgr.getInstance().showLayerGui(true);
            var _loc_2:* = Utility.getTypeObject(this.type);
            switch(_loc_2)
            {
                case BuildingType.RES:
                {
                    if ((this as ResourceObject).harvestIcon.visible)
                    {
                        GameInput.getInstance().isMouseDrag = false;
                        return;
                    }
                    break;
                }
                case BuildingType.CLAN:
                {
                    if (this.status == MapObject.BROKEN)
                    {
                        GameInput.getInstance().isMouseDrag = false;
                        return;
                    }
                    CityMgr.getInstance().guiPopup.showMessageBox("Xin lỗi", "Chức năng hiện đang bảo trì\nSẽ sớm quay trở lại", "ĐỒNG Ý", null);
                    return;
                }
                default:
                {
                    break;
                }
            }
            if (!GameInput.getInstance().isDragging)
            {
                if (this.isSelected)
                {
                    if (!MouseMgr.getInstance().mouseIcon || MouseMgr.getInstance().mouseIcon.mapObject.autoId == this.autoId)
                    {
                        if (this.posX == GameDataMgr.getInstance().saveObjPosX && this.posY == GameDataMgr.getInstance().saveObjPosY)
                        {
                            this.hideSelected();
                            MouseMgr.getInstance().buildSomethings();
                        }
                        else if (GameDataMgr.getInstance().saveObjPosX < 0 && GameDataMgr.getInstance().saveObjPosY < 0)
                        {
                            CityMgr.getInstance().guiBuildingAction.hide();
                        }
                        else if (MouseMgr.getInstance().isValidToBuild())
                        {
                            MouseMgr.getInstance().buildSomethings();
                        }
                    }
                }
                else if (MouseMgr.getInstance().isShopIcon)
                {
                    if (MouseMgr.getInstance().isValidToBuild())
                    {
                        if (this.type != BuildingType.WALL)
                        {
                            CityMgr.getInstance().hideBuildingActionGui();
                        }
                        MouseMgr.getInstance().buildSomethings();
                    }
                }
                else
                {
                    if (MouseMgr.getInstance().mouseIcon && MouseMgr.getInstance().mouseIcon.mapObject.autoId != this.autoId)
                    {
                        MouseMgr.getInstance().rollBackMoveBuilding();
                    }
                    if (this.borderImage && !this.borderImage.visible)
                    {
                        return;
                    }
                    this.scaleClick();
                    CityMgr.getInstance().showBuildingActionGui(this);
                    SoundModule.getInstance().playSound(SoundModule[this.type + "_PICKUP"]);
                }
            }
            GameInput.getInstance().isMouseDrag = false;
            return;
        }// end function

        public function onClick(event:MouseEvent) : void
        {
            var _loc_2:int = 0;
            if (!this.parent)
            {
                if (TutorialMgr.getInstance().isTutorial)
                {
                    _loc_2 = TutorialMgr.getInstance().curStep;
                    if (_loc_2 != 7 && _loc_2 != 26 && _loc_2 != 35 && _loc_2 != 44 && _loc_2 != 49 && _loc_2 != 61 && _loc_2 != 64)
                    {
                        return;
                    }
                }
            }
            return;
        }// end function

        public function scaleClick(param1:Boolean = true) : void
        {
            if (TutorialMgr.getInstance().isTutorial)
            {
                return;
            }
            if (this.avatar == null)
            {
                return;
            }
            var _loc_2:Number = 0.1;
            this.dx = this.avatar.width * _loc_2 / 2;
            this.dy = this.avatar.height * _loc_2 / 2;
            var _loc_3:* = 1 + _loc_2;
            TweenMax.to(this.avatar, 0.2, {scaleX:_loc_3, scaleY:_loc_3, colorMatrixFilter:{contrast:1.2, brightness:1.3}, onComplete:this.onFinishTween});
            if (!this.hasColorMatrixFilter && param1)
            {
                TweenMax.to(this.avatar, 0.2, {colorMatrixFilter:{contrast:1.2, brightness:1.3}});
                this.hasColorMatrixFilter = true;
            }
            else
            {
                this.colorMatrixFilterReturn();
            }
            return;
        }// end function

        private function onFinishTween() : void
        {
            if (this.avatar)
            {
                TweenMax.to(this.avatar, 0.1, {scaleX:1, scaleY:1});
            }
            return;
        }// end function

        public function colorMatrixFilterReturn() : void
        {
            this.isSelected = false;
            this.hasColorMatrixFilter = false;
            TweenMax.to(this.avatar, 0.2, {colorMatrixFilter:{contrast:1, brightness:1}});
            return;
        }// end function

        public function removeEventFromAvatar() : void
        {
            this.avatar.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
            this.avatar.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
            this.avatar.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
            this.avatar.removeEventListener(MouseEvent.MOUSE_UP, this.onUp);
            this.avatar.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMove);
            this.avatar.removeEventListener(MouseEvent.CLICK, this.onClick);
            return;
        }// end function

        public function removeEventFromBgImage() : void
        {
            if (this.bgImage)
            {
                this.bgImage.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
                this.bgImage.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
                this.bgImage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
                this.bgImage.removeEventListener(MouseEvent.MOUSE_UP, this.onUp);
                this.bgImage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMove);
                this.bgImage.removeEventListener(MouseEvent.CLICK, this.onClick);
                this.bgImage.mouseEnabled = false;
                this.bgImage.mouseChildren = false;
            }
            return;
        }// end function

        public function removeAvatar() : void
        {
            this.removeEventFromAvatar();
            if (this.upgradingImage && this.upgradingImage.parent != null)
            {
                this.upgradingImage.parent.removeChild(this.upgradingImage);
                this.upgradingImage = null;
            }
            if (this.avatar != null && this.avatar.parent != null)
            {
                this.avatar.destroy();
            }
            if (this.avatar != null && this.avatar.parent != null)
            {
                this.avatar.parent.removeChild(this.avatar);
            }
            this.avatar = null;
            return;
        }// end function

        public function destroy() : void
        {
            this.removeEventFromBgImage();
            this.removeAvatar();
            if (this.bgImage != null && this.bgImage.parent != null)
            {
                this.bgImage.parent.removeChild(this.bgImage);
                this.bgImage = null;
            }
            if (this.statusBar)
            {
                this.statusBar.destroyBaseGUI();
                this.statusBar = null;
            }
            if (this.borderImage)
            {
                this.borderImage.visible = false;
            }
            return;
        }// end function

        public function upgrade(param1:int) : void
        {
            var _loc_2:* = Utility.getInfoToBuild(this.type, (this.level + 1));
            GameDataMgr.getInstance().addMoney(_loc_2.cost.type, -_loc_2.cost.value);
            this.buildTimeNextLevel = _loc_2.buildTime;
            var _loc_3:* = Utility.getCurTime();
            var _loc_4:* = _loc_3 + _loc_2.buildTime;
            GameDataMgr.getInstance().takeBuilder(param1, this.autoId, _loc_4, _loc_2.buildTime > 0);
            this.status = MapObject.UPGRADING;
            this.startTime = _loc_3;
            if (this.upgradingImage)
            {
                this.upgradingImage.visible = true;
            }
            CityMgr.getInstance().sendUpgradeBuilding(this, param1);
            return;
        }// end function

        private function createChooseImage() : void
        {
            if (this.chooseImage && this.chooseImage.parent != null)
            {
                this.chooseImage.parent.removeChild(this.chooseImage);
                this.chooseImage = null;
            }
            if (!this.bgImage)
            {
                return;
            }
            this.chooseImage = ResMgr.getInstance().getMovieClip("arrow_select_" + this.width) as Sprite;
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_EFFECT);
            _loc_1.addChild(this.chooseImage);
            this.chooseImage.x = this.bgImage.x + this.bgImageWidth / 2;
            this.chooseImage.y = this.bgImage.y + this.bgImageHeight / 2;
            CityMgr.getInstance().spriteList.push(this.chooseImage);
            this.chooseImage.mouseChildren = false;
            this.chooseImage.mouseEnabled = false;
            this.chooseImage.visible = false;
            return;
        }// end function

        public function showSelected() : void
        {
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            if (TutorialMgr.getInstance().isTutorial)
            {
                return;
            }
            var _loc_1:* = Utility.getTypeObject(this.type);
            switch(_loc_1)
            {
                case BuildingType.OBS:
                {
                    return;
                }
                default:
                {
                    break;
                }
            }
            if (this.borderImage)
            {
                this.borderImage.visible = false;
            }
            this.isSelected = true;
            if (!this.chooseImage)
            {
                return;
            }
            this.chooseImage.visible = true;
            var _loc_3:Number = 0.8;
            this.chooseImage.scaleY = 0.8;
            this.chooseImage.scaleX = _loc_3;
            var _loc_2:Number = 1;
            this.chooseImage.alpha = 0.2;
            if (this.saveTween)
            {
                this.saveTween.kill();
                this.saveTween = null;
            }
            this.saveTween = TweenMax.to(this.chooseImage, 0.3, {scaleX:_loc_2, scaleY:_loc_2, alpha:1, delay:0.1, ease:Back.easeOut});
            return;
        }// end function

        public function hideSelected() : void
        {
            this.isSelected = false;
            if (!this.chooseImage)
            {
                return;
            }
            var _loc_1:Number = 0.8;
            if (this.saveTween)
            {
                this.saveTween.kill();
                this.saveTween = null;
            }
            this.saveTween = TweenMax.to(this.chooseImage, 0.2, {scaleX:_loc_1, scaleY:_loc_1, alpha:0.5, ease:Back.easeIn, onComplete:this.clearChooseImage});
            return;
        }// end function

        private function clearChooseImage() : void
        {
            this.chooseImage.visible = false;
            return;
        }// end function

        public function makePoints() : void
        {
            var _loc_1:* = new Sprite();
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
            _loc_2.addChild(_loc_1);
            _loc_1.graphics.beginFill(16711680);
            this.points.splice(0, (this.points.length - 1));
            this.points = new Vector.<Point>;
            var _loc_3:* = new Point();
            _loc_3 = MapMgr.getInstance().cityMap.isoToPoint(this.posX, this.posY);
            this.points.push(_loc_3);
            var _loc_4:* = new Point();
            _loc_4 = MapMgr.getInstance().cityMap.isoToPoint(this.posX + this.width - 1, this.posY);
            MapMgr.getInstance().cityMap.isoToPoint(this.posX + this.width - 1, this.posY).x = _loc_4.x + MapMgr.getInstance().cityMap.MaxHalfWidth;
            _loc_4.y = _loc_4.y + MapMgr.getInstance().cityMap.MaxHalfHeight;
            this.points.push(_loc_4);
            var _loc_5:* = new Point();
            _loc_5 = MapMgr.getInstance().cityMap.isoToPoint(this.posX + this.width - 1, this.posY + this.width - 1);
            MapMgr.getInstance().cityMap.isoToPoint(this.posX + this.width - 1, this.posY + this.width - 1).y = _loc_5.y + MapMgr.getInstance().cityMap.MaxHalfHeight * 2;
            this.points.push(_loc_5);
            var _loc_6:* = new Point();
            _loc_6 = MapMgr.getInstance().cityMap.isoToPoint(this.posX, this.posY + this.width - 1);
            MapMgr.getInstance().cityMap.isoToPoint(this.posX, this.posY + this.width - 1).x = _loc_6.x - MapMgr.getInstance().cityMap.MaxHalfWidth;
            _loc_6.y = _loc_6.y + MapMgr.getInstance().cityMap.MaxHalfHeight;
            this.points.push(_loc_6);
            return;
        }// end function

        public function changeMovingMode() : void
        {
            if (!MouseMgr.getInstance().mouseIcon || MouseMgr.getInstance().isValidToBuild())
            {
                this.chooseImage.visible = false;
                GameDataMgr.getInstance().saveObjPosX = this.posX;
                GameDataMgr.getInstance().saveObjPosY = this.posY;
                MapMgr.getInstance().unSetBuilding(this);
                this.hide();
                GlobalVar.mouseState = GlobalVar.MOVE_BUILDING;
                GameDataMgr.getInstance().curObject = this;
                MouseMgr.getInstance().changeBuildingMouseIcon(this);
            }
            return;
        }// end function

        public function playEffectDropHouse() : void
        {
            var _loc_1:* = this.bgImageWidth / 3;
            var _loc_2:* = this.bgImageHeight / 3;
            var _loc_3:* = this.bgImageWidth / 2 - 40;
            var _loc_4:* = this.bgImageHeight / 2 - 40;
            var _loc_5:Number = 1;
            var _loc_6:* = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/smokedropcontructs.png");
            ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/smokedropcontructs.png").x = _loc_3;
            _loc_6.y = _loc_4;
            var _loc_7:* = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/smokedropcontructs.png");
            ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/smokedropcontructs.png").x = _loc_3;
            _loc_7.y = _loc_4;
            var _loc_8:* = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/smokedropcontructs.png");
            ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/smokedropcontructs.png").x = _loc_3;
            _loc_8.y = _loc_4;
            var _loc_9:* = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/smokedropcontructs.png");
            ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/smokedropcontructs.png").x = _loc_3;
            _loc_9.y = _loc_4;
            var _loc_10:int = 2;
            if (this.bgImage.numChildren < 3)
            {
                _loc_10 = 1;
            }
            this.bgImage.addChildAt(_loc_6, _loc_10);
            this.bgImage.addChildAt(_loc_7, _loc_10);
            this.bgImage.addChildAt(_loc_8, _loc_10);
            this.bgImage.addChildAt(_loc_9, _loc_10);
            TweenMax.to(_loc_6, 0.7, {bezier:[{x:_loc_3 + _loc_1 + Utility.randomNumber(-20, 30), y:_loc_4 + _loc_2 + Utility.randomNumber(-20, 30)}], alpha:0, ease:Linear.easeNone, onComplete:this.compEffectDropHouse, onCompleteParams:[_loc_6]});
            TweenMax.to(_loc_7, 0.7, {bezier:[{x:_loc_3 - _loc_1 + Utility.randomNumber(-20, 30), y:_loc_4 + _loc_2 + Utility.randomNumber(-20, 30)}], alpha:0, ease:Linear.easeNone, onComplete:this.compEffectDropHouse, onCompleteParams:[_loc_7]});
            TweenMax.to(_loc_8, 0.7, {bezier:[{x:_loc_3 + _loc_1 + Utility.randomNumber(-20, 30), y:_loc_4 - _loc_2 + Utility.randomNumber(-20, 30)}], alpha:0, ease:Linear.easeNone, onComplete:this.compEffectDropHouse, onCompleteParams:[_loc_8]});
            TweenMax.to(_loc_9, 0.7, {bezier:[{x:_loc_3 - _loc_1 + Utility.randomNumber(-20, 30), y:_loc_4 - _loc_2 + Utility.randomNumber(-20, 30)}], alpha:0, ease:Linear.easeNone, onComplete:this.compEffectDropHouse, onCompleteParams:[_loc_9]});
            var _loc_11:Number = 1.1;
            TweenMax.to(this.avatar, 0.2, {scaleX:_loc_11, scaleY:_loc_11, onComplete:this.onFinishTween});
            return;
        }// end function

        private function compEffectDropHouse(param1:Sprite) : void
        {
            param1.parent.removeChild(param1);
            param1.visible = false;
            param1 = null;
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            return;
        }// end function

        public function showExpEffect(param1:int) : void
        {
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_EFFECT);
            AttUpdateEffect.play2(_loc_2, AttUpdateEffect.EXP, param1, new Point(this.bgImage.x + this.bgImageWidth / 2, this.bgImage.y), 2);
            return;
        }// end function

        public function showCoinEffect(param1:int) : void
        {
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_EFFECT);
            AttUpdateEffect.play2(_loc_2, AttUpdateEffect.COIN, param1, new Point(this.bgImage.x + this.bgImageWidth / 4, this.bgImage.y), 2);
            return;
        }// end function

    }
}
