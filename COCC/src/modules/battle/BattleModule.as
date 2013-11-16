package modules.battle
{
    import __AS3__.vec.*;
    import bitzero.core.*;
    import bitzero.net.data.*;
    import bitzero.net.events.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import component.*;
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import component.avatar.things.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import gameData.*;
    import map.*;
    import map.logic.*;
    import modules.*;
    import modules.battle.data.*;
    import modules.battle.graphics.*;
    import modules.battle.logic.*;
    import modules.battle.logic.bean.*;
    import modules.city.*;
    import modules.city.graphics.tutorial.*;
    import modules.feed.*;
    import modules.replay.*;
    import modules.sound.*;
    import network.*;
    import network.send.*;
    import resMgr.*;
    import utility.*;

    public class BattleModule extends BaseModule
    {
        private var countLoopShowRange:int = 0;
        private var showRangeActtack:Boolean = false;
        private var countLoopDelayClan:int = 0;
        private var countLoopDelayClanHouse:int = 0;
        private var cellClan:int;
        public var battleData:BattleData;
        public var curLoop:int;
        public var curIdTroop:String = "";
        public var listTroop:Vector.<Troop>;
        public var listTroopDrop:Vector.<Troop>;
        public var listTroopClan:Vector.<Troop>;
        public var listTroopClanHouse:Vector.<Troop>;
        public var guiBattleTroop:GuiBattleTroop;
        public var guiBattleCenterLeft:GuiBattleCenterLeft;
        public var guiBattleCenterRight:GuiBattleCenterRight;
        public var guiBattleTopCenter:GuiBattleTopCenter;
        public var guiBattleTopLeft:GuiBattleTopLeft;
        public var guiResumBattle:GuiResumBattle;
        private var guiEndBattle:GuiBattleEnd;
        public var gold:int;
        public var elixir:int;
        public var darkElixir:int;
        public var uId:int;
        public var uName:String;
        public var uAvatar:String;
        public var trophyReceive:int;
        public var trophyLost:int;
        public var status:int = 0;
        public var numStar:int;
        public var hasClan:Boolean = true;
        public var ridTroopClan:Boolean = false;
        public var ridTroopClanHouse:Boolean = false;
        public var percentLife:int = 0;
        public var totalHp:int;
        public var curHp:int;
        public var goldRop:int;
        public var elixirRop:int;
        public var darkElixirRop:int;
        private var iconClan:Sprite;
        private var cellHouseClan:int;
        private var listEffectStar:Vector.<int>;
        private var countEffectStar:int = 0;
        public var typeIconClan:int = 0;
        public var clanIconFriend:int = 0;
        public var clanNameFriend:String = "";
        private var lastLoopDropTroop:int = 0;
        private var listCmd:Vector.<AddTroopCmd>;
        private var hasACK:Boolean = true;
        private var modBattle:int = 0;
        private var countDownEndGame:int = 0;
        private var playingEffectStar:Boolean = false;
        private var numShowArrow:int;
        public static const END_TIME:int = 1;
        public static const WIN:int = 2;
        public static const BONUS_MAP:int = 3;
        public static const LOST:int = 3;
        public static const REQUEST_END_BATTLE:int = 4;
        public static const DELAY_RENDER:int = 5;
        public static const COUNT_DOWN_ACK:int = 100;
        private static var instance:BattleModule;
        private static const DELAY_ADD_TROOP_CLAN:int = 5;
        private static const DELAY_EFFECT_STAR:int = 30;
        private static const COUNT_DOWN_SHOW_RANGE:int = 90;

        public function BattleModule()
        {
            this.battleData = new BattleData();
            this.listTroop = new Vector.<Troop>;
            this.listTroopDrop = new Vector.<Troop>;
            this.listTroopClan = new Vector.<Troop>;
            this.listTroopClanHouse = new Vector.<Troop>;
            this.guiBattleTroop = new GuiBattleTroop();
            this.guiBattleCenterLeft = new GuiBattleCenterLeft();
            this.guiBattleCenterRight = new GuiBattleCenterRight();
            this.guiBattleTopCenter = new GuiBattleTopCenter();
            this.guiBattleTopLeft = new GuiBattleTopLeft();
            this.guiResumBattle = new GuiResumBattle();
            this.listEffectStar = new Vector.<int>;
            this.listCmd = new Vector.<AddTroopCmd>;
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            return;
        }// end function

        override protected function onInit() : void
        {
            bzConnector.addResponseListener(Command.BATTLE_PUT_TROOP, this.onGetDropTroop);
            bzConnector.addEventListener(BZEvent.CONNECTION_LOST, this.onConnectionLost);
            return;
        }// end function

        private function onConnectionLost(event:BZEvent) : void
        {
            this.hasACK = false;
            return;
        }// end function

        private function onGetDropTroop(param1:MsgInfo) : void
        {
            var _loc_2:* = new BaseMsg(param1.Data);
            if (_loc_2.errorCode == 0)
            {
                this.listCmd.splice(0, 1);
                if (this.listCmd.length > 0)
                {
                    bzConnector.send(this.listCmd[0]);
                }
            }
            else
            {
                this.listCmd.splice(0, 1);
            }
            return;
        }// end function

        private function createAvatar() : void
        {
            var _loc_1:* = new Avatar();
            _loc_1.create(AnCategory.AVATAR, "ARM_2", 1);
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI);
            _loc_2.addChild(_loc_1);
            _loc_1.x = GlobalVar.MAP_WIDTH / 2 * MapMgr.curScale;
            _loc_1.y = GlobalVar.MAP_HEIGHT / 2 * MapMgr.curScale;
            return;
        }// end function

        public function onClickMap() : void
        {
            var _loc_14:int = 0;
            var _loc_15:DataObject = null;
            var _loc_16:String = null;
            var _loc_17:String = null;
            var _loc_18:TooltipText = null;
            if (TutorialMgr.getInstance().isTutorial)
            {
                _loc_14 = TutorialMgr.getInstance().curStep;
                if (_loc_14 >= 11 && _loc_14 <= 14)
                {
                    return;
                }
            }
            if (this.countDownEndGame > 0)
            {
                return;
            }
            if (this.lastLoopDropTroop == this.curLoop)
            {
                return;
            }
            this.lastLoopDropTroop = this.curLoop;
            var _loc_1:* = MouseMgr.getInstance().mousePos;
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            _loc_1 = LayerMgr.getInstance().getLocal(GlobalVar.LAYER_GAME, _loc_1);
            var _loc_3:* = MapMgr.getInstance().cityMap.pointToIso(_loc_1.x, _loc_1.y);
            if (_loc_3.x < 0 && _loc_3.x > -BONUS_MAP)
            {
                _loc_3.x = 0;
            }
            if (_loc_3.y < 0 && _loc_3.y > -BONUS_MAP)
            {
                _loc_3.y = 0;
            }
            var _loc_4:* = MapMgr.getInstance().cityMap.maxCol - 1;
            if (_loc_3.x > _loc_4 && _loc_4 + BONUS_MAP)
            {
                _loc_3.x = _loc_4;
            }
            if (_loc_3.y > _loc_4 && _loc_4 + BONUS_MAP)
            {
                _loc_3.y = _loc_4;
            }
            var _loc_5:* = MapMgr.getInstance().cityMap.getIsoType(_loc_3.x, _loc_3.y);
            var _loc_6:* = new Point(_loc_3.x * 3, _loc_3.y * 3);
            var _loc_7:* = Math.random() * 3;
            var _loc_8:* = Math.random() * 3;
            var _loc_9:* = new Point(_loc_6.x + _loc_7, _loc_6.y + _loc_8);
            var _loc_10:Boolean = false;
            if (_loc_5 == BaseMap.OBSTACLE)
            {
                _loc_15 = this.battleData.getObject(MapMgr.getInstance().cityMap.areaMap.getNode(_loc_3.x, _loc_3.y).idNode);
                if (_loc_15 && _loc_15 is DataHouse)
                {
                    _loc_9 = Utility.randomCellBuilding(DataHouse(_loc_15).mapObject);
                    _loc_10 = true;
                }
            }
            var _loc_11:* = MapMgr.getInstance().battleMap.isoToCell(_loc_9.x, _loc_9.y);
            if (this.checkIso(_loc_9) != BaseMap.CAN_DROP && _loc_10 == false)
            {
                CityMgr.getInstance().guiNotify.addNewNotify(Localization.getInstance().getString("Battle_CantDropTroop"), "#FF4040");
                MapMgr.getInstance().rangeMap.showViewRange();
                this.showRangeActtack = true;
                this.countLoopShowRange = COUNT_DOWN_SHOW_RANGE;
                return;
            }
            if (!this.subTroop(this.curIdTroop, 1))
            {
                _loc_16 = "<p align=\'center\'><font size=\'22\'color =\'#FFFFFF\'>" + Localization.getInstance().getString("Battle_CantHasTroop") + "</font></p>";
                _loc_17 = "<font size=\'22\'color =\'#FF0000\'>" + Localization.getInstance().getString(this.curIdTroop) + "</font>";
                _loc_16 = _loc_16.replace("@name@", _loc_17);
                _loc_18 = new TooltipText(true, true, true);
                _loc_18.autoSize = TextFieldAutoSize.CENTER;
                _loc_18.htmlText = _loc_16;
                CityMgr.getInstance().guiNotify.addNewNotifyText(_loc_18);
                return;
            }
            var _loc_12:int = 1;
            _loc_1 = MapMgr.getInstance().battleMap.isoToPoint(_loc_9.x, _loc_9.y);
            EffectDraw.play("drop_troops", new Point(_loc_1.x, _loc_1.y), _loc_2);
            if (this.curIdTroop != "Clan")
            {
                _loc_12 = this.getLevelTroop(this.curIdTroop, 0);
                this.addTroop(this.curIdTroop, _loc_11, _loc_12);
            }
            else
            {
                this.startAddClanTroop(_loc_11);
            }
            this.addListTroopDrop(this.curIdTroop, 1, _loc_12);
            var _loc_13:* = new AddTroopCmd(this.curIdTroop, _loc_11, this.curLoop);
            if (this.listCmd.length == 0)
            {
                bzConnector.send(_loc_13);
                CityMgr.getInstance().lastACKLoop = 0;
            }
            this.listCmd.push(_loc_13);
            if (this.status == 0)
            {
                this.startBattle();
            }
            this.status = 2;
            if (TutorialMgr.getInstance().isTutorial)
            {
                var _loc_19:String = this;
                var _loc_20:* = this.numShowArrow + 1;
                _loc_19.numShowArrow = _loc_20;
                if (this.numShowArrow >= 4)
                {
                    TutorialMgr.getInstance().removeArrow();
                }
            }
            return;
        }// end function

        public function startAddClanTroop(param1:int) : void
        {
            var _loc_2:* = MapMgr.getInstance().battleMap.cellToPoint(param1);
            var _loc_3:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            this.ridTroopClan = true;
            this.countLoopDelayClan = DELAY_ADD_TROOP_CLAN;
            this.cellClan = param1;
            var _loc_4:* = ResMgr.getInstance().getMovieClip("ClanSymbol_" + GameDataMgr.getInstance().myClanDetial.icon) as Sprite;
            this.iconClan = ResMgr.getInstance().getMovieClip("ClanTower") as Sprite;
            _loc_3.addChild(this.iconClan);
            this.battleData.imageList.push(this.iconClan);
            _loc_4.x = (-_loc_4.width) / 2;
            _loc_4.y = -60;
            this.iconClan.addChild(_loc_4);
            this.iconClan.x = _loc_2.x;
            this.iconClan.y = _loc_2.y;
            return;
        }// end function

        public function addTroop(param1:String, param2:int, param3:int, param4:Boolean = false, param5:int = 1) : void
        {
            var _loc_6:DataObject = null;
            var _loc_7:Sprite = null;
            switch(param1)
            {
                case DataObject.BARBARIAN:
                {
                    _loc_6 = new Babarian();
                    break;
                }
                case DataObject.GOBLIN:
                {
                    _loc_6 = new Goblin();
                    break;
                }
                case DataObject.GIANT:
                {
                    _loc_6 = new Giant();
                    break;
                }
                case DataObject.ARCHER:
                {
                    _loc_6 = new Archer();
                    break;
                }
                case DataObject.WALL_BREAKER:
                {
                    _loc_6 = new WallBreaker();
                    break;
                }
                case DataObject.BALLOON:
                {
                    _loc_6 = new Balloon();
                    break;
                }
                case DataObject.WINZAR:
                {
                    _loc_6 = new Winzar();
                    break;
                }
                case DataObject.HEALER:
                {
                    _loc_6 = new Healer();
                    break;
                }
                default:
                {
                    _loc_6 = new DataTroop();
                    break;
                    break;
                }
            }
            _loc_6.setInfo(param1, param3);
            _loc_6.responeCell = param2;
            _loc_6.team = param5;
            if (param5 == 2)
            {
                _loc_6.deepLevel = 2;
            }
            this.battleData.addObj(_loc_6);
            if (param4)
            {
                if (param5 == 2)
                {
                    if (this.clanIconFriend < 0)
                    {
                        this.clanIconFriend = 0;
                    }
                    _loc_7 = ResMgr.getInstance().getMovieClip("ClanSymbol_" + this.clanIconFriend) as Sprite;
                }
                else
                {
                    _loc_7 = ResMgr.getInstance().getMovieClip("ClanSymbol_" + GameDataMgr.getInstance().myClanDetial.icon) as Sprite;
                }
                var _loc_8:Number = 0.5;
                _loc_7.scaleY = 0.5;
                _loc_7.scaleX = _loc_8;
                _loc_6.avatar.addChild(_loc_7);
                _loc_7.x = (-_loc_7.width) / 2;
                _loc_7.y = (-_loc_6.avatar.height) / 3 - _loc_7.height;
            }
            SoundModule.getInstance().playSound(SoundModule[param1 + "_DEPLOY"]);
            return;
        }// end function

        private function subTroop(param1:String, param2:int = 1) : Boolean
        {
            var _loc_3:int = 0;
            if (param1 == "Clan")
            {
                if (this.hasClan)
                {
                    this.guiBattleTroop.subTroop(param1, param2);
                    this.hasClan = false;
                    return true;
                }
            }
            else
            {
                _loc_3 = 0;
                while (_loc_3 < this.listTroop.length)
                {
                    
                    if (this.listTroop[_loc_3].type == param1)
                    {
                        if (this.listTroop[_loc_3].num >= param2)
                        {
                            this.listTroop[_loc_3].num = this.listTroop[_loc_3].num - param2;
                            this.guiBattleTroop.subTroop(param1, param2);
                            return true;
                        }
                    }
                    _loc_3++;
                }
            }
            return false;
        }// end function

        private function addListTroopDrop(param1:String, param2:int = 1, param3:int = 1) : void
        {
            var _loc_4:* = new Troop();
            new Troop().type = param1;
            _loc_4.num = 1;
            _loc_4.level = param3;
            var _loc_5:int = 0;
            while (_loc_5 < this.listTroopDrop.length)
            {
                
                if (this.listTroopDrop[_loc_5].type == param1)
                {
                    var _loc_6:* = this.listTroopDrop[_loc_5];
                    var _loc_7:* = this.listTroopDrop[_loc_5].num + 1;
                    _loc_6.num = _loc_7;
                    return;
                }
                _loc_5++;
            }
            this.listTroopDrop.push(_loc_4);
            return;
        }// end function

        private function getLevelTroop(param1:String, param2:int) : int
        {
            var _loc_3:Vector.<Troop> = null;
            switch(param2)
            {
                case 0:
                {
                    _loc_3 = this.listTroop;
                    break;
                }
                case 1:
                {
                    _loc_3 = this.listTroopClan;
                    break;
                }
                case 2:
                {
                    _loc_3 = this.listTroopClanHouse;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                if (_loc_3[_loc_4].type == param1)
                {
                    return _loc_3[_loc_4].level;
                }
                _loc_4++;
            }
            return 1;
        }// end function

        private function checkIso(param1:Point) : int
        {
            return MapMgr.getInstance().battleMap.getIsoType(param1.x, param1.y);
        }// end function

        public function loop() : void
        {
            if (GlobalVar.state != GlobalVar.STATE_BATTLE && GlobalVar.state != GlobalVar.STATE_REPLAY && GlobalVar.state != GlobalVar.STATE_SINGLE_MAP)
            {
                return;
            }
            this.battleData.showCheckSum();
            var _loc_1:String = this;
            var _loc_2:* = this.curLoop + 1;
            _loc_1.curLoop = _loc_2;
            this.battleData.loop();
            if (this.curLoop % DELAY_RENDER == 0)
            {
                this.battleData.renderObj(true);
            }
            if (GlobalVar.state != GlobalVar.STATE_BATTLE && GlobalVar.state != GlobalVar.STATE_SINGLE_MAP)
            {
                if (GlobalVar.state == GlobalVar.STATE_REPLAY)
                {
                    if (this.curLoop >= ReplayMgr.getInstance().dropLoop)
                    {
                        ReplayMgr.getInstance().dropTroop();
                    }
                    if (this.ridTroopClan)
                    {
                        if (this.countLoopDelayClan >= DELAY_ADD_TROOP_CLAN)
                        {
                            if (this.listTroopClan.length > 0)
                            {
                                this.addTroop(this.listTroopClan[0].type, this.cellClan, this.listTroopClan[0].level, true);
                            }
                            else
                            {
                                this.ridTroopClan = false;
                            }
                            this.listTroopClan.splice(0, 1);
                            this.countLoopDelayClan = 0;
                        }
                        if (this.listTroopClan.length > 0)
                        {
                            var _loc_1:String = this;
                            var _loc_2:* = this.countLoopDelayClan + 1;
                            _loc_1.countLoopDelayClan = _loc_2;
                        }
                    }
                    if (this.ridTroopClanHouse)
                    {
                        if (this.countLoopDelayClanHouse >= DELAY_ADD_TROOP_CLAN)
                        {
                            if (this.listTroopClanHouse.length > 0)
                            {
                                this.addTroop(this.listTroopClanHouse[0].type, this.cellHouseClan, this.listTroopClanHouse[0].level, true, 2);
                            }
                            else
                            {
                                this.ridTroopClanHouse = false;
                            }
                            this.listTroopClanHouse.splice(0, 1);
                            this.countLoopDelayClanHouse = 0;
                        }
                        if (this.listTroopClanHouse.length > 0)
                        {
                            var _loc_1:String = this;
                            var _loc_2:* = this.countLoopDelayClanHouse + 1;
                            _loc_1.countLoopDelayClanHouse = _loc_2;
                        }
                    }
                }
                return;
            }
            if (GlobalVar.state != GlobalVar.STATE_SINGLE_MAP)
            {
                this.guiBattleTopCenter.loop();
            }
            if (this.ridTroopClan)
            {
                if (this.countLoopDelayClan >= DELAY_ADD_TROOP_CLAN)
                {
                    if (this.listTroopClan.length > 0)
                    {
                        this.addTroop(this.listTroopClan[0].type, this.cellClan, this.listTroopClan[0].level, true);
                    }
                    this.listTroopClan.splice(0, 1);
                    this.countLoopDelayClan = 0;
                }
                if (this.listTroopClan.length > 0)
                {
                    var _loc_1:String = this;
                    var _loc_2:* = this.countLoopDelayClan + 1;
                    _loc_1.countLoopDelayClan = _loc_2;
                }
            }
            if (this.ridTroopClanHouse)
            {
                if (this.countLoopDelayClanHouse >= DELAY_ADD_TROOP_CLAN)
                {
                    if (this.listTroopClanHouse.length > 0)
                    {
                        this.addTroop(this.listTroopClanHouse[0].type, this.cellHouseClan, this.listTroopClanHouse[0].level, true, 2);
                    }
                    this.listTroopClanHouse.splice(0, 1);
                    this.countLoopDelayClanHouse = 0;
                }
                if (this.listTroopClanHouse.length > 0)
                {
                    var _loc_1:String = this;
                    var _loc_2:* = this.countLoopDelayClanHouse + 1;
                    _loc_1.countLoopDelayClanHouse = _loc_2;
                }
            }
            if (this.showRangeActtack)
            {
                var _loc_1:String = this;
                var _loc_2:* = this.countLoopShowRange - 1;
                _loc_1.countLoopShowRange = _loc_2;
                if (this.countLoopShowRange <= 0)
                {
                    this.showRangeActtack = false;
                    MapMgr.getInstance().rangeMap.hideViewRange();
                }
            }
            if (this.listEffectStar.length > 0)
            {
                var _loc_1:String = this;
                var _loc_2:* = this.countEffectStar - 1;
                _loc_1.countEffectStar = _loc_2;
                if (this.countEffectStar <= 0)
                {
                    this.playEffectStar(this.listEffectStar[0], false);
                    this.countEffectStar = DELAY_EFFECT_STAR;
                    this.listEffectStar.splice(0, 1);
                }
            }
            else if (this.countDownEndGame > 0)
            {
                var _loc_1:String = this;
                var _loc_2:* = this.countDownEndGame - 1;
                _loc_1.countDownEndGame = _loc_2;
                if (this.countDownEndGame == 0)
                {
                    this.showResumBattle();
                }
            }
            if (this.curLoop % COUNT_DOWN_ACK == 0)
            {
                this.sendCmdAck();
            }
            return;
        }// end function

        private function sendCmdAck() : void
        {
            var _loc_1:AckBattleCmd = null;
            if (this.hasACK)
            {
                _loc_1 = new AckBattleCmd(this.curLoop);
                bzConnector.send(_loc_1);
            }
            return;
        }// end function

        public function showResumBattle(param1:int = 0) : void
        {
            var _loc_2:Point = null;
            switch(param1)
            {
                case 0:
                {
                    switch(this.status)
                    {
                        case 0:
                        case 1:
                        {
                            ModuleMgr.getInstance().doFunction(CityMgr.SHOW_TRANSITION_EFF, this.returnHome);
                            break;
                        }
                        case 2:
                        {
                            CityMgr.getInstance().setState(GlobalVar.STATE_SAFE);
                            if (this.guiEndBattle == null)
                            {
                                this.guiEndBattle = new GuiBattleEnd();
                            }
                            this.guiEndBattle.setInfo();
                            this.guiEndBattle.show(null, true);
                            this.battleData.removeAllEvent();
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case 1:
                {
                    CityMgr.getInstance().setState(GlobalVar.STATE_SAFE);
                    if (this.guiEndBattle == null)
                    {
                        this.guiEndBattle = new GuiBattleEnd();
                    }
                    this.guiEndBattle.setInfo();
                    this.guiEndBattle.show(null, true);
                    this.battleData.removeAllEvent();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (TutorialMgr.getInstance().isTutorial)
            {
                TutorialMgr.getInstance().layer.hideFog();
                _loc_2 = this.guiEndBattle.getPos();
                _loc_2.x = _loc_2.x + (this.guiEndBattle.bmpReturnHome.img.x + this.guiEndBattle.bmpReturnHome.width / 2);
                _loc_2.y = _loc_2.y + (this.guiEndBattle.bmpReturnHome.img.y - 5);
                TutorialMgr.getInstance().showArrow(_loc_2.x, _loc_2.y);
            }
            CityMgr.getInstance().hideMessage();
            this.guiBattleTroop.hide();
            this.guiBattleCenterLeft.hide();
            this.guiBattleTopCenter.hide();
            this.guiResumBattle.hide();
            return;
        }// end function

        public function findComplete(param1:Vector.<Troop>, param2:Boolean) : void
        {
            var _loc_3:Point = null;
            var _loc_4:ItemBattleTroop = null;
            var _loc_5:int = 0;
            this.listTroop = new Vector.<Troop>;
            this.listTroop = param1;
            this.listTroopDrop = new Vector.<Troop>;
            this.resetData();
            this.guiBattleTroop.setData(this.listTroop);
            this.guiBattleTroop.show();
            this.modBattle = GlobalVar.state;
            if (!TutorialMgr.getInstance().isTutorial)
            {
                if (GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
                {
                    this.guiBattleTopCenter.hideAll();
                }
                else
                {
                    this.guiBattleTopCenter.showAll();
                }
                this.guiBattleTopCenter.show();
                this.guiBattleTopLeft.show();
                this.guiBattleCenterLeft.show();
                this.guiBattleCenterLeft.bgImg.y = this.guiBattleTopLeft.bgImg.y + this.guiBattleTopLeft.bgImg.height + 30;
                this.guiBattleCenterLeft.setInfo();
                if (GlobalVar.state == GlobalVar.STATE_BATTLE)
                {
                    this.guiBattleCenterRight.show();
                    this.guiBattleCenterRight.bgImg.y = this.guiBattleTroop.bgImg.y - this.guiBattleCenterRight.bgImg.height - 10;
                    this.guiBattleCenterRight.bgImg.x = this.guiBattleTroop.bgImg.x + this.guiBattleTroop.bgImg.width - this.guiBattleCenterRight.bgImg.width;
                }
                this.guiResumBattle.hide();
                this.status = 0;
            }
            else
            {
                _loc_3 = this.guiBattleTroop.getPos();
                _loc_4 = this.guiBattleTroop.listItemTroop[0];
                _loc_3.x = _loc_3.x + (_loc_4.getPos().x + _loc_4.widthBg / 2);
                _loc_3.y = _loc_3.y + _loc_4.getPos().y;
                TutorialMgr.getInstance().showArrow(_loc_3.x, _loc_3.y);
                this.numShowArrow = 0;
            }
            if (GlobalVar.state == GlobalVar.STATE_BATTLE)
            {
                _loc_5 = 0;
                while (_loc_5 < 10)
                {
                    
                    CityMgr.getInstance().createFarmer(1);
                    _loc_5++;
                }
            }
            if (param2)
            {
                this.guiBattleCenterRight.hide();
            }
            this.battleData.updateWall();
            return;
        }// end function

        public function resetData() : void
        {
            this.curHp = 0;
            this.curLoop = 0;
            this.numStar = 0;
            this.goldRop = 0;
            this.elixirRop = 0;
            this.darkElixirRop = 0;
            this.percentLife = 0;
            this.playingEffectStar = false;
            this.listEffectStar = new Vector.<int>;
            this.countDownEndGame = 0;
            this.lastLoopDropTroop = 0;
            this.listCmd = new Vector.<AddTroopCmd>;
            this.hasACK = true;
            this.modBattle = 0;
            return;
        }// end function

        public function startBattle() : void
        {
            SoundModule.getInstance().playBgMusic(SoundModule.MUSIC_BG_FIGHT);
            this.status = 1;
            this.guiBattleTopCenter.startBattle();
            this.guiResumBattle.show();
            this.guiResumBattle.bgImg.y = this.guiBattleCenterLeft.bgImg.y + this.guiBattleCenterLeft.heightBg + 10;
            this.guiBattleCenterRight.hide();
            LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME).mouseEnabled = false;
            LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME).mouseChildren = false;
            this.percentLife = 0;
            this.numStar = 0;
            this.curHp = 0;
            this.goldRop = 0;
            this.elixirRop = 0;
            this.darkElixirRop = 0;
            MapMgr.getInstance().rangeMap.hideViewRange();
            CityMgr.getInstance().allFarmerReturnHome();
            return;
        }// end function

        public function endBattle(param1:int) : void
        {
            switch(param1)
            {
                case END_TIME:
                {
                    this.showResumBattle(1);
                    break;
                }
                case WIN:
                {
                    this.countDownEndGame = 90;
                    break;
                }
                case LOST:
                {
                    this.countDownEndGame = 30;
                    break;
                }
                case REQUEST_END_BATTLE:
                {
                    this.showResumBattle();
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.battleData.setActionAllTroop();
            this.guiBattleTopCenter.bmpEndBattle.enable = false;
            CityMgr.getInstance().hideMessage();
            CityMgr.getInstance().guiFindMath.guiSingleMap.finishSingleMap(CityMgr.getInstance().guiFindMath.guiSingleMap.curPointMap, this.numStar, this.goldRop, this.elixirRop);
            this.sendCmdEndBattle();
            return;
        }// end function

        public function showPopupEndGame(param1:int) : void
        {
            CityMgr.getInstance().showMessage(Localization.getInstance().getString("Title_TB"), Localization.getInstance().getString("Message_1"), Localization.getInstance().getString("Button_OK"), this.endBattle, [param1]);
            return;
        }// end function

        public function sendCmdEndBattle() : void
        {
            if (TutorialMgr.getInstance().isTutorial && TutorialMgr.getInstance().curStep == 15)
            {
                return;
            }
            var _loc_1:int = 0;
            if (this.numStar > 0)
            {
                _loc_1 = this.numStar / 3 * this.trophyReceive;
            }
            else
            {
                _loc_1 = -this.trophyLost;
            }
            var _loc_2:* = this.getCheckSum();
            var _loc_3:* = new BattleEndCmd(this.curLoop, this.numStar, this.goldRop, this.elixirRop, this.darkElixirRop, _loc_1, this.percentLife, _loc_2);
            bzConnector.send(_loc_3);
            FeedMgr.getInstance().endBattle(this.modBattle, this.numStar, this.goldRop, this.elixirRop, this.darkElixirRop, _loc_1);
            return;
        }// end function

        public function getCheckSum() : String
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:Number = 0;
            var _loc_4:Number = 0;
            var _loc_5:String = "";
            var _loc_6:* = this.battleData.objList;
            var _loc_7:int = 0;
            while (_loc_7 < _loc_6.length)
            {
                
                if (_loc_6[_loc_7] is Bullet)
                {
                }
                else
                {
                    _loc_1++;
                    if (_loc_6[_loc_7].objectType != 7)
                    {
                        _loc_2 = _loc_2 + _loc_6[_loc_7].baseInfo.curHp;
                    }
                    _loc_3 = _loc_3 + _loc_6[_loc_7].move.x;
                    _loc_4 = _loc_4 + _loc_6[_loc_7].move.y;
                }
                _loc_7++;
            }
            _loc_5 = _loc_5 + (BattleModule.getInstance().goldRop + "_" + BattleModule.getInstance().elixirRop + " " + BattleModule.getInstance().totalHp + "_" + BattleModule.getInstance().curHp);
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            while (_loc_9 < this.listTroopDrop.length)
            {
                
                _loc_8 = _loc_8 + this.listTroopDrop[_loc_9].num;
                _loc_9++;
            }
            _loc_5 = "check sum curLoop numObj,hp,dx,dy,ext : " + BattleModule.getInstance().curLoop + "_" + _loc_1 + "_" + _loc_2 + "_" + int(_loc_3) + "_" + int(_loc_4) + "_" + _loc_5 + "_" + _loc_8;
            return _loc_5;
        }// end function

        public function returnHome() : void
        {
            SoundModule.getInstance().playBgMusic(SoundModule.MUSIC_BG_HOME);
            this.battleData.clearAllObj();
            this.hideAllGui();
            CityMgr.getInstance().returnMyHome();
            if (this.guiEndBattle)
            {
                this.guiEndBattle.destroyBaseGUI();
                this.guiEndBattle = null;
            }
            this.status = 0;
            return;
        }// end function

        public function hideAllGui() : void
        {
            this.guiBattleCenterLeft.hide();
            this.guiBattleCenterRight.hide();
            this.guiBattleTopCenter.hide();
            this.guiBattleTopLeft.hide();
            this.guiBattleTroop.hide();
            this.guiResumBattle.hide();
            return;
        }// end function

        public function endTime() : void
        {
            this.endBattle(END_TIME);
            return;
        }// end function

        public function addMoney(param1:String, param2:int) : void
        {
            var _loc_3:* = GameDataMgr.getInstance().getMoney(param1);
            var _loc_4:int = 0;
            switch(param1)
            {
                case MoneyType.GOLD:
                {
                    this.gold = this.gold - param2;
                    this.goldRop = this.goldRop + param2;
                    _loc_4 = GameDataMgr.getInstance().maxGoldCapacity;
                    break;
                }
                case MoneyType.ELIXIR:
                {
                    this.elixir = this.elixir - param2;
                    this.elixirRop = this.elixirRop + param2;
                    _loc_4 = GameDataMgr.getInstance().maxElixirCapacity;
                    break;
                }
                case MoneyType.DARK_ELIXIR:
                {
                    this.darkElixir = this.darkElixir - param2;
                    this.darkElixirRop = this.darkElixirRop + param2;
                    _loc_4 = GameDataMgr.getInstance().maxDarkElixirCapacity;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param2 + _loc_3 > _loc_4)
            {
                param2 = _loc_4 - _loc_3;
            }
            GameDataMgr.getInstance().addMoney(param1, param2);
            this.guiBattleCenterLeft.loop();
            return;
        }// end function

        public function createTroopClanHouse(param1:Array) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:Troop = null;
            this.listTroopClanHouse = new Vector.<Troop>;
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_3 = param1[_loc_2].num;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_5 = new Troop();
                    _loc_5.type = param1[_loc_2].objType;
                    _loc_5.level = param1[_loc_2].level;
                    this.listTroopClanHouse.push(_loc_5);
                    _loc_4++;
                }
                _loc_2++;
            }
            this.countLoopDelayClanHouse = 0;
            this.ridTroopClanHouse = false;
            return;
        }// end function

        public function createTroopClan(param1:Array) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:Troop = null;
            this.listTroopClan = new Vector.<Troop>;
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_3 = param1[_loc_2].num;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_5 = new Troop();
                    _loc_5.type = param1[_loc_2].objType;
                    _loc_5.level = param1[_loc_2].level;
                    this.listTroopClan.push(_loc_5);
                    _loc_4++;
                }
                _loc_2++;
            }
            if (param1.length > 0)
            {
                this.hasClan = true;
            }
            else
            {
                this.hasClan = false;
            }
            this.countLoopDelayClan = 0;
            this.ridTroopClan = false;
            return;
        }// end function

        public function upStar() : void
        {
            var _loc_1:String = this;
            var _loc_2:* = this.numStar + 1;
            _loc_1.numStar = _loc_2;
            if (GlobalVar.state == GlobalVar.STATE_REPLAY)
            {
                return;
            }
            this.playEffectStar(this.numStar);
            return;
        }// end function

        private function playEffectStar(param1:int, param2:Boolean = true) : void
        {
            if (this.playingEffectStar && param2)
            {
                this.listEffectStar.push(param1);
                this.countEffectStar = DELAY_EFFECT_STAR;
                return;
            }
            var _loc_3:* = new Avatar();
            _loc_3.create(AnCategory.EFFECT, "stargain", 0);
            var _loc_4:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI);
            LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI).addChild(_loc_3);
            _loc_3.x = GlobalVar.SCREEN_WIDTH / 2;
            _loc_3.y = GlobalVar.SCREEN_HEIGHT / 2;
            var _loc_6:Number = 0.7;
            _loc_3.scaleY = 0.7;
            _loc_3.scaleX = _loc_6;
            var _loc_5:Number = 1;
            this.playingEffectStar = true;
            TweenMax.to(_loc_3, 0.1, {scaleX:_loc_5, scaleY:_loc_5, onComplete:this.onFinishTweenScale, onCompleteParams:[_loc_3, param1], ease:Linear.easeNone});
            this.onUpdateTween(_loc_3);
            return;
        }// end function

        private function onFinishTweenScale(param1:Avatar, param2:int) : void
        {
            TweenMax.to(param1, 0.3, {onComplete:this.onFinishTweenIdle, onCompleteParams:[param1, param2], ease:Linear.easeNone});
            return;
        }// end function

        private function onFinishTweenIdle(param1:Avatar, param2:int) : void
        {
            var _loc_3:Number = 0.2;
            var _loc_4:* = MovieClip(this.guiResumBattle["imageStar" + param2]);
            var _loc_5:* = new Point(_loc_4.x, _loc_4.y);
            _loc_5 = _loc_4.localToGlobal(_loc_5);
            TweenMax.to(param1, 1, {rotation:-360, scaleX:_loc_3, scaleY:_loc_3, bezier:[{x:_loc_5.x, y:_loc_5.y}], onComplete:this.onFinishTween, onCompleteParams:[param1, param2], ease:Quad.easeIn, onUpdate:this.onUpdateTweenFly, onUpdateParams:[param1]});
            return;
        }// end function

        private function onUpdateTweenFly(param1:Avatar) : void
        {
            var _loc_4:Avatar = null;
            var _loc_5:int = 0;
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI);
            var _loc_3:int = 0;
            while (_loc_3 < 3)
            {
                
                _loc_4 = new Avatar();
                _loc_4.create(AnCategory.EFFECT, "starmini", 0);
                _loc_5 = _loc_2.getChildIndex(param1);
                _loc_2.addChildAt(_loc_4, _loc_5);
                _loc_4.x = param1.x + Utility.randomNumber(-10 * param1.scaleX, 50 * param1.scaleX);
                _loc_4.y = param1.y + Utility.randomNumber(-40 * param1.scaleX, 10 * param1.scaleX);
                var _loc_6:* = Utility.randomNumber(Math.max(0.4 * param1.scaleX, 0.2), Math.max(0.8 * param1.scaleX, 0.5));
                _loc_4.scaleY = Utility.randomNumber(Math.max(0.4 * param1.scaleX, 0.2), Math.max(0.8 * param1.scaleX, 0.5));
                _loc_4.scaleX = _loc_6;
                _loc_4.blendMode = BlendMode.ADD;
                _loc_4.alpha = 0.8;
                TweenMax.to(_loc_4, 0.5, {alpha:0, scaleX:0.2 * param1.scaleX, scaleY:0.2 * param1.scaleX, onComplete:this.onFinishTweenUpdate, onCompleteParams:[_loc_4]});
                _loc_3++;
            }
            return;
        }// end function

        private function onFinishTween(param1:Avatar, param2:int) : void
        {
            if (param1 && param1.parent)
            {
                param1.destroy();
                param1.parent.removeChild(param1);
                param1.visible = false;
                param1 = null;
            }
            this.playingEffectStar = false;
            this.guiResumBattle.updateStar(param2);
            return;
        }// end function

        private function onUpdateTween(param1:Avatar) : void
        {
            var _loc_4:Avatar = null;
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI);
            var _loc_3:int = 0;
            while (_loc_3 < 8)
            {
                
                _loc_4 = new Avatar();
                _loc_4.create(AnCategory.EFFECT, "starmini", 0);
                _loc_2.addChild(_loc_4);
                _loc_4.x = param1.x;
                _loc_4.y = param1.y;
                _loc_4.blendMode = BlendMode.ADD;
                TweenMax.to(_loc_4, 1, {alpha:0.4, bezier:[{x:param1.x + Utility.randomNumber(-200, 200), y:param1.y + Utility.randomNumber(-200, 200)}], onComplete:this.onFinishTweenUpdate, onCompleteParams:[_loc_4]});
                _loc_3++;
            }
            return;
        }// end function

        private function onFinishTweenUpdate(param1:Avatar) : void
        {
            param1.destroy();
            param1.parent.removeChild(param1);
            param1.visible = false;
            param1 = null;
            return;
        }// end function

        public function addPercentLife(param1:int = 0) : void
        {
            this.curHp = this.curHp + param1;
            var _loc_2:* = this.percentLife;
            this.percentLife = this.curHp / this.totalHp * 100;
            if (GlobalVar.state == GlobalVar.STATE_REPLAY)
            {
                return;
            }
            if (this.percentLife >= 50 && _loc_2 < 50)
            {
                this.upStar();
            }
            this.guiResumBattle.updatePercent(this.percentLife);
            if (this.percentLife >= 100)
            {
                this.upStar();
                this.endBattle(WIN);
            }
            return;
        }// end function

        public function troopDie() : void
        {
            var _loc_1:* = this.battleData.objList;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                if (_loc_1[_loc_2] is Bullet)
                {
                }
                else if (_loc_1[_loc_2].team == 1)
                {
                    return;
                }
                _loc_2++;
            }
            if (this.hasClan)
            {
                return;
            }
            _loc_2 = 0;
            while (_loc_2 < this.listTroop.length)
            {
                
                if (this.listTroop[_loc_2].num > 0)
                {
                    return;
                }
                _loc_2++;
            }
            if (GlobalVar.state == GlobalVar.STATE_REPLAY)
            {
                return;
            }
            this.endBattle(LOST);
            return;
        }// end function

        public function dropTroopFromClanHouse(param1:int) : void
        {
            this.cellHouseClan = param1;
            if (this.listTroopClanHouse.length > 0)
            {
                this.ridTroopClanHouse = true;
            }
            return;
        }// end function

        public static function getInstance() : BattleModule
        {
            if (!instance)
            {
                instance = new BattleModule;
            }
            return instance;
        }// end function

    }
}
