package component.avatar.things
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import gameData.*;
    import modules.battle.logic.*;
    import resMgr.*;
    import utility.*;

    public class Avatar extends Sprite
    {
        public var anSetting:AnSetting;
        public var bodyBitmap:MultiBitmap;
        protected var animation:BitmapObj;
        protected var _ready:Boolean = false;
        protected var nameLbl:TextField;
        public var sprite:Sprite;
        private var shadow:Sprite;
        protected var bodySprite:Sprite;
        public var extraSprite:Sprite;
        private var duration:int;
        private var typeAction:int;
        private var signCastRange:Sprite;
        public static const TF_NPC:TextFormat = new TextFormat("Tahoma", 12, 8453965, false, null, null, null, null, TextFormatAlign.CENTER);
        public static const TF_FILTERS:Array = [new GlowFilter(1842204, 1, 2, 2, 5)];
        public static const SC_FILTERS:Array = [new GlowFilter(4663308, 0.8, 1.5, 1.5, 1.8)];

        public function Avatar()
        {
            this.sprite = new Sprite();
            addChild(this.sprite);
            this.bodySprite = new Sprite();
            this.sprite.addChild(this.bodySprite);
            this.anSetting = new AnSetting();
            this.animation = new BitmapObj();
            this.bodyBitmap = new MultiBitmap(this.anSetting, this.animation);
            this.bodySprite.addChild(this.bodyBitmap);
            this.nameLbl = new TextField();
            this.nameLbl.cacheAsBitmap = true;
            this.nameLbl.selectable = false;
            this.nameLbl.defaultTextFormat = TF_NPC;
            this.nameLbl.filters = TF_FILTERS;
            this.sprite.addChild(this.nameLbl);
            this.nameLbl.visible = false;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        public function get layerBody() : DisplayObjectContainer
        {
            return this.bodySprite;
        }// end function

        public function get layerGround() : DisplayObjectContainer
        {
            return this.shadow;
        }// end function

        public function get HeadPos() : Point
        {
            return new Point(0, -120);
        }// end function

        public function get HeartPos() : Point
        {
            return new Point(0, -60);
        }// end function

        public function create(param1:String, param2:String, param3:int) : void
        {
            if (param1 == AnCategory.AVATAR)
            {
                switch(param2)
                {
                    case DataObject.GIANT:
                    {
                        this.shadow = ResMgr.getInstance().getMovieClip("Shadow_Big") as Sprite;
                        break;
                    }
                    default:
                    {
                        this.shadow = ResMgr.getInstance().getMovieClip("Shadow_Small") as Sprite;
                        break;
                        break;
                    }
                }
                if (this.shadow)
                {
                    this.sprite.addChildAt(this.shadow, 0);
                }
            }
            this._ready = false;
            this.anSetting.reset();
            this.anSetting.currAction = AnConst.STAND;
            if (param3 > 0)
            {
                if (param1 == AnCategory.HOUSE || param1 == AnCategory.AVATAR)
                {
                    param2 = Utility.getContentName(param2, param3);
                }
            }
            this.setBodySource(param1, param2);
            FrameTimerManager.getInstance(GlobalVar.ANIMAL_TIMER).add(DataObject.DELAY_FRAME, 0, this.frameScript);
            return;
        }// end function

        public function updatefrs(param1:int) : void
        {
            this.removeFrameScript();
            FrameTimerManager.getInstance(GlobalVar.ANIMAL_TIMER).add(param1, 0, this.frameScript);
            return;
        }// end function

        public function removeFrameScript() : void
        {
            FrameTimerManager.getInstance(GlobalVar.ANIMAL_TIMER).remove(this.frameScript);
            return;
        }// end function

        public function addFrameScript() : void
        {
            this.removeFrameScript();
            FrameTimerManager.getInstance(GlobalVar.ANIMAL_TIMER).add(DataObject.DELAY_FRAME, 0, this.frameScript);
            return;
        }// end function

        public function setBodySource(param1:String, param2:String) : void
        {
            this.animation.setSource(param1, param2);
            this.animation.load();
            this.smoothingAvatar();
            return;
        }// end function

        public function frameScript() : void
        {
            if (this.bodyBitmap.setting.frameCount != 1 || this.bodyBitmap.isLoaded == false)
            {
                this.bodyBitmap.draw();
                this.bodyBitmap.nextFrame();
            }
            if (this.duration > 0)
            {
                if (this.bodyBitmap.setting.reachEnding)
                {
                    var _loc_1:String = this;
                    var _loc_2:* = this.duration - 1;
                    _loc_1.duration = _loc_2;
                    if (this.duration == 0)
                    {
                        switch(this.typeAction)
                        {
                            case 0:
                            {
                                this.removeFrameScript();
                                break;
                            }
                            case 1:
                            {
                                this.updatefrs(DataObject.DELAY_FRAME * 2);
                                this.setAction(AnConst.STAND, this.anSetting.currDir);
                                break;
                            }
                            case 2:
                            {
                                this.setAction(AnConst.ATTACK, this.anSetting.currDir, 1, 1);
                                break;
                            }
                            case 3:
                            {
                                this.updatefrs(DataObject.DELAY_FRAME * 2);
                                this.setAction(AnConst.STAND, this.anSetting.currDir);
                                break;
                            }
                            case 4:
                            {
                                this.removeFrameScript();
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
            return;
        }// end function

        public function setAction(param1:int, param2:int, param3:int = -1, param4:int = 0) : void
        {
            this.duration = param3;
            this.typeAction = param4;
            this.anSetting.currAction = param1;
            this.anSetting.currDir = param2;
            this.bodyBitmap.setting.frameCount = 0;
            if (param4 == 3)
            {
                return;
            }
            if (param1 == AnConst.RUN)
            {
                this.anSetting.currFrame = Math.random() * 12;
            }
            else
            {
                this.anSetting.currFrame = 0;
            }
            return;
        }// end function

        public function setHighLight(param1:Number = 16744448) : void
        {
            if (param1 < 0)
            {
                this.bodyBitmap.filters = null;
                return;
            }
            var _loc_2:* = new GlowFilter(param1, 1, 5, 5, 2, 1);
            this.bodyBitmap.filters = [_loc_2];
            return;
        }// end function

        public function destroy() : void
        {
            var _loc_1:DisplayObject = null;
            this.removeFrameScript();
            this.animation.unload();
            this.animation = null;
            this.anSetting = null;
            this.bodyBitmap.clear();
            while (this.numChildren > 0)
            {
                
                _loc_1 = this.removeChildAt(0);
                _loc_1.visible = false;
                _loc_1 = null;
            }
            if (this.extraSprite && this.extraSprite.parent != null)
            {
                this.extraSprite.parent.removeChild(this.extraSprite);
                this.extraSprite = null;
            }
            return;
        }// end function

        public function smoothingAvatar() : void
        {
            return;
        }// end function

        public function showAttackRange(param1:Number) : void
        {
            this.createAttackRange();
            this.cleanAttackRange();
            var _loc_4:int = 1;
            this.signCastRange.scaleY = 1;
            this.signCastRange.scaleX = _loc_4;
            var _loc_2:* = param1 * 2 / this.signCastRange.width;
            this.signCastRange.alpha = 0.2;
            TweenMax.to(this.signCastRange, 0.4, {scaleX:_loc_2, scaleY:_loc_2, alpha:0.5, delay:0.1, ease:Back.easeOut});
            var _loc_3:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            _loc_3.addChild(this.signCastRange);
            this.signCastRange.x = this.parent.x + this.x;
            this.signCastRange.y = this.parent.y + this.y;
            this.signCastRange.visible = true;
            this.signCastRange.mouseChildren = false;
            this.signCastRange.mouseEnabled = false;
            return;
        }// end function

        public function createAttackRange() : void
        {
            if (this.signCastRange == null)
            {
                this.signCastRange = new MovieClip();
                this.signCastRange = ResMgr.getInstance().getMovieClip("ViewCastRange") as MovieClip;
                this.sprite.addChildAt(this.signCastRange, 0);
                this.signCastRange.visible = false;
            }
            return;
        }// end function

        public function hideAttackRange() : void
        {
            var _loc_1:Number = NaN;
            if (this.signCastRange)
            {
                _loc_1 = 1;
                TweenMax.to(this.signCastRange, 0.3, {scaleX:_loc_1, scaleY:_loc_1, alpha:0.5, ease:Back.easeIn, onComplete:this.cleanAttackRange});
            }
            return;
        }// end function

        public function addShadow(param1:String, param2:int) : void
        {
            var _loc_4:Sprite = null;
            var _loc_3:String = "";
            switch(param1)
            {
                case BuildingType.WIZARD_TOWER:
                case BuildingType.ACHER_TOWER:
                case BuildingType.CANON:
                {
                    _loc_3 = Utility.getContentShadow(param1, param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_3 != "")
            {
                _loc_4 = ResMgr.getInstance().getMovieClip(_loc_3) as Sprite;
                this.addChildAt(_loc_4, 0);
            }
            return;
        }// end function

        public function hideShadow() : void
        {
            if (this.shadow == null)
            {
                return;
            }
            this.shadow.visible = false;
            return;
        }// end function

        private function cleanAttackRange() : void
        {
            if (this.signCastRange)
            {
                if (this.signCastRange.parent)
                {
                    this.signCastRange.parent.removeChild(this.signCastRange);
                }
                this.signCastRange.visible = false;
            }
            return;
        }// end function

    }
}
