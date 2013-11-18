package modules.replay
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import bitzero.net.events.*;
    import gameData.*;
    import map.*;
    import modules.*;
    import modules.battle.*;
    import modules.battle.data.*;
    import modules.city.*;
    import modules.replay.data.*;
    import modules.replay.graphics.*;
    import modules.sound.*;
    import network.*;
    import network.receive.*;
    import network.send.*;
    import resMgr.*;
    import utility.*;

    public class ReplayMgr extends BaseModule
    {
        public var troopList:Vector.<Troop>;
        public var troopsCell:Vector.<int>;
        public var curLoop:int;
        public var dropLoop:int;
        public var endLoop:int;
        public var time:int;
        public var guiReturnHome:GuiReturnHomeReplay;
        public var guiEndReplay:GuiEndReplay;
        public var guiTime:GuiTimeReplayBattle;
        private var firstDrop:Boolean = true;
        private var lastTimeLogin:Number = 0;
        public var guiBeenAttacked:GuiBeenAttacked;
        private var listLog:Vector.<LogBattleData>;
        private var listLogAttack:Vector.<LogBattleData>;
        private var percentLife:Number;
        private var curKeyLog:int;
        private var curType:int;
        public static const END_TIME:int = 1;
        public static const WIN:int = 2;
        public static const LOST:int = 3;
        public static const REQUEST_END_BATTLE:int = 4;
        private static var instance:ReplayMgr;

        public function ReplayMgr()
        {
            return;
        }// end function

        override protected function onInit() : void
        {
            bzConnector.addResponseListener(Command.REPLAY_BATTLE_LIST, this.onGetReplayBattleList);
            bzConnector.addResponseListener(Command.REPLAY_BATTLE_INFO, this.onGetReplayBattleInfo);
            bzConnector.addResponseListener(Command.BATTLE_REVENGE, this.onGetRevengeInfo);
            return;
        }// end function

        private function onGetRevengeInfo(param1:MsgInfo) : void
        {
            var _loc_3:String = null;
            var _loc_4:String = null;
            var _loc_2:* = new BattleInfoMsg(param1.Data);
            if (_loc_2.errorCode > 0)
            {
                _loc_3 = Localization.getInstance().getString("QuickFinish0");
                switch(_loc_2.errorCode)
                {
                    case 30:
                    {
                        _loc_4 = Localization.getInstance().getString("ErrorCode24");
                        break;
                    }
                    case 31:
                    {
                        _loc_4 = Localization.getInstance().getString("ErrorCode25");
                        break;
                    }
                    case 33:
                    {
                        _loc_4 = Localization.getInstance().getString("ErrorCode26");
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                CityMgr.getInstance().showMessage(_loc_3, _loc_4, "ĐÓNG", null);
                return;
            }
            BattleModule.getInstance().resetData();
            this.destroyAllObjCity();
            CityMgr.getInstance().showTransitionEff(this.startRevenge, _loc_2);
            CityMgr.getInstance().setState(GlobalVar.STATE_BATTLE);
            return;
        }// end function

        private function startRevenge(param1:BattleInfoMsg) : void
        {
            CityMgr.getInstance().loadBattleInfo(param1);
            return;
        }// end function

        private function destroyAllObjCity() : void
        {
            CityMgr.getInstance().destroyTroopList();
            CityMgr.getInstance().destroyBuilderList();
            CityMgr.getInstance().destroyFarmerList();
            CityMgr.getInstance().destroyEffectList();
            CityMgr.getInstance().destroyBirdList();
            return;
        }// end function

        private function onGetReplayBattleInfo(param1:MsgInfo) : void
        {
            var _loc_2:BattleInfoReplayMsg = null;
            var _loc_3:BattleInfoMsg = null;
            this.curLoop = 0;
            SoundModule.getInstance().playBgMusic(SoundModule.MUSIC_BG_FIGHT);
            CityMgr.getInstance().setState(GlobalVar.STATE_REPLAY);
            this.destroyAllObjCity();
            _loc_2 = new BattleInfoReplayMsg(param1.Data);
            _loc_3 = new BattleInfoMsg();
            _loc_3.dataList = _loc_2.dataList;
            _loc_3.errorCode = _loc_2.errorCode;
            _loc_3.troopClans = _loc_2.troopClans;
            _loc_3.troopClansHouse = _loc_2.troopClansHouse;
            _loc_3.troopList = _loc_2.troopList;
            _loc_3.dataObstacle = _loc_2.dataObstacle;
            _loc_3.trophyLost = 0;
            _loc_3.trophyReceive = 0;
            _loc_3.uAvatar = "";
            _loc_3.uId = _loc_2.uId;
            _loc_3.uName = _loc_2.uName;
            _loc_3.clanIcon = _loc_2.clanIcon;
            _loc_3.clanName = _loc_2.clanName;
            CityMgr.getInstance().loadBattleInfo(_loc_3);
            this.troopList = _loc_2.troopList;
            this.troopsCell = _loc_2.troopsCell;
            this.dropLoop = this.troopList[0].num;
            this.curLoop = this.dropLoop - GlobalVar.stage.frameRate * 3;
            this.endLoop = _loc_2.endLoop;
            this.time = _loc_2.endTime - _loc_2.startTime;
            this.percentLife = _loc_2.percentLife;
            this.time = (this.endLoop - this.curLoop) / GlobalVar.stage.frameRate + 1;
            this.hideAllGui();
            this.guiReturnHome = new GuiReturnHomeReplay();
            this.guiTime = new GuiTimeReplayBattle();
            this.guiTime.time = this.time;
            this.guiTime.show();
            this.guiReturnHome.show();
            this.firstDrop = true;
            BattleModule.getInstance().resetData();
            BattleModule.getInstance().curLoop = this.curLoop;
            return;
        }// end function

        private function hideAllGui() : void
        {
            CityMgr.getInstance().guiMainTopRight.hide();
            BattleModule.getInstance().hideAllGui();
            return;
        }// end function

        private function onLogin(param1:MsgInfo) : void
        {
            this.sendGetLogInfo();
            return;
        }// end function

        public function sendGetLogInfo() : void
        {
            var _loc_1:* = new BaseCmd(Command.REPLAY_BATTLE_LIST);
            bzConnector.send(_loc_1);
            return;
        }// end function

        private function onGetReplayBattleList(param1:MsgInfo) : void
        {
            var _loc_2:* = new ReplayBattleListMsg(param1.Data);
            this.listLog = _loc_2.listLog;
            this.listLogAttack = _loc_2.listLogAttack;
            this.listLog.sort(this.compareLogBattleData);
            this.listLogAttack.sort(this.compareLogBattleData);
            CityMgr.getInstance().guiLog.setInfo(this.listLog, this.listLogAttack);
            if (this.lastTimeLogin == 0)
            {
                this.lastTimeLogin = GameDataMgr.getInstance().myInfo.lastTimeLogin;
            }
            var _loc_3:* = new Vector.<LogBattleData>;
            var _loc_4:int = 0;
            while (_loc_4 < this.listLog.length)
            {
                
                if (this.lastTimeLogin < this.listLog[_loc_4].endTime)
                {
                    _loc_3.push(this.listLog[_loc_4]);
                }
                _loc_4++;
            }
            this.lastTimeLogin = Utility.getCurTime();
            if (_loc_3.length > 0)
            {
                this.guiBeenAttacked = new GuiBeenAttacked();
                this.guiBeenAttacked.loadInfo(_loc_3);
                this.guiBeenAttacked.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP), true);
                CityMgr.getInstance().guiMainBottom.showMailNotice(_loc_3.length);
            }
            return;
        }// end function

        private function compareLogBattleData(param1:LogBattleData, param2:LogBattleData) : int
        {
            if (param1.keyLog > param2.keyLog)
            {
                return 1;
            }
            if (param1.keyLog < param2.keyLog)
            {
                return -1;
            }
            return 0;
        }// end function

        public function loop() : void
        {
            var _loc_1:int = 0;
            if (GlobalVar.state != GlobalVar.STATE_REPLAY)
            {
                return;
            }
            
            this.curLoop++;
            if (this.curLoop >= this.dropLoop)
            {
            }
            if (this.curLoop >= this.endLoop && BattleModule.getInstance().percentLife >= this.percentLife)
            {
                _loc_1 = BattleModule.getInstance().percentLife;
                BattleModule.getInstance().battleData.removeAllEvent();
                GlobalVar.state = GlobalVar.STATE_SAFE;
                this.showEndTime();
                return;
            }
            this.guiTime.loop();
            return;
        }// end function

        public function dropTroop() : void
        {
            var _loc_2:Troop = null;
            var _loc_1:* = BattleModule.getInstance();
            if (this.troopList && this.troopList.length > 0)
            {
                _loc_2 = this.troopList[0];
                if (_loc_2.type != "Clan")
                {
                    BattleModule.getInstance().addTroop(_loc_2.type, this.troopsCell[0], _loc_2.level);
                }
                else
                {
                    _loc_1.startAddClanTroop(this.troopsCell[0]);
                }
                this.troopList.splice(0, 1);
                this.troopsCell.splice(0, 1);
                if (this.troopList.length > 0)
                {
                    this.dropLoop = this.troopList[0].num;
                }
                if (this.firstDrop)
                {
                    MapMgr.getInstance().rangeMap.hideViewRange();
                    this.firstDrop = false;
                }
            }
            return;
        }// end function

        private function showEndTime() : void
        {
            this.guiReturnHome.hide();
            this.guiEndReplay = new GuiEndReplay();
            this.guiEndReplay.show();
            return;
        }// end function

        public function sendReplayBattle(param1:int, param2:int) : void
        {
            this.percentLife = 0;
            var _loc_3:int = 0;
            while (_loc_3 < this.listLog.length)
            {
                
                if (this.listLog[_loc_3].keyLog == param1)
                {
                    this.percentLife = this.listLog[_loc_3].percentLife;
                }
                _loc_3++;
            }
            var _loc_4:* = new GetInfoReplayBattle();
            _loc_4.key = param1;
            _loc_4.mode = param2;
            bzConnector.send(_loc_4);
            BattleModule.getInstance().resetData();
            return;
        }// end function

        public function returnHome() : void
        {
            this.hideAllGuiReplay();
            BattleModule.getInstance().returnHome();
            CityMgr.getInstance().setState(GlobalVar.STATE_MYHOME);
            return;
        }// end function

        private function hideAllGuiReplay() : void
        {
            this.guiReturnHome.hide();
            this.guiReturnHome.destroyBaseGUI();
            this.guiTime.hide();
            this.guiTime.destroyBaseGUI();
            if (this.guiEndReplay)
            {
                this.guiEndReplay.hide();
                this.guiEndReplay.destroyBaseGUI();
                this.guiEndReplay = null;
            }
            return;
        }// end function

        public function showEffectReplayBattle(param1:int, param2:int) : void
        {
            this.curKeyLog = param1;
            this.curType = param2;
            CityMgr.getInstance().showTransitionEff(this.sendReplayBattle, param1, param2);
            return;
        }// end function

        public function replay() : void
        {
            this.hideAllGuiReplay();
            BattleModule.getInstance().battleData.clearAllObj();
            CityMgr.getInstance().showTransitionEff(this.sendReplayBattle, this.curKeyLog, this.curType);
            return;
        }// end function

        public function EffectReturnHome() : void
        {
            CityMgr.getInstance().showTransitionEff(this.returnHome);
            return;
        }// end function

        public function sendRevenge(param1:int) : void
        {
            var _loc_2:* = new RevengeCmd();
            _loc_2.id = param1;
            bzConnector.send(_loc_2);
            return;
        }// end function

        public static function getInstance() : ReplayMgr
        {
            if (!instance)
            {
                instance = new ReplayMgr;
            }
            return instance;
        }// end function

    }
}
