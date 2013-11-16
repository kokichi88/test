package component.avatar.things
{
    import component.avatar.model.animation.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class MultiBitmap extends Bitmap
    {
        private var objs:Array;
        private var actionLink:Object;
        private var bmps:Object;
        private var offset:Point;
        public var setting:AnSetting;
        public var coreObj:BitmapObj;
        public var isLoaded:Boolean = false;

        public function MultiBitmap(param1:AnSetting, param2:BitmapObj)
        {
            this.offset = new Point();
            this.actionLink = {};
            this.bmps = {};
            this.objs = [];
            this.setting = param1;
            this.coreObj = param2;
            this.addObjEvent(this.coreObj);
            return;
        }// end function

        private function onObjVisible(event:Event) : void
        {
            return;
        }// end function

        public function draw() : void
        {
            var _loc_18:int = 0;
            var _loc_1:AnLoadData = null;
            var _loc_2:Object = null;
            var _loc_3:Object = null;
            var _loc_4:Object = null;
            var _loc_5:Rectangle = null;
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_8:BitmapObj = null;
            var _loc_9:AnLoadData = null;
            var _loc_10:Object = null;
            var _loc_11:Object = null;
            var _loc_12:Object = null;
            var _loc_13:Object = null;
            var _loc_14:Boolean = false;
            var _loc_15:BitmapData = null;
            var _loc_16:* = this.getBmpId(this.setting.currAction, this.setting.currDir, this.setting.currFrame);
            var _loc_17:* = this.bmps[_loc_16];
            if (this.bmps[_loc_16])
            {
                if (bitmapData != _loc_17.bitmapData || scaleX != _loc_17.scaleX)
                {
                    bitmapData = _loc_17.bitmapData;
                    scaleX = _loc_17.scaleX;
                    x = _loc_17.x;
                    y = _loc_17.y;
                }
                else
                {
                    bitmapData = _loc_17.bitmapData;
                    scaleX = _loc_17.scaleX;
                    x = _loc_17.x;
                    y = _loc_17.y;
                }
            }
            else
            {
                _loc_1 = this.coreObj.data;
                if (!_loc_1)
                {
                    return;
                }
                if (!_loc_1.ready)
                {
                    return;
                }
                _loc_2 = _loc_1[this.setting.currAction];
                if (!_loc_2)
                {
                    if (this.actionLink[this.setting.currAction] != null)
                    {
                        _loc_2 = _loc_1[this.actionLink[this.setting.currAction]];
                        if (!_loc_2)
                        {
                            bitmapData = null;
                            return;
                        }
                    }
                    else
                    {
                        bitmapData = null;
                        return;
                    }
                }
                _loc_3 = _loc_2.dirData[this.setting.currDir];
                if (_loc_3 == null)
                {
                    return;
                }
                _loc_4 = _loc_3.frames[this.setting.currFrame];
                if (_loc_4 && _loc_4.bitmapData)
                {
                    _loc_5 = _loc_4.rect.clone();
                    _loc_6 = [];
                    _loc_7 = 0;
                    while (_loc_7 < this.objs.length)
                    {
                        
                        _loc_8 = this.objs[_loc_7];
                        if (!_loc_8.visible)
                        {
                        }
                        else if (!_loc_8.defined)
                        {
                        }
                        else
                        {
                            _loc_9 = this.objs[_loc_7].data;
                            if (!_loc_9)
                            {
                            }
                            else if (!_loc_9.ready)
                            {
                            }
                            else
                            {
                                _loc_10 = _loc_9[this.setting.currAction];
                                if (!_loc_10)
                                {
                                }
                                else
                                {
                                    _loc_11 = _loc_10.dirData[this.setting.currDir];
                                    _loc_12 = _loc_11.frames[this.setting.currFrame];
                                    if (_loc_12 && _loc_12.bitmapData)
                                    {
                                        _loc_5 = _loc_5.union(_loc_12.rect);
                                        _loc_6.push(_loc_12);
                                    }
                                }
                            }
                        }
                        _loc_7++;
                    }
                    _loc_14 = false;
                    if (_loc_6.length)
                    {
                        this.offset.x = _loc_4.rect.x - _loc_5.x;
                        this.offset.y = _loc_4.rect.y - _loc_5.y;
                        _loc_15 = new BitmapData(_loc_5.width, _loc_5.height, true, 0);
                        _loc_15.copyPixels(_loc_4.bitmapData, _loc_4.bitmapData.rect, this.offset, null, null, true);
                        _loc_18 = 0;
                        while (_loc_18 < _loc_6.length)
                        {
                            
                            _loc_13 = _loc_6[_loc_18];
                            if (_loc_1.isfiler || true)
                            {
                            }
                            _loc_15.copyPixels(_loc_13.bitmapData, _loc_13.bitmapData.rect, new Point(_loc_13.rect.x - _loc_5.x, _loc_13.rect.y - _loc_5.y), null, null, true);
                            _loc_18++;
                        }
                    }
                    else
                    {
                        this.offset.x = 0;
                        this.offset.y = 0;
                        _loc_14 = true;
                        _loc_15 = _loc_4.bitmapData;
                    }
                    if (_loc_3.flip)
                    {
                        scaleX = -1;
                        x = -_loc_4.rect.x + this.setting.offset.x + this.offset.x;
                        y = _loc_4.rect.y + this.setting.offset.y - this.offset.y;
                    }
                    else
                    {
                        scaleX = 1;
                        x = _loc_4.rect.x + this.setting.offset.x - this.offset.x;
                        y = _loc_4.rect.y + this.setting.offset.y - this.offset.y;
                    }
                    this.isLoaded = true;
                    bitmapData = _loc_15;
                    this.bmps[_loc_16] = {bitmapData:_loc_15, scaleX:scaleX, x:x, y:y, body:_loc_14};
                }
            }
            return;
        }// end function

        private function getBmpId(param1:int, param2:int, param3:int) : String
        {
            return param1 + "_" + param2 + "_" + param3;
        }// end function

        private function addObjEvent(param1:BitmapObj) : void
        {
            param1.addEventListener(BitmapObj.VISIBLE, this.onObjVisible);
            param1.addEventListener(BitmapObj.COMPLETE, this.onObjVisible);
            param1.addEventListener(BitmapObj.UNLOAD, this.onObjVisible);
            return;
        }// end function

        public function clear() : void
        {
            this.clearBmps();
            return;
        }// end function

        public function setActionLink(param1:int, param2:int) : void
        {
            this.actionLink[param1] = param2;
            return;
        }// end function

        public function addObj(param1:BitmapObj) : void
        {
            this.objs.push(param1);
            this.addObjEvent(param1);
            return;
        }// end function

        public function nextFrame() : void
        {
            this.setting.setFrame(this.coreObj.data);
            return;
        }// end function

        private function clearBmps() : void
        {
            var _loc_1:String = null;
            var _loc_2:Object = null;
            for (_loc_1 in this.bmps)
            {
                
                _loc_2 = this.bmps[_loc_1];
                if (!_loc_2.body)
                {
                    _loc_2.bitmapData.dispose();
                }
                delete this.bmps[_loc_1];
            }
            bitmapData = null;
            return;
        }// end function

    }
}
