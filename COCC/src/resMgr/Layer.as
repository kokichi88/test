package resMgr
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import component.avatar.things.*;
    import flash.display.*;
    import flash.geom.*;

    public class Layer extends Sprite
    {
        private var Fog:Sprite = null;
        private var __fillLayer:Sprite;
        private var saveTween:TweenMax = null;
        private var saveTween2:TweenMax = null;
        public var IdLayer:int;
        private var signCastRange:Sprite;
        private var signSafeZone:Sprite;

        public function Layer(param1:int)
        {
            this.IdLayer = param1;
            return;
        }// end function

        public function get fog() : Sprite
        {
            return this.Fog;
        }// end function

        public function SetPos(param1:int, param2:int) : void
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function ShowDisableScreen(param1:Number, param2:int = 0) : void
        {
            var _loc_3:* = stage.stageWidth + 2000;
            var _loc_4:* = stage.stageHeight + 2000;
            if (this.Fog != null && this.Fog.parent)
            {
                this.Fog.parent.removeChild(this.Fog);
            }
            this.Fog = new Sprite();
            this.Fog.graphics.beginFill(0, param1);
            this.Fog.graphics.drawRect(0, 0, _loc_3, _loc_4);
            this.Fog.graphics.endFill();
            addChildAt(this.Fog, 0);
            return;
        }// end function

        public function HideDisableScreen() : void
        {
            if (this.Fog && this.Fog.parent)
            {
                this.Fog.parent.removeChild(this.Fog);
                this.Fog = null;
            }
            return;
        }// end function

        public function showFog(param1:Number, param2:int = 0) : void
        {
            this.ShowDisableScreen(param1, param2);
            return;
        }// end function

        public function hideFog() : void
        {
            this.HideDisableScreen();
            return;
        }// end function

        public function PanX(param1:int) : void
        {
            this.x = this.x + param1;
            return;
        }// end function

        public function PanY(param1:int) : void
        {
            this.y = this.y + param1;
            return;
        }// end function

        public function Empty() : void
        {
            var _loc_1:int = 0;
            while (numChildren > 0)
            {
                
                removeChildAt(0);
            }
            this.Fog = null;
            return;
        }// end function

        public function ShowTutorialScreen(param1:int, param2:int, param3:int, param4:int = 1) : void
        {
            var _loc_5:* = stage.stageWidth;
            var _loc_6:* = stage.stageHeight;
            if (this.Fog != null)
            {
                removeChild(this.Fog);
            }
            this.Fog = new Sprite();
            addChild(this.Fog);
            this.Fog.graphics.clear();
            this.Fog.graphics.beginFill(0, 0.5);
            this.Fog.graphics.drawRect(0, 0, _loc_5, _loc_6);
            this.Fog.graphics.drawCircle(param1, param2, param3);
            this.Fog.graphics.endFill();
            if (param4 == 0)
            {
                this.Fog.alpha = 0;
            }
            return;
        }// end function

        public function ShowTutorialScreenRect(param1:int, param2:int, param3:int, param4:int, param5:int = 1) : void
        {
            var _loc_6:* = stage.stageWidth;
            var _loc_7:* = stage.stageHeight;
            if (this.Fog != null)
            {
                removeChild(this.Fog);
            }
            this.Fog = new Sprite();
            addChild(this.Fog);
            this.Fog.graphics.clear();
            this.Fog.graphics.beginFill(0, 0.5);
            this.Fog.graphics.drawRect(0, 0, _loc_6, _loc_7);
            this.Fog.graphics.drawRoundRect(param1, param2, param3, param4, 10);
            this.Fog.graphics.endFill();
            if (param5 == 0)
            {
                this.Fog.alpha = 0;
            }
            return;
        }// end function

        public function fillLayer(param1:int = 0) : void
        {
            this.__fillLayer = new Sprite();
            this.__fillLayer.graphics.beginFill(param1);
            this.__fillLayer.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
            this.__fillLayer.graphics.endFill();
            addChild(this.__fillLayer);
            return;
        }// end function

        public function clearFillLayer() : void
        {
            if (this.__fillLayer)
            {
                removeChild(this.__fillLayer);
                this.__fillLayer = null;
            }
            return;
        }// end function

        public function clear() : void
        {
            while (numChildren > 0)
            {
                
                removeChildAt(0);
            }
            this.Fog = null;
            return;
        }// end function

        public function showAttackRange(param1:Avatar, param2:Number, param3:int = 0) : void
        {
            if (!param1 || !param1.parent)
            {
                return;
            }
            this.createAttackRange();
            this.cleanAttackRange();
            var _loc_5:int = 1;
            this.signCastRange.scaleY = 1;
            this.signCastRange.scaleX = _loc_5;
            var _loc_4:* = param2 * 2 / this.signCastRange.width;
            this.signCastRange.alpha = 0.2;
            this.saveTween = TweenMax.to(this.signCastRange, 0.4, {scaleX:_loc_4, scaleY:_loc_4, alpha:0.5, delay:0.1, ease:Back.easeOut});
            this.addChild(this.signCastRange);
            this.signCastRange.x = param1.parent.x + param1.x;
            this.signCastRange.y = param1.parent.y + param1.y;
            this.signCastRange.visible = true;
            this.signCastRange.mouseChildren = false;
            this.signCastRange.mouseEnabled = false;
            if (param3 > 0)
            {
                var _loc_5:int = 1;
                this.signSafeZone.scaleY = 1;
                this.signSafeZone.scaleX = _loc_5;
                _loc_4 = param3 * 2 / this.signSafeZone.width;
                this.signSafeZone.alpha = 0.2;
                this.saveTween2 = TweenMax.to(this.signSafeZone, 0.4, {scaleX:_loc_4, scaleY:_loc_4, alpha:0.5, delay:0.1, ease:Back.easeOut});
                this.addChild(this.signSafeZone);
                this.signSafeZone.x = param1.parent.x + param1.x;
                this.signSafeZone.y = param1.parent.y + param1.y;
                this.signSafeZone.visible = true;
                this.signSafeZone.mouseChildren = false;
                this.signSafeZone.mouseEnabled = false;
            }
            return;
        }// end function

        public function showAttackRange2(param1:Point, param2:Number, param3:int = 0) : void
        {
            this.createAttackRange();
            this.cleanAttackRange();
            var _loc_5:int = 1;
            this.signCastRange.scaleY = 1;
            this.signCastRange.scaleX = _loc_5;
            var _loc_4:* = param2 * 2 / this.signCastRange.width;
            this.signCastRange.alpha = 0.2;
            this.saveTween = TweenMax.to(this.signCastRange, 0.4, {scaleX:_loc_4, scaleY:_loc_4, alpha:0.5, delay:0.1, ease:Back.easeOut});
            this.addChild(this.signCastRange);
            this.signCastRange.x = param1.x;
            this.signCastRange.y = param1.y;
            this.signCastRange.visible = true;
            this.signCastRange.mouseChildren = false;
            this.signCastRange.mouseEnabled = false;
            if (param3 > 0)
            {
                var _loc_5:int = 1;
                this.signSafeZone.scaleY = 1;
                this.signSafeZone.scaleX = _loc_5;
                _loc_4 = param3 * 2 / this.signSafeZone.width;
                this.signSafeZone.alpha = 0.2;
                TweenMax.to(this.signSafeZone, 0.4, {scaleX:_loc_4, scaleY:_loc_4, alpha:0.5, delay:0.1, ease:Back.easeOut});
                this.addChild(this.signSafeZone);
                this.signSafeZone.x = param1.x;
                this.signSafeZone.y = param1.y;
                this.signSafeZone.visible = true;
                this.signSafeZone.mouseChildren = false;
                this.signSafeZone.mouseEnabled = false;
            }
            this.graphics.beginFill(16711680, 0.3);
            this.graphics.drawEllipse(param1.x - param2, param1.y - param2 * 0.75, 2 * param2, param2 * 1.5);
            this.graphics.endFill();
            return;
        }// end function

        public function createAttackRange() : void
        {
            if (this.signCastRange == null)
            {
                this.signCastRange = new Sprite();
                this.signCastRange = ResMgr.getInstance().getMovieClip("ViewCastRange") as Sprite;
            }
            if (this.signSafeZone == null)
            {
                this.signSafeZone = new Sprite();
                this.signSafeZone = ResMgr.getInstance().getMovieClip("ViewSafeRange") as Sprite;
            }
            return;
        }// end function

        public function hideAttackRange(param1:Boolean = true) : void
        {
            var _loc_2:Number = NaN;
            if (this.signCastRange)
            {
                if (this.saveTween)
                {
                    this.saveTween.kill();
                    this.saveTween = null;
                }
                if (param1)
                {
                    _loc_2 = 1;
                    TweenMax.to(this.signCastRange, 0.3, {scaleX:_loc_2, scaleY:_loc_2, alpha:0.5, ease:Back.easeIn, onComplete:this.cleanAttackRange});
                }
                else
                {
                    this.signCastRange.alpha = 0;
                }
            }
            if (this.signSafeZone)
            {
                if (this.saveTween2)
                {
                    this.saveTween2.kill();
                    this.saveTween2 = null;
                }
                if (param1)
                {
                    _loc_2 = 1;
                    TweenMax.to(this.signSafeZone, 0.3, {scaleX:_loc_2, scaleY:_loc_2, alpha:0.5, ease:Back.easeIn});
                }
                else
                {
                    this.signSafeZone.alpha = 0;
                }
            }
            this.graphics.clear();
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
            if (this.signSafeZone)
            {
                if (this.signSafeZone.parent)
                {
                    this.signSafeZone.parent.removeChild(this.signSafeZone);
                }
                this.signSafeZone.visible = false;
            }
            return;
        }// end function

    }
}
