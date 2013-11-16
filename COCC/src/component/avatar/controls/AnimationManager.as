package component.avatar.controls
{
    import br.com.stimuli.loading.*;
    import br.com.stimuli.loading.loadingtypes.*;
    import component.avatar.model.animation.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class AnimationManager extends Object
    {
        private var bulkLoader:BulkLoader;
        private var animations:Object;
        private var pendingFrames:Array;
        private static const gcCate:Array = [AnCategory.AVATAR, AnCategory.EFFECT, AnCategory.MOUNTS];

        public function AnimationManager()
        {
            this.bulkLoader = new BulkLoader("AnimationManager");
            this.pendingFrames = new Array();
            this.bulkLoader.addEventListener(ErrorEvent.ERROR, this.loaderErrorHandler);
            this.animations = new Object();
            this.animations[AnCategory.AVATAR] = new Object();
            this.animations[AnCategory.EFFECT] = new Object();
            this.animations[AnCategory.MOUNTS] = new Object();
            this.animations[AnCategory.HOUSE] = new Object();
            FrameTimerManager.getInstance().add(3, 0, this.decodeFrames);
            FrameTimerManager.getTimer().add(60 * 4, 0, this.gc);
            this.bulkLoader.start();
            return;
        }// end function

        private function onLoadItemComplete(event:Event) : void
        {
            var category:String;
            var name:String;
            var event:* = event;
            var evt:* = event;
            var item:* = evt.currentTarget as LoadingItem;
            this.removeItemListeners(item);
            var itemIds:* = item.id.split("/");
            category = itemIds[0];
            name = itemIds[1];
            try
            {
                this.setAnimation(category, name, this.bulkLoader.getBinary(item.id));
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public function setAnimation(param1:String, param2:String, param3:ByteArray, param4:Boolean = false) : void
        {
            var _loc_5:* = this.getAnimationAfterLoad(param1, param2);
            this.getAnimationAfterLoad(param1, param2).loaded = true;
            _loc_5.preload = param4;
            var _loc_6:* = param3.readUTF();
            var _loc_7:* = param3.readInt();
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:Object = null;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:Object = null;
            var _loc_14:int = 0;
            var _loc_15:int = 0;
            var _loc_16:Object = null;
            var _loc_17:int = 0;
            var _loc_18:FrameLoader = null;
            var _loc_19:int = 0;
            var _loc_20:Object = null;
            var _loc_21:Rectangle = null;
            var _loc_22:Point = null;
            var _loc_23:int = 0;
            var _loc_24:int = 0;
            while (param3.bytesAvailable)
            {
                
                _loc_8 = param3.readByte();
                _loc_9 = param3.readInt();
                _loc_10 = {owner:_loc_5, loadings:0, ready:false};
                _loc_5[_loc_8] = _loc_10;
                _loc_11 = param3.position;
                _loc_10.frameCount = param3.readByte();
                _loc_5.frInfo[_loc_8] = _loc_10.frameCount;
                _loc_10.boundsRect = new Rectangle();
                _loc_10.boundsRect.x = param3.readShort();
                _loc_10.boundsRect.y = param3.readShort();
                _loc_10.boundsRect.width = param3.readShort();
                _loc_10.boundsRect.height = param3.readShort();
                _loc_10.speed = param3.readByte();
                if (_loc_8 == 3)
                {
                }
                _loc_10.speed = 5;
                if (_loc_7 >= 5)
                {
                    _loc_10.fireFrame = [param3.readByte(), param3.readByte(), param3.readByte()];
                    _loc_10.secondFireEndFrame = param3.readByte();
                }
                else
                {
                    _loc_10.fireFrame = [param3.readByte()];
                    _loc_10.secondFireEndFrame = 0;
                }
                _loc_10.repeatDelay = param3.readByte();
                if (_loc_7 == 7 || _loc_7 == 3)
                {
                    param3.readByte();
                }
                if (_loc_7 >= 6)
                {
                    _loc_10.swing = param3.readByte() == 1;
                }
                else
                {
                    _loc_10.swing = false;
                }
                _loc_10.dirData = new Object();
                _loc_14 = 0;
                while (param3.position < _loc_9 + _loc_11)
                {
                    
                    _loc_12 = param3.readByte();
                    _loc_13 = {frames:[], rect:new Rectangle(), firePoint:new Point(), flip:false};
                    _loc_10.dirData[_loc_12] = _loc_13;
                    if (_loc_14 == 0)
                    {
                        _loc_10.defaultDir = _loc_12;
                    }
                    _loc_14++;
                    _loc_13.rect.x = param3.readShort();
                    _loc_13.rect.y = param3.readShort();
                    _loc_13.rect.width = param3.readShort();
                    _loc_13.rect.height = param3.readShort();
                    _loc_13.firePoint.x = param3.readShort();
                    _loc_13.firePoint.y = param3.readShort();
                    _loc_15 = 0;
                    while (_loc_15 < _loc_10.frameCount)
                    {
                        
                        _loc_16 = new Object();
                        _loc_16.rect = new Rectangle();
                        _loc_16.rect.x = param3.readShort();
                        _loc_16.rect.y = param3.readShort();
                        _loc_16.rect.width = param3.readShort();
                        _loc_16.rect.height = param3.readShort();
                        _loc_17 = param3.readInt();
                        if (_loc_17 > 0)
                        {
                            _loc_16.raw = new ByteArray();
                            param3.readBytes(_loc_16.raw, 0, _loc_17);
                        }
                        _loc_16.owner = _loc_10;
                        _loc_13.frames[_loc_15] = _loc_16;
                        if (_loc_16.raw)
                        {
                            var _loc_25:* = _loc_10;
                            var _loc_26:* = _loc_10.loadings + 1;
                            _loc_25.loadings = _loc_26;
                            _loc_18 = new FrameLoader();
                            _loc_18.frame = _loc_16;
                            _loc_16.loader = _loc_18;
                            _loc_18.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onFrameLoaded);
                            _loc_16.prior = 1;
                            var _loc_25:* = _loc_5;
                            var _loc_26:* = _loc_5.loadings + 1;
                            _loc_25.loadings = _loc_26;
                            if (_loc_5.priority > 0)
                            {
                                _loc_18.loadBytes(_loc_16.raw);
                                delete _loc_16.raw;
                            }
                            else
                            {
                                this.pendingFrames.push(_loc_16);
                            }
                        }
                        else
                        {
                            _loc_16.bitmapData = new BitmapData(1, 1, true, 0);
                        }
                        _loc_15++;
                    }
                }
                _loc_19 = 1;
                while (_loc_19 <= 8)
                {
                    
                    _loc_20 = _loc_10.dirData[_loc_19];
                    if (!_loc_20)
                    {
                        _loc_20 = _loc_10.dirData[10 - _loc_19];
                        if (_loc_20)
                        {
                            _loc_21 = _loc_20.rect.clone();
                            _loc_20.rect.clone().x = -_loc_21.right;
                            _loc_22 = _loc_20.firePoint.clone();
                            _loc_20.firePoint.clone().x = -_loc_22.x;
                            _loc_10.dirData[_loc_19] = {flip:true, frames:_loc_20.frames, rect:_loc_21, firePoint:_loc_22};
                            if (_loc_19 < 5)
                            {
                                _loc_23 = _loc_19;
                            }
                            else
                            {
                                _loc_24 = _loc_19;
                            }
                        }
                    }
                    else if (_loc_19 < 5)
                    {
                        _loc_23 = _loc_19;
                    }
                    else
                    {
                        _loc_24 = _loc_19;
                    }
                    _loc_19++;
                }
                if (_loc_23 == 0)
                {
                    _loc_23 = _loc_24;
                }
                if (_loc_24 == 0)
                {
                    _loc_24 = _loc_23;
                }
                _loc_19 = 1;
                while (_loc_19 <= 8)
                {
                    
                    _loc_20 = _loc_10.dirData[_loc_19];
                    if (!_loc_20)
                    {
                        if (_loc_19 < 5)
                        {
                            _loc_10.dirData[_loc_19] = _loc_10.dirData[_loc_23];
                        }
                        else
                        {
                            _loc_10.dirData[_loc_19] = _loc_10.dirData[_loc_24];
                        }
                    }
                    _loc_19++;
                }
            }
            return;
        }// end function

        private function loaderErrorHandler(event:Event) : void
        {
            return;
        }// end function

        public function load(param1:AnLoadData) : void
        {
            var _loc_2:String = null;
            var _loc_3:String = null;
            var _loc_4:LoadingItem = null;
            if (!param1.loaded)
            {
                _loc_2 = null;
                _loc_3 = null;
                _loc_4 = null;
                param1.loaded = true;
                _loc_2 = URLManager.getURL(param1.category, param1.name);
                _loc_3 = this.getId(param1.category, param1.name);
                _loc_4 = this.bulkLoader.add(_loc_2, {id:_loc_3, type:BulkLoader.TYPE_BINARY});
                _loc_4.addEventListener(Event.COMPLETE, this.onLoadItemComplete);
                _loc_4.addEventListener(ErrorEvent.ERROR, this.onLoadItemError);
            }
            return;
        }// end function

        private function removeItemListeners(param1:LoadingItem) : void
        {
            param1.removeEventListener(Event.COMPLETE, this.onLoadItemComplete);
            param1.removeEventListener(ErrorEvent.ERROR, this.onLoadItemError);
            return;
        }// end function

        private function onFrameLoaded(event:Event) : void
        {
            var _loc_2:AnLoadData = null;
            var _loc_3:* = FrameLoader(LoaderInfo(event.currentTarget).loader);
            var _loc_4:* = _loc_3.frame;
            delete _loc_3.frame.loader;
            _loc_4.bitmapData = Bitmap(event.target.content).bitmapData;
            var _loc_5:* = _loc_4.owner;
            var _loc_6:* = _loc_4.owner.loadings - 1;
            _loc_5.loadings = _loc_6;
            if (_loc_4.owner.loadings == 0)
            {
                _loc_4.owner.ready = true;
            }
            if (_loc_4.prior)
            {
                _loc_2 = _loc_4.owner.owner;
                var _loc_5:* = _loc_2;
                var _loc_6:* = _loc_2.loadings - 1;
                _loc_5.loadings = _loc_6;
                if (_loc_2.loadings == 0)
                {
                    _loc_2.ready = true;
                }
            }
            return;
        }// end function

        public function getAnimation(param1:String, param2:String) : AnLoadData
        {
            var _loc_3:* = this.animations[param1][param2];
            if (_loc_3 == null)
            {
                _loc_3 = new AnLoadData(param1, param2);
                this.animations[param1][param2] = _loc_3;
            }
            return _loc_3;
        }// end function

        public function getAnimationAfterLoad(param1:String, param2:String) : AnLoadData
        {
            var _loc_3:* = this.animations[param1][param2];
            return _loc_3;
        }// end function

        private function onLoadItemError(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as LoadingItem;
            this.removeItemListeners(_loc_2);
            return;
        }// end function

        private function getId(param1:String, param2:String) : String
        {
            return param1 + "/" + param2;
        }// end function

        private function decodeFrames() : void
        {
            var _loc_1:int = 0;
            var _loc_2:Object = null;
            if (this.pendingFrames.length > 0)
            {
                _loc_1 = 0;
                while (_loc_1 < 30)
                {
                    
                    _loc_2 = this.pendingFrames.pop();
                    if (_loc_2.raw)
                    {
                        _loc_2.loader.loadBytes(_loc_2.raw);
                        delete _loc_2.raw;
                    }
                    if (this.pendingFrames.length == 0)
                    {
                        break;
                    }
                    _loc_1++;
                }
            }
            return;
        }// end function

        public function freeAll(param1:String) : void
        {
            var _loc_2:String = null;
            var _loc_3:AnLoadData = null;
            var _loc_4:* = this.animations[param1];
            for (_loc_2 in _loc_4)
            {
                
                _loc_3 = _loc_4[_loc_2];
                if (!_loc_3.preload)
                {
                    this.freeAnimation(_loc_3);
                    delete _loc_4[_loc_2];
                }
            }
            return;
        }// end function

        private function freeAnimation(param1:AnLoadData) : void
        {
            var action:Object;
            var j:int;
            var frames:Array;
            var z:int;
            var data:*;
            var anData:* = param1;
            data = anData;
            var i:int;
            while (i < 5)
            {
                
                action = data[i];
                if (action && action.dirData)
                {
                    j;
                    while (j <= 8)
                    {
                        
                        try
                        {
                            frames = action.dirData[j].frames;
                            z;
                            while (z < frames.length)
                            {
                                
                                if (frames[z].bitmapData)
                                {
                                    frames[z].bitmapData.dispose();
                                }
                                delete frames[z].raw;
                                z = (z + 1);
                            }
                        }
                        catch (e:Error)
                        {
                            throw new Error(data.category + "_" + data.name + ":parse error....");
                        }
                        j = (j + 1);
                    }
                }
                i = (i + 1);
            }
            return;
        }// end function

        private function gc() : void
        {
            return;
        }// end function

    }
}
import flash.display.Loader;

class FrameLoader extends Loader
{
    public var frame:Object;

    function FrameLoader()
    {
        return;
    }// end function

}

