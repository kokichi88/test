package component.avatar.things
{
    import component.avatar.model.animation.*;
    import flash.display.*;

    public class AnimationBitmap extends Bitmap
    {
        private var _name:String;
        private var _data:AnLoadData;
        private var _flip:Boolean = false;
        public var setting:AnSetting;
        private var actionLink:Object;
        private var _category:String;

        public function AnimationBitmap(param1:AnSetting = null)
        {
            this.actionLink = {};
            this.setting = param1;
            if (!param1)
            {
                this.setting = new AnSetting();
            }
            return;
        }// end function

        public function setView() : void
        {
            this.draw();
            this.nextFrame();
            return;
        }// end function

        public function draw() : void
        {
            var _loc_1:Object = null;
            var _loc_2:Object = null;
            var _loc_3:Object = null;
            if (!this._data)
            {
                return;
            }
            if (this._data.ready)
            {
                _loc_1 = this._data[this.setting.currAction];
                if (!_loc_1)
                {
                    if (this.actionLink[this.setting.currAction] != undefined)
                    {
                        _loc_1 = this._data[this.actionLink[this.setting.currAction]];
                        if (!_loc_1)
                        {
                            this.bitmapData = null;
                            return;
                        }
                    }
                    else
                    {
                        this.bitmapData = null;
                        return;
                    }
                }
                _loc_2 = _loc_1.dirData[this.setting.currDir];
                if (!_loc_2)
                {
                    return;
                }
                _loc_3 = _loc_2.frames[this.setting.currFrame];
                if (_loc_3 && _loc_3.bitmapData)
                {
                    if (_loc_3.bitmapData != this.bitmapData || this._flip != _loc_2.flip)
                    {
                        this.bitmapData = _loc_3.bitmapData;
                        if (_loc_2.flip)
                        {
                            if (this.scaleX != -1)
                            {
                                this.scaleX = -1;
                            }
                            this._flip = true;
                            this.x = -_loc_3.rect.x + this.setting.offset.x;
                            this.y = _loc_3.rect.y + this.setting.offset.y;
                        }
                        else
                        {
                            if (this.scaleX != 1)
                            {
                                this.scaleX = 1;
                            }
                            this._flip = false;
                            this.x = _loc_3.rect.x + this.setting.offset.x;
                            this.y = _loc_3.rect.y + this.setting.offset.y;
                        }
                    }
                }
            }
            return;
        }// end function

        public function load() : void
        {
            if (this._data && !this._data.loaded)
            {
                GlobalVar.animationManager.load(this._data);
            }
            return;
        }// end function

        public function get defined() : Boolean
        {
            return this._data != null;
        }// end function

        public function clear() : void
        {
            this.bitmapData = null;
            return;
        }// end function

        public function get data() : AnLoadData
        {
            return this._data;
        }// end function

        public function setSource(param1:String, param2:String, param3:int = 0) : void
        {
            if (this._category != param1 || this._name != param2)
            {
                if (this._data)
                {
                    var _loc_4:* = this._data;
                    var _loc_5:* = this._data.ref - 1;
                    _loc_4.ref = _loc_5;
                }
                this._category = param1;
                this._name = param2;
                this._data = GlobalVar.animationManager.getAnimation(param1, param2);
                this.x = this._data.x;
                this.y = this._data.y;
                if (this._data)
                {
                    var _loc_4:* = this._data;
                    var _loc_5:* = this._data.ref + 1;
                    _loc_4.ref = _loc_5;
                }
                if (param3 > this._data.priority)
                {
                    this._data.priority = param3;
                }
                this.bitmapData = null;
                this._flip = false;
            }
            return;
        }// end function

        public function setActionLink(param1:int, param2:int) : void
        {
            this.actionLink[param1] = param2;
            return;
        }// end function

        public function nextFrame() : void
        {
            this.setting.setFrame(this._data);
            return;
        }// end function

        public function unload() : void
        {
            if (this._data)
            {
                var _loc_1:* = this._data;
                var _loc_2:* = this._data.ref - 1;
                _loc_1.ref = _loc_2;
            }
            this._name = null;
            this._category = null;
            this._data = null;
            this.bitmapData = null;
            this._flip = false;
            return;
        }// end function

    }
}
