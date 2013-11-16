package resMgr
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
	import flash.geom.Rectangle;
    import flash.net.*;
    import flash.system.*;
    import utility.*;

    public class ResMgr extends EventDispatcher
    {
        public var contents:Vector.<ApplicationDomain>;
        private var resArray:Object;
        private var loadResArr:Array;
        private var bdMgr:Array;
        private var bmpList:Object;
        private var urlLoaded:Object;
        private var bmpDataList:Object;
        public static const DATA_TYPE_BITMAP:int = 0;
        public static const DATA_TYPE_BIMAPDATA:int = 1;
        public static const DATA_TYPE_MOVIE:int = 2;
        public static const DATA_TYPE_CLASS:int = 3;
        private static var instance:ResMgr;
        public static var UseMd5:Boolean = true;

        public function ResMgr()
        {
            this.contents = new Vector.<ApplicationDomain>;
            this.resArray = new Object();
            this.loadResArr = [];
            this.bdMgr = [];
            this.bmpList = new Object();
            this.urlLoaded = new Object();
            this.bmpDataList = new Object();
            if (instance != null)
            {
                throw new Error("Single cases of class instantiation error-ResMgr");
            }
            return;
        }// end function

        public function getBitmap(param1:String) : Bitmap
        {
            var _loc_2:BitmapData = null;
            var _loc_3:Bitmap = null;
            if (param1 in this.bmpDataList)
            {
                _loc_2 = this.bmpDataList[param1];
                _loc_3 = new Bitmap(_loc_2);
                return _loc_3;
            }
            var _loc_4:* = this.getClass(param1);
            if (this.getClass(param1) != null)
            {
                _loc_2 = new _loc_4(1, 1);
                this.bmpDataList[param1] = _loc_2;
                _loc_3 = new Bitmap(_loc_2);
                return _loc_3;
            }
            return null;
        }// end function

        public function getSimpleButton(param1:String) : SimpleButton
        {
            var _loc_3:Class = null;
            var _loc_2:SimpleButton = null;
            if (this.isLinkage(param1))
            {
                _loc_3 = this.getClass(param1);
                if (_loc_3 != null)
                {
                    _loc_2 = new _loc_3;
                    _loc_2.name = param1;
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getMovieClip(param1:String) : MovieClip
        {
            var loader:Loader;
            var m1:MovieClipEx;
            var c:Class;
            var m:MovieClip;
            var bmp:Bitmap;
            var name:* = param1;
            var retVal:MovieClip;
            if (this.isLinkage(name))
            {
                c = this.getClass(name);
                if (c != null)
                {
                    retVal = new c;
                    retVal.name = name;
                    return retVal;
                }
                return null;
            }
            var obj:* = this.urlLoaded[name];
            if (obj != null)
            {
                loader = obj["loader"] as Loader;
                if (obj["state"] == "loaded")
                {
                    try
                    {
                        m = new MovieClip();
                        bmp = loader.content as Bitmap;
                        m.addChild(new Bitmap(bmp.bitmapData.clone()));
                        return m;
                    }
                    catch (e:Error)
                    {
                        m1 = new MovieClipEx();
                        m1.setEvent(name);
                        return m1;
                    }
                }
                else
                {
                    m1 = new MovieClipEx();
                    m1.setEvent(name);
                    return m1;
                }
            }
            var urlReq:* = new URLRequest(name + "?" + GlobalVar.CONTENT_VERSION);
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function () : void
            {
                urlDone(name);
                return;
            }// end function
            );
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.urlIoError);
            loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.urlSecurityError);
            loader.load(urlReq);
            var o:* = new Object();
            o["state"] = "loading";
            o["loader"] = loader;
            this.urlLoaded[name] = o;
            m1 = new MovieClipEx();
            m1.setEvent(name);
            return m1;
        }// end function

        private function urlSecurityError(event:SecurityErrorEvent) : void
        {
            return;
        }// end function

        private function urlIoError(event:IOErrorEvent) : void
        {
            return;
        }// end function

        private function urlDone(param1:String) : void
        {
            var _loc_2:* = this.urlLoaded[param1];
            _loc_2["state"] = "loaded";
            dispatchEvent(new Event(param1));
            return;
        }// end function

        private function isLinkage(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return true;
            }
            if (param1.search(".png") > 0)
            {
                return false;
            }
            if (param1.search(".jpg") > 0)
            {
                return false;
            }
            return true;
        }// end function

        private function getClass(param1:String) : Class
        {
            var _loc_2:int = 0;
            var _loc_3:ApplicationDomain = null;
            _loc_2 = 0;
            while (_loc_2 < this.contents.length)
            {
                
                _loc_3 = this.contents[_loc_2];
                if (_loc_3.hasDefinition(param1))
                {
                    return _loc_3.getDefinition(param1) as Class;
                }
                _loc_2++;
            }
            return null;
        }// end function

        public function getData(param1:String, param2:Boolean, param3:int, param4:Boolean = true)
        {
            switch(param3)
            {
                case DATA_TYPE_BIMAPDATA:
                {
                    return this.__getBitmapData(param1);
                }
                case DATA_TYPE_BITMAP:
                {
                    return this.__getBimap(param1);
                }
                case DATA_TYPE_CLASS:
                {
                    return this.getClass(param1);
                }
                case DATA_TYPE_MOVIE:
                {
                    return this.getMovieClip(param1);
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        public function getShape(param1:String) : DisplayObject
        {
            var _loc_2:* = this.getMovieClip(param1);
            if (_loc_2 && _loc_2.numChildren > 0)
            {
                return _loc_2.getChildAt(0);
            }
            return new Shape();
        }// end function

        private function __getBimap(param1:String) : Bitmap
        {
            var _loc_3:Bitmap = null;
            var _loc_2:* = this.__getBitmapData(param1);
            if (_loc_2)
            {
                _loc_3 = new Bitmap(_loc_2);
                return _loc_3;
            }
            return null;
        }// end function

        public function getBitmapMovie(param1:MovieClip) : MovieClip
        {
            return new MovieClip();
        }// end function

        public function GetBmpArray(param1:String) : Vector.<BitmapData>
        {
            if (this.bmpList[param1])
            {
                return this.bmpList[param1].bmpList;
            }
            return null;
        }// end function

        public function deleteNameBmp(param1:String, param2:Number = 1, param3:Number = 1) : void
        {
            var _loc_4:* = param1 + "_" + param2 + "_" + param3;
            if (param1 + "_" + param2 + "_" + param3 in this.bmpList)
            {
                delete this.bmpList[_loc_4];
            }
            return;
        }// end function

        public function getBmpArrayPos(param1:String) : Vector.<Rectangle>
        {
            if (this.bmpList[param1])
            {
                return this.bmpList[param1].bmpPos;
            }
            return null;
        }// end function

        private function __getBitmapData(param1:String, param2:Boolean = true) : BitmapData
        {
            var _loc_3:BitmapData = null;
            var _loc_4:MovieClip = null;
            _loc_3 = this.bdMgr[param1];
            if (param1 != "" && _loc_3 == null)
            {
                _loc_4 = this.getMovieClip(param1);
                if (_loc_4)
                {
                    _loc_3 = new BitmapData(_loc_4.width, _loc_4.height, true, 0);
                    _loc_3.draw(_loc_4);
                    this.bdMgr[param1] = _loc_3;
                }
            }
            if (_loc_3)
            {
                return _loc_3;
            }
            return new BitmapData(1, 1, true, 0);
        }// end function

        private function GetDuplicateUrl(param1:String) : int
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.loadResArr.length)
            {
                
                if (this.loadResArr[_loc_2]["url"] == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        private function LoadResErr(param1:int) : void
        {
            this.loadResArr[param1]["status"] = "error";
            dispatchEvent(new Event("err" + this.loadResArr[param1]["url"]));
            return;
        }// end function

        public function UrlLoaded(param1:int, param2:Boolean = false, param3:String = "") : void
        {
            this.loadResArr[param1]["status"] = "loaded";
            var _loc_4:* = this.loadResArr[param1]["loader"] as Loader;
            if ((this.loadResArr[param1]["loader"] as Loader).contentLoaderInfo.contentType == "application/x-shockwave-flash")
            {
                this.resArray[this.loadResArr[param1]["url"]] = _loc_4.contentLoaderInfo.applicationDomain;
                this.contents.push(_loc_4.contentLoaderInfo.applicationDomain);
            }
            dispatchEvent(new Event(this.loadResArr[param1]["url"]));
            return;
        }// end function

        public function loadSwf() : void
        {
            var _loc_1:* = VersionConfig.getSwfList();
            return;
        }// end function

        public static function getInstance() : ResMgr
        {
            if (instance == null)
            {
                instance = new ResMgr;
            }
            return instance;
        }// end function

    }
}
