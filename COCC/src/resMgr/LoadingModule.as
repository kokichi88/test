package resMgr
{
    import __AS3__.vec.*;
    import br.com.stimuli.loading.*;
    import br.com.stimuli.loading.loadingtypes.*;
    import flash.display.*;
    import flash.events.*;
    import org.aswing.util.*;

    public class LoadingModule extends Sprite
    {
        private var PRE_LOAD_SWF_TYPE:String = "swf";
        private var PRE_LOAD_JSON_TYPE:String = "json";
        private var PRE_LOAD_XML_TYPE:String = "xml";
        private var curLoad:String;
        private var ibulkLoader:BulkLoader;
        public var progressName:String;
        public var progressPercent:Number;
        public var isAutoLoadDone:Boolean = false;
        public var hashBulkLoader:HashMap;
        public static const CONFIG_DIR:String = "config/";
        public static const RES_DIR:String = "../res/";
        public static const PRELOAD_URL:String = "preload.json";
        public static const AUTOLOAD_URL:String = "autoload.json";
        public static const COMPLETE_PRELOAD:String = "CompletePreload";
        public static const PROGRESS_PRELOAD:String = "ProgressPreload";
        public static const COMPLETE_AUTOLOAD:String = "CompleteAutoload";
        public static const PROGRESS_AUTOLOAD:String = "ProgressAutoload";

        public function LoadingModule()
        {
            this.hashBulkLoader = new HashMap();
            return;
        }// end function

        public function getId(param1:String = "") : String
        {
            switch(param1)
            {
                case PRELOAD_URL:
                {
                    return "preLoad";
                }
                case AUTOLOAD_URL:
                {
                    return "autoLoad";
                }
                default:
                {
                    break;
                }
            }
            return "defaultLoad";
        }// end function

        public function getEvent(param1:String, param2:Boolean = true) : String
        {
            switch(param1)
            {
                case PRELOAD_URL:
                {
                    if (param2)
                    {
                        return COMPLETE_PRELOAD;
                    }
                    return PROGRESS_PRELOAD;
                }
                case AUTOLOAD_URL:
                {
                    if (param2)
                    {
                        return COMPLETE_AUTOLOAD;
                    }
                    return PROGRESS_AUTOLOAD;
                }
                default:
                {
                    break;
                }
            }
            return PROGRESS_PRELOAD;
        }// end function

        public function getResUrl(param1:String) : String
        {
            return GlobalVar.STATIC_URL + RES_DIR + param1 + "?" + GlobalVar.CONTENT_VERSION;
        }// end function

        public function getConfigUrl(param1:String) : String
        {
            return GlobalVar.STATIC_URL + CONFIG_DIR + param1 + "?" + GlobalVar.CONTENT_VERSION;
        }// end function

        private function initPreloadContent() : void
        {
            this.curLoad = PRELOAD_URL;
            this.ibulkLoader = new BulkLoader(this.getId(PRELOAD_URL));
            this.ibulkLoader.addEventListener(BulkLoader.PROGRESS, this.onProgressHandler);
            this.ibulkLoader.addEventListener(BulkLoader.COMPLETE, this.onPreloadCompleteHandler);
            this.ibulkLoader.addEventListener(ErrorEvent.ERROR, this.onErrorHandle);
            this.ibulkLoader.add(this.getConfigUrl(PRELOAD_URL), {id:this.getId(PRELOAD_URL), type:BulkLoader.TYPE_TEXT});
            this.ibulkLoader.start();
            this.progressName = this.getId(PRELOAD_URL);
            return;
        }// end function

        public function initAutoLoadContent() : void
        {
            this.isAutoLoadDone = false;
            this.curLoad = AUTOLOAD_URL;
            this.ibulkLoader = new BulkLoader(this.getId(AUTOLOAD_URL));
            this.ibulkLoader.addEventListener(BulkLoader.PROGRESS, this.onProgressHandler);
            this.ibulkLoader.addEventListener(BulkLoader.COMPLETE, this.onPreloadCompleteHandler);
            this.ibulkLoader.addEventListener(ErrorEvent.ERROR, this.onErrorHandle);
            this.ibulkLoader.add(this.getConfigUrl(AUTOLOAD_URL), {id:this.getId(AUTOLOAD_URL), type:BulkLoader.TYPE_TEXT});
            this.ibulkLoader.start();
            this.progressName = this.getId(AUTOLOAD_URL);
            return;
        }// end function

        public function loadCustomeFile(param1:String) : void
        {
            return;
        }// end function

        private function onPreloadCompleteHandler(event:Event) : void
        {
            var _loc_2:* = this.ibulkLoader.getText(this.getConfigUrl(this.curLoad), true);
            return;
        }// end function

        public function processLoadingConfigFile(param1:Vector.<String>) : void
        {
            this.ibulkLoader = new BulkLoader(this.getId());
            this.ibulkLoader.addEventListener(BulkLoader.COMPLETE, this.onCompleteHandler);
            this.ibulkLoader.addEventListener(BulkLoader.PROGRESS, this.onProgressHandler);
            this.ibulkLoader.addEventListener(ErrorEvent.ERROR, this.onErrorHandle);
            this.putLoadingItem(param1, this.ibulkLoader);
            this.ibulkLoader.start();
            this.progressName = this.getId();
            return;
        }// end function

        private function processLoadingCustomeFile(param1:String, param2:Vector.<String>) : void
        {
            if (this.hashBulkLoader.containsKey(param1))
            {
                return;
            }
            var _loc_3:* = new BulkLoader(param1);
            _loc_3.addEventListener(BulkLoader.COMPLETE, this.onLoadCustomeComplete);
            _loc_3.addEventListener(BulkLoader.ERROR, this.onLoadCustomeError);
            this.putLoadingItem(param2, _loc_3, true);
            _loc_3.start();
            this.hashBulkLoader.put(param1, _loc_3);
            return;
        }// end function

        private function onLoadCustomeError(event:Event) : void
        {
            return;
        }// end function

        private function onLoadCustomeComplete(event:Event) : void
        {
            var _loc_2:* = (event.target as BulkLoader).name;
            dispatchEvent(new Event(_loc_2));
            if (this.hashBulkLoader.containsKey(_loc_2))
            {
                (this.hashBulkLoader.getValue(_loc_2) as BulkLoader).clear();
                this.hashBulkLoader.remove(_loc_2);
            }
            return;
        }// end function

        private function putLoadingItem(param1:Vector.<String>, param2:BulkLoader, param3:Boolean = false) : void
        {
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_9:String = null;
            var _loc_11:String = null;
            var _loc_12:Array = null;
            var _loc_13:LoadingItem = null;
            var _loc_4:Array = [];
            var _loc_10:int = 0;
            while (_loc_10 < param1.length)
            {
                
                _loc_11 = param1[_loc_10];
                _loc_12 = _loc_11.split("/");
                _loc_8 = _loc_11.split("/")[_loc_12.length - 2];
                _loc_9 = _loc_11;
                _loc_5 = _loc_12[(_loc_12.length - 1)];
                _loc_7 = _loc_11;
                _loc_6 = BulkLoader.TYPE_BINARY;
                switch(_loc_8)
                {
                    case this.PRE_LOAD_SWF_TYPE:
                    {
                        _loc_6 = BulkLoader.TYPE_MOVIECLIP;
                        break;
                    }
                    case this.PRE_LOAD_JSON_TYPE:
                    {
                        _loc_6 = BulkLoader.TYPE_TEXT;
                        break;
                    }
                    case this.PRE_LOAD_XML_TYPE:
                    {
                        _loc_6 = BulkLoader.TYPE_XML;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_13 = param2.add(_loc_7, {id:_loc_9, type:_loc_6, maxTries:1});
                _loc_13._uid = param2.name;
                if (!param3)
                {
                    _loc_13.addEventListener(Event.COMPLETE, this.onLoadDefaulItemComplete);
                }
                else
                {
                    _loc_13.addEventListener(Event.COMPLETE, this.onLoadCustomeItemComplete);
                }
                _loc_13.addEventListener(ErrorEvent.ERROR, this.onLoadItemError);
                _loc_10++;
            }
            return;
        }// end function

        private function onLoadDefaulItemComplete(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as LoadingItem;
            this.onLoadItemComplete(_loc_2, this.ibulkLoader);
            return;
        }// end function

        private function onLoadCustomeItemComplete(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as LoadingItem;
            if (this.hashBulkLoader.containsKey(_loc_2._uid))
            {
                this.onLoadItemComplete(_loc_2, this.hashBulkLoader.getValue(_loc_2._uid) as BulkLoader);
            }
            return;
        }// end function

        private function onCompleteHandler(event:Event) : void
        {
            this.ibulkLoader.removeEventListener(BulkLoader.COMPLETE, this.onCompleteHandler);
            this.ibulkLoader.removeEventListener(BulkLoader.PROGRESS, this.onProgressHandler);
            this.ibulkLoader.removeEventListener(ErrorEvent.ERROR, this.onErrorHandle);
            this.ibulkLoader.clear();
            this.dispose();
            return;
        }// end function

        private function onLoadItemComplete(param1:LoadingItem, param2:BulkLoader) : void
        {
            var arrInfo:Array;
            var data:Object;
            var str:String;
            var content:DisplayObject;
            var fileName:String;
            var loadItem:* = param1;
            var loader:* = param2;
            this.removeItemListeners(loadItem);
            var name:String;
            arrInfo = loadItem.id.split("/");
            var type:* = arrInfo[arrInfo.length - 2];
            switch(type)
            {
                case this.PRE_LOAD_SWF_TYPE:
                {
                    content = loader.getContent(loadItem.id) as DisplayObject;
                    if (content)
                    {
                        ResMgr.getInstance().contents.push(content.loaderInfo.applicationDomain);
                    }
                    break;
                }
                case this.PRE_LOAD_JSON_TYPE:
                {
                    str = (loadItem as URLItem).loader.data;
                    try
                    {
                        data = JSON.parse(str);
                    }
                    catch (err:Error)
                    {
                        data = new Object();
                    }
                    fileName = arrInfo[(arrInfo.length - 1)];
                    fileName = fileName.substring(0, fileName.indexOf("?"));
                    switch(fileName)
                    {
                        case "ArmyCamp.json":
                        {
                            JsonMgr.getInstance().setArmyCampConfig(data);
                            break;
                        }
                        case "Barrack.json":
                        {
                            JsonMgr.getInstance().setBarrackConfig(data);
                            break;
                        }
                        case "Laboratory.json":
                        {
                            JsonMgr.getInstance().setLaboratoryConfig(data);
                            break;
                        }
                        case "Resource.json":
                        {
                            JsonMgr.getInstance().setResourceConfig(data);
                            break;
                        }
                        case "SpellFactory.json":
                        {
                            JsonMgr.getInstance().setSpellFactoryConfig(data);
                            break;
                        }
                        case "Storage.json":
                        {
                            JsonMgr.getInstance().setStorageConfig(data);
                            break;
                        }
                        case "TownHall.json":
                        {
                            JsonMgr.getInstance().setTownHallConfig(data);
                            break;
                        }
                        case "Troop.json":
                        {
                            JsonMgr.getInstance().setTroopConfig(data);
                            break;
                        }
                        case "TroopBase.json":
                        {
                            JsonMgr.getInstance().setTroopBaseConfig(data);
                            break;
                        }
                        case "Wall.json":
                        {
                            JsonMgr.getInstance().setWallConfig(data);
                            break;
                        }
                        case "Defence.json":
                        {
                            JsonMgr.getInstance().setDefenseConfig(data);
                            break;
                        }
                        case "DefenceBase.json":
                        {
                            JsonMgr.getInstance().setDefenseBaseConfig(data);
                            break;
                        }
                        case "ClanCastle.json":
                        {
                            JsonMgr.getInstance().setClanCastleConfig(data);
                            break;
                        }
                        case "BuildCap.json":
                        {
                            JsonMgr.getInstance().setBuildCapConfig(data);
                            break;
                        }
                        case "BuilderHut.json":
                        {
                            JsonMgr.getInstance().setBuilderHutConfig(data);
                            break;
                        }
                        case "ContentName.json":
                        {
                            JsonMgr.getInstance().setContentName(data);
                            break;
                        }
                        case "Sound.json":
                        {
                            JsonMgr.getInstance().setSound(data);
                            break;
                        }
                        case "Music.json":
                        {
                            JsonMgr.getInstance().setMusic(data);
                            break;
                        }
                        case "Ambience.json":
                        {
                            JsonMgr.getInstance().setAmbience(data);
                            break;
                        }
                        case "SingleBattle.json":
                        {
                            JsonMgr.getInstance().setSingleBattle(data);
                            break;
                        }
                        case "FindPrice.json":
                        {
                            JsonMgr.getInstance().setFindPrice(data);
                            break;
                        }
                        case "Obstacles.json":
                        {
                            JsonMgr.getInstance().setObstacles(data);
                            break;
                        }
                        case "SideQuest.json":
                        {
                            JsonMgr.getInstance().setSideQuest(data);
                            break;
                        }
                        case "SideQuestReward.json":
                        {
                            JsonMgr.getInstance().setSideQuestReward(data);
                            break;
                        }
                        case "LevelUser.json":
                        {
                            JsonMgr.getInstance().setLevelUser(data);
                            break;
                        }
                        case "Trap.json":
                        {
                            JsonMgr.getInstance().setTrap(data);
                            break;
                        }
                        case "ShieldPrice.json":
                        {
                            JsonMgr.getInstance().setShieldPrice(data);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case this.PRE_LOAD_XML_TYPE:
                {
                    switch(arrInfo[arrInfo.length - 2])
                    {
                        default:
                        {
                            break;
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onProgressHandler(event:BulkProgressEvent) : void
        {
            this.progressPercent = this.ibulkLoader.weightPercent;
            dispatchEvent(new Event(this.getEvent(this.curLoad, false)));
            if (this.curLoad == AUTOLOAD_URL)
            {
                this.isAutoLoadDone = true;
            }
            return;
        }// end function

        private function removeItemListeners(param1:LoadingItem) : void
        {
            param1.removeEventListener(Event.COMPLETE, this.onLoadItemComplete);
            param1.removeEventListener(ErrorEvent.ERROR, this.onLoadItemError);
            return;
        }// end function

        private function onErrorHandle(event:ErrorEvent) : void
        {
            this.ibulkLoader.remove(event.text);
            return;
        }// end function

        private function onLoadItemError(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as LoadingItem;
            _loc_2.load();
            return;
        }// end function

        private function dispose() : void
        {
            dispatchEvent(new Event(LoadingModule.COMPLETE_PRELOAD));
            return;
        }// end function

    }
}
