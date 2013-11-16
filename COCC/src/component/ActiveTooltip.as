package component
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import resMgr.*;

    public class ActiveTooltip extends Object
    {
        private var img:Sprite = null;
        private var arrow:Sprite = null;
        private var txt:DisplayObject = null;
        private var myImg:Sprite = null;
        private var myTxt:DisplayObject = null;
        private var iconNext:DisplayObject = null;
        private var CurObj:Object = null;
        private var IsShow:Boolean = false;
        private var CountDownShow:int = 0;
        private var CountDownHide:int = 0;
        private var Color:ColorTransform;
        public var Parent:Sprite;
        private var deltaX:Number = 0;
        private var deltaY:Number = 0;
        private static var instance:ActiveTooltip;
        private static const ACTIVE_TIP_WIDTH:int = 250;
        public static var hasInit:Boolean = false;

        public function ActiveTooltip(param1:Sprite)
        {
            this.Color = new ColorTransform(0.9, 0.9, 0.9, 0.9);
            this.Parent = param1;
            this.arrow = ResMgr.getInstance().getMovieClip("Arrow") as Sprite;
            this.img = ResMgr.getInstance().getMovieClip("ActiveTipFrame") as Sprite;
            this.img.mouseChildren = false;
            this.img.mouseEnabled = false;
            if (this.Color != null)
            {
                this.arrow.transform.colorTransform = this.Color;
                this.img.transform.colorTransform = this.Color;
            }
            return;
        }// end function

        public function showNewTooltipText(param1:String, param2:DisplayObject) : void
        {
            var _loc_3:* = new TooltipText();
            var _loc_4:* = _loc_3.defaultTextFormat;
            _loc_3.defaultTextFormat.bold = true;
            _loc_4.color = 16777215;
            _loc_4.font = "Tahoma";
            _loc_4.size = 11;
            _loc_3.defaultTextFormat = _loc_4;
            _loc_3.text = param1;
            this.showNewTooltip(_loc_3, param2);
            return;
        }// end function

        public function setPos(param1:Number, param2:Number) : void
        {
            if (this.Parent)
            {
                this.deltaX = param1;
                this.deltaY = param2;
                this.Parent.x = this.Parent.x + this.deltaX;
                this.Parent.y = this.Parent.y + this.deltaY;
            }
            return;
        }// end function

        public function onFrame(param1:String) : void
        {
            if (this.txt as TextField)
            {
                (this.txt as TextField).text = param1;
            }
            return;
        }// end function

        public function showNewTooltip(param1:DisplayObject, param2:DisplayObject, param3:Boolean = false) : void
        {
            var _loc_9:Rectangle = null;
            this.clearTooltip();
            if (param2.stage == null)
            {
                return;
            }
            if (param1 == null || param2 == null)
            {
                return;
            }
            var _loc_4:* = (-(param2.stage.stageWidth - GlobalVar.SCREEN_WIDTH)) / 2 + 10;
            var _loc_5:* = (-(param2.stage.stageHeight - GlobalVar.SCREEN_HEIGHT)) / 2 + 10;
            this.CountDownShow = 5;
            this.CountDownHide = 500;
            this.txt = param1;
            this.IsShow = true;
            this.CurObj = param2;
            this.Parent.addChild(this.arrow);
            this.Parent.addChild(this.img);
            this.Parent.addChild(this.txt);
            this.img.visible = false;
            this.txt.visible = false;
            this.arrow.visible = false;
            var _loc_6:int = 10;
            var _loc_7:* = this.txt.width + 1.2 * _loc_6;
            var _loc_8:* = this.txt.height + 1.2 * _loc_6;
            if (param1 is TextField)
            {
                _loc_7 = TextField(param1).textWidth + _loc_6;
                _loc_8 = TextField(param1).textHeight + 2 * _loc_6;
            }
            if (_loc_7 > 30)
            {
                this.img.scaleX = _loc_7 / 100;
            }
            if (_loc_8 > 10)
            {
                this.img.scaleY = _loc_8 / 100;
            }
            var _loc_10:* = param2.parent.localToGlobal(new Point(param2.x, param2.y));
            if (param3)
            {
                _loc_10.y = _loc_10.y - 50;
            }
            var _loc_11:* = new Rectangle(_loc_10.x, _loc_10.y, param2.width, param2.height);
            this.img.x = _loc_11.left - 20 - GlobalVar.rootSprite.x;
            this.img.y = _loc_11.top - this.img.height - 10 - GlobalVar.rootSprite.y;
            this.arrow.rotationZ = 0;
            _loc_9 = this.img.getBounds(this.img.parent);
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:int = 0;
            if (_loc_9.left <= _loc_4)
            {
                this.img.x = this.img.x + (_loc_4 - _loc_9.left);
            }
            if (_loc_9.right >= this.img.stage.stageWidth - 10)
            {
                this.img.x = this.img.x + (-(_loc_9.right - this.img.stage.stageWidth + 10));
            }
            if (_loc_9.top < _loc_5)
            {
                this.img.y = _loc_11.bottom;
            }
            _loc_9 = this.img.getBounds(this.img.parent);
            this.arrow.x = _loc_11.left + _loc_11.width / 2 - 10;
            if (this.arrow.x < _loc_9.left + 30)
            {
                this.arrow.x = _loc_9.left + 30;
            }
            if (this.arrow.x > _loc_9.right - 30)
            {
                this.arrow.x = _loc_9.right - 30;
            }
            if (_loc_9.right < this.img.stage.stageWidth - 10)
            {
                if (this.img.y != _loc_11.bottom)
                {
                    this.arrow.y = _loc_9.bottom - 1;
                }
                else
                {
                    this.arrow.y = _loc_9.top;
                    this.arrow.rotationZ = 180;
                    this.arrow.x = this.arrow.x + 10;
                }
            }
            else if (this.img.y != _loc_11.bottom)
            {
                this.arrow.y = _loc_9.bottom - 1;
            }
            else
            {
                this.arrow.y = _loc_9.top;
                this.arrow.rotationZ = 180;
                this.arrow.x = this.arrow.x + 10;
            }
            this.txt.x = _loc_9.left + (_loc_9.width - _loc_7 + _loc_6) / 2;
            this.txt.y = _loc_9.top + _loc_6;
            this.img.visible = true;
            this.txt.visible = true;
            this.arrow.visible = true;
            return;
        }// end function

        private function resetPos() : void
        {
            if (this.Parent)
            {
                this.Parent.x = this.Parent.x - this.deltaX;
                this.Parent.y = this.Parent.y - this.deltaY;
                this.deltaY = 0;
                this.deltaX = 0;
            }
            return;
        }// end function

        public function clearTooltip() : void
        {
            this.Parent.graphics.clear();
            this.resetPos();
            if (this.IsShow)
            {
                this.Parent.removeChild(this.img);
                if (this.txt && this.txt.parent)
                {
                    this.txt.parent.removeChild(this.txt);
                }
                this.Parent.removeChild(this.arrow);
                if (this.myTxt != null)
                {
                    this.Parent.removeChild(this.myImg);
                    this.Parent.removeChild(this.myTxt);
                    this.myTxt = null;
                }
                if (this.iconNext != null)
                {
                    this.Parent.removeChild(this.iconNext);
                    this.iconNext = null;
                }
                this.CurObj = null;
                this.IsShow = false;
                this.CountDownHide = 0;
                this.CountDownShow = 0;
            }
            return;
        }// end function

        public function getTextTooltip(param1:String) : DisplayObjectContainer
        {
            var _loc_2:* = new Sprite();
            var _loc_3:* = new TextField();
            var _loc_4:* = _loc_3.defaultTextFormat;
            _loc_3.defaultTextFormat.bold = true;
            _loc_4.color = 16777215;
            _loc_4.font = "Tahoma";
            _loc_4.size = 11;
            _loc_3.defaultTextFormat = _loc_4;
            _loc_3.autoSize = TextFieldAutoSize.LEFT;
            _loc_3.text = param1;
            var _loc_5:* = ResMgr.getInstance().getMovieClip("Arrow") as Sprite;
            var _loc_6:* = ResMgr.getInstance().getMovieClip("ActiveTipFrame") as Sprite;
            (ResMgr.getInstance().getMovieClip("ActiveTipFrame") as Sprite).mouseChildren = false;
            _loc_6.mouseEnabled = false;
            _loc_6.width = _loc_3.width + 20;
            _loc_6.height = _loc_3.height + 20;
            _loc_3.x = 10;
            _loc_3.y = 10;
            _loc_5.y = _loc_6.height;
            _loc_5.x = (_loc_6.width - _loc_5.width) / 2;
            _loc_2.addChild(_loc_6);
            _loc_2.addChild(_loc_3);
            _loc_2.addChild(_loc_5);
            return _loc_2;
        }// end function

        public function update() : void
        {
            if (this.CurObj != null && this.CurObj.parent != null)
            {
                if (this.CountDownShow > 0)
                {
                    this.CountDownShow--;
                    if (this.CountDownShow <= 0)
                    {
                        this.txt.visible = true;
                        this.img.visible = true;
                        this.arrow.visible = true;
                        if (this.myTxt != null)
                        {
                            this.myImg.visible = true;
                            this.myTxt.visible = true;
                        }
                        if (this.iconNext != null)
                        {
                            this.iconNext.visible = true;
                        }
                    }
                }
                if (this.CountDownHide > 0)
                {                   
                    this.CountDownHide--;
                    if (this.CountDownHide <= 0)
                    {
                        this.clearTooltip();
                    }
                }
            }
            else if (this.IsShow)
            {
                this.clearTooltip();
            }
            return;
        }// end function

        public static function getInstance(param1:Sprite = null) : ActiveTooltip
        {
            if (instance == null)
            {
                instance = new ActiveTooltip(param1);
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
