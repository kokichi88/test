package component
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import resMgr.*;

    public class BaseGui extends Object
    {
        private var fog:Sprite;
        public var bgImg:Sprite;
        public var autoAlign:String = "";
        private var hasInit:Boolean = false;
        public var img:MovieClip;
        protected var _isShowing:Boolean = false;
        public var widthBg:Number;
        public var heightBg:Number;
        private var isGUIMove:Boolean = false;
        private var isMove:Boolean = false;
        private var changeDx:Number = 0;
        private var changeDy:Number = 0;
        private var mouseDownDy:Number = 0;
        private var mouseDownDx:Number = 0;
        private var _enable:Boolean = false;
        public var bmpButtonList:Object;
        public var imageList:Object;
        public var guiList:Array;
        public var enableDisableScreen:Boolean = false;
        public var enableClickOutToClose:Boolean = false;
        public var disableScreenAlpha:Number = 0.01;
        public static const AUTO_ALIGN_LEFT:String = "left";
        public static const AUTO_ALIGN_LEFT_CENTER:String = "left_center";
        public static const AUTO_ALIGN_TOP_LEFT:String = "left_top";
        public static const AUTO_ALIGN_RIGHT:String = "right";
        public static const AUTO_ALIGN_RIGHT_TOP:String = "right_top";
        public static const AUTO_ALIGN_RIGHT_CENTER:String = "right_center";
        public static const AUTO_ALIGN_TOP:String = "top";
        public static const AUTO_ALIGN_TOP_CENTER:String = "top_center";
        public static const AUTO_ALIGN_BOTTOM:String = "bottom";
        public static const AUTO_ALIGN_BOTTOM_RIGHT:String = "bottom_right";
        public static const AUTO_ALIGN_BOTTOM_CENTER:String = "bottom_center";
        public static const AUTO_ALIGN_BOTTOM_LEFT:String = "bottom_left";
        public static const AUTO_ALIGN_CENTER:String = "center";

        public function BaseGui(param1:MovieClip, param2:Boolean = false)
        {
            this.bgImg = new Sprite();
            this.bmpButtonList = new Object();
            this.imageList = new Object();
            this.guiList = new Array();
            this.img = param1;
            this.bgImg.addChild(this.img);
            this.syncComponent();
            this.img.buttonMode = false;
            this.widthBg = this.img.width;
            this.heightBg = this.img.height;
            this.isGUIMove = param2;
            return;
        }// end function

        public function initNewGui(param1:MovieClip) : void
        {
            if (this.img && this.img.parent)
            {
                this.img.parent.removeChild(this.img);
                this.img = null;
            }
            this.img = param1;
            this.bgImg.addChild(this.img);
            this.syncComponent();
            this.img.buttonMode = false;
            this.widthBg = this.img.width;
            this.heightBg = this.img.height;
            return;
        }// end function

        public function addEventClickOutSideGui() : void
        {
            if (this.fog)
            {
                this.fog.addEventListener(MouseEvent.CLICK, this.onClickStage);
            }
            return;
        }// end function

        private function onClickStage(event:MouseEvent) : void
        {
            this.clickOutSideGui();
            return;
        }// end function

        public function clickOutSideGui() : void
        {
            if (!GlobalVar.SHOW_MESSAGE_BOX)
            {
                this.hide(true);
            }
            return;
        }// end function

        public function setMoveGui(param1:Boolean) : void
        {
            this.isGUIMove = param1;
            return;
        }// end function

        private function bgOnMouseDown(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as DisplayObject;
            if (_loc_2 == this.img)
            {
                this.isMove = true;
                this.changeDx = event.stageX - event.localX;
                this.changeDy = event.stageY - event.localY;
                this.mouseDownDx = event.localX;
                this.mouseDownDy = event.localY;
            }
            return;
        }// end function

        private function bgOnMouseUp(event:MouseEvent) : void
        {
            this.isMove = false;
            return;
        }// end function

        private function bgOnMouseMove(event:MouseEvent) : void
        {
            if (!this.isMove)
            {
                return;
            }
            this.bgImg.x = MouseMgr.getInstance().mousePos.x - this.mouseDownDx;
            this.bgImg.y = MouseMgr.getInstance().mousePos.y - this.mouseDownDy;
            return;
        }// end function

        public function setSizeBg(param1:Number, param2:Number) : void
        {
            this.widthBg = param1;
            this.heightBg = param2;
            return;
        }// end function

        public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            return;
        }// end function

        public function onDoubleClick(param1:String, param2:MouseEvent) : void
        {
            return;
        }// end function

        public function onMouseDown(param1:String, param2:MouseEvent) : void
        {
            return;
        }// end function

        public function onMouseOver(param1:String, param2:MouseEvent) : void
        {
            return;
        }// end function

        public function onMouseOut(param1:String, param2:MouseEvent) : void
        {
            return;
        }// end function

        public function onMouseMove(event:MouseEvent) : void
        {
            return;
        }// end function

        public function onMouseUp(event:MouseEvent) : void
        {
            return;
        }// end function

        public function loop() : void
        {
            return;
        }// end function

        public function setPos(param1:Number, param2:Number) : void
        {
            this.bgImg.x = param1;
            this.bgImg.y = param2;
            return;
        }// end function

        public function getPos() : Point
        {
            return new Point(this.bgImg.x, this.bgImg.y);
        }// end function

        public function processMouseClick(event:MouseEvent) : void
        {
            var _loc_5:String = null;
            var _loc_6:int = 0;
            if (!this._isShowing)
            {
                return;
            }
            var _loc_2:* = event.currentTarget as DisplayObject;
            if (_loc_2 == null)
            {
                return;
            }
            var _loc_3:* = _loc_2.name;
            var _loc_4:* = _loc_3.split("_");
            if (_loc_3.split("_").length < 2)
            {
                this.onMouseClick(_loc_3, event);
            }
            else
            {
                _loc_5 = "";
                _loc_6 = 0;
                while (_loc_6 < _loc_4.length)
                {
                    
                    _loc_5 = _loc_5 + _loc_4[_loc_6];
                    _loc_6++;
                }
                this.onMouseClick(_loc_5, event);
            }
            return;
        }// end function

        public function processDoubleClick(event:MouseEvent) : void
        {
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_2:* = event.currentTarget as DisplayObject;
            if (_loc_2 == null)
            {
                return;
            }
            var _loc_3:* = _loc_2.name;
            var _loc_4:* = _loc_3.split("_");
            if (_loc_3.split("_").length < 2)
            {
                this.onDoubleClick(_loc_3, event);
            }
            else
            {
                _loc_5 = "";
                _loc_6 = 0;
                while (_loc_6 < _loc_4.length)
                {
                    
                    _loc_5 = _loc_5 + _loc_4[_loc_6];
                    _loc_6++;
                }
                this.onDoubleClick(_loc_5, event);
            }
            return;
        }// end function

        private function processMouseDown(event:MouseEvent) : void
        {
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_2:* = event.currentTarget as DisplayObject;
            if (_loc_2 == null)
            {
                return;
            }
            var _loc_3:* = _loc_2.name;
            var _loc_4:* = _loc_3.split("_");
            if (_loc_3.split("_").length < 2)
            {
                this.onMouseDown(_loc_3, event);
            }
            else
            {
                _loc_5 = "";
                _loc_6 = 0;
                while (_loc_6 < _loc_4.length)
                {
                    
                    _loc_5 = _loc_5 + _loc_4[_loc_6];
                    _loc_6++;
                }
                this.onMouseDown(_loc_5, event);
            }
            return;
        }// end function

        private function processMouseOver(event:MouseEvent) : void
        {
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_2:* = event.currentTarget as DisplayObject;
            if (_loc_2 == null)
            {
                return;
            }
            var _loc_3:* = _loc_2.name;
            var _loc_4:* = _loc_3.split("_");
            if (_loc_3.split("_").length < 2)
            {
                this.onMouseOver(_loc_3, event);
            }
            else
            {
                _loc_5 = "";
                _loc_6 = 0;
                while (_loc_6 < _loc_4.length)
                {
                    
                    _loc_5 = _loc_5 + _loc_4[_loc_6];
                    _loc_6++;
                }
                this.onMouseOver(_loc_5, event);
            }
            return;
        }// end function

        private function processMouseOut(event:MouseEvent) : void
        {
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_2:* = event.currentTarget as DisplayObject;
            if (_loc_2 == null)
            {
                return;
            }
            var _loc_3:* = _loc_2.name;
            var _loc_4:* = _loc_3.split("_");
            if (_loc_3.split("_").length < 2)
            {
                this.onMouseOut(_loc_3, event);
            }
            else
            {
                _loc_5 = "";
                _loc_6 = 0;
                while (_loc_6 < _loc_4.length)
                {
                    
                    _loc_5 = _loc_5 + _loc_4[_loc_6];
                    _loc_6++;
                }
                this.onMouseOut(_loc_5, event);
            }
            return;
        }// end function

        private function syncComponent() : void
        {
            var _loc_2:Object = null;
            var _loc_3:DisplayObject = null;
            var _loc_4:Array = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:String = null;
            var _loc_10:String = null;
            var _loc_11:BitmapButton = null;
            var _loc_12:TextField = null;
            var _loc_13:TextField = null;
            var _loc_1:Array = [];
            _loc_7 = 0;
            while (_loc_7 < this.img.numChildren)
            {
                
                _loc_3 = this.img.getChildAt(_loc_7);
                _loc_9 = _loc_3.name;
                if (_loc_9 != "")
                {
                    _loc_4 = _loc_9.split("_");
                    if (_loc_4.length < 2)
                    {
                    }
                    else
                    {
                        _loc_10 = this.getName(_loc_4);
                        switch(_loc_4[0])
                        {
                            case "image":
                            {
                                if (_loc_10 in this)
                                {
                                    this[_loc_10] = _loc_3;
                                }
                                this.imageList[_loc_10] = _loc_3;
                                break;
                            }
                            case "button":
                            {
                                _loc_3.addEventListener(MouseEvent.CLICK, this.processMouseClick);
                                _loc_3.addEventListener(MouseEvent.MOUSE_DOWN, this.processMouseDown);
                                if (_loc_10 in this)
                                {
                                    this[_loc_10] = _loc_3;
                                }
                                break;
                            }
                            case "bmpButton":
                            {
                                _loc_11 = new BitmapButton(_loc_3 as MovieClip);
                                _loc_11.objId = _loc_10;
                                _loc_11.regEventHandler(this);
                                if (_loc_10 in this)
                                {
                                    this[_loc_10] = _loc_11;
                                }
                                this.bmpButtonList[_loc_4[1]] = _loc_11;
                                break;
                            }
                            case "bmp":
                            {
                                _loc_11 = new BitmapButton(_loc_3 as MovieClip, 1);
                                _loc_11.objId = _loc_10;
                                _loc_11.regEventHandler(this);
                                if (_loc_10 in this)
                                {
                                    this[_loc_10] = _loc_11;
                                }
                                this.bmpButtonList[_loc_4[1]] = _loc_11;
                                break;
                            }
                            case "bmp2":
                            {
                                _loc_11 = new BitmapButton(_loc_3 as MovieClip, 4);
                                _loc_11.objId = _loc_10;
                                _loc_11.regEventHandler(this);
                                if (_loc_10 in this)
                                {
                                    this[_loc_10] = _loc_11;
                                }
                                this.bmpButtonList[_loc_4[1]] = _loc_11;
                                break;
                            }
                            case "label":
                            {
                                _loc_12 = _loc_3 as TextField;
                                _loc_12.mouseEnabled = false;
                                if (_loc_10 in this)
                                {
                                    this[_loc_10] = _loc_12;
                                }
                                break;
                            }
                            case "textbox":
                            {
                                _loc_13 = _loc_3 as TextField;
                                if (_loc_10 in this)
                                {
                                    this[_loc_10] = _loc_13;
                                }
                                break;
                            }
                            default:
                            {
                                break;
                                break;
                            }
                        }
                    }
                }
                _loc_7++;
            }
            return;
        }// end function

        private function getName(param1:Array) : String
        {
            var _loc_2:* = param1[0] + param1[1];
            var _loc_3:int = 2;
            while (_loc_3 < param1.length)
            {
                
                _loc_2 = _loc_2 + ("_" + param1[_loc_3]);
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function addGui(param1:BaseGui, param2:String = "") : void
        {
            this.img.addChild(param1.bgImg);
            if (param2 != "")
            {
                param1.bgImg.addEventListener(MouseEvent.CLICK, this.processMouseClick);
                param1.bgImg.addEventListener(MouseEvent.DOUBLE_CLICK, this.processDoubleClick);
                param1.bgImg.addEventListener(MouseEvent.MOUSE_DOWN, this.processMouseDown);
                param1.bgImg.addEventListener(MouseEvent.MOUSE_OVER, this.processMouseOver);
                param1.bgImg.addEventListener(MouseEvent.MOUSE_OUT, this.processMouseOut);
                param1.bgImg.name = param2;
            }
            return;
        }// end function

        public function removeGui(param1:BaseGui) : void
        {
            var _loc_2:int = 0;
            param1.bgImg.removeEventListener(MouseEvent.CLICK, this.processMouseClick);
            param1.bgImg.removeEventListener(MouseEvent.DOUBLE_CLICK, this.processDoubleClick);
            param1.bgImg.removeEventListener(MouseEvent.MOUSE_DOWN, this.processMouseDown);
            param1.bgImg.removeEventListener(MouseEvent.MOUSE_OVER, this.processMouseOver);
            param1.bgImg.removeEventListener(MouseEvent.MOUSE_OUT, this.processMouseOut);
            if (this.img.contains(param1.bgImg))
            {
                this.img.removeChild(param1.bgImg);
            }
            _loc_2 = 0;
            while (_loc_2 < this.guiList.length)
            {
                
                if (this.guiList[_loc_2].id == param1.bgImg.name)
                {
                    this.guiList.splice(_loc_2, 1);
                    break;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function removeGuiById(param1:String) : void
        {
            var _loc_2:int = 0;
            var _loc_3:BaseGui = null;
            _loc_2 = 0;
            while (_loc_2 < this.guiList.length)
            {
                
                if (this.guiList[_loc_2].id == param1)
                {
                    _loc_3 = this.guiList[_loc_2].gui;
                    this.removeGui(_loc_3);
                    break;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function addGUI_Parent(param1:BaseGui, param2:String, param3:Boolean = true) : void
        {
            var _loc_4:* = new Object();
            _loc_4.gui = param1;
            _loc_4.id = param2;
            this.guiList.push(_loc_4);
            this.img.addChild(param1.bgImg);
            if (param3)
            {
                param1.bgImg.addEventListener(MouseEvent.CLICK, this.processMouseClick);
                param1.bgImg.addEventListener(MouseEvent.DOUBLE_CLICK, this.processDoubleClick);
                param1.bgImg.addEventListener(MouseEvent.MOUSE_DOWN, this.processMouseDown);
                param1.bgImg.addEventListener(MouseEvent.MOUSE_OVER, this.processMouseOver);
                param1.bgImg.addEventListener(MouseEvent.MOUSE_OUT, this.processMouseOut);
                param1.bgImg.name = param2;
            }
            return;
        }// end function

        public function getGUI_Parent(param1:String) : BaseGui
        {
            var _loc_2:* = this.guiList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this.guiList[_loc_3].id == param1)
                {
                    return this.guiList[_loc_3].gui;
                }
                _loc_3++;
            }
            return null;
        }// end function

        public function addBmpButton(param1:BitmapButton, param2:int = 0, param3:int = 0, param4:String = "") : void
        {
            this.img.addChild(param1.img);
            param1.setPos(param2, param3);
            param1.regEventHandler(this);
            param1.objId = param4;
            return;
        }// end function

        public function addMovieClip(param1:MovieClip, param2:int = 0, param3:int = 0, param4:String = "") : void
        {
            this.img.addChild(param1);
            param1.x = param2;
            param1.y = param3;
            if (param4 != "")
            {
                param1.addEventListener(MouseEvent.CLICK, this.processMouseClick);
                param1.addEventListener(MouseEvent.DOUBLE_CLICK, this.processDoubleClick);
                param1.addEventListener(MouseEvent.MOUSE_DOWN, this.processMouseDown);
                param1.addEventListener(MouseEvent.MOUSE_OVER, this.processMouseOver);
                param1.addEventListener(MouseEvent.MOUSE_OUT, this.processMouseOut);
                param1.name = param4;
            }
            return;
        }// end function

        public function addLabel(param1:String, param2:int = 0, param3:int = 0, param4:String = "", param5:EmbedFormat = null) : void
        {
            var _loc_7:EmbedFormat = null;
            var _loc_6:* = new TextField();
            _loc_6.mouseEnabled = false;
            _loc_6.text = param1;
            _loc_6.mouseEnabled = false;
            _loc_6.embedFonts = true;
            this.img.addChild(_loc_6);
            _loc_6.x = param2;
            _loc_6.y = param3;
            if (param4 != "")
            {
                this[param4] = _loc_6;
            }
            if (param5)
            {
                _loc_6.setTextFormat(param5);
                _loc_6.defaultTextFormat = param5;
            }
            else
            {
                _loc_7 = new EmbedFormat();
                _loc_6.setTextFormat(_loc_7);
                _loc_6.defaultTextFormat = _loc_7;
            }
            return;
        }// end function

        public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            var _loc_3:Bitmap = null;
            var _loc_4:BitmapData = null;
            var _loc_5:Sprite = null;
            if (this.img != null)
            {
            }
            if (param1 == null)
            {
                param1 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI);
            }
            this.bgImg.visible = true;
            param1.addChild(this.bgImg);
            this._isShowing = true;
            this.updatePos();
            this.bgImg.visible = false;
            if (this.isGUIMove)
            {
                GlobalVar.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.bgOnMouseMove);
                GlobalVar.stage.addEventListener(MouseEvent.MOUSE_UP, this.bgOnMouseUp);
                this.img.addEventListener(MouseEvent.MOUSE_DOWN, this.bgOnMouseDown);
            }
            if (param2)
            {
                _loc_4 = new BitmapData(this.img.width, this.img.height, true, 0);
                _loc_4.draw(this.img, null, null, null, null, true);
                _loc_3 = new Bitmap(_loc_4);
                _loc_5 = new Sprite();
                _loc_5.addChild(_loc_3);
                _loc_3.x = (-this.widthBg) / 2;
                _loc_3.y = (-this.heightBg) / 2;
                LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI).addChild(_loc_5);
                _loc_5.x = this.bgImg.x + this.widthBg / 2;
                _loc_5.y = this.bgImg.y + this.heightBg / 2;
                var _loc_6:Number = 1.8;
                _loc_5.scaleY = 1.8;
                _loc_5.scaleX = _loc_6;
                _loc_5.alpha = 0;
                TweenMax.to(_loc_5, 0.25, {alpha:1});
                TweenMax.to(_loc_5, 0.3, {scaleX:1, scaleY:1, ease:Back.easeOut, onComplete:this.onCompleteTweenShow, onCompleteParams:[_loc_5]});
            }
            else
            {
                this.bgImg.visible = true;
            }
            if (this.enableDisableScreen)
            {
                this.showDisableScreen(this.disableScreenAlpha);
            }
            return;
        }// end function

        public function onCompleteTweenShow(param1:Sprite) : void
        {
            param1.parent.removeChild(param1);
            this.bgImg.visible = true;
            if (this.enableClickOutToClose)
            {
                this.addEventClickOutSideGui();
            }
            return;
        }// end function

        public function hide(param1:Boolean = false) : void
        {
            var _loc_2:Bitmap = null;
            var _loc_3:BitmapData = null;
            var _loc_4:Sprite = null;
            this.bgImg.visible = false;
            this._isShowing = false;
            if (this.isGUIMove)
            {
                GlobalVar.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.bgOnMouseMove);
                GlobalVar.stage.removeEventListener(MouseEvent.MOUSE_UP, this.bgOnMouseUp);
                this.img.removeEventListener(MouseEvent.MOUSE_DOWN, this.bgOnMouseDown);
            }
            if (param1)
            {
                _loc_3 = new BitmapData(this.img.width, this.img.height, true, 0);
                _loc_3.draw(this.img, null, null, null, null, true);
                _loc_2 = new Bitmap(_loc_3);
                _loc_4 = new Sprite();
                _loc_4.addChild(_loc_2);
                _loc_2.x = (-this.widthBg) / 2;
                _loc_2.y = (-this.heightBg) / 2;
                LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI).addChild(_loc_4);
                _loc_4.x = this.bgImg.x + this.widthBg / 2;
                _loc_4.y = this.bgImg.y + this.heightBg / 2;
                _loc_4.alpha = 1;
                TweenMax.to(_loc_4, 0.2, {alpha:0.5, scaleX:1.1, scaleY:1.1, onComplete:this.onCompleteHide1, onCompleteParams:[_loc_4]});
            }
            this.hideDisableScreen();
            if (this.fog)
            {
                this.fog.removeEventListener(MouseEvent.CLICK, this.onClickStage);
            }
            return;
        }// end function

        private function onCompleteHide1(param1:Sprite) : void
        {
            TweenMax.to(param1, 0.1, {alpha:0, scaleX:0.8, scaleY:0.8, onComplete:this.onCompleteHide2, onCompleteParams:[param1]});
            return;
        }// end function

        private function onCompleteHide2(param1:Sprite) : void
        {
            param1.parent.removeChild(param1);
            return;
        }// end function

        public function get isShowing() : Boolean
        {
            return this._isShowing;
        }// end function

        public function set isShowing(param1:Boolean) : void
        {
            this._isShowing = param1;
            return;
        }// end function

        public function get enable() : Boolean
        {
            return this._enable;
        }// end function

        public function set enable(param1:Boolean) : void
        {
            this._enable = param1;
            this.bgImg.mouseEnabled = this._enable;
            this.bgImg.mouseChildren = this._enable;
            if (!param1)
            {
                this.img.filters = [BitmapButton.disableFilter];
            }
            else
            {
                this.img.filters = [];
            }
            return;
        }// end function

        protected function updatePos() : void
        {
            if (this.img == null)
            {
                return;
            }
            if (this.img.stage == null)
            {
                return;
            }
            var _loc_1:int = 5;
            var _loc_2:Boolean = true;
            switch(this.autoAlign)
            {
                case AUTO_ALIGN_TOP:
                {
                    this.setPos(_loc_1, _loc_1);
                    break;
                }
                case AUTO_ALIGN_TOP_CENTER:
                {
                    this.setPos((GlobalVar.SCREEN_WIDTH - this.widthBg) / 2, 0);
                    break;
                }
                case AUTO_ALIGN_TOP_LEFT:
                {
                    this.setPos(_loc_1, _loc_1);
                    break;
                }
                case AUTO_ALIGN_RIGHT_TOP:
                {
                    this.setPos(GlobalVar.SCREEN_WIDTH - this.widthBg - 15, 0);
                    break;
                }
                case AUTO_ALIGN_CENTER:
                {
                    this.setPos((GlobalVar.SCREEN_WIDTH - this.widthBg) / 2, Math.max((GlobalVar.SCREEN_HEIGHT - this.heightBg) / 2, -20));
                    break;
                }
                case AUTO_ALIGN_BOTTOM_CENTER:
                {
                    this.setPos((GlobalVar.SCREEN_WIDTH - this.widthBg) / 2, GlobalVar.SCREEN_HEIGHT - this.heightBg);
                    break;
                }
                case AUTO_ALIGN_BOTTOM:
                {
                    this.setPos(0, GlobalVar.SCREEN_HEIGHT - this.heightBg);
                    break;
                }
                case AUTO_ALIGN_BOTTOM_RIGHT:
                {
                    this.setPos(GlobalVar.SCREEN_WIDTH - this.widthBg, GlobalVar.SCREEN_HEIGHT - this.heightBg);
                    break;
                }
                case AUTO_ALIGN_BOTTOM_LEFT:
                {
                    this.setPos(_loc_1, GlobalVar.SCREEN_HEIGHT - this.heightBg);
                    break;
                }
                case AUTO_ALIGN_RIGHT:
                {
                    this.setPos(GlobalVar.SCREEN_WIDTH - this.widthBg, _loc_1);
                    break;
                }
                case AUTO_ALIGN_RIGHT_CENTER:
                {
                    this.setPos(GlobalVar.SCREEN_WIDTH - this.widthBg - 15, (GlobalVar.SCREEN_HEIGHT - this.heightBg) / 2);
                    break;
                }
                case AUTO_ALIGN_LEFT:
                {
                    this.bgImg.x = _loc_1;
                    break;
                }
                case AUTO_ALIGN_LEFT_CENTER:
                {
                    this.setPos(_loc_1, (GlobalVar.SCREEN_HEIGHT - this.heightBg) / 2);
                    break;
                }
                default:
                {
                    _loc_2 = false;
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function showDisableScreen(param1:Number) : void
        {
            var _loc_2:int = 0;
            if (this.fog == null)
            {
                this.fog = ResMgr.getInstance().getMovieClip("Square") as Sprite;
                this.fog.alpha = param1;
                this.fog.cacheAsBitmap = true;
                this.fog.width = GlobalVar.SCREEN_WIDTH;
                this.fog.height = GlobalVar.SCREEN_HEIGHT;
            }
            this.hideDisableScreen();
            if (this.img != null && this.bgImg != null && this.bgImg.parent != null)
            {
                _loc_2 = this.bgImg.parent.getChildIndex(this.bgImg);
                this.bgImg.parent.addChildAt(this.fog, _loc_2);
            }
            return;
        }// end function

        public function hideDisableScreen() : void
        {
            if (this.fog != null && this.fog.parent != null)
            {
                this.fog.parent.removeChild(this.fog);
            }
            return;
        }// end function

        public function resize() : void
        {
            if (this._isShowing)
            {
                this.show();
            }
            return;
        }// end function

        public function destroyBaseGUI() : void
        {
            while (this.bgImg.numChildren > 0)
            {
                
                this.bgImg.removeChildAt(0);
            }
            this.bgImg = null;
            this.img = null;
            this.fog = null;
            this.bmpButtonList = null;
            return;
        }// end function

    }
}
