package {		// ^_^;;;;;;;;;        public class  Main2 extends flash.display.Sprite        {                private static var loaderDict:flash.utils.Dictionary;                public function Main2()                {                        if(stage)                        {                                this.onAddToStage();                        }                        else                        {                                this.addEventListener(flash.events.Event.ADDED_TO_STAGE, this.onAddToStage);                        }                }                private var _current:int = -1;                private var _loadingUI:Main1;                private var _loadNum:int;                private var _parameters:Object;                private function creatGame(arg0:flash.events.Event):void                {                        var internal::e:* = arg0;                        var internal::key:* = undefined;                        var internal::game:* = undefined;                        this.showLoadingUI('Đang tải tập tin thiết lập…');                        var local1:* = 0;                        var local2:* = loaderDict;                        while(<hasnext2>(local2))                        {                                var internal::key:* = <nextvalue>(local1, local2);                                loaderDict[internal::key] = null;                                delete loaderDict[internal::key];                        }                        var internal::game:* = internal::e.target.content;                        if(Boolean(internal::game))                        {                                if(Boolean(flash.display.DisplayObject(internal::game)))                                {                                        internal::game.addEventListener('LoadingUI', this.gameUpdateLoadingUI);                                        this.hideLoadingUI();                                        addChild(flash.display.DisplayObject(internal::game));                                        internal::game.startup(stage, this._parameters, Main3.func1);                                }                        }                        else                        {                                internal::game.addEventListener('LoadingUI', this.gameUpdateLoadingUI);                                this.hideLoadingUI();                                addChild(flash.display.DisplayObject(internal::game));                                internal::game.startup(stage, this._parameters, Main3.func1);                        }                }                private function gameUpdateLoadingUI(arg0:Object):void                {                        var local0:* = arg0.action;                        if('showLoadingUI' !== local0)                        {                                if('hideLoadingUI' !== local0)                                {                                        if(!('updateLoadingUI' !== local0))                                        {                                                this.updateLoadingUI(arg0.data.per);                                                return;                                        }                                }                                else                                {                                        this.hideLoadingUI();                                        return;                                }                        }                        else                        {                                this.showLoadingUI(arg0.data.loadTarget);                                return;                        }                }                private function hideLoadingUI():void                {                        if(this._loadingUI)                        {                                if(this._loadingUI.parent)                                {                                        this._loadingUI.parent.removeChild(this._loadingUI);                                        this._loadingUI.removeEvent(stage);                                }                                this._loadingUI = null;                        }                }                private function loadGame(arg0:flash.events.Event):void                {                        this.showLoadingUI('Đang tải tập tin thực thi ...');                        var uRLLoader1:flash.net.URLLoader = new flash.net.URLLoader();                        loaderDict[uRLLoader1] = true;                        uRLLoader1.dataFormat = flash.net.URLLoaderDataFormat.BINARY;                        uRLLoader1.addEventListener(flash.events.ProgressEvent.PROGRESS, this.loadUpdate);                        uRLLoader1.addEventListener(flash.events.Event.COMPLETE, this.loadMainUrlComplete);                        uRLLoader1.load(new flash.net.URLRequest(this._parameters['main']));                }                private function loadMainUrlComplete(arg0:flash.events.Event):void                {                        var byteArray1:flash.utils.ByteArray = arg0.currentTarget.data;                        byteArray1 = Main3.func1(byteArray1);                        byteArray1.position = 0;                        var loader1:flash.display.Loader = new flash.display.Loader();                        loaderDict[loader1] = true;                        loader1.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.creatGame);                        loader1.loadBytes(byteArray1, new flash.system.LoaderContext(false, flash.system.ApplicationDomain.currentDomain));                }                private function loadRslUrlComplete(arg0:flash.events.Event):void                {                        var byteArray1:flash.utils.ByteArray = arg0.currentTarget.data;                        byteArray1.position = 0;                        var loader1:flash.display.Loader = new flash.display.Loader();                        loaderDict[loader1] = true;                        loader1.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.loadGame);                        loader1.loadBytes(byteArray1, new flash.system.LoaderContext(false, flash.system.ApplicationDomain.currentDomain));                }                private function loadRslUrlStart():void                {                        var uRLLoader1:flash.net.URLLoader = new flash.net.URLLoader();                        loaderDict[uRLLoader1] = true;                        uRLLoader1.dataFormat = flash.net.URLLoaderDataFormat.BINARY;                        uRLLoader1.addEventListener(flash.events.ProgressEvent.PROGRESS, this.loadUpdate);                        uRLLoader1.addEventListener(flash.events.Event.COMPLETE, this.loadRslUrlComplete);                        uRLLoader1.load(new flash.net.URLRequest(this._parameters['lib']));                }                private function loadUpdate(arg0:Object):void                {                        var local0:* = NaN;                        if(arg0 is Number)                        {                                local0 = arg0;                        }                        else                        {                                if(arg0.hasOwnProperty('weightPercent'))                                {                                        local0 = arg0.weightPercent;                                }                                else                                {                                        local0 = arg0.bytesLoaded / arg0.bytesTotal;                                }                        }                        this.updateLoadingUI(local0);                }                private function onAddToStage(arg0:flash.events.Event):void                {                        this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.onAddToStage);                        stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;                        stage.align = flash.display.StageAlign.TOP_LEFT;                        stage.quality = flash.display.StageQuality.HIGH;                        stage.frameRate = 30;                        var object1:Object = {'loadnum': 9, 'policys': 'myplay.gmtool.vn/crossdomain.xml', 'lib': 'ToanTNLib.swf', 'main': 'bzmonitor.tnt', 'baseDir': '/assets/admin/', 'loginServer': '10.30.44.40', 'loginPort': '433,109', 'chatServer': '10.30.44.40', 'recharge': 'https://pay.zing.vn/zingxu/napthe.html', 'chatPort': '109,433', 'auth': 'c2lkPTQ1JnVpZD10b2Fubm9iaSZpcD0xMC4zMC4yNC4yNTQmdGltZT0xMzIyMTIyMTQzJmluZHVsZ2U9biZwcm9tb3Rpb249MA==', 'sign': '270985343338f0578cc936553ae5d9f7'};                        this._parameters = root.loaderInfo.parameters;                        if(!(this._parameters['config'] != undefined))                        {                                this._parameters = object1;                        }                        this._loadNum = Number(this._parameters['loadnum']);                        if(this._loadNum <= 0)                        {                                this._loadNum = 1;                        }                        flash.display.Stage.prototype.embedComplete = this.loadGame;                        this.showLoadingUI('Đang tải tập tin dữ liệu…');                }                private function showLoadingUI(arg0:String):void                {                        var local0:* = this;                        var local1:* = int(<dup>this._current) + 1;                        local0._current = local1;                        if(!(this._loadingUI))                        {                                this._loadingUI = new Main1();                                this._loadingUI.addEvent(stage);                        }                        this._loadingUI.loadTarget = arg0;                        this.updateLoadingUI(0);                        if(stage)                        {                                this._loadingUI.x = stage.stageWidth / 2;                                this._loadingUI.y = stage.stageHeight / 2;                                stage.addChild(this._loadingUI);                        }                }                private function updateLoadingUI(arg0:Number):void                {                        if(this._loadingUI)                        {                                this._loadingUI.update(arg0, Math.min(this._current / this._loadNum, 1));                        }                        else                        {                                return;                        }                }        }}