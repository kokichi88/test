package modules.feed
{
    import bitzero.net.data.*;
    import bitzero.net.events.*;
    import com.adobe.images.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import gameData.*;
    import modules.*;
    import network.*;
    import network.receive.*;
    import network.send.*;
    import resMgr.*;
    import utility.*;

    public class FeedMgr extends BaseModule
    {
        private var arrFeedDaily:Array;
        private var arrTrophy:Array;
        public var arrInfo:Array;
        public static const URL:String = "res/imgFeed/Feed_";
        public static const LEVEL_TOWNHALL:int = 3;
        public static const LEVEL_PLAYER:int = 10;
        public static const BATTLE_WIN_GOLD:int = 150000;
        public static const BATTLE_WIN_OIL:int = 150000;
        public static const BATTLE_WIN_TROPHY:int = 27;
        public static const BATTLE_WIN_TROPHY_MORE:int = 200;
        public static const BATTLE_WIN_TOWNHALL_MORE:int = 2;
        public static const SINGE_MAP_STAR1:int = 100;
        public static const SINGE_MAP_STAR2:int = 150;
        public static const FIRST_PLAY_GAME:int = 1;
        public static const FIRST_WIN_BATTLE:int = 2;
        public static const FIRST_WIN_BATTLE_3STAR:int = 3;
        public static const ACHIE_TROPHY_1:int = 4;
        public static const ACHIE_TROPHY_2:int = 5;
        public static const ACHIE_TROPHY_3:int = 6;
        public static const ACHIE_TROPHY_4:int = 7;
        public static const ACHIE_TROPHY_5:int = 8;
        public static const ACHIE_TROPHY_6:int = 9;
        public static const ACHIE_TROPHY_7:int = 10;
        public static const ACHIE_TROPHY_8:int = 11;
        public static const ACHIE_TROPHY_9:int = 12;
        public static const ACHIE_TROPHY_10:int = 13;
        public static const ACHIE_TROPHY_11:int = 14;
        public static const ACHIE_TROPHY_12:int = 15;
        public static const ACHIE_TROPHY_13:int = 16;
        public static const ACHIE_TROPHY_14:int = 17;
        public static const ACHIE_TROPHY_15:int = 18;
        public static const ACHIE_TROPHY_16:int = 19;
        public static const BUILD_LAB_1:int = 20;
        public static const BUILD_BDH_4:int = 21;
        public static const BUILD_CLC_1:int = 22;
        public static const BUILD_DEF_3:int = 23;
        public static const BUILD_SPF_1:int = 24;
        public static const BUILD_RES_3:int = 25;
        public static const BUILD_BDH_5:int = 26;
        public static const BUILD_DEF_6:int = 27;
        public static const BUILD_ALT_1:int = 28;
        public static const BUILD_ALT_2:int = 29;
        public static const UP_KING_40:int = 30;
        public static const UP_QUEEN_40:int = 31;
        public static const UP_LEVEL_TOWNHALL:int = 32;
        public static const UP_LEVEL:int = 33;
        public static const SINGE_MAP_100Star:int = 34;
        public static const SINGE_MAP_150Star:int = 35;
        public static const BATTLE_TROPHY_200:int = 36;
        public static const BATTLE_LEVEL_TOWNHALL_2:int = 37;
        public static const BATTLE_TROPHY_RECIEVE_27:int = 38;
        public static const BATTLE_GOLD:int = 39;
        public static const BATTLE_OIL:int = 40;
        private static var instance:FeedMgr;

        public function FeedMgr()
        {
            this.arrFeedDaily = [32, 33, 36, 37, 38, 39, 40];
            this.arrTrophy = [400, 500, 600, 800, 1000, 1200, 1400, 1600, 1800, 2000, 2200, 2400, 2600, 2800, 3000, 3200, 10000];
            this.arrInfo = new Array();
            return;
        }// end function

        override protected function onInit() : void
        {
            bzConnector.addResponseListener(Command.GET_TOKEN_FEED, this.onGetTokenFeed);
            bzConnector.addResponseListener(Command.GET_FEED_INFO, this.onGetFeedInfo);
            return;
        }// end function

        private function onGetFeedInfo(param1:MsgInfo) : void
        {
            if (!Config.hasFeed)
            {
                return;
            }
            var _loc_2:* = new GetFeedInfoMsg(param1.Data);
            this.arrInfo = _loc_2.feed.split("_");
            return;
        }// end function

        private function onGetTokenFeed(param1:MsgInfo) : void
        {
            if (!Config.hasFeed)
            {
                return;
            }
            var _loc_2:* = new GetTokenFeedMsg(param1.Data);
            this.uploadFeedWall(_loc_2.token, _loc_2.appId, _loc_2.userName, _loc_2.feedId);
            return;
        }// end function

        public function sendGetFeedInfo() : void
        {
            if (!Config.hasFeed)
            {
                return;
            }
            var _loc_1:* = new BaseCmd(Command.GET_FEED_INFO);
            bzConnector.send(_loc_1);
            return;
        }// end function

        public function sendRequestFeedWall(param1:int) : void
        {
            var _loc_2:RequestFeedWallCmd = null;
            if (!Config.hasFeed)
            {
                return;
            }
            if (this.checkCanFeed(param1))
            {
                _loc_2 = new RequestFeedWallCmd(param1);
                bzConnector.send(_loc_2);
                this.arrInfo.push(param1);
            }
            return;
        }// end function

        private function checkCanFeed(param1:int) : Boolean
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.arrFeedDaily.length)
            {
                
                if (this.arrFeedDaily[_loc_2] == param1)
                {
                    return true;
                }
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.arrInfo.length)
            {
                
                if (param1 == int(this.arrInfo[_loc_2]))
                {
                    return false;
                }
                _loc_2++;
            }
            return true;
        }// end function

        private function checkHasFeed(param1:int) : Boolean
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.arrInfo.length)
            {
                
                if (param1 == int(this.arrInfo[_loc_2]))
                {
                    return true;
                }
                _loc_2++;
            }
            return false;
        }// end function

        private function sendFeed(param1:String, param2:int, param3:String, param4:int, param5:Sprite) : void
        {
            var detail:String;
            var spr:Sprite;
            var bitmapData:BitmapData;
            var encoder:JPGEncoder;
            var uInfo:UserInfo;
            var pict:ByteArray;
            var AddVariable:URLVariables;
            var url:String;
            var aURLRequest:URLRequest;
            var header:URLRequestHeader;
            var aURLLoader:URLLoader;
            var tokenObj:* = param1;
            var appId:* = param2;
            var username:* = param3;
            var id:* = param4;
            var bg:* = param5;
            try
            {
                var feedComp:* = function (event:Event) : void
            {
                return;
            }// end function
            ;
                var feedErr:* = function (event:Event) : void
            {
                return;
            }// end function
            ;
                detail = Localization.getInstance().getString("Feed_Dec_" + id) + ": http://me.zing.vn/apps/thoiloan";
                if (id >= 4 && id <= 19)
                {
                    detail = Localization.getInstance().getString("Feed_Dec_4") + ": http://me.zing.vn/apps/thoiloan";
                    detail = detail.replace("@num", this.arrTrophy[id - 4]);
                }
                spr = new Sprite();
                spr.addChild(bg);
                bitmapData = new BitmapData(spr.width, spr.height, false, 16777215);
                bitmapData.draw(spr);
                encoder = new JPGEncoder();
                uInfo = GameDataMgr.getInstance().myInfo;
                pict = encoder.encode(bitmapData);
                AddVariable = new URLVariables();
                AddVariable.userid = uInfo.uId;
                AddVariable.username = username;
                AddVariable.token = tokenObj;
                AddVariable.app_id = appId;
                AddVariable.description = detail;
                url;
                url = url + (username + "?" + AddVariable.toString());
                aURLRequest = new URLRequest(url);
                header = new URLRequestHeader("Content-type", "application/octet-stream");
                aURLRequest.requestHeaders.push(header);
                aURLRequest.method = URLRequestMethod.POST;
                aURLRequest.data = pict;
                aURLLoader = new URLLoader();
                aURLLoader.dataFormat = URLLoaderDataFormat.BINARY;
                aURLLoader.addEventListener(IOErrorEvent.IO_ERROR, feedErr);
                aURLLoader.addEventListener(Event.COMPLETE, feedComp);
                aURLLoader.load(aURLRequest);
            }
            catch (err:Error)
            {
            }
            return;
        }// end function

		public function uploadFeedWall(param1:String, param2:int, param3:String, param4:int):void
		{
			var bg:Sprite;
			var tokenObj:* = param1;
			var appId:* = param2;
			var username:* = param3;
			var id:* = param4;
			var imgName:* = Config.getStaticUrl() + "imgFeed/Feed_" + id + ".jpg";
			bg = ResMgr.getInstance().getMovieClip(imgName) as MovieClip;
			if (bg.width == 0 || bg.height == 0)
			{
				var loadComp:Function = function():void
				{
					bg.removeEventListener(MovieClipEx.EVENT_LOADED, loadComp);
					sendFeed(tokenObj, appId, username, id, bg);
					return;
				} // end function
				;
				
				bg.addEventListener(MovieClipEx.EVENT_LOADED, function():void
					{
						bg.removeEventListener(MovieClipEx.EVENT_LOADED, loadComp);
						sendFeed(tokenObj, appId, username, id, bg);
						return;
					} // end function
					);
			}
			else
			{
				this.sendFeed(tokenObj, appId, username, id, bg);
			}
			return;
		} // end function

        public function endBattle(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
        {
            var _loc_7:UserInfo = null;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            switch(param1)
            {
                case GlobalVar.STATE_BATTLE:
                {
                    if (param2 == 3 && this.checkCanFeed(FeedMgr.FIRST_WIN_BATTLE_3STAR))
                    {
                        this.sendRequestFeedWall(FeedMgr.FIRST_WIN_BATTLE_3STAR);
                        return;
                    }
                    if (this.checkCanFeed(FeedMgr.FIRST_WIN_BATTLE))
                    {
                        this.sendRequestFeedWall(FeedMgr.FIRST_WIN_BATTLE);
                        return;
                    }
                    _loc_7 = GameDataMgr.getInstance().myInfo;
                    _loc_8 = _loc_7.trophy + param6;
                    _loc_9 = this.getIndex(_loc_8);
                    if (_loc_9 >= 0 && _loc_9 < 15)
                    {
                        if (this.checkCanFeed(_loc_9 + 4))
                        {
                            this.sendRequestFeedWall(_loc_9 + 4);
                        }
                    }
                    if (param6 > BATTLE_WIN_TROPHY)
                    {
                        this.sendRequestFeedWall(BATTLE_TROPHY_RECIEVE_27);
                    }
                    if (param3 >= BATTLE_WIN_GOLD)
                    {
                        this.sendRequestFeedWall(BATTLE_GOLD);
                    }
                    if (param3 >= BATTLE_WIN_OIL)
                    {
                        this.sendRequestFeedWall(BATTLE_OIL);
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

        private function getIndex(param1:int) : int
        {
            var _loc_2:int = 0;
            while (_loc_2 < (this.arrTrophy.length - 1))
            {
                
                if (this.arrTrophy[_loc_2] <= param1 && param1 < this.arrTrophy[(_loc_2 + 1)])
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public static function getInstance() : FeedMgr
        {
            if (!instance)
            {
                instance = new FeedMgr;
            }
            return instance;
        }// end function

    }
}
