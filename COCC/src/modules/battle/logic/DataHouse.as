package modules.battle.logic
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import component.avatar.things.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import gameData.*;
    import map.*;
    import map.logic.*;
    import modules.battle.*;
    import modules.battle.logic.bean.*;
    import modules.city.logic.*;
    import modules.sound.*;
    import resMgr.*;
    import utility.*;

    public class DataHouse extends DataObject
    {
        public var imgDie:Sprite;
        public var mapObject:MapObject;
        private var shadow:Sprite;
        private var typeObj:String = "";
        public var bgImage:Sprite;
        public var bgImageWidth:Number = 0;
        public var bgImageHeight:Number = 0;

        public function DataHouse()
        {
            objectType = DataObject.OBJTYPE_HOUSE;
            team = 2;
            return;
        }// end function

        override public function death() : void
        {
            var _loc_3:AnLoadData = null;
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_7:Bitmap = null;
            var _loc_8:Timer = null;
            var _loc_9:Vector2D = null;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            SoundModule.getInstance().playSound(SoundModule.BUILDING_DESTROYED);
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            if (this.mapObject.type != BuildingType.TRA_4 && this.mapObject.type != BuildingType.TRA_5 && this.mapObject.type != BuildingType.TRA_2)
            {
                _loc_1.addChildAt(this.imgDie, 0);
                this.imgDie.x = avatar.x - this.imgDie.width / 2;
                this.imgDie.y = avatar.y - this.imgDie.height / 2;
            }
            if (this.mapObject.type != BuildingType.TRA_2)
            {
                this.showEffectExplosionElements();
                this.showEffectExplosionSmoke();
                if (this.objectType != DataObject.OBJTYPE_WALL)
                {
                    this.playEffectDuongPQ();
                }
            }
            else
            {
                _loc_3 = avatar.bodyBitmap.coreObj.data;
                _loc_4 = _loc_3[avatar.anSetting.currAction];
                _loc_5 = _loc_4.dirData[avatar.anSetting.currDir];
                _loc_6 = _loc_5.frames[avatar.anSetting.currFrame];
                _loc_7 = new Bitmap();
                _loc_7.bitmapData = avatar.bodyBitmap.bitmapData;
                _loc_7.x = avatar.x + _loc_6.rect.x;
                _loc_7.y = avatar.y + _loc_6.rect.y;
                _loc_1.addChild(_loc_7);
                BattleModule.getInstance().battleData.imageList.push(_loc_7);
                _loc_7.alpha = 1.5;
                TweenMax.to(_loc_7, 3, {alpha:0, onComplete:this.onFinishTweenHideTrap2, onCompleteParams:[_loc_7]});
            }
            if (this.objectType != DataObject.OBJTYPE_WALL && this.objectType != DataObject.OBJTYPE_TRAP)
            {
                BattleModule.getInstance().addPercentLife(baseInfo.maxHp);
                EffectDraw.play("construct_destroyed", new Point(avatar.x, avatar.y + 20), _loc_1);
                _loc_8 = new Timer(250, 15);
                _loc_8.addEventListener(TimerEvent.TIMER, this.onTimer);
                _loc_8.start();
            }
            BattleModule.getInstance().battleData.imageList.push(this.imgDie);
            if (this.shadow && this.shadow.parent)
            {
                this.shadow.parent.removeChild(this.shadow);
                this.shadow.visible = false;
                this.shadow = null;
            }
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
            EffectDraw.vibrateLayer(_loc_2, 2);
            EffectDraw.vibrateLayer(_loc_1, 2);
            super.death();
            if (this.objectType != DataObject.OBJTYPE_WALL && this.objectType != DataObject.OBJTYPE_TRAP)
            {
                _loc_9 = MapMgr.getInstance().battleMap.cellToIso(move.responeCell);
                _loc_10 = _loc_9.x / 3;
                _loc_11 = _loc_9.y / 3;
                MapMgr.getInstance().battleMap.setBuilding(_loc_9.x, _loc_9.y, this.mapObject.width * 3, this.mapObject.height * 3, BaseMap.CAN_MOVE, 1);
                MapMgr.getInstance().cityMap.setBuilding(_loc_10, _loc_11, this.mapObject.width, this.mapObject.height, BaseMap.CAN_MOVE);
            }
            return;
        }// end function

        private function onFinishTweenHideTrap2(param1:Bitmap) : void
        {
            if (param1 && param1.parent)
            {
                param1.parent.removeChild(param1);
                param1.visible = false;
                param1 = null;
            }
            return;
        }// end function

        private function playEffectDuongPQ() : void
        {
            var _loc_4:Avatar = null;
            var _loc_5:Avatar = null;
            var _loc_1:Number = 2;
            var _loc_2:Number = 2.5;
            var _loc_3:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            _loc_4 = new Avatar();
            _loc_4.create(AnCategory.EFFECT, "explosion_flame_1", 0);
            _loc_4.mouseChildren = false;
            _loc_4.mouseEnabled = false;
            _loc_3.addChild(_loc_4);
            _loc_4.alpha = 2;
            _loc_4.x = avatar.x;
            _loc_4.y = avatar.y;
            var _loc_6:Number = 0.2;
            _loc_4.scaleY = 0.2;
            _loc_4.scaleX = _loc_6;
            _loc_4.blendMode = BlendMode.ADD;
            if (this.objectType == DataObject.OBJTYPE_WALL)
            {
                _loc_1 = 0.7;
            }
            else
            {
                _loc_5 = new Avatar();
                _loc_5.create(AnCategory.EFFECT, "explosionsmokering", 0);
                _loc_5.mouseChildren = false;
                _loc_5.mouseEnabled = false;
                this.bgImage.addChild(_loc_5);
                _loc_5.x = this.bgImage.width / 2;
                _loc_5.y = this.bgImage.height / 2;
                var _loc_6:Number = 0.5;
                _loc_5.scaleY = 0.5;
                _loc_5.scaleX = _loc_6;
                TweenMax.to(_loc_5, 0.5, {scaleX:2.5, scaleY:2.5, alpha:0, ease:Linear.easeNone, onComplete:this.compSpLevel, onCompleteParams:[_loc_5]});
            }
            TweenMax.to(_loc_4, 0.7, {scaleX:_loc_1, scaleY:_loc_1, alpha:0.1, ease:Linear.easeNone, onComplete:this.compSpLevel, onCompleteParams:[_loc_4]});
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

        private function showEffectExplosionElements() : void
        {
            var _loc_2:SeedEffect = null;
            var _loc_1:int = 0;
            while (_loc_1 < 50)
            {
                
                _loc_2 = new SeedEffect();
                _loc_2.create("explosionElements", avatar.x, avatar.y + 100);
                if (this.objectType == DataObject.OBJTYPE_WALL)
                {
                    var _loc_3:Number = 0.5;
                    _loc_2.avt.scaleY = 0.5;
                    _loc_2.avt.scaleX = _loc_3;
                }
                _loc_1++;
            }
            return;
        }// end function

        private function showEffectExplosionSmoke() : void
        {
            var _loc_2:SeedEffect = null;
            var _loc_1:int = 0;
            while (_loc_1 < 6)
            {
                
                _loc_2 = new SeedEffect();
                if (this.objectType == DataObject.OBJTYPE_WALL)
                {
                    _loc_2.create("explosion_smoke_Wall", avatar.x, avatar.y);
                    var _loc_3:Number = 0.5;
                    _loc_2.avt.scaleY = 0.5;
                    _loc_2.avt.scaleX = _loc_3;
                }
                else
                {
                    _loc_2.create("explosion_smoke", avatar.x, avatar.y);
                }
                _loc_1++;
            }
            return;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            this.playEffectDestroy();
            return;
        }// end function

        private function playEffectDestroy() : void
        {
            if (this.imgDie == null)
            {
                return;
            }
            var _loc_1:* = Math.random() * 2 + 1;
            var _loc_2:* = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/burningsmoke_" + _loc_1 + ".png");
            var _loc_5:Number = 0.5;
            _loc_2.scaleY = 0.5;
            _loc_2.scaleX = _loc_5;
            _loc_2.x = this.imgDie.width / 2 - _loc_2.width / 2;
            var _loc_3:* = Utility.randomNumber(-50, 20);
            _loc_2.y = 30;
            var _loc_4:Number = 1.5;
            if (this.mapObject.type == BuildingType.TOWN_HALL)
            {
                //var _loc_5:int = 1;
                _loc_2.scaleY = 1;
                _loc_2.scaleX = _loc_5;
                _loc_4 = 2.5;
                _loc_3 = Utility.randomNumber(-200, 100);
                TweenMax.to(_loc_2, 3, {scaleX:_loc_4, scaleY:_loc_4, alpha:0, bezier:[{x:this.imgDie.width / 2 + _loc_3 / 2, y:-140}, {x:this.imgDie.width / 2 + _loc_3, y:-180}], ease:Linear.easeNone, onComplete:this.onFinishTween, onCompleteParams:[_loc_2]});
            }
            else
            {
                TweenMax.to(_loc_2, 3, {scaleX:_loc_4, scaleY:_loc_4, alpha:0, bezier:[{x:this.imgDie.width / 2 + _loc_3 / 2, y:-80}, {x:this.imgDie.width / 2 + _loc_3, y:-100}], ease:Linear.easeNone, onComplete:this.onFinishTween, onCompleteParams:[_loc_2]});
            }
            this.imgDie.addChild(_loc_2);
            return;
        }// end function

        private function onFinishTween(param1:Sprite) : void
        {
            if (param1.parent)
            {
                param1.parent.removeChild(param1);
                param1.visible = false;
                param1 = null;
            }
            return;
        }// end function

        public function setDataHouse(param1:MapObject) : void
        {
            var _loc_2:int = 0;
            this.mapObject = param1;
            this.responeCell = MapMgr.getInstance().battleMap.isoToCell(this.mapObject.posX * 3, this.mapObject.posY * 3);
            if (this.mapObject.type == BuildingType.CLAN_CASTLE && this.mapObject.status == 2)
            {
                this.create(AnCategory.HOUSE, this.mapObject.type + "_broken", this.mapObject.level);
            }
            else
            {
                this.create(AnCategory.HOUSE, this.mapObject.type, this.mapObject.level);
            }
            this.setInfo(this.mapObject.type, this.mapObject.level);
            switch(this.mapObject.type)
            {
                case BuildingType.TOWN_HALL:
                {
                    this.imgDie = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/junk_mainhouse.png") as Sprite;
                    break;
                }
                case BuildingType.WALL:
                case BuildingType.TRA_1:
                case BuildingType.TRA_2:
                case BuildingType.TRA_3:
                case BuildingType.TRA_4:
                case BuildingType.TRA_5:
                {
                    _loc_2 = Math.random() * 3;
                    this.imgDie = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/junk_wall_" + _loc_2 + ".png") as Sprite;
                    break;
                }
                case BuildingType.ELIXIR_STORAGE:
                case BuildingType.ELIXIR_COLLECTOR:
                {
                    this.imgDie = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/junk_elixirdrill.png") as Sprite;
                    break;
                }
                default:
                {
                    _loc_2 = Math.random() * 2;
                    this.imgDie = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/junk_contructs_" + _loc_2.toString() + ".png") as Sprite;
                    break;
                    break;
                }
            }
            this.typeObj = Utility.getTypeObject(this.mapObject.type);
            baseInfo.id = this.mapObject.type;
            return;
        }// end function

        public function updatePosAvatar() : void
        {
            var _loc_1:Layer = null;
            var _loc_2:AniEffect = null;
            var _loc_3:AniEffect = null;
            var _loc_4:AniEffect = null;
            avatar.x = this.bgImage.x + this.bgImageWidth / 2;
            avatar.y = this.bgImage.y + this.bgImageHeight / 2;
            switch(this.mapObject.type)
            {
                case BuildingType.ARMY_CAMP:
                {
                    _loc_1 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                    switch(this.mapObject.level)
                    {
                        case 1:
                        {
                            _loc_2 = EffectDraw.play("armycam_1", new Point(0, -20), avatar, 0);
                            break;
                        }
                        case 2:
                        case 3:
                        case 4:
                        case 5:
                        {
                            _loc_2 = EffectDraw.play("armycam_2", new Point(0, 0), avatar, 0);
                            break;
                        }
                        case 6:
                        {
                            _loc_2 = EffectDraw.play("armycamp_puplefire", new Point(0, -20), avatar, 0);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    aniEffects.push(_loc_2);
                    break;
                }
                case BuildingType.TOWN_HALL:
                {
                    switch(this.mapObject.level)
                    {
                        case 7:
                        {
                            _loc_3 = EffectDraw.play("towhall_flame", new Point(50, 51), avatar, 0);
                            _loc_4 = EffectDraw.play("towhall_flame", new Point(85, 25), avatar, 0);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    aniEffects.push(_loc_3);
                    aniEffects.push(_loc_4);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function setInfo(param1:String, param2:int) : void
        {
            var _loc_8:String = null;
            var _loc_9:String = null;
            var _loc_10:Sprite = null;
            super.setInfo(param1, param2);
            var _loc_3:* = Utility.getTypeObject(this.mapObject.type);
            var _loc_4:* = this.mapObject.width;
            if (GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
            {
                if (_loc_3 == BuildingType.OBS)
                {
                    _loc_8 = "OBS_GRASS_SINGLE_" + _loc_4;
                    this.bgImage = ResMgr.getInstance().getMovieClip(_loc_8) as Sprite;
                }
                else
                {
                    this.bgImage = ResMgr.getInstance().getMovieClip("GRASS_SINGLE_" + _loc_4) as Sprite;
                }
            }
            else if (_loc_3 == BuildingType.OBS)
            {
                _loc_8 = "OBS_GRASS_" + _loc_4;
                this.bgImage = ResMgr.getInstance().getMovieClip(_loc_8) as Sprite;
            }
            else
            {
                this.bgImage = ResMgr.getInstance().getMovieClip("GRASS_" + _loc_4) as Sprite;
            }
            this.bgImageWidth = this.bgImage.width;
            this.bgImageHeight = this.bgImage.height;
            var _loc_5:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
            var _loc_6:* = MapMgr.getInstance().battleMap.isoToPoint(this.mapObject.posX * 3, this.mapObject.posY * 3);
            var _loc_7:* = MapMgr.getInstance().cityMap.isoToPoint(this.mapObject.posX, this.mapObject.posY);
            this.bgImage.x = _loc_6.x - MapMgr.getInstance().cityMap.MaxHalfWidth * _loc_4;
            this.bgImage.y = _loc_6.y - MapMgr.getInstance().battleMap.MaxHalfHeight;
            if (_loc_4 % 2 == 1)
            {
                move.curCell = MapMgr.getInstance().battleMap.pointToCell(_loc_6.x, _loc_6.y + MapMgr.getInstance().battleMap.MaxHalfHeight * (_loc_4 * 3 - 1));
            }
            else
            {
                move.curCell = MapMgr.getInstance().battleMap.pointToCell(_loc_6.x, _loc_6.y + MapMgr.getInstance().battleMap.MaxHalfHeight * (_loc_4 * 3));
            }
            if (_loc_3 != BuildingType.TRA)
            {
                _loc_5.addChild(this.bgImage);
            }
            baseInfo.maxHp = this.mapObject["info"]["hitpoints"];
            baseInfo.curHp = baseInfo.maxHp;
            BattleModule.getInstance().battleData.imageList.push(this.bgImage);
            if (this.mapObject.width > 1 && this.mapObject.width < 5)
            {
                _loc_9 = "GRASS_" + this.mapObject.width + "_Shadow";
                switch(this.mapObject.type)
                {
                    case BuildingType.MOTAR:
                    case BuildingType.ELIXIR_STORAGE:
                    case BuildingType.GOLD_STORAGE:
                    case BuildingType.AIR_DEFENSES:
                    {
                        _loc_9 = "GRASS_5_Shadow";
                        break;
                    }
                    case BuildingType.ACHER_TOWER:
                    case BuildingType.CANON:
                    case BuildingType.WIZARD_TOWER:
                    {
                        _loc_9 = "";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (_loc_9 != "" && _loc_3 != BuildingType.OBS)
                {
                    this.shadow = ResMgr.getInstance().getMovieClip(_loc_9) as Sprite;
                    if (this.mapObject.type == BuildingType.TOWN_HALL && GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
                    {
                        var _loc_11:Number = 1.2;
                        this.shadow.scaleY = 1.2;
                        this.shadow.scaleX = _loc_11;
                        this.shadow.x = -40;
                        this.shadow.y = -30;
                    }
                    this.bgImage.addChild(this.shadow);
                }
            }
            if (this.mapObject.status == 1)
            {
                _loc_10 = ResMgr.getInstance().getMovieClip("Image_Upgrading") as Sprite;
                _loc_10.x = this.bgImage.x + (this.bgImage.width - _loc_10.width) / 2;
                _loc_10.y = this.bgImage.y + (this.bgImage.height - _loc_10.height) - 15;
                _loc_10.mouseChildren = false;
                _loc_10.mouseEnabled = false;
                _loc_5.addChild(_loc_10);
                BattleModule.getInstance().battleData.imageList.push(_loc_10);
            }
            this.bgImage.mouseChildren = false;
            this.bgImage.mouseEnabled = false;
            return;
        }// end function

        private function addCenter(param1:int, param2:int) : void
        {
            var _loc_3:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_EFFECT);
            var _loc_4:* = ResMgr.getInstance().getMovieClip("GREEN_" + param2);
            var _loc_6:Number = 0.3;
            ResMgr.getInstance().getMovieClip("GREEN_" + param2).scaleY = 0.3;
            ResMgr.getInstance().getMovieClip("GREEN_" + param2).scaleX = _loc_6;
            _loc_3.addChild(_loc_4);
            var _loc_5:* = MapMgr.getInstance().battleMap.cellToPoint(param1);
            _loc_4.x = _loc_5.x - _loc_4.width / 2;
            _loc_4.y = _loc_5.y;
            return;
        }// end function

        override public function loop() : void
        {
            if (this.mapObject && (this.mapObject.status == 1 || this.mapObject.status == 2) || this.typeObj == BuildingType.OBS)
            {
                return;
            }
            super.loop();
            return;
        }// end function

    }
}
