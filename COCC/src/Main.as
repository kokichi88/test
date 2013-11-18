package 
{
    import __AS3__.vec.*;
    import bitzero.controls.*;
    import com.flashdynamix.utils.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.system.*;
    import map.*;
    import modules.*;
    import network.*;
    import resMgr.*;
    import utility.*;

    public class Main extends Sprite
    {
        public var gameInput:GameInput = null;
        private var loading:LoadingScreen;
        public var gameResLoader:LoadingModule;

        public function Main() : void
        {
            if (stage)
            {
                this.init();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, this.init);
            }
            return;
        }// end function

        private function init(event:Event = null) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.init);
			var config:Object = ConfigHijack.makeConfig();
            if ("configUrl" in config)
            {
                Config.staticURL = config["configUrl"];
                Config.server_ip = config["socketIp"];
                Config.server_port = config["socketPort"];
                Config.uId = config["userId"];
                Config.signed_request = config["signed_request"];
                Config.authorizationCode = config["code"];
                Config.gameVersion = config["gameVersion"];
                Config.configVersion = config["configVersion"];
                Config.hasFeed = config["isFeed"];
            }
            GlobalVar.SCREEN_WIDTH = stage.stageWidth;
            GlobalVar.SCREEN_HEIGHT = stage.stageHeight;
            GlobalVar.stage = this.stage;
            GlobalVar.stage.scaleMode = StageScaleMode.NO_SCALE;
            GlobalVar.stage.align = StageAlign.TOP_LEFT;
            Connector.getInstance().init(this.onConnection);
            MouseWheelTrap.setup(stage);
            Security.allowDomain("*");
            SWFProfiler.init(stage, this);
            GlobalVar.rootSprite = new Sprite();
            addChild(GlobalVar.rootSprite);
            LayerMgr.getInstance().AddLayers(GlobalVar.rootSprite, GlobalVar.NUM_LAYER);
            return;
        }// end function

        private function onConnection() : void
        {
            VersionConfig.loadData(this.prepareData);
            return;
        }// end function

        private function prepareData() : void
        {
            Localization.loadData(this.startLoadAsset);
            return;
        }// end function

        private function startLoadAsset() : void
        {
            this.loading = new LoadingScreen();
            this.loading.afterLoading = this.gameStart;
            this.addChild(this.loading);
            var swfList:* = VersionConfig.getSwfList();
            var jsonList:* = VersionConfig.getJsonList();
            var listContent:* = swfList.concat(jsonList);
            this.gameResLoader = new LoadingModule();
            this.gameResLoader.processLoadingConfigFile(listContent);
            this.gameResLoader.addEventListener(LoadingModule.COMPLETE_PRELOAD, this.onFinishLoadContent);
            this.gameResLoader.addEventListener(LoadingModule.PROGRESS_PRELOAD, function () : void
            {
                loading.onLoading(gameResLoader.progressPercent);
                return;
            }// end function
            );
            return;
        }// end function

        private function onFinishLoadContent(event:Event) : void
        {
            this.gameResLoader.removeEventListener(LoadingModule.COMPLETE_PRELOAD, this.onFinishLoadContent);
            this.loading.onFinishLoading();
            return;
        }// end function

        private function gameStart() : void
        {
            if (this.loading)
            {
                this.removeChild(this.loading);
                this.gameResLoader.removeEventListener(LoadingModule.PROGRESS_PRELOAD, function () : void
            {
                loading.onLoading(gameResLoader.progressPercent);
                return;
            }// end function
            );
            }
            this.loading = null;
            this.gameInput = GameInput.getInstance();
            MapMgr.getInstance().init();
            ModuleMgr.getInstance().init();
            GlobalVar.stage.addEventListener(Event.ENTER_FRAME, loop);
            MouseMgr.getInstance(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_INFO));
            MouseMgr.hasInit = true;
            ActiveTooltip.getInstance(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_LOADING));
            ActiveTooltip.hasInit = true;
            if (ExternalInterface.available)
            {
                ExternalInterface.addCallback("doWheel", this.doWheel);
            }
            this.addInputGame();
            return;
        }// end function

        private function loop(e:Event) : void
        {
            if (MouseMgr.hasInit)
            {
                MouseMgr.getInstance().update();
            }
            ModuleMgr.getInstance().loop();
            return;
        }// end function

        private function addInputGame() : void
        {
            GlobalVar.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.gameInput.onMouseMove, false, -1);
            GlobalVar.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.gameInput.onMouseDown, false, -1);
            GlobalVar.stage.addEventListener(MouseEvent.MOUSE_UP, this.gameInput.onMouseUp, false, -1);
            GlobalVar.stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.gameInput.onMouseWheel, false, -1);
            GlobalVar.stage.addEventListener(MouseEvent.MOUSE_OVER, this.gameInput.onMouseOver, false, -1);
            GlobalVar.stage.addEventListener(MouseEvent.MOUSE_OUT, this.gameInput.onMouseOut, false, -1);
            GlobalVar.stage.addEventListener(MouseEvent.CLICK, this.gameInput.onMouseClick, false, -1);
            return;
        }// end function

        public function removeInputGame() : void
        {
            GlobalVar.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.gameInput.onMouseMove);
            GlobalVar.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.gameInput.onMouseDown);
            GlobalVar.stage.removeEventListener(MouseEvent.MOUSE_UP, this.gameInput.onMouseUp);
            GlobalVar.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, this.gameInput.onMouseWheel);
            GlobalVar.stage.removeEventListener(MouseEvent.MOUSE_OVER, this.gameInput.onMouseOver);
            GlobalVar.stage.removeEventListener(MouseEvent.MOUSE_OUT, this.gameInput.onMouseOut);
            GlobalVar.stage.removeEventListener(MouseEvent.CLICK, this.gameInput.onMouseClick);
            return;
        }// end function

        private function doWheel(param1:Object) : void
        {
            if (this.loading != null)
            {
                return;
            }
            if (param1 > 0)
            {
                MapMgr.getInstance().zoomInMap();
            }
            else
            {
                MapMgr.getInstance().zoomOutMap();
            }
            return;
        }// end function

    }
}
