package modules.city
{
    import __AS3__.vec.*;
    import bitzero.*;
    import bitzero.core.*;
    import bitzero.net.data.*;
    import bitzero.net.events.*;
    import bitzero.util.*;
    import com.greensock.*;
    import component.*;
    import component.avatar.controls.*;
    import component.avatar.things.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import gameData.*;
    import gameData.clan.*;
    import map.*;
    import map.logic.*;
    import modules.*;
    import modules.battle.*;
    import modules.battle.data.*;
    import modules.battle.logic.*;
    import modules.city.graphics.*;
    import modules.city.graphics.Others.*;
    import modules.city.graphics.barrack.*;
    import modules.city.graphics.build.*;
    import modules.city.graphics.chat.*;
    import modules.city.graphics.clan.*;
    import modules.city.graphics.clan.donate.*;
    import modules.city.graphics.fanpage.*;
    import modules.city.graphics.findmatch.*;
    import modules.city.graphics.friend.*;
    import modules.city.graphics.laboratory.*;
    import modules.city.graphics.moneyCard.*;
    import modules.city.graphics.promoteG.*;
    import modules.city.graphics.ranking.*;
    import modules.city.graphics.setting.*;
    import modules.city.graphics.shop.*;
    import modules.city.graphics.sideQuest.*;
    import modules.city.graphics.thongbao.*;
    import modules.city.graphics.troop.*;
    import modules.city.graphics.tutorial.*;
    import modules.city.logic.*;
    import modules.feed.*;
    import modules.replay.*;
    import modules.replay.graphics.*;
    import modules.sound.*;
    import network.*;
    import network.receive.*;
    import network.send.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class CityMgr extends BaseModule
    {
        private var countDownCreateFarmer:int = 0;
        private var countDownGetCurTime:int = 27000;
        public var guiMainBottom:GuiMainBottomRight;
        public var guiMainTopLeft:GuiMainTopLeft;
        public var guiMainTop:GuiMainTop;
        public var guiMainTopRight:GuiMainTopRight;
        public var guiMainSetting:GuiMainSetting;
        public var guiShop:GuiShop;
        public var guiBuildingAction:GuiBuildingAction;
        public var guiUpgradeBuilding:GuiUpgradeBuilding;
        public var guiTrainTroop:GuiTrainTroop;
        public var guiLaboratory:GuiLaboratory;
        public var guiTroopUpgrade:GuiTroopUpgrade;
        public var guiPopup:GuiPopup;
        public var guiFriendsList:GuiFriendsList;
        public var guiClan:GuiClan;
        public var guiBuildingInfo:GuiBuildingInfo;
        public var guiDonateTroop:GuiDonateTroop;
        public var guiContentChat:GuiContentChat;
        public var guiTotalTroop:GuiTroopTotal;
        public var guiNotify:GuiNotify;
        public var guiBuyResource:GuiBuyResources;
        public var transEff:TransitionEffect;
        public var guiNPC1:GuiNPC1 = null;
        public var guiNPC2:GuiNPC2 = null;
        public var guiRebuildClan:GuiRebuildClan;
        public var guiReturnHome:GuiReturnHome;
        public var guiFindMath:GuiFindMatch;
        private var troopList:Vector.<CityTroop>;
        private var buidlerList:Vector.<Builder>;
        public var farmerList:Vector.<Farmer>;
        private var birdList:Vector.<AngryBird>;
        public var effectList:Vector.<AniEffect>;
        public var spriteList:Vector.<Sprite>;
        private var saveFnCallBack:Function = null;
        private var saveObject:MapObject = null;
        public var guiLog:GuiLogBattle;
        public var guiSideQuest:GuiSideQuest;
        public var guiWarning:GuiWarning;
        public var guiLevelUp:GuiLevelUp;
        public var guiNapThe:GuiNapThe;
        public var guiRanking:GuiRanking;
        public var guiToolTip:GuiClanMemberToolTip;
        public var guiFanpage:GuiFanpage;
        public var guiThongBao:GuiThongBao;
        public var guiFirstAddG:GuiFirstAddG;
        public var guiPromoteLevel:GuiPromoteG_1;
        public var guiPromotePayG:GuiPromoteG_2;
        private var timeToMaintain:Number = -1;
        private var notifyMaintain:TooltipText;
        public var lastACKLoop:int;
        private var hasSendClearRIP:Boolean;
        private var farmerId:int = 0;
        private var birdId:int = 0;
        private var listCmd:Vector.<Object>;
        public static const MAX_FARMER:int = 5;
        public static const MAX_BIRD:int = 3;
        public static const FARMER_LOOP:int = 150;
        public static const COUNT_GET_CUR_TIME_LOOP:int = 27000;
        public static const COUNT_LAST_ACK_LOOP:int = 8100;
        public static const CITY_LOOP:String = "cityLoop";
        public static const SET_BUILDING:String = "setBuilding";
        public static const SHOW_BUILDING_ACTION_GUI:String = "showBuildingActionGui";
        public static const HIDE_BUILDING_ACTION_GUI:String = "hideBuildingActionGui";
        public static const SHOW_UPGRADE_BUILDING_GUI:String = "showUpgradeBuildingGui";
        public static const HIDE_UPGRADE_BUILDING_GUI:String = "hideUpgradeBuildingGui";
        public static const SHOW_LABORATORY_GUI:String = "showLaboratoryGui";
        public static const HIDE_LABORATORY_GUI:String = "hideLaboratoryGui";
        public static const SHOW_TROOP_UPGRADE_GUI:String = "showTroopUpgradeGui";
        public static const HIDE_TROOP_UPGRADE_GUI:String = "hideTroopUpgradeGui";
        public static const TROOP_UPGRADING_GUI_UPDATE_TIME:String = "updateRemainTime";
        public static const SHOW_FRIENDSLIST_GUI:String = "showFriendsListGui";
        public static const HIDE_FRIENDSLIST_GUI:String = "hideFriendsListGui";
        public static const SHOW_CLAN_GUI:String = "showClanGui";
        public static const HIDE_CLAN_GUI:String = "hideClanGui";
        public static const SHOW_LIST_CLAN:String = "showListClan";
        public static const SHOW_DETAIL_CLAN:String = "showDetailClan";
        public static const SHOW_CREATE_CLAN:String = "showCreateClan";
        public static const HIDE_CREATE_CLAN:String = "hideCreateClan";
        public static const SHOW_FRIEND_TOOL_TIP:String = "showFriendToolTip";
        public static const HIDE_FRIEND_TOOL_TIP:String = "hideFriendToolTip";
        public static const SHOW_BUILDING_INFO:String = "showBuildingInfo";
        public static const HIDE_BUILDING_INFO:String = "hideBuildingInfo";
        public static const SHOW_MESSAGE:String = "showMessage";
        public static const HIDE_MESSAGE:String = "hideMessage";
        public static const UPDATE_BUILDER_LIST:String = "updateBuilder";
        public static const QUICK_FINISH:String = "quickFinish";
        public static const REBUILD_CLAN_CASTLE:String = "rebuildClanCastle";
        public static const SHOW_TRANSITION_EFF:String = "showTransitionEff";
        public static const HIDE_TRANSITION_EFF:String = "hideTransitionEff";
        public static const SEND_UPGRADE_BUILDING:String = "upgradeBuilding";
        public static const SEND_HARVEST:String = "sendHarvest";
        public static const BUY_BUILDING:String = "buyBuilding";
        public static const MOVE_BUILDING:String = "moveBuilding";
        public static const SHOW_TRAIN_TROOP:String = "showTrainTroop";
        public static const SEND_RESEARCH:String = "sendResearch";
        public static const SEND_FRIEND_LIST_CMD:String = "sendFriendListCmd";
        public static const SEND_GET_CLANS_CMD:String = "sendGetClansCmd";
        public static var _inst:CityMgr;

        public function CityMgr()
        {
            this.troopList = new Vector.<CityTroop>;
            this.buidlerList = new Vector.<Builder>;
            this.farmerList = new Vector.<Farmer>;
            this.birdList = new Vector.<AngryBird>;
            this.effectList = new Vector.<AniEffect>;
            this.spriteList = new Vector.<Sprite>;
            this.listCmd = new Vector.<Object>;
            return;
        }// end function

        public function initMainGui() : void
        {
            ModuleMgr.getInstance().regFunction(CITY_LOOP, this.loop);
            ModuleMgr.getInstance().regFunction(SET_BUILDING, this.setBuildingToMap);
            ModuleMgr.getInstance().regFunction(SHOW_BUILDING_ACTION_GUI, this.showBuildingActionGui);
            ModuleMgr.getInstance().regFunction(HIDE_BUILDING_ACTION_GUI, this.hideBuildingActionGui);
            ModuleMgr.getInstance().regFunction(BUY_BUILDING, this.buyBuilding);
            ModuleMgr.getInstance().regFunction(MOVE_BUILDING, this.moveBuilding);
            ModuleMgr.getInstance().regFunction(SHOW_UPGRADE_BUILDING_GUI, this.showUpgradeBuildingGui);
            ModuleMgr.getInstance().regFunction(HIDE_UPGRADE_BUILDING_GUI, this.hideUpgradeBuildingGui);
            ModuleMgr.getInstance().regFunction(SEND_UPGRADE_BUILDING, this.upgradeBuilding);
            ModuleMgr.getInstance().regFunction(SHOW_TRAIN_TROOP, this.showGuiTrainTroop);
            ModuleMgr.getInstance().regFunction(SHOW_LABORATORY_GUI, this.showLaboratoryGui);
            ModuleMgr.getInstance().regFunction(HIDE_LABORATORY_GUI, this.hideLaboratoryGui);
            ModuleMgr.getInstance().regFunction(SHOW_TROOP_UPGRADE_GUI, this.showTroopUpgradeGui);
            ModuleMgr.getInstance().regFunction(HIDE_TROOP_UPGRADE_GUI, this.hideTroopUpgradeGui);
            ModuleMgr.getInstance().regFunction(SEND_HARVEST, this.sendHarvest);
            ModuleMgr.getInstance().regFunction(TROOP_UPGRADING_GUI_UPDATE_TIME, this.updateRemainTime);
            ModuleMgr.getInstance().regFunction(SHOW_FRIENDSLIST_GUI, this.showFriendsListGui);
            ModuleMgr.getInstance().regFunction(HIDE_FRIENDSLIST_GUI, this.hideFriendsListGui);
            ModuleMgr.getInstance().regFunction(SHOW_FRIEND_TOOL_TIP, this.showFriendToolTip);
            ModuleMgr.getInstance().regFunction(HIDE_FRIEND_TOOL_TIP, this.hideFriendToolTip);
            ModuleMgr.getInstance().regFunction(SHOW_BUILDING_INFO, this.showBuildingInfo);
            ModuleMgr.getInstance().regFunction(HIDE_BUILDING_INFO, this.hideBuildingInfo);
            ModuleMgr.getInstance().regFunction(SHOW_MESSAGE, this.showMessage);
            ModuleMgr.getInstance().regFunction(HIDE_MESSAGE, this.hideMessage);
            ModuleMgr.getInstance().regFunction(UPDATE_BUILDER_LIST, this.updateBuilder);
            ModuleMgr.getInstance().regFunction(QUICK_FINISH, this.quickFinish);
            ModuleMgr.getInstance().regFunction(SEND_RESEARCH, this.sendResearch);
            ModuleMgr.getInstance().regFunction(REBUILD_CLAN_CASTLE, this.rebuildClanCastle);
            ModuleMgr.getInstance().regFunction(SEND_FRIEND_LIST_CMD, this.sendFriendListCmd);
            ModuleMgr.getInstance().regFunction(SEND_GET_CLANS_CMD, this.sendGetClansCmd);
            ModuleMgr.getInstance().regFunction(SHOW_TRANSITION_EFF, this.showTransitionEff);
            ModuleMgr.getInstance().regFunction(HIDE_TRANSITION_EFF, this.hideTransitionEff);
            bzConnector.addEventListener(BZEvent.CONNECTION_LOST, this.onConnectionLost);
            bzConnector.addResponseListener(Command.LOGIN, this.onLogin);
            bzConnector.addResponseListener(Command.GET_PLAYER_INFO, this.onGetPlayerInfo);
            bzConnector.addResponseListener(Command.GET_BUILDING_INFO, this.onGetBuildingInfo);
            bzConnector.addResponseListener(Command.GET_TROOPER_INFO, this.onGetTrooperInfo);
            bzConnector.addResponseListener(Command.PLACE_BUILDING, this.onPlaceBuilding);
            bzConnector.addResponseListener(Command.TRAIN_TROOP, this.onTrainTroop);
            bzConnector.addResponseListener(Command.GET_BATTLE_INFO, this.onGetBattleInfoMgs);
            bzConnector.addResponseListener(Command.QUICK_FINISH, this.onGetQuickFinish);
            bzConnector.addResponseListener(Command.RESEARCH, this.onGetResearch);
            bzConnector.addResponseListener(Command.HARVEST, this.onGetHarvest);
            bzConnector.addResponseListener(Command.UPGRADE_BUILDING, this.onGetUpgrade);
            bzConnector.addResponseListener(Command.MOVE_BUILDING, this.onMoveBuilding);
            bzConnector.addResponseListener(Command.REBUILD_CLAN_CASTLE, this.onGetRebuildClanMgs);
            bzConnector.addResponseListener(Command.GET_FRIEND_LIST, this.onFriendListMsg);
            bzConnector.addResponseListener(Command.GET_CLANS, this.onGetClansMsg);
            bzConnector.addResponseListener(Command.GET_FRIEND_INFO, this.onGetFriendInfo);
            bzConnector.addResponseListener(Command.CREATE_CLAN, this.onGetCreateClan);
            bzConnector.addResponseListener(Command.GET_CLAN_DETAIL, this.onGetClanDetailMsg);
            bzConnector.addResponseListener(Command.JOIN_CLAN, this.onGetJoinClan);
            bzConnector.addResponseListener(Command.LEAVE_CLAN, this.onGetLeaveClan);
            bzConnector.addResponseListener(Command.CHANGE_MEMBER_TITLE, this.onGetChangeMemberTitle);
            bzConnector.addResponseListener(Command.KICK_MEMBER, this.onGetKickMember);
            bzConnector.addResponseListener(Command.GET_TROOP_REQUEST, this.onGetTroopRequestList);
            bzConnector.addResponseListener(Command.DONATE_TROOP_MSG, this.onGetDonateTroopMsg);
            bzConnector.addResponseListener(Command.DONATE_TROOP, this.onGetDonateTroopResponse);
            bzConnector.addResponseListener(Command.REQUEST_TROOP_MSG, this.onGetRequestTroopMsg);
            bzConnector.addResponseListener(Command.REQUEST_TROOP, this.onGetRequestTroopResponse);
            bzConnector.addResponseListener(Command.BUY_RESOURCE, this.onGetBuyResource);
            bzConnector.addResponseListener(Command.CANCEL_PLACING, this.onGetCancelBuildingMsg);
            bzConnector.addResponseListener(Command.CANCEL_UPGRADING, this.onGetCancelBuildingMsg);
            bzConnector.addResponseListener(Command.QUICK_TRAINING, this.onGetQuickTrainTroopMsg);
            bzConnector.addResponseListener(Command.TRAIN_TROOP, this.onGetTrainTroopMsg);
            bzConnector.addResponseListener(Command.CANCEL_TRAIN_TROOP, this.onGetCancelTroopTrainMsg);
            bzConnector.addResponseListener(Command.GET_CLAN_CHAT, this.onGetClanChat);
            bzConnector.addResponseListener(Command.SEND_CLAN_CHAT_MSG, this.onGetClanChatAuto);
            bzConnector.addResponseListener(Command.SEND_CLAN_CHAT, this.onSendChat);
            bzConnector.addResponseListener(Command.SINGLE_BATTLE_INFO, this.onGetSingleMapInfoMsg);
            bzConnector.addResponseListener(Command.SET_NAME, this.onGetSetNameMsg);
            bzConnector.addResponseListener(Command.USER_JOIN_CLAN, this.onGetUserJoinClan);
            bzConnector.addResponseListener(Command.GET_QUEST_INFO, this.onGetQuestInfoMsg);
            bzConnector.addResponseListener(Command.CLAIM_REWARD, this.onGetClaimRewardMsg);
            bzConnector.addResponseListener(Command.REMOVE_OBSTACLES, this.onGetRemoveObstacle);
            bzConnector.addResponseListener(Command.REMOVE_OBSTACLES_COMPLETED, this.onGetRemoveObstacleComp);
            bzConnector.addResponseListener(Command.FINISH_BUILDING, this.onGetFinishBuilding);
            bzConnector.addResponseListener(Command.SINGLE_END, this.onGetSingleEnd);
            bzConnector.addResponseListener(Command.END_ATTACK, this.onGetEndAttack);
            bzConnector.addResponseListener(Command.BATTLE_END, this.onGetBattleEnd);
            bzConnector.addResponseListener(Command.CHARGE_CARD, this.onGetChargeCard);
            bzConnector.addResponseListener(Command.UPDATE_COIN, this.onGetUpdateCoin);
            bzConnector.addResponseListener(Command.GET_CURRENT_TIME, this.onGetCurrentTime);
            bzConnector.addResponseListener(Command.USER_KICKED, this.onGetUserKickedMsg);
            bzConnector.addResponseListener(Command.MEMBER_CHANGED_TITLE, this.onGetMemberChangedTitle);
            bzConnector.addResponseListener(Command.SEARCH_CLAN, this.onGetSearchClan);
            bzConnector.addResponseListener(Command.CLEAR_RIP, this.onGetClearRIP);
            bzConnector.addResponseListener(Command.RANKING_LIST, this.onGetRankingListMsg);
            bzConnector.addResponseListener(Command.BUY_SHIELD_TIME, this.onGetBuyShield);
            bzConnector.addResponseListener(Command.UPDATE_MONEY, this.onGetUpdateMoney);
            bzConnector.addResponseListener(Command.LEVEL_UP, this.onGetLevelUp);
            bzConnector.addResponseListener(Command.USER_LEAVE_CLAN, this.onGetUserLeaveClan);
            bzConnector.addResponseListener(Command.FINISH_TRAIN_TROOP, this.onGetFinishTrainTroop);
            bzConnector.addResponseListener(Command.GET_TRANS_ID, this.onGetTransitionIDMsg);
            bzConnector.addResponseListener(Command.SERVER_MAINTAIN, this.onGetServerMaintain);
            bzConnector.addResponseListener(Command.BETA_USER_PROMO, this.onGetBetaUserPromote);
            bzConnector.addResponseListener(Command.BETA_PAY_USER_PROMO, this.onGetBetaPayUserPromote);
            bzConnector.addResponseListener(Command.PROMO_G, this.onGetPromoG);
            bzConnector.send(new LoginCmd());
            this.initMap();
            this.guiMainTop = new GuiMainTop();
            this.guiMainTop.show();
            this.guiMainBottom = new GuiMainBottomRight();
            this.guiMainBottom.show();
            this.guiMainTopLeft = new GuiMainTopLeft();
            this.guiMainTopLeft.show();
            this.guiMainTopRight = new GuiMainTopRight();
            this.guiMainTopRight.show();
            this.guiMainSetting = new GuiMainSetting();
            this.guiMainSetting.show();
            this.guiContentChat = new GuiContentChat();
            this.guiShop = new GuiShop();
            this.guiBuildingAction = new GuiBuildingAction();
            this.guiUpgradeBuilding = new GuiUpgradeBuilding();
            this.guiBuildingInfo = new GuiBuildingInfo();
            this.guiTrainTroop = new GuiTrainTroop();
            this.guiLaboratory = new GuiLaboratory();
            this.guiTroopUpgrade = new GuiTroopUpgrade();
            this.guiPopup = new GuiPopup();
            this.guiFriendsList = new GuiFriendsList();
            var _loc_1:* = this.guiMainBottom.getPos();
            this.guiFriendsList.setPos((GlobalVar.SCREEN_WIDTH - this.guiFriendsList.widthBg) / 2, _loc_1.y - this.guiFriendsList.heightBg + 20);
            this.guiToolTip = new GuiClanMemberToolTip();
            this.guiClan = new GuiClan();
            this.guiDonateTroop = new GuiDonateTroop();
            Utility.getTroopHousingSpaceConfig();
            this.guiTotalTroop = new GuiTroopTotal();
            this.guiBuyResource = new GuiBuyResources();
            this.initGuiNotify();
            this.transEff = new TransitionEffect();
            this.guiNPC1 = new GuiNPC1();
            this.guiRebuildClan = new GuiRebuildClan();
            this.guiReturnHome = new GuiReturnHome();
            this.guiFindMath = new GuiFindMatch();
            this.guiLog = new GuiLogBattle();
            this.guiSideQuest = new GuiSideQuest();
            this.guiWarning = new GuiWarning();
            this.guiLevelUp = new GuiLevelUp();
            this.guiNapThe = new GuiNapThe();
            this.guiRanking = new GuiRanking();
            this.guiFanpage = new GuiFanpage();
            this.guiFirstAddG = new GuiFirstAddG();
            this.guiPromoteLevel = new GuiPromoteG_1();
            this.guiPromotePayG = new GuiPromoteG_2();
            return;
        }// end function

        public function showTransitionEff(param1:Function = null, ... args) : void
        {
            this.transEff.showEff(param1, args);
            return;
        }// end function

        public function hideTransitionEff(param1:Number = 1) : void
        {
            this.transEff.hideEff(param1);
            return;
        }// end function

        private function initGuiNotify() : void
        {
            this.guiNotify = new GuiNotify();
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_LOADING);
            _loc_1.mouseEnabled = false;
            _loc_1.addChild(this.guiNotify);
            return;
        }// end function

        private function initMap() : void
        {
            MapMgr.getInstance().initCity();
            return;
        }// end function

        public function initShopGui() : void
        {
            this.guiShop = new GuiShop();
            return;
        }// end function

        public function showShopGui() : void
        {
            if (this.guiShop.isShowing)
            {
                this.guiShop.hide(true);
            }
            else
            {
                this.guiShop.show();
            }
            return;
        }// end function

        public function hideShopGui() : void
        {
            this.guiShop.hide();
            return;
        }// end function

        public function showBuildingActionGui(param1:MapObject) : void
        {
            if (!param1)
            {
                return;
            }
            if (this.guiBuildingAction.curObject != null)
            {
                if (param1 != this.guiBuildingAction.curObject)
                {
                    this.guiBuildingAction.curObject.hideSelected();
                }
                else
                {
                    return;
                }
            }
            param1.showSelected();
            this.guiBuildingAction.loadActions(param1);
            this.guiBuildingAction.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI));
            return;
        }// end function

        public function hideBuildingActionGui() : void
        {
            this.guiBuildingAction.hide();
            return;
        }// end function

        public function showUpgradeBuildingGui(param1:MapObject) : void
        {
            this.guiUpgradeBuilding.loadInfoUpgrade(param1);
            this.guiUpgradeBuilding.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        public function hideUpgradeBuildingGui() : void
        {
            this.guiUpgradeBuilding.hide(true);
            return;
        }// end function

        public function showLaboratoryGui() : void
        {
            this.guiLaboratory.loadInfo();
            this.guiLaboratory.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        public function hideLaboratoryGui() : void
        {
            this.guiLaboratory.hide();
            return;
        }// end function

        public function showTroopUpgradeGui(param1:String, param2:int) : void
        {
            this.guiTroopUpgrade.loadUpgradeInfo(param1, param2);
            this.guiTroopUpgrade.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        public function showTroopInfoGui(param1:String, param2:int) : void
        {
            this.guiTroopUpgrade.loadInfo(param1, param2);
            this.guiTroopUpgrade.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        public function hideTroopUpgradeGui() : void
        {
            this.guiTroopUpgrade.hide();
            return;
        }// end function

        private function updateRemainTime(param1:String) : void
        {
            return;
        }// end function

        public function showMessage(param1:String, param2:String, param3:String, param4:Function, param5 = null, param6:Boolean = true) : void
        {
            this.guiPopup.showMessageBox(param1, param2, param3, param4, param5, param6);
            return;
        }// end function

        public function hideMessage() : void
        {
            if (this.guiPopup)
            {
                this.guiPopup.hide();
            }
            return;
        }// end function

        public function showFriendsListGui() : void
        {
            this.guiFriendsList.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        public function hideFriendsListGui() : void
        {
            this.guiFriendsList.hide(true);
            return;
        }// end function

        public function showClanGui() : void
        {
            this.guiClan.show();
            return;
        }// end function

        public function hideClanGui() : void
        {
            this.guiClan.hide(true);
            return;
        }// end function

        public function showListClan() : void
        {
            this.guiClan.showListClan();
            return;
        }// end function

        public function showDetailClan(param1:int) : void
        {
            this.sendGetClanDetail(param1);
            if (this.guiClan.isShowing)
            {
                this.guiClan.showDetailClan();
            }
            else
            {
                this.guiRanking.showDetailClan();
            }
            return;
        }// end function

        public function showFriendToolTip(param1:int) : void
        {
            this.guiFriendsList.showToolTip(param1);
            return;
        }// end function

        public function hideFriendToolTip() : void
        {
            this.guiFriendsList.hideToolTip();
            return;
        }// end function

        public function showBuildingInfo(param1:MapObject, param2:Boolean = false) : void
        {
            this.guiBuildingInfo.isShopItem = param2;
            this.guiBuildingInfo.loadInfo(param1);
            this.guiBuildingInfo.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        public function hideBuildingInfo() : void
        {
            this.guiBuildingInfo.hide(true);
            return;
        }// end function

        public function showDonateTroopGui() : void
        {
            this.guiDonateTroop.getTroops();
            this.guiDonateTroop.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI));
            return;
        }// end function

        public function hideDonateTroopGui() : void
        {
            this.guiDonateTroop.hide();
            return;
        }// end function

        private function loop() : void
        {
            var _loc_2:int = 0;
            this.guiMainTopLeft.updateData();
            this.guiMainTopRight.updateData();
            this.guiTrainTroop.loop();
            GameDataMgr.getInstance().loop();
            this.guiTotalTroop.loop();
            this.guiNotify.loop();
            this.guiMainTop.loop();
            this.guiShop.loop();
            if (this.guiContentChat.isShowing)
            {
                this.guiContentChat.loop();
            }
            if (this.guiClan.isShowing)
            {
                this.guiClan.loop();
            }
            var _loc_1:int = 0;
            while (_loc_1 < this.troopList.length)
            {
                
                this.troopList[_loc_1].loop();
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.buidlerList.length)
            {
                
                this.buidlerList[_loc_1].loop();
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.farmerList.length)
            {
                
                this.farmerList[_loc_1].loop();
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.birdList.length)
            {
                
                this.birdList[_loc_1].loop();
                _loc_1++;
            }
            if (this.countDownCreateFarmer % 5 == 0)
            {
                this.renderObj();
            }
            if (this.timeToMaintain > 0)
            {
                _loc_2 = this.timeToMaintain - Utility.getCurTime();
                if (_loc_2 > 0)
                {
                    this.notifyMaintain.text = Localization.getInstance().getString("MaintainServer");
                    this.notifyMaintain.text = this.notifyMaintain.text.replace("@time", Utility.convertTimeToString(_loc_2));
                    this.notifyMaintain.x = (GlobalVar.SCREEN_WIDTH - this.notifyMaintain.width) / 2;
                    this.notifyMaintain.y = 100;
                }
            }
            if (GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
            {
                var _loc_3:String = this;
                var _loc_4:* = this.lastACKLoop + 1;
                _loc_3.lastACKLoop = _loc_4;
                if (this.lastACKLoop == COUNT_LAST_ACK_LOOP)
                {
                    this.sendDisconect();
                }
            }
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            if (this.countDownCreateFarmer <= 0 && GameDataMgr.getInstance().townHall && GameDataMgr.getInstance().townHall.type != null)
            {
                this.createFarmer();
                this.countDownCreateFarmer = FARMER_LOOP;
                this.createAngryBird();
            }
            else
            {
                var _loc_3:String = this;
                var _loc_4:* = this.countDownCreateFarmer - 1;
                _loc_3.countDownCreateFarmer = _loc_4;
            }
            var _loc_3:String = this;
            var _loc_4:* = this.countDownGetCurTime - 1;
            _loc_3.countDownGetCurTime = _loc_4;
            if (this.countDownGetCurTime < 0)
            {
                this.sendGetCurTime();
                this.countDownGetCurTime = COUNT_GET_CUR_TIME_LOOP;
            }
            return;
        }// end function

        public function sendGetCurTime() : void
        {
            var _loc_1:* = new SendGetCurTime();
            bzConnector.send(_loc_1);
            return;
        }// end function

        public function createFarmer(param1:int = 0) : void
        {
            if (this.farmerList.length >= MAX_FARMER)
            {
                return;
            }
            var _loc_2:* = new Farmer();
            _loc_2.setInfo(this.farmerId);
            var _loc_3:String = this;
            var _loc_4:* = this.farmerId + 1;
            _loc_3.farmerId = _loc_4;
            this.farmerList.push(_loc_2);
            if (param1 == 1)
            {
                _loc_2.randomHouseStart();
            }
            return;
        }// end function

        public function createAngryBird(param1:int = 0) : void
        {
            if (this.birdList.length >= MAX_BIRD)
            {
                return;
            }
            var _loc_2:* = new AngryBird();
            _loc_2.setInfo(this.birdId);
            var _loc_3:String = this;
            var _loc_4:* = this.birdId + 1;
            _loc_3.birdId = _loc_4;
            this.birdList.push(_loc_2);
            return;
        }// end function

        public function updateIsoAmryCamp(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:int = 0;
            while (_loc_4 < this.troopList.length)
            {
                
                if (this.troopList[_loc_4].idAmryCamp == param3)
                {
                    this.troopList[_loc_4].updateCellAMC(param1, param2, 1);
                }
                _loc_4++;
            }
            return;
        }// end function

        public function setBuildingToMap(param1:MapObject, param2:Boolean = false, param3:Boolean = true, param4:Boolean = false) : void
        {
            var _loc_5:String = null;
            var _loc_6:DataHouse = null;
            if (GlobalVar.state != GlobalVar.STATE_BATTLE && GlobalVar.state != GlobalVar.STATE_REPLAY && GlobalVar.state != GlobalVar.STATE_SINGLE_MAP)
            {
                if (GameDataMgr.getInstance().curObject == null)
                {
                    MapMgr.getInstance().addNewBuilding(param1, param4);
                }
                else
                {
                    MapMgr.getInstance().moveBuilding(param1, param2, param3);
                }
            }
            else
            {
                _loc_5 = Utility.getTypeObject(param1.type);
                switch(_loc_5)
                {
                    case BuildingType.DEF:
                    {
                        switch(param1.type)
                        {
                            case BuildingType.CANON:
                            {
                                _loc_6 = new Cannon();
                                break;
                            }
                            case BuildingType.ACHER_TOWER:
                            {
                                _loc_6 = new ArcherTower();
                                break;
                            }
                            case BuildingType.MOTAR:
                            {
                                _loc_6 = new Mortar();
                                break;
                            }
                            case BuildingType.WIZARD_TOWER:
                            {
                                _loc_6 = new WinzarTower();
                                break;
                            }
                            case BuildingType.AIR_DEFENSES:
                            {
                                _loc_6 = new AirDefenses();
                                break;
                            }
                            default:
                            {
                                _loc_6 = new HouseDefenses();
                                break;
                                break;
                            }
                        }
                        _loc_6.setDataHouse(param1);
                        break;
                    }
                    case BuildingType.WAL:
                    {
                        _loc_6 = new Wall();
                        _loc_6.responeCell = MapMgr.getInstance().battleMap.isoToCell(param1.posX * 3, param1.posY * 3);
                        _loc_6.setDataHouse(param1);
                        break;
                    }
                    case BuildingType.RES:
                    case BuildingType.STO:
                    {
                        _loc_6 = new HouseResources();
                        HouseResources(_loc_6).gold = param1.gold;
                        HouseResources(_loc_6).elixir = param1.elixir;
                        HouseResources(_loc_6).darkElixir = param1.darkElixir;
                        _loc_6.setDataHouse(param1);
                        break;
                    }
                    case BuildingType.TOW:
                    {
                        _loc_6 = new TownHall();
                        TownHall(_loc_6).gold = param1.gold;
                        TownHall(_loc_6).elixir = param1.elixir;
                        TownHall(_loc_6).darkElixir = param1.darkElixir;
                        _loc_6.setDataHouse(param1);
                        break;
                    }
                    case BuildingType.CLAN:
                    {
                        _loc_6 = new HouseClan();
                        _loc_6.setDataHouse(param1);
                        break;
                    }
                    case BuildingType.OBS:
                    {
                        _loc_6 = new DataHouse();
                        _loc_6.objectType = DataObject.OBJTYPE_OBSTACLE;
                        _loc_6.setDataHouse(param1);
                        break;
                    }
                    case BuildingType.TRA:
                    {
                        switch(param1.type)
                        {
                            case BuildingType.TRA_1:
                            case BuildingType.TRA_2:
                            case BuildingType.TRA_3:
                            {
                                _loc_6 = new Trap();
                                _loc_6.objectType = DataObject.OBJTYPE_TRAP;
                                _loc_6.setDataHouse(param1);
                                break;
                            }
                            case BuildingType.TRA_4:
                            case BuildingType.TRA_5:
                            {
                                _loc_6 = new TrapAir();
                                _loc_6.objectType = DataObject.OBJTYPE_TRAP;
                                _loc_6.setDataHouse(param1);
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        break;
                    }
                    default:
                    {
                        _loc_6 = new HouseNormal();
                        _loc_6.setDataHouse(param1);
                        break;
                        break;
                    }
                }
                _loc_6.team = 2;
                BattleModule.getInstance().battleData.addObj(_loc_6);
                MapMgr.getInstance().updateMapLogic(param1, _loc_6.objId);
                if (_loc_6 is Wall)
                {
                    Wall(_loc_6).updateDir();
                }
                else if (_loc_6 is HouseClan)
                {
                    if (param1.status != 2)
                    {
                        BattleModule.getInstance().totalHp = BattleModule.getInstance().totalHp + param1["info"]["hitpoints"];
                    }
                }
                else if (_loc_5 != BuildingType.OBS && _loc_5 != BuildingType.TRA)
                {
                    BattleModule.getInstance().totalHp = BattleModule.getInstance().totalHp + param1["info"]["hitpoints"];
                }
            }
            return;
        }// end function

        public function reorderCity(param1:MapObject) : void
        {
            return;
        }// end function

        public function setState(param1:int) : void
        {
            TweenMax.resumeAll();
            GlobalVar.state = param1;
            switch(param1)
            {
                case GlobalVar.STATE_BATTLE:
                case GlobalVar.STATE_REPLAY:
                {
                    this.hideAllGui();
                    break;
                }
                case GlobalVar.STATE_SINGLE_MAP:
                {
                    this.hideAllGui();
                    this.lastACKLoop = 0;
                    break;
                }
                case GlobalVar.STATE_MYHOME:
                {
                    MapMgr.getInstance().showCityMap();
                    this.showAllGui();
                    this.destroyCityAvatar();
                    break;
                }
                case GlobalVar.STATE_FRIEND:
                {
                    this.hideAllGui();
                    this.showFriendGui();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function showFriendGui() : void
        {
            this.destroyCityAvatar();
            this.guiMainTopLeft.show();
            this.guiMainTopRight.show();
            this.guiReturnHome.show();
            this.guiMainSetting.show();
            this.guiFanpage.show();
            return;
        }// end function

        public function hideAllGui() : void
        {
            if (this.guiMainTopRight.bmpThongBao)
            {
                this.guiMainTopRight.bmpThongBao.visible = false;
            }
            this.guiMainTop.hide();
            this.guiMainTopLeft.hide();
            this.guiMainBottom.hide();
            if (this.guiShop && this.guiShop.isShowing)
            {
                this.guiShop.hide();
            }
            this.guiFanpage.hide();
            this.guiMainSetting.hide();
            this.guiContentChat.hide();
            this.guiBuildingAction.hide();
            this.guiUpgradeBuilding.hide();
            this.guiBuildingInfo.hide();
            this.guiTrainTroop.hide();
            this.guiLaboratory.hide();
            this.guiTroopUpgrade.hide();
            this.guiFriendsList.hide();
            this.guiClan.hide();
            this.guiDonateTroop.hide();
            this.guiBuyResource.hide();
            this.guiLog.hide();
            this.guiFindMath.hide();
            this.guiContentChat.hide();
            this.guiSideQuest.hide();
            ActiveTooltip.getInstance().clearTooltip();
            this.guiBuildingAction.hide();
            this.guiRanking.hide();
            return;
        }// end function

        public function showAllGui() : void
        {
            this.guiMainTop.show();
            this.guiMainTopLeft.show();
            this.guiMainBottom.show();
            this.guiSideQuest.show();
            this.guiMainSetting.show();
            this.guiContentChat.show();
            this.guiFanpage.show();
            this.guiMainTopRight.show();
            if (this.guiMainTopRight.bmpThongBao && !GameDataMgr.getInstance().myInfo.isChargedUser)
            {
                this.guiMainTopRight.bmpThongBao.visible = true;
            }
            return;
        }// end function

        private function onLogin(param1:MsgInfo) : void
        {
            if (param1.ErrorCode == ErrorCode.SUCCESS)
            {
                this.setState(GlobalVar.STATE_MYHOME);
                bzConnector.send(new BaseCmd(Command.GET_PLAYER_INFO));
                this.sendSingleMapInfoCmd();
            }
            return;
        }// end function

        public function sendSingleMapInfoCmd() : void
        {
            var _loc_1:* = new SingleMapInfoCmd();
            bzConnector.send(_loc_1);
            return;
        }// end function

        private function onGetPlayerInfo(param1:MsgInfo) : void
        {
            var _loc_2:* = new PlayerInfoMsg(param1.Data);
            var _loc_3:* = new UserInfo();
            _loc_3.uId = _loc_2.uId;
            _loc_3.uName = _loc_2.uName;
            _loc_3.uAvatar = _loc_2.uAvatar;
            _loc_3.exp = _loc_2.exp;
            _loc_3.level = _loc_2.level;
            _loc_3.trophy = _loc_2.trophy;
            _loc_3.gold = _loc_2.gold;
            _loc_3.coin = _loc_2.coin;
            _loc_3.elixir = _loc_2.elixir;
            _loc_3.darkElixir = _loc_2.darkElixir;
            _loc_3.lastTimeLogin = _loc_2.lastTimeLogin;
            _loc_3.shieldTime = _loc_2.shieldTime;
            _loc_3.shieldList[0] = _loc_2.shieldList[0];
            _loc_3.shieldList[1] = _loc_2.shieldList[1];
            _loc_3.shieldList[2] = _loc_2.shieldList[2];
            _loc_3.attackingTime = _loc_2.attackingTime;
            _loc_3.builderList = _loc_2.builderList;
            Utility.setCurTime(_loc_2.currentTime);
            _loc_3.topAutoId = _loc_2.topAutoId;
            _loc_3.tutStep = _loc_2.tutStep;
            _loc_3.isChargedUser = _loc_2.isChargedUser;
            _loc_3.sound = _loc_2.sound;
            _loc_3.music = _loc_2.music;
            GameDataMgr.getInstance().uInfo = _loc_3;
            this.guiMainTopLeft.updateData();
            if (GlobalVar.state == GlobalVar.STATE_MYHOME)
            {
                GameDataMgr.getInstance().myInfo = _loc_3;
                GameDataMgr.getInstance().refreshBuilderList();
                this.guiMainTop.updateBuilder();
                this.guiMainTop.updateShield();
                if (_loc_3.attackingTime > 0)
                {
                    this.guiWarning.showGui(_loc_3.attackingTime);
                }
                ReplayMgr.getInstance().sendGetLogInfo();
                FeedMgr.getInstance().sendGetFeedInfo();
                this.countDownGetCurTime = COUNT_GET_CUR_TIME_LOOP;
                if (_loc_3.tutStep < Config.FINAL_TUTORIAL_STEP)
                {
                    this.guiContentChat.hide();
                    if (this.guiMainTopRight.bmpThongBao)
                    {
                        this.guiMainTopRight.bmpThongBao.visible = false;
                    }
                }
                if (this.guiMainTopRight.bmpThongBao && _loc_3.isChargedUser)
                {
                    this.guiMainTopRight.bmpThongBao.visible = false;
                }
                this.guiMainSetting.guiSubSetting.turnSound(_loc_3.sound == 1);
                this.guiMainSetting.guiSubSetting.turnMusic(_loc_3.music == 1);
            }
            else if (GlobalVar.state == GlobalVar.STATE_FRIEND || GlobalVar.state == GlobalVar.STATE_GUEST)
            {
            }
            return;
        }// end function

        private function onGetBuildingInfo(param1:MsgInfo) : void
        {
            var _loc_5:BarrackObject = null;
            if (this.guiWarning.isShowing)
            {
                return;
            }
            var _loc_2:* = new BuildingInfoMsg(param1.Data);
            if (_loc_2.errorCode != ErrorCode.SUCCESS)
            {
                this.showErrorCode(_loc_2.errorCode);
                return;
            }
            GameDataMgr.getInstance().resetDataCity();
            GameDataMgr.getInstance().curObject = null;
            var _loc_3:* = new Vector.<MapObject>;
            _loc_3.push(this.getTownHall(_loc_2.townHall));
            var _loc_4:int = 0;
            _loc_4 = 0;
            while (_loc_4 < _loc_2.armyCampList.length)
            {
                
                _loc_3.push(this.getArmyCamp(_loc_2.armyCampList[_loc_4]));
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_2.barrackList.length)
            {
                
                _loc_5 = this.getBarrack(_loc_2.barrackList[_loc_4]);
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_2.resourceList.length)
            {
                
                _loc_3.push(this.getResource(_loc_2.resourceList[_loc_4]));
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_2.storageList.length)
            {
                
                _loc_3.push(this.getStorage(_loc_2.storageList[_loc_4]));
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_2.defenceList.length)
            {
                
                _loc_3.push(this.getDefense(_loc_2.defenceList[_loc_4]));
                _loc_4++;
            }
            if (_loc_2.laboratory.autoId > 0)
            {
                _loc_2.laboratory.loadConfigData();
                _loc_3.push(_loc_2.laboratory);
            }
            _loc_2.clanCastle.loadConfigData();
            _loc_3.push(_loc_2.clanCastle);
            _loc_4 = 0;
            while (_loc_4 < _loc_2.builderHutList.length)
            {
                
                _loc_3.push(this.getBuilderHut(_loc_2.builderHutList[_loc_4]));
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_2.wallList.length)
            {
                
                _loc_3.push(this.getWall(_loc_2.wallList[_loc_4]));
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_2.obstaclesList.length)
            {
                
                _loc_3.push(this.getObstacle(_loc_2.obstaclesList[_loc_4]));
                _loc_4++;
            }
            if (GlobalVar.state == GlobalVar.STATE_MYHOME)
            {
                _loc_4 = 0;
                while (_loc_4 < _loc_2.trapList.length)
                {
                    
                    _loc_3.push(this.getTrap(_loc_2.trapList[_loc_4]));
                    _loc_4++;
                }
            }
            this.addListBuildingToMap(_loc_3);
            if (GlobalVar.state == GlobalVar.STATE_MYHOME && _loc_2.clanCastle.details.clanId > 0)
            {
                GameDataMgr.getInstance().myClanDetial.clanId = _loc_2.clanCastle.details.clanId;
                GameDataMgr.getInstance().getRequestClanList = false;
                this.sendGetClanDetail(_loc_2.clanCastle.details.clanId);
                this.guiContentChat.show();
            }
            else
            {
                this.guiContentChat.hide();
            }
            this.addListGraveStone(_loc_2.gravestoneList);
            this.addFish();
            return;
        }// end function

        public function addFish() : void
        {
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            var _loc_2:* = EffectDraw.play("fishunderwater", new Point(3050, 3350), _loc_1, 0);
            var _loc_3:* = EffectDraw.play("fishunderwater", new Point(3550, 3150), _loc_1, 0);
            var _loc_4:* = EffectDraw.play("fishunderwater", new Point(4350, 2800), _loc_1, 0);
            EffectDraw.play("fishunderwater", new Point(4350, 2800), _loc_1, 0).alpha = 0.5;
            this.effectList.push(_loc_2);
            this.effectList.push(_loc_3);
            this.effectList.push(_loc_4);
            return;
        }// end function

        private function addListGraveStone(param1:Array) : void
        {
            var _loc_4:Sprite = null;
            var _loc_5:Point = null;
            this.hasSendClearRIP = false;
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = ResMgr.getInstance().getMovieClip("ImageRIP") as Sprite;
                _loc_4.addEventListener(MouseEvent.CLICK, this.onCleanGraveStones);
                _loc_5 = MapMgr.getInstance().cityMap.cellToPoint(param1[_loc_3].cell);
                MapMgr.getInstance().cityMap.setCellType(param1[_loc_3].cell, 1);
                _loc_5.y = _loc_5.y + (MapMgr.getInstance().cityMap.MaxHalfHeight + 5);
                _loc_5.x = _loc_5.x - 5;
                _loc_4.x = _loc_5.x;
                _loc_4.y = _loc_5.y;
                _loc_2.addChild(_loc_4);
                GameDataMgr.getInstance().graveStoneList.push(_loc_4);
                _loc_3++;
            }
            return;
        }// end function

        private function onCleanGraveStones(event:MouseEvent) : void
        {
            if (GlobalVar.state == GlobalVar.STATE_MYHOME)
            {
                if (!this.hasSendClearRIP)
                {
                    this.sendClearRIP();
                }
            }
            return;
        }// end function

        private function getTrap(param1:Object) : TrapObject
        {
            var _loc_2:* = new TrapObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            return _loc_2;
        }// end function

        private function getObstacle(param1:Object) : ObstacleObject
        {
            var _loc_2:* = new ObstacleObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            return _loc_2;
        }// end function

        private function compareMapObject(param1:MapObject, param2:MapObject) : int
        {
            if (param1.posX > param2.posX)
            {
                return 1;
            }
            if (param1.posX < param2.posX)
            {
                return -1;
            }
            if (param1.posY > param2.posY)
            {
                return 1;
            }
            if (param1.posY < param2.posY)
            {
                return -1;
            }
            return 0;
        }// end function

        public function addListBuildingToMap(param1:Vector.<MapObject>) : void
        {
            param1.sort(this.compareMapObject);
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.setBuildingToMap(param1[_loc_2]);
                _loc_2++;
            }
            if (GlobalVar.state == GlobalVar.STATE_MYHOME)
            {
                GameDataMgr.getInstance().updateMaxCapacity();
                GameDataMgr.getInstance().splitResources(BuildingType.GOLD_STORAGE);
                GameDataMgr.getInstance().splitResources(BuildingType.ELIXIR_STORAGE);
            }
            this.createAvartarBuilder();
            return;
        }// end function

        private function onGetTrooperInfo(param1:MsgInfo) : void
        {
            var _loc_3:int = 0;
            if (this.guiWarning.isShowing)
            {
                return;
            }
            var _loc_2:* = new TroopInfoMsg(param1.Data);
            logger.debug("cmd", param1.type, ErrorCode.getReason(_loc_2.errorCode));
            GameDataMgr.getInstance().troopList = _loc_2.troopList;
            this.guiTotalTroop.updateTroop();
            this.guiMainTop.updateTotalTroop();
            this.dropTroopToArmyCamp();
            ModuleMgr.getInstance().doFunction(CityMgr.HIDE_TRANSITION_EFF, 2);
            if (GlobalVar.state == GlobalVar.STATE_MYHOME)
            {
                _loc_3 = GameDataMgr.getInstance().myInfo.tutStep;
                if (_loc_3 < Config.FINAL_TUTORIAL_STEP)
                {
                    this.startTutorial();
                }
                else
                {
                    this.sendQuestInfoCmd();
                }
            }
            if (!TutorialMgr.getInstance().isTutorial)
            {
                SoundModule.getInstance().playBgMusic();
            }
            return;
        }// end function

        private function dropTroopToArmyCamp() : void
        {
            var _loc_6:int = 0;
            var _loc_7:CityTroop = null;
            this.troopList = new Vector.<CityTroop>;
            var _loc_1:* = GameDataMgr.getInstance().armyCampList;
            var _loc_2:* = GameDataMgr.getInstance().troopList;
            var _loc_3:* = _loc_1.length;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                _loc_6 = 0;
                while (_loc_6 < _loc_2[_loc_5].num)
                {
                    
                    _loc_7 = new CityTroop();
                    _loc_7.setInfo(_loc_2[_loc_5].type, _loc_2[_loc_5].level, _loc_1[_loc_4 % _loc_3].posX, _loc_1[_loc_4 % _loc_3].posY);
                    _loc_7.idAmryCamp = _loc_1[_loc_4 % _loc_3].autoId;
                    if (this.troopList.length > 0)
                    {
                        _loc_7.troopIndex = this.troopList[(this.troopList.length - 1)].troopIndex + 1;
                    }
                    this.troopList.push(_loc_7);
                    _loc_4++;
                    this.renderObj();
                    _loc_6++;
                }
                _loc_5++;
            }
            return;
        }// end function

        public function destroyEffectList() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.effectList.length)
            {
                
                if (this.effectList[_loc_1])
                {
                    this.effectList[_loc_1].terminate();
                    this.effectList[_loc_1] = null;
                }
                _loc_1++;
            }
            this.effectList = new Vector.<AniEffect>;
            return;
        }// end function

        public function destroyTroopList() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.troopList.length)
            {
                
                this.troopList[_loc_1].destroy();
                this.troopList[_loc_1] = null;
                _loc_1++;
            }
            this.troopList = new Vector.<CityTroop>;
            return;
        }// end function

        public function destroyBuilderList() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.buidlerList.length)
            {
                
                this.buidlerList[_loc_1].destroy();
                this.buidlerList[_loc_1] = null;
                _loc_1++;
            }
            this.buidlerList = new Vector.<Builder>;
            return;
        }// end function

        public function destroyFarmerList() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.farmerList.length)
            {
                
                this.farmerList[_loc_1].destroy();
                this.farmerList[_loc_1] = null;
                _loc_1++;
            }
            this.farmerList = new Vector.<Farmer>;
            this.farmerId = 0;
            return;
        }// end function

        public function destroyBirdList() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.birdList.length)
            {
                
                this.birdList[_loc_1].destroy();
                this.birdList[_loc_1] = null;
                _loc_1++;
            }
            this.birdList = new Vector.<AngryBird>;
            this.birdId = 0;
            return;
        }// end function

        public function destroyCityAvatar() : void
        {
            this.destroyTroopList();
            this.destroyBuilderList();
            this.destroyFarmerList();
            this.destroyEffectList();
            this.destroyBirdList();
            return;
        }// end function

        private function onTrainTroop(param1:MsgInfo) : void
        {
            var _loc_2:* = new TrainTroopMsg(param1.Data);
            return;
        }// end function

        private function setArmyCamp(param1:Object) : void
        {
            var _loc_2:* = new ArmyCampObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            this.setBuildingToMap(_loc_2);
            return;
        }// end function

        private function getArmyCamp(param1:Object) : ArmyCampObject
        {
            var _loc_2:* = new ArmyCampObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            return _loc_2;
        }// end function

        private function setArmyCamps(param1:Array) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.setArmyCamp(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        public function getTownHall(param1:Object) : TownHallObject
        {
            var _loc_2:* = new TownHallObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            return _loc_2;
        }// end function

        private function setTownHall(param1:Object) : void
        {
            var _loc_2:* = new TownHallObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            this.setBuildingToMap(_loc_2);
            return;
        }// end function

        private function setBarrack(param1:Object) : void
        {
            var _loc_2:* = new BarrackObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            this.setBuildingToMap(_loc_2);
            return;
        }// end function

        private function getBarrack(param1:Object) : BarrackObject
        {
            var _loc_2:* = new BarrackObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            return _loc_2;
        }// end function

        private function setBarracks(param1:Array) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.setBarrack(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        private function setResource(param1:Object) : void
        {
            var _loc_2:* = new ResourceObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            this.setBuildingToMap(_loc_2);
            return;
        }// end function

        private function getResource(param1:Object) : ResourceObject
        {
            var _loc_2:* = new ResourceObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            return _loc_2;
        }// end function

        private function setResources(param1:Array) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.setResource(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        private function setStorage(param1:Object) : void
        {
            var _loc_2:* = new StorageObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            this.setBuildingToMap(_loc_2);
            return;
        }// end function

        private function getStorage(param1:Object) : StorageObject
        {
            var _loc_2:* = new StorageObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            return _loc_2;
        }// end function

        private function setStorages(param1:Array) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.setStorage(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        private function setDefense(param1:Object) : void
        {
            var _loc_2:* = new DefenseObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            this.setBuildingToMap(_loc_2);
            return;
        }// end function

        private function setWall(param1:Object) : void
        {
            var _loc_2:* = this.getWall(param1);
            this.setBuildingToMap(_loc_2);
            return;
        }// end function

        private function setTrap(param1:Object) : void
        {
            var _loc_2:* = this.getTrap(param1);
            this.setBuildingToMap(_loc_2);
            return;
        }// end function

        private function setObstacle(param1:Object) : void
        {
            var _loc_2:* = this.getObstacle(param1);
            this.setBuildingToMap(_loc_2);
            return;
        }// end function

        private function getDefense(param1:Object) : DefenseObject
        {
            var _loc_2:* = new DefenseObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            return _loc_2;
        }// end function

        private function setDefenses(param1:Array) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.setDefense(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        private function setBuilderHut(param1:Object) : void
        {
            var _loc_2:* = new BuilderObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            this.setBuildingToMap(_loc_2);
            return;
        }// end function

        private function getBuilderHut(param1:Object) : BuilderObject
        {
            var _loc_2:* = new BuilderObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            return _loc_2;
        }// end function

        private function setBuilderHuts(param1:Array) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.setBuilderHut(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        private function setLaboratory(param1:LaboratoryObject) : void
        {
            param1.loadConfigData();
            this.setBuildingToMap(param1);
            return;
        }// end function

        private function setClanCastle(param1:ClanObject) : void
        {
            param1.loadConfigData();
            this.setBuildingToMap(param1);
            if (GameDataMgr.getInstance().getClanId() > 0)
            {
            }
            return;
        }// end function

        private function getWall(param1:Object) : WallObject
        {
            var _loc_2:* = new WallObject();
            Utility.setData(_loc_2, param1);
            _loc_2.loadConfigData();
            return _loc_2;
        }// end function

        public function sendPlaceBuilding(param1:MapObject, param2:int) : void
        {
            var _loc_3:* = new PlaceBuildingCmd();
            _loc_3.type = param1.type;
            _loc_3.posX = param1.posX;
            _loc_3.posY = param1.posY;
            _loc_3.builder = param2;
            bzConnector.send(_loc_3);
            return;
        }// end function

        public function buyBuilding() : void
        {
            var _loc_2:DataBuildingInfo = null;
            var _loc_3:DataBuilder = null;
            var _loc_4:int = 0;
            var _loc_5:DataBuildingInfo = null;
            var _loc_6:int = 0;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:String = null;
            var _loc_10:String = null;
            var _loc_11:int = 0;
            this.saveFnCallBack = null;
            if (TutorialMgr.getInstance().isTutorial)
            {
                TutorialMgr.getInstance().forceSetBuilding();
            }
            var _loc_1:* = GameDataMgr.getInstance().tempObject;
            if (!_loc_1)
            {
                return;
            }
            if (_loc_1.type == BuildingType.BUILDER_HUT)
            {
                SoundModule.getInstance().playSound(SoundModule.BUILDING_FINISH);
                _loc_2 = Utility.getInfoToBuild(_loc_1.type, 1);
                GameDataMgr.getInstance().addMoney(_loc_2.cost.type, -_loc_2.cost.value);
                var _loc_12:* = GameDataMgr.getInstance().myInfo;
                var _loc_13:* = GameDataMgr.getInstance().myInfo.topAutoId + 1;
                _loc_12.topAutoId = _loc_13;
                _loc_1.autoId = GameDataMgr.getInstance().myInfo.topAutoId;
                _loc_1.status = MapObject.PRODUCING;
                _loc_1.startTime = 0;
                this.setBuildingToMap(_loc_1, false, true, true);
                if (_loc_1.type == BuildingType.BUILDER_HUT)
                {
                    _loc_3 = new DataBuilder();
                    GameDataMgr.getInstance().myInfo.builderList.push(_loc_3);
                    if (GameDataMgr.getInstance().myInfo.builderList.length == 4)
                    {
                        FeedMgr.getInstance().sendRequestFeedWall(FeedMgr.BUILD_BDH_4);
                    }
                    if (GameDataMgr.getInstance().myInfo.builderList.length == 5)
                    {
                        FeedMgr.getInstance().sendRequestFeedWall(FeedMgr.BUILD_BDH_5);
                    }
                }
                if (TutorialMgr.getInstance().isTutorial)
                {
                    MapMgr.getInstance().removeDrawCell();
                }
                this.sendPlaceBuilding(_loc_1, 0);
                this.guiMainTop.updateBuilder();
            }
            else
            {
                _loc_4 = GameDataMgr.getInstance().getFreeBuilder();
                if (_loc_4 >= 0)
                {
                    _loc_5 = Utility.getInfoToBuild(_loc_1.type, 1);
                    GameDataMgr.getInstance().addMoney(_loc_5.cost.type, -_loc_5.cost.value);
                    var _loc_12:* = GameDataMgr.getInstance().myInfo;
                    var _loc_13:* = GameDataMgr.getInstance().myInfo.topAutoId + 1;
                    _loc_12.topAutoId = _loc_13;
                    _loc_1.autoId = GameDataMgr.getInstance().myInfo.topAutoId;
                    _loc_1.status = MapObject.BUILDING;
                    _loc_1.startTime = Utility.getCurTime();
                    if (_loc_1.type == BuildingType.WALL)
                    {
                        GameDataMgr.getInstance().takeBuilder(_loc_4, _loc_1.autoId, _loc_1.startTime + _loc_1.buildTimeNextLevel, false);
                        this.setBuildingToMap(_loc_1, false, true, true);
                    }
                    else
                    {
                        SoundModule.getInstance().playSound(SoundModule.BUILDING_CONTRUCT);
                        this.setBuildingToMap(_loc_1, false, true, true);
                        GameDataMgr.getInstance().takeBuilder(_loc_4, _loc_1.autoId, _loc_1.startTime + _loc_1.buildTimeNextLevel);
                    }
                    if (TutorialMgr.getInstance().isTutorial)
                    {
                        MapMgr.getInstance().removeDrawCell();
                    }
                    this.sendPlaceBuilding(_loc_1, _loc_4);
                    if (_loc_1.type == BuildingType.WALL)
                    {
                        WallObject(_loc_1).checkMax();
                    }
                    if (Utility.getTypeObject(_loc_1.type) == BuildingType.TRA)
                    {
                        TrapObject(_loc_1).checkMax();
                    }
                }
                else
                {
                    _loc_6 = GameDataMgr.getInstance().getNearestBusyBuilder();
                    _loc_7 = Utility.getCurTime();
                    _loc_8 = GameDataMgr.getInstance().myInfo.builderList[_loc_6].endTime;
                    _loc_9 = Localization.getInstance().getString("NotEnoughBuilder0");
                    _loc_10 = Localization.getInstance().getString("NotEnoughBuilder1");
                    _loc_11 = Utility.getCostToBuyTime(_loc_8 - _loc_7).value;
                    GameDataMgr.getInstance().quickFinishCost = _loc_11;
                    this.guiBuyResource.showGuiByTime(_loc_9, _loc_10, _loc_11, this.acceptFreeUpBuilder, null, [_loc_6, this.buyBuilding]);
                }
            }
            return;
        }// end function

        public function acceptFreeUpBuilder(param1:int, param2:Function) : void
        {
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            this.hideMessage();
            var _loc_3:* = GameDataMgr.getInstance().myInfo.builderList[param1].buildingAutoId;
            var _loc_4:* = GameDataMgr.getInstance().getBuildingByAutoId(_loc_3);
            if (GameDataMgr.getInstance().getBuildingByAutoId(_loc_3))
            {
                this.saveFnCallBack = param2;
                _loc_5 = Utility.getCurTime();
                _loc_6 = _loc_4.buildTimeNextLevel + _loc_4.startTime;
                this.acceptQuickFinish(_loc_4);
            }
            return;
        }// end function

        public function prepareToBuyBuilding(param1:MapObject) : void
        {
            var _loc_4:int = 0;
            this.saveFnCallBack = null;
            GameDataMgr.getInstance().tempObject = param1;
            var _loc_2:* = Utility.getInfoToBuild(param1.type, 1);
            var _loc_3:* = GameDataMgr.getInstance().getMoney(_loc_2.cost.type);
            if (_loc_3 >= _loc_2.cost.value)
            {
                this.buyBuilding();
            }
            else if (param1.type != BuildingType.BUILDER_HUT)
            {
                _loc_4 = _loc_2.cost.value - _loc_3;
                this.guiBuyResource.showGuiBuyResource(_loc_2.cost.type, _loc_4, this.acceptBuyResource, [_loc_2.cost.type, _loc_4, this.buyBuilding]);
            }
            else
            {
                this.showShopBuyG();
            }
            return;
        }// end function

        public function acceptBuyResource(param1:String, param2:int, param3:Function) : void
        {
            var _loc_4:* = GameDataMgr.getInstance().getMoney(MoneyType.COIN);
            var _loc_5:* = Utility.getCostToBuyResources(param2).value;
            if (_loc_4 < _loc_5)
            {
                this.showShopBuyG();
                return;
            }
            var _loc_6:* = GameDataMgr.getInstance().getMoney(param1);
            var _loc_7:* = Utility.getStorageType(param1);
            var _loc_8:* = GameDataMgr.getInstance().getTotalResourceStorage(_loc_7);
            if (_loc_6 + param2 <= _loc_8)
            {
                GameDataMgr.getInstance().fnCallBack = param3;
                GameDataMgr.getInstance().lackingMoney.type = param1;
                GameDataMgr.getInstance().lackingMoney.value = param2;
                this.sendBuyResource(param1, param2, _loc_5);
            }
            else
            {
                this.showNotEnoughResoureStorages(_loc_7, "", param1);
            }
            return;
        }// end function

        private function showNotEnoughResoureStorages(param1:String, param2:String = "", param3:String = "") : void
        {
            var _loc_4:* = Localization.getInstance().getString("NotEnoughResourceStorage" + param2);
            if (param2 != "")
            {
                _loc_4 = _loc_4.replace("@type@", Localization.getInstance().getString(param1));
            }
            else
            {
                _loc_4 = _loc_4.replace("@type@", Localization.getInstance().getString(param3));
            }
            _loc_4 = _loc_4.replace("@type@", Localization.getInstance().getString(param1));
            this.guiNotify.addNewNotify(_loc_4);
            return;
        }// end function

        public function sendBuyResource(param1:String, param2:int, param3:int) : void
        {
            var _loc_4:* = new BuyResourceCmd();
            new BuyResourceCmd().number = param2;
            _loc_4.type = param1;
            _loc_4.cost = param3;
            bzConnector.send(_loc_4);
            return;
        }// end function

        private function onGetBuyResource(param1:MsgInfo) : void
        {
            var _loc_3:MoneyType = null;
            var _loc_4:int = 0;
            var _loc_5:Function = null;
            var _loc_2:* = new BuyResourceMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                _loc_3 = GameDataMgr.getInstance().lackingMoney;
                _loc_4 = Utility.getCostToBuyResources(_loc_3.value).value;
                GameDataMgr.getInstance().addMoney(MoneyType.COIN, -_loc_4);
                GameDataMgr.getInstance().addMoney(_loc_3.type, _loc_3.value);
                _loc_5 = GameDataMgr.getInstance().fnCallBack;
                if (_loc_5 != null)
                {
                    _loc_5.apply();
                }
            }
            else
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        private function upgradeBuilding() : void
        {
            var _loc_3:int = 0;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:int = 0;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_9:int = 0;
            this.saveFnCallBack = null;
            this.guiUpgradeBuilding.hide(true);
            var _loc_1:* = GameDataMgr.getInstance().tempObject;
            var _loc_2:* = GameDataMgr.getInstance().getFreeBuilder();
            if (_loc_2 >= 0)
            {
                _loc_1.upgrade(_loc_2);
                if (_loc_1.type == BuildingType.BUILDER_HUT || _loc_1.type == BuildingType.WALL)
                {
                    SoundModule.getInstance().playSound(SoundModule.BUILDING_FINISH);
                }
                else
                {
                    SoundModule.getInstance().playSound(SoundModule.BUILDING_CONTRUCT);
                }
            }
            else
            {
                _loc_3 = GameDataMgr.getInstance().getNearestBusyBuilder();
                _loc_4 = Utility.getCurTime();
                _loc_5 = GameDataMgr.getInstance().myInfo.builderList[_loc_3].endTime;
                _loc_6 = Utility.getCostToBuyTime(_loc_5 - _loc_4).value;
                _loc_7 = Localization.getInstance().getString("NotEnoughBuilder0");
                _loc_8 = Localization.getInstance().getString("NotEnoughBuilder1");
                _loc_9 = Utility.getCostToBuyTime(_loc_5 - _loc_4).value;
                GameDataMgr.getInstance().quickFinishCost = _loc_9;
                this.guiBuyResource.showGuiByTime(_loc_7, _loc_8, _loc_9, this.acceptFreeUpBuilder, this.showBuildingActionGui, [_loc_3, this.upgradeBuilding], [_loc_1]);
            }
            return;
        }// end function

        public function prepareToUpgradeBuilding(param1:MapObject, param2:int, param3:String, param4:Number) : void
        {
            var _loc_6:int = 0;
            this.saveFnCallBack = null;
            GameDataMgr.getInstance().tempObject = param1;
            var _loc_5:* = Utility.getInfoToBuild(param1.type, (param1.level + 1));
            param2 = GameDataMgr.getInstance().getMoney(_loc_5.cost.type);
            if (param2 >= _loc_5.cost.value)
            {
                this.upgradeBuilding();
            }
            else
            {
                _loc_6 = _loc_5.cost.value - param2;
                this.guiBuyResource.showGuiBuyResource(_loc_5.cost.type, _loc_6, this.acceptBuyResource, [_loc_5.cost.type, _loc_6, this.upgradeBuilding]);
            }
            return;
        }// end function

        public function moveBuilding(param1:MapObject, param2:Boolean) : void
        {
            var _loc_3:MoveBuildingCmd = null;
            this.setBuildingToMap(param1, false, param2);
            if (param2)
            {
                _loc_3 = new MoveBuildingCmd();
                _loc_3.autoId = param1.autoId;
                _loc_3.type = param1.type;
                _loc_3.posX = param1.posX;
                _loc_3.posY = param1.posY;
                bzConnector.send(_loc_3);
            }
            return;
        }// end function

        private function onPlaceBuilding(param1:MsgInfo) : void
        {
            var _loc_3:MapObject = null;
            var _loc_4:String = null;
            var _loc_5:Number = NaN;
            var _loc_2:* = new PlaceBuildingMsg(param1.Data);
            logger.debug("cmd", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                if (TutorialMgr.getInstance().isTutorial)
                {
                    TutorialMgr.getInstance().nextStep(1);
                }
                _loc_3 = GameDataMgr.getInstance().getBuildingByAutoId(_loc_2.buildingAutoId);
                if (!_loc_3)
                {
                    return;
                }
                _loc_4 = Utility.getTypeObject(_loc_3.type);
                if (_loc_3.type == BuildingType.WALL || _loc_4 == BuildingType.TRA)
                {
                    _loc_3.startTime = Utility.getCurTime();
                    GameDataMgr.getInstance().updateBuilder(_loc_2.buildingAutoId, _loc_3.startTime + _loc_3.buildTimeNextLevel);
                    _loc_3.finishBuilding(1);
                }
                else
                {
                    _loc_5 = Utility.getCurTime();
                    _loc_3.startTime = _loc_2.startTime;
                    GameDataMgr.getInstance().updateBuilder(_loc_2.buildingAutoId, _loc_3.startTime + _loc_3.buildTimeNextLevel);
                }
                if (_loc_3.type != BuildingType.WALL && _loc_4 != BuildingType.TRA)
                {
                    this.showBuildingActionGui(_loc_3);
                }
            }
            return;
        }// end function

        private function onMoveBuilding(param1:MsgInfo) : void
        {
            var _loc_2:* = new MoveBuildingMsg(param1.Data);
            logger.debug("cmd", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        public function showGuiTrainTroop(param1:int) : void
        {
            if (param1 == -1)
            {
                param1 = GameDataMgr.getInstance().findAvaiableBarrack();
            }
            if (param1 == -1)
            {
                this.guiNotify.addNewNotify(Localization.getInstance().getString("NoBarrackAvaiable"));
                return;
            }
            this.guiTrainTroop.showGui(param1);
            this.guiMainBottom.hide();
            this.guiShop.hide();
            return;
        }// end function

        public function sendUpgradeBuilding(param1:MapObject, param2:int) : void
        {
            var _loc_3:* = new UpgradeCmd();
            _loc_3.type = param1.type;
            _loc_3.autoId = param1.autoId;
            _loc_3.builder = param2;
            bzConnector.send(_loc_3);
            return;
        }// end function

        private function getConnector() : BZConnector
        {
            return bzConnector;
        }// end function

        public function sendHarvest(param1:int, param2:String) : void
        {
            var _loc_3:* = new HarvestCmd();
            _loc_3.ResourceAutoId = param1;
            _loc_3.ResourceType = param2;
            bzConnector.send(_loc_3);
            return;
        }// end function

        private function onGetHarvest(param1:MsgInfo) : void
        {
            var _loc_2:* = new HarvestMsg(param1.Data);
            logger.debug("cmd", ErrorCode.getReason(_loc_2.errorCode));
            var _loc_3:* = GameDataMgr.getInstance().resourceList;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                if (_loc_3[_loc_4].autoId == _loc_2.autoId)
                {
                    if (_loc_2.errorCode == 0)
                    {
                        _loc_3[_loc_4].receiveHarvest(_loc_2);
                    }
                    break;
                }
                _loc_4++;
            }
            return;
        }// end function

        private function onGetUpgrade(param1:MsgInfo) : void
        {
            var _loc_3:MapObject = null;
            var _loc_2:* = new UpgradeMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                if (TutorialMgr.getInstance().isTutorial)
                {
                    TutorialMgr.getInstance().nextStep(1);
                }
                _loc_3 = GameDataMgr.getInstance().getBuildingByAutoId(_loc_2.autoId);
                if (!_loc_3)
                {
                    return;
                }
                if (_loc_3.type == BuildingType.WALL)
                {
                    _loc_3.startTime = Utility.getCurTime();
                    GameDataMgr.getInstance().updateBuilder(_loc_2.autoId, _loc_3.startTime + _loc_3.buildTimeNextLevel);
                    WallObject(_loc_3).finishUpgrade();
                }
                else
                {
                    _loc_3.startTime = _loc_2.startTime;
                    GameDataMgr.getInstance().updateBuilder(_loc_2.autoId, _loc_3.startTime + _loc_3.buildTimeNextLevel);
                }
                this.showBuildingActionGui(_loc_3);
            }
            return;
        }// end function

        public function updateBuilder() : void
        {
            this.guiMainTop.updateBuilder();
            return;
        }// end function

        public function getBattleInfo() : void
        {
            this.guiFindMath.hide();
            var _loc_1:* = new BattleInfoCmd();
            bzConnector.send(_loc_1);
            return;
        }// end function

        public function loadBattleInfo(param1:BattleInfoMsg) : void
        {
            var _loc_3:Object = null;
            var _loc_4:Vector2D = null;
            var _loc_5:LaboratoryObject = null;
            var _loc_6:ClanObject = null;
            if (GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
            {
                MapMgr.getInstance().showSingleMap();
            }
            else
            {
                MapMgr.getInstance().showCityMap();
            }
            GameDataMgr.getInstance().resetDataCity();
            BattleModule.getInstance().gold = 0;
            BattleModule.getInstance().elixir = 0;
            BattleModule.getInstance().darkElixir = 0;
            BattleModule.getInstance().totalHp = 0;
            BattleModule.getInstance().uId = param1.uId;
            BattleModule.getInstance().uName = param1.uName;
            BattleModule.getInstance().uAvatar = param1.uAvatar;
            BattleModule.getInstance().trophyLost = param1.trophyLost;
            BattleModule.getInstance().trophyReceive = param1.trophyReceive;
            var _loc_2:int = 0;
            while (_loc_2 < param1.dataList.length)
            {
                
                _loc_3 = new Object();
                _loc_3.autoId = param1.dataList[_loc_2].objId;
                _loc_3.type = param1.dataList[_loc_2].objType;
                _loc_3.level = param1.dataList[_loc_2].level;
                _loc_4 = MapMgr.getInstance().cityMap.cellToIso(param1.dataList[_loc_2].cell);
                _loc_3.posX = _loc_4.x;
                _loc_3.posY = _loc_4.y;
                _loc_3.gold = param1.dataList[_loc_2].gold;
                _loc_3.elixir = param1.dataList[_loc_2].elixir;
                _loc_3.darkElixir = param1.dataList[_loc_2].darkElixir;
                _loc_3.status = param1.dataList[_loc_2].status;
                BattleModule.getInstance().gold = BattleModule.getInstance().gold + param1.dataList[_loc_2].gold;
                BattleModule.getInstance().elixir = BattleModule.getInstance().elixir + param1.dataList[_loc_2].elixir;
                BattleModule.getInstance().darkElixir = BattleModule.getInstance().darkElixir + param1.dataList[_loc_2].darkElixir;
                switch(_loc_3.type)
                {
                    case BuildingType.ARMY_CAMP:
                    {
                        this.setArmyCamp(_loc_3);
                        break;
                    }
                    case BuildingType.TOWN_HALL:
                    {
                        this.setTownHall(_loc_3);
                        break;
                    }
                    case BuildingType.BARRACK:
                    {
                        this.setBarrack(_loc_3);
                        break;
                    }
                    case BuildingType.GOLD_STORAGE:
                    case BuildingType.ELIXIR_STORAGE:
                    case BuildingType.DARK_ELIXIR_STORAGE:
                    {
                        this.setStorage(_loc_3);
                        break;
                    }
                    case BuildingType.GOLD_MINE:
                    case BuildingType.ELIXIR_COLLECTOR:
                    case BuildingType.DARK_ELIXIR_COLLECTOR:
                    {
                        this.setResource(_loc_3);
                        break;
                    }
                    case BuildingType.CANON:
                    case BuildingType.MOTAR:
                    case BuildingType.ACHER_TOWER:
                    case BuildingType.WIZARD_TOWER:
                    case BuildingType.AIR_DEFENSES:
                    {
                        this.setDefense(_loc_3);
                        break;
                    }
                    case BuildingType.WALL:
                    {
                        this.setWall(_loc_3);
                        break;
                    }
                    case BuildingType.LABORATORY:
                    {
                        _loc_5 = new LaboratoryObject();
                        Utility.setData(_loc_5, _loc_3);
                        this.setLaboratory(_loc_5);
                        break;
                    }
                    case BuildingType.BUILDER_HUT:
                    {
                        this.setBuilderHut(_loc_3);
                        break;
                    }
                    case BuildingType.CLAN_CASTLE:
                    {
                        _loc_6 = new ClanObject();
                        Utility.setData(_loc_6, _loc_3);
                        BattleModule.getInstance().clanIconFriend = param1.clanIcon;
                        BattleModule.getInstance().clanNameFriend = param1.clanName;
                        this.setClanCastle(_loc_6);
                        break;
                    }
                    case BuildingType.TRA_1:
                    case BuildingType.TRA_2:
                    case BuildingType.TRA_3:
                    case BuildingType.TRA_4:
                    case BuildingType.TRA_5:
                    {
                        this.setTrap(_loc_3);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < param1.dataObstacle.length)
            {
                
                _loc_3 = new Object();
                _loc_3.autoId = param1.dataObstacle[_loc_2].objId;
                _loc_3.type = param1.dataObstacle[_loc_2].objType;
                _loc_3.level = param1.dataObstacle[_loc_2].level;
                _loc_4 = MapMgr.getInstance().cityMap.cellToIso(param1.dataObstacle[_loc_2].cell);
                _loc_3.posX = _loc_4.x;
                _loc_3.posY = _loc_4.y;
                this.setObstacle(_loc_3);
                _loc_2++;
            }
            BattleModule.getInstance().createTroopClan(param1.troopClans);
            BattleModule.getInstance().createTroopClanHouse(param1.troopClansHouse);
            BattleModule.getInstance().findComplete(param1.troopList, param1.revenge);
            ModuleMgr.getInstance().doFunction(CityMgr.HIDE_TRANSITION_EFF);
            return;
        }// end function

        private function onGetBattleInfoMgs(param1:MsgInfo) : void
        {
            this.destroyCityAvatar();
            var _loc_2:* = new BattleInfoMsg(param1.Data);
            if (_loc_2.errorCode != ErrorCode.SUCCESS)
            {
                this.showErrorCode(_loc_2.errorCode);
                return;
            }
            TutorialMgr.getInstance().removeArrow();
            this.loadBattleInfo(_loc_2);
            return;
        }// end function

        public function prepareToQuickFinish(param1:MapObject) : void
        {
            var _loc_6:String = null;
            var _loc_7:String = null;
            if (!param1)
            {
                return;
            }
            this.saveFnCallBack = null;
            this.hideBuildingActionGui();
            GameDataMgr.getInstance().tempObject = param1;
            var _loc_2:* = this.guiBuildingAction.buildingInfo.buildTime - Utility.getCurTime() + param1.startTime;
            var _loc_3:* = this.guiBuildingAction.buildingInfo.buildTime - Utility.getCurTime() + param1.startTime;
            var _loc_4:* = Utility.getCurTime();
            var _loc_5:* = Utility.getCostToBuyTime(this.guiBuildingAction.buildingInfo.buildTime - _loc_4 + param1.startTime).value;
            GameDataMgr.getInstance().quickFinishCost = _loc_5;
            if (GlobalVar.QUICK_FINISH_NEED_CONFIRM)
            {
                _loc_6 = Localization.getInstance().getString("QuickFinish0");
                _loc_7 = Localization.getInstance().getString("QuickFinish1");
                this.guiBuyResource.showGuiByTime(_loc_6, _loc_7, _loc_5, this.acceptQuickFinish, this.showBuildingActionGui, [param1], [param1]);
            }
            else
            {
                this.acceptQuickFinish(param1);
            }
            return;
        }// end function

        public function quickFinish() : void
        {
            var _loc_1:MapObject = null;
            if (!this.saveObject)
            {
                return;
            }
            this.saveObject.finishBuilding(1);
            if (!TutorialMgr.getInstance().isTutorial)
            {
                _loc_1 = GameDataMgr.getInstance().tempObject;
                if (_loc_1 == this.saveObject)
                {
                    if (_loc_1 && Utility.getTypeObject(_loc_1.type) != BuildingType.OBS)
                    {
                        this.showBuildingActionGui(_loc_1);
                    }
                }
            }
            return;
        }// end function

        public function quickResearch() : void
        {
            if (!this.saveObject)
            {
                return;
            }
            LaboratoryObject(this.saveObject).finishResearch();
            this.guiBuildingAction.curObject = null;
            this.showBuildingActionGui(this.saveObject);
            return;
        }// end function

        private function acceptQuickFinish(param1:MapObject) : void
        {
            var _loc_2:* = GameDataMgr.getInstance().quickFinishCost;
            if (GameDataMgr.getInstance().getMoney(MoneyType.COIN) < _loc_2)
            {
                this.showShopBuyG();
                return;
            }
            if (param1.type == BuildingType.LABORATORY && LaboratoryObject(param1).troopType != "" && param1.status == MapObject.PRODUCING)
            {
                this.sendQuickFinish(GlobalVar.QUICK_FINISH_RESEARCH, param1.autoId);
            }
            else
            {
                this.sendQuickFinish(param1.type, param1.autoId);
            }
            this.saveObject = param1;
            return;
        }// end function

        public function sendQuickFinish(param1:String, param2:int) : void
        {
            GameDataMgr.getInstance().quickFinishType = param1;
            var _loc_3:* = new QuickFinishCmd();
            _loc_3.type = param1;
            _loc_3.autoId = param2;
            bzConnector.send(_loc_3);
            return;
        }// end function

        private function onGetQuickFinish(param1:MsgInfo) : void
        {
            var _loc_3:String = null;
            var _loc_4:String = null;
            var _loc_2:* = new QuickFinishMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                switch(_loc_4)
                {
                    case GlobalVar.QUICK_FINISH_TRAINING:
                    {
                        break;
                    }
                    case GlobalVar.QUICK_FINISH_RESEARCH:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            if (this.saveObject && Utility.getTypeObject(this.saveObject.type) != BuildingType.OBS)
            {
                if (this.saveFnCallBack != null)
                {
                }
            }
            return;
        }// end function

        public function sendResearch(param1:String) : void
        {
            var _loc_2:* = new ResearchCmd();
            _loc_2.troopType = param1;
            bzConnector.send(_loc_2);
            return;
        }// end function

        private function onGetResearch(param1:MsgInfo) : void
        {
            var _loc_2:* = new ResearchMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                this.startResearch(_loc_2.startTime);
            }
            return;
        }// end function

        public function prepareToRebuildClanCastle() : void
        {
            this.guiRebuildClan.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        public function confirmRebuild() : void
        {
            var _loc_3:int = 0;
            var _loc_1:* = Utility.getInfoToBuild(BuildingType.CLAN_CASTLE, 1);
            var _loc_2:* = GameDataMgr.getInstance().getMoney(_loc_1.cost.type);
            if (_loc_2 >= _loc_1.cost.value)
            {
                this.rebuildClanCastle();
            }
            else
            {
                _loc_3 = _loc_1.cost.value - _loc_2;
                this.guiBuyResource.showGuiBuyResource(_loc_1.cost.type, _loc_3, this.acceptBuyResource, [_loc_1.cost.type, _loc_3, this.rebuildClanCastle]);
            }
            return;
        }// end function

        public function rebuildClanCastle() : void
        {
            var _loc_1:* = Utility.getInfoToBuild(BuildingType.CLAN_CASTLE, 1);
            GameDataMgr.getInstance().addMoney(_loc_1.cost.type, -_loc_1.cost.value);
            var _loc_2:* = GameDataMgr.getInstance().clanCastle;
            _loc_2.finishRebuild();
            var _loc_3:* = new RebuildClanCastleCmd();
            bzConnector.send(_loc_3);
            FeedMgr.getInstance().sendRequestFeedWall(FeedMgr.BUILD_CLC_1);
            return;
        }// end function

        private function onGetRebuildClanMgs(param1:MsgInfo) : void
        {
            var _loc_2:* = new RebuildClanCastleMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                this.guiClan.hide();
            }
            else
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        private function sendFriendListCmd() : void
        {
            var _loc_1:* = new FriendListCmd();
            _loc_1.isNewest = true;
            bzConnector.send(_loc_1);
            return;
        }// end function

        private function onFriendListMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new FriendListMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            this.guiFriendsList.getFriendsList(_loc_2.list);
            return;
        }// end function

        public function sendGetClansCmd() : void
        {
            var _loc_1:* = new GetClanCmd();
            bzConnector.send(_loc_1);
            return;
        }// end function

        private function onGetClansMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new GetClansMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                this.guiClan.loadListClans(_loc_2.list);
            }
            else
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        public function sendCreateClan(param1:ClanInfo) : void
        {
            var _loc_2:* = new CreateClanCmd();
            _loc_2.name = param1.name;
            _loc_2.icon = param1.icon;
            _loc_2.type = param1.type;
            _loc_2.requiredTrophy = param1.requiredTrophy;
            _loc_2.description = param1.description;
            bzConnector.send(_loc_2);
            this.hideClanGui();
            return;
        }// end function

        public function onGetCreateClan(param1:MsgInfo) : void
        {
            var _loc_2:* = new CreateClansMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                GameDataMgr.getInstance().setClanId(_loc_2.clanId);
                GameDataMgr.getInstance().clanCastle.title = GlobalVar.CLAN_LEADER;
                this.sendGetClanDetail(GameDataMgr.getInstance().myClanDetial.clanId);
                this.guiContentChat.show();
            }
            else
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        public function sendGetClanDetail(param1:int) : void
        {
            var _loc_2:* = new GetClanDetailCmd();
            _loc_2.clanId = param1;
            bzConnector.send(_loc_2);
            return;
        }// end function

        public function onGetClanDetailMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new GetClanDetailMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                if (_loc_2.clanObj.clanId == GameDataMgr.getInstance().myClanDetial.clanId)
                {
                    GameDataMgr.getInstance().saveMyClan(_loc_2);
                    if (!GameDataMgr.getInstance().getRequestClanList)
                    {
                        this.guiContentChat.removeAllItem();
                        this.sendGetTroopRequestList();
                        this.sendGetChatClan();
                    }
                }
                if (this.guiClan.isShowing)
                {
                    this.guiClan.guiJoinClan.loadClanDetail(_loc_2);
                }
                else if (this.guiRanking.isShowing)
                {
                    this.guiRanking.guiJoinClan.loadClanDetail(_loc_2);
                }
            }
            else
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        public function sendVisitFriend(param1:int) : void
        {
            var _loc_2:* = new FriendInfoCmd();
            _loc_2.friendId = param1;
            bzConnector.send(_loc_2);
            return;
        }// end function

        public function onGetFriendInfo(param1:MsgInfo) : void
        {
            var _loc_2:* = new PlayerInfoMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        public function returnMyHome() : void
        {
            GameDataMgr.getInstance().curObject = null;
            this.setState(GlobalVar.STATE_MYHOME);
            if (TutorialMgr.getInstance().isTutorial && TutorialMgr.getInstance().curStep == 15)
            {
                this.loadCityFromTutorial();
                TutorialMgr.getInstance().nextStep();
                ModuleMgr.getInstance().doFunction(CityMgr.HIDE_TRANSITION_EFF, 2);
            }
            else
            {
                this.sendVisitFriend(Config.uId);
            }
            return;
        }// end function

        private function loadCityFromTutorial() : void
        {
            GameDataMgr.getInstance().resetDataCity();
            GameDataMgr.getInstance().myInfo = TutorialMgr.getInstance().myInfo;
            GameDataMgr.getInstance().uInfo = TutorialMgr.getInstance().myInfo;
            this.addListBuildingToMap(TutorialMgr.getInstance().listBuilding);
            this.guiMainTopLeft.updateData();
            this.guiMainBottom.show();
            this.guiMainTop.updateBuilder();
            this.guiMainTop.updateTotalTroop();
            this.guiContentChat.hide();
            if (this.guiMainTopRight.bmpThongBao)
            {
                this.guiMainTopRight.bmpThongBao.visible = false;
            }
            return;
        }// end function

        public function sendJoinClan(param1:int) : void
        {
            GameDataMgr.getInstance().setClanId(param1);
            var _loc_2:* = new JoinClanCmd();
            _loc_2.clanId = param1;
            bzConnector.send(_loc_2);
            return;
        }// end function

        public function onGetJoinClan(param1:MsgInfo) : void
        {
            var _loc_2:JoinClanMsg = null;
            var _loc_3:String = null;
            var _loc_4:String = null;
            _loc_2 = new JoinClanMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                GameDataMgr.getInstance().clanCastle.title = GlobalVar.CLAN_MEMBER;
                if (this.guiClan.isShowing)
                {
                    this.hideClanGui();
                }
                if (this.guiRanking.isShowing)
                {
                    this.guiRanking.hide(true);
                }
                this.sendGetClanDetail(GameDataMgr.getInstance().myClanDetial.clanId);
                this.guiContentChat.show();
            }
            else
            {
                GameDataMgr.getInstance().leaveClan();
                switch(_loc_2.errorCode)
                {
                    case ErrorCode.CLAN_FULL:
                    case ErrorCode.NOT_ENOUGH_PERMISSION:
                    case ErrorCode.NOT_ENOUGH_TROPHY:
                    {
                        this.hideClanGui();
                        _loc_3 = Localization.getInstance().getString("Title_TB");
                        _loc_4 = Localization.getInstance().getString("ClanJoinError" + _loc_2.errorCode);
                        this.showMessage(_loc_3, _loc_4, "ĐÓNG", null, null, false);
                        break;
                    }
                    default:
                    {
                        this.showErrorCode(_loc_2.errorCode);
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function sendLeaveClan() : void
        {
            var _loc_1:* = new LeaveClanCmd();
            bzConnector.send(_loc_1);
            return;
        }// end function

        public function onGetLeaveClan(param1:MsgInfo) : void
        {
            var _loc_2:* = new LeaveClanMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                GameDataMgr.getInstance().leaveClan();
                this.guiContentChat.removeAllItem();
                if (this.guiClan.isShowing)
                {
                    this.hideClanGui();
                }
                if (this.guiRanking.isShowing)
                {
                    this.guiRanking.hide(true);
                }
            }
            else
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        public function sendChangeMemberTitle(param1:int, param2:int) : void
        {
            var _loc_3:* = new ChangeMemberTitleCmd();
            _loc_3.memberId = param1;
            _loc_3.newTitle = param2;
            bzConnector.send(_loc_3);
            this.guiClan.hide();
            return;
        }// end function

        private function onGetChangeMemberTitle(param1:MsgInfo) : void
        {
            var _loc_2:* = new ChangeMemberTitleMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            return;
        }// end function

        public function kickMember(param1:int) : void
        {
            this.guiClan.hide();
            var _loc_2:* = new KickMemberCmd();
            _loc_2.memberId = param1;
            bzConnector.send(_loc_2);
            return;
        }// end function

        private function onGetKickMember(param1:MsgInfo) : void
        {
            var _loc_2:* = new KickMemberMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            return;
        }// end function

        public function sendRequestTroopCmd(param1:String) : void
        {
            var _loc_2:* = new RequestTroopCmd();
            _loc_2.msg = param1;
            bzConnector.send(_loc_2);
            this.guiNotify.addNewNotify("Yêu cầu xin quân của bạn đã được gửi đi.");
            return;
        }// end function

        private function onGetRequestTroopResponse(param1:MsgInfo) : void
        {
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            var _loc_2:* = new RequestTroopResponseMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                GameDataMgr.getInstance().clanCastle.lastRequestTime = Utility.getCurTime();
            }
            return;
        }// end function

        private function onGetRequestTroopMsg(param1:MsgInfo) : void
        {
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            var _loc_2:* = new RequestTroopMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                this.guiContentChat.addNewRequest(_loc_2);
            }
            else
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        public function sendDonateTroopCmd(param1:int, param2:String) : void
        {
            var _loc_3:* = new DonateTroopCmd();
            _loc_3.friendId = param1;
            _loc_3.type = param2;
            bzConnector.send(_loc_3);
            return;
        }// end function

        private function onGetDonateTroopResponse(param1:MsgInfo) : void
        {
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            var _loc_2:* = new DonateTroopResponseMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
            }
            return;
        }// end function

        private function onGetDonateTroopMsg(param1:MsgInfo) : void
        {
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            var _loc_2:* = new DonateTroopMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                this.guiContentChat.updateRequestAfterDonate(_loc_2.sender, _loc_2.receiver, _loc_2.troopList);
            }
            else
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        public function sendGetTroopRequestList() : void
        {
            var _loc_1:* = new GetRequestTroopListCmd();
            bzConnector.send(_loc_1);
            return;
        }// end function

        private function onGetTroopRequestList(param1:MsgInfo) : void
        {
            var _loc_2:* = new GetRequestTroopListMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                this.guiContentChat.loadRequesList(_loc_2.troopRequests);
            }
            else
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        public function startResearch(param1:Number) : void
        {
            var _loc_2:* = GameDataMgr.getInstance().laboratory;
            _loc_2.status = MapObject.PRODUCING;
            _loc_2.startTime = param1;
            _loc_2.troopType = GameDataMgr.getInstance().curTroopType;
            var _loc_3:* = GameDataMgr.getInstance().getTroopLevel(_loc_2.troopType) + 1;
            _loc_2.researchTime = JsonMgr.getInstance().troop[_loc_2.troopType][_loc_3]["researchTime"];
            var _loc_4:* = JsonMgr.getInstance().troop[_loc_2.troopType][_loc_3]["researchCost"];
            GameDataMgr.getInstance().addMoney(MoneyType.ELIXIR, -_loc_4);
            this.guiTroopUpgrade.hide(true);
            return;
        }// end function

        private function researchTroop() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().curTroopType;
            this.sendResearch(_loc_1);
            return;
        }// end function

        public function prepareToResearch(param1:int, param2:String, param3:int) : void
        {
            var _loc_5:int = 0;
            var _loc_4:* = GameDataMgr.getInstance().getMoney(MoneyType.ELIXIR);
            GameDataMgr.getInstance().curTroopType = param2;
            if (_loc_4 >= param1)
            {
                this.researchTroop();
            }
            else
            {
                _loc_5 = param1 - _loc_4;
                this.guiBuyResource.showGuiBuyResource(MoneyType.ELIXIR, _loc_5, this.acceptBuyResource, [MoneyType.ELIXIR, _loc_5, this.researchTroop]);
            }
            return;
        }// end function

        public function addShopIconToMouse(param1:String) : void
        {
            GlobalVar.mouseState = GlobalVar.NEW_BUILDING;
            var _loc_2:* = new MapObject();
            _loc_2.type = param1;
            _loc_2.level = 1;
            _loc_2.loadConfigData();
            GameDataMgr.getInstance().curObject = null;
            MouseMgr.getInstance().changeBuildingMouseIcon(_loc_2, true);
            if (TutorialMgr.getInstance().isTutorial)
            {
                TutorialMgr.getInstance().nextStep();
            }
            this.guiShop.hide();
            this.guiBuildingAction.showShopCancelAction();
            return;
        }// end function

        public function createClan() : void
        {
            var _loc_3:int = 0;
            var _loc_1:* = GameDataMgr.getInstance().clanInfo;
            var _loc_2:* = GameDataMgr.getInstance().getMoney(MoneyType.GOLD);
            if (_loc_2 >= GlobalVar.CLAN_COST_TO_CREATE)
            {
                GameDataMgr.getInstance().addMoney(MoneyType.GOLD, -GlobalVar.CLAN_COST_TO_CREATE);
                this.sendCreateClan(_loc_1);
            }
            else
            {
                _loc_3 = GlobalVar.CLAN_COST_TO_CREATE - _loc_2;
                this.guiBuyResource.showGuiBuyResource(MoneyType.GOLD, _loc_3, this.acceptBuyResource, [MoneyType.GOLD, _loc_3, this.createClan]);
            }
            return;
        }// end function

        public function prepareCancelBuilding(param1:MapObject) : void
        {
            if (!param1 || param1.status == MapObject.PRODUCING)
            {
                return;
            }
            GameDataMgr.getInstance().tempObject = param1;
            var _loc_2:* = param1.status == MapObject.BUILDING ? (Command.CANCEL_PLACING) : (Command.CANCEL_UPGRADING);
            var _loc_3:* = param1.status == MapObject.BUILDING ? (Localization.getInstance().getString("CancelBuildingMsg0")) : (Localization.getInstance().getString("CancelBuildingMsg1"));
            var _loc_4:* = Localization.getInstance().getString("CancelBuildingTitle");
            var _loc_5:* = Localization.getInstance().getString("CancelBuildingMsg3");
            _loc_5 = Localization.getInstance().getString("CancelBuildingMsg3").replace("@action@", _loc_3);
            _loc_5 = _loc_5.replace("@name@", Localization.getInstance().getString(param1.type));
            this.guiPopup.showConfirmBox(_loc_4 + " " + _loc_3 + "?", _loc_5, "ĐỒNG Ý", this.cancelBuilding, this.showBuildingActionGui, [_loc_2], [param1]);
            return;
        }// end function

        public function cancelBuilding(param1:int) : void
        {
            var _loc_4:String = null;
            var _loc_5:DataBuildingInfo = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:DataBuildingInfo = null;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_2:* = GameDataMgr.getInstance().tempObject;
            if (!_loc_2)
            {
                return;
            }
            if (_loc_2.status == MapObject.PRODUCING)
            {
                _loc_4 = Localization.getInstance().getString("CannotCancelPlacing");
                _loc_4 = _loc_4.replace("@name@", Localization.getInstance().getString(_loc_2.type));
                this.guiNotify.addNewNotify(_loc_4);
                return;
            }
            var _loc_3:Boolean = false;
            if (param1 == Command.CANCEL_PLACING)
            {
                _loc_5 = Utility.getInfoToBuild(_loc_2.type, 1);
                _loc_6 = GameDataMgr.getInstance().getTotalResourceStorage(Utility.getStorageType(_loc_5.cost.type));
                _loc_7 = GameDataMgr.getInstance().getMoney(_loc_5.cost.type);
                _loc_8 = int(_loc_5.cost.value / 2);
                if (_loc_7 + _loc_8 <= _loc_6)
                {
                    GameDataMgr.getInstance().addMoney(_loc_5.cost.type, _loc_8);
                    GameDataMgr.getInstance().removeBuilding(_loc_2);
                    _loc_3 = true;
                }
                else
                {
                    this.showNotEnoughResoureStorages(_loc_5.cost.type, "2");
                }
            }
            else
            {
                _loc_9 = Utility.getInfoToBuild(_loc_2.type, (_loc_2.level + 1));
                _loc_10 = GameDataMgr.getInstance().getTotalResourceStorage(Utility.getStorageType(_loc_9.cost.type));
                _loc_11 = GameDataMgr.getInstance().getMoney(_loc_9.cost.type);
                _loc_12 = int(_loc_9.cost.value / 2);
                if (_loc_11 + _loc_12 <= _loc_10)
                {
                    GameDataMgr.getInstance().addMoney(_loc_9.cost.type, int(_loc_9.cost.value / 2));
                    _loc_2.startTime = 0;
                    _loc_2.status = MapObject.PRODUCING;
                    _loc_2.upgradingImage.visible = false;
                    _loc_2.hideStatusBar();
                    _loc_3 = true;
                }
                else
                {
                    this.showNotEnoughResoureStorages(_loc_9.cost.type, "2");
                }
            }
            if (_loc_3)
            {
                this.builderReturnHome(_loc_2.autoId);
                GameDataMgr.getInstance().freeBuilder(_loc_2.autoId);
                this.sendCancelBuilding(_loc_2.autoId, _loc_2.type, param1);
            }
            return;
        }// end function

        public function sendCancelBuilding(param1:int, param2:String, param3:int) : void
        {
            var _loc_4:* = new CancelPlacingCmd();
            new CancelPlacingCmd().typeId = param3;
            _loc_4.autoId = param1;
            _loc_4.type = param2;
            bzConnector.send(_loc_4);
            GameDataMgr.getInstance().curObject = null;
            return;
        }// end function

        private function onGetCancelBuildingMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new CancelBuildingMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
            }
            return;
        }// end function

        public function prepareToQuickTraining(param1:int, param2:int) : void
        {
            this.saveFnCallBack = null;
            var _loc_3:* = GameDataMgr.getInstance().getMoney(MoneyType.COIN);
            if (_loc_3 >= param2)
            {
                GameDataMgr.getInstance().curBarrackId = param1;
                GameDataMgr.getInstance().quickFinishCost = param2;
                this.sendQuickFinish(GlobalVar.QUICK_FINISH_TRAINING, GameDataMgr.getInstance().barrackList[param1].autoId);
            }
            else
            {
                this.showShopBuyG();
            }
            return;
        }// end function

        public function quickTrainTroop() : void
        {
            this.guiTrainTroop.finishAllTraining(GameDataMgr.getInstance().curBarrackId);
            this.guiNotify.addNewNotify(Localization.getInstance().getString("FinishQuickTraining"));
            this.guiMainTop.updateTotalTroop();
            if (TutorialMgr.getInstance().isTutorial)
            {
                this.guiTrainTroop.hide(true);
                this.guiTotalTroop.hide(true);
                this.guiMainBottom.show();
                TutorialMgr.getInstance().nextStep(1);
            }
            return;
        }// end function

        public function sendQuickTrainingCmd(param1:int) : void
        {
            var _loc_2:* = new QuickTrainTroopCmd();
            _loc_2.barrackId = param1;
            bzConnector.send(_loc_2);
            return;
        }// end function

        private function onGetQuickTrainTroopMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new QuickTrainTroopMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        public function sendTrainTroopCmd(param1:int, param2:String, param3:int) : void
        {
            var _loc_4:* = new TrainTroopCmd();
            new TrainTroopCmd().barrackAutoId = param1;
            _loc_4.troopType = param2;
            _loc_4.troopNumber = param3;
            bzConnector.send(_loc_4);
            return;
        }// end function

        private function onGetTrainTroopMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new TrainTroopMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.guiTrainTroop.updateStartTime(_loc_2.startTime);
            }
            else
            {
                this.guiTrainTroop.onGetTrainTroopMsg(_loc_2.startTime);
            }
            return;
        }// end function

        public function sendCancelTroopTrainCmd(param1:int, param2:String, param3:int) : void
        {
            var _loc_4:* = new CancelTrainTroopCmd();
            new CancelTrainTroopCmd().barrackAutoId = param1;
            _loc_4.troopType = param2;
            _loc_4.troopNumber = param3;
            bzConnector.send(_loc_4);
            return;
        }// end function

        private function onGetCancelTroopTrainMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new CancelTroopTrainMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
            }
            else
            {
                this.guiTrainTroop.onGetCancelTrainTroopMsg(_loc_2);
            }
            return;
        }// end function

        private function onGetClanChat(param1:MsgInfo) : void
        {
            var _loc_2:* = new GetClanChatMsg(param1.Data);
            this.guiContentChat.addDataChat(_loc_2.data);
            return;
        }// end function

        private function onGetClanChatAuto(param1:MsgInfo) : void
        {
            var _loc_2:* = new SendClanChatMsg(param1.Data);
            this.guiContentChat.addChat(_loc_2.sender, _loc_2.msg);
            return;
        }// end function

        public function sendChat(param1:String) : void
        {
            var _loc_2:* = new SendClanChatCmd(param1);
            bzConnector.send(_loc_2);
            return;
        }// end function

        private function onSendChat(param1:MsgInfo) : void
        {
            return;
        }// end function

        private function sendGetChatClan() : void
        {
            var _loc_1:* = new GetClanChatCmd();
            bzConnector.send(_loc_1);
            return;
        }// end function

        public function showErrorCode(param1:int) : void
        {
            this.showMessage("Thông báo lỗi", "Lỗi kết nối\nError: " + param1, "Kết nối lại", this.reloadGame, null, false);
            return;
        }// end function

        private function onConnectionLost(event:BZEvent) : void
        {
            var _loc_2:String = null;
            switch(event.params["reason"])
            {
                case ClientDisconnectionReason.LOGIN:
                {
                    _loc_2 = Localization.getInstance().getString("DisconnectedLogin");
                    break;
                }
                case ClientDisconnectionReason.KICK:
                {
                    _loc_2 = Localization.getInstance().getString("DisconnectedKick");
                    break;
                }
                default:
                {
                    _loc_2 = Localization.getInstance().getString("DisconnectedIdle");
                    break;
                    break;
                }
            }
            this.showMessage("Mất kết nối", _loc_2, "Kết nối lại", this.reloadGame, null, false);
            return;
        }// end function

        public function reloadGame() : void
        {
            Utility.callURL(GlobalVar.URL_THOI_LOAN, "_parent");
            return;
        }// end function

        public function startTutorial() : void
        {
            if (Config.TRY_TUTORIAL == 0)
            {
                return;
            }
            if (!this.guiNPC1)
            {
                this.guiNPC1 = new GuiNPC1();
            }
            if (!this.guiNPC2)
            {
                this.guiNPC2 = new GuiNPC2();
            }
            TutorialMgr.getInstance().initNewTut();
            TutorialMgr.getInstance().run(1);
            if (this.guiMainTopRight.bmpThongBao)
            {
                this.guiMainTopRight.bmpThongBao.visible = false;
            }
            FeedMgr.getInstance().sendRequestFeedWall(FeedMgr.FIRST_PLAY_GAME);
            return;
        }// end function

        public function sendFinishTutorialCmd() : void
        {
            var _loc_1:* = new FinishTutorialCmd();
            bzConnector.send(_loc_1);
            return;
        }// end function

        public function showShopBuyG() : void
        {
            var _loc_1:* = Localization.getInstance().getString("Title_TB");
            var _loc_2:* = Localization.getInstance().getString("NotEnoughMoney2");
            CityMgr.getInstance().showMessage(_loc_1, _loc_2, "NẠP G", this.guiNapThe.show, [null, true]);
            return;
        }// end function

        public function finishTraining(param1:Troop, param2:int, param3:int) : void
        {
            var _loc_4:* = GameDataMgr.getInstance().armyCampList;
            var _loc_5:* = GameDataMgr.getInstance().armyCampList.length;
            var _loc_6:* = this.troopList.length;
            var _loc_7:* = new CityTroop();
            new CityTroop().setInfo(param1.type, param1.level, _loc_4[_loc_6 % _loc_5].posX, _loc_4[_loc_6 % _loc_5].posY);
            _loc_7.idAmryCamp = _loc_4[_loc_6 % _loc_5].autoId;
            if (this.troopList.length > 0)
            {
                _loc_7.troopIndex = this.troopList[(this.troopList.length - 1)].troopIndex + 1;
            }
            this.troopList.push(_loc_7);
            _loc_7.move.curCell = MapMgr.getInstance().battleMap.isoToCell(param2 * 3, param3 * 3);
            return;
        }// end function

        public function onGetSingleMapInfoMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new SingleMapInfoMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                GameDataMgr.getInstance().singleMapInfo = _loc_2.mapInfo;
                GameDataMgr.getInstance().singleMapLevel = _loc_2.level;
                this.guiFindMath.loadSingleMap();
            }
            return;
        }// end function

        public function sendAttackSingleMap(param1:int) : void
        {
            var _loc_2:* = new BattleInfoCmd(param1);
            bzConnector.send(_loc_2);
            return;
        }// end function

        public function showGuiLog() : void
        {
            this.guiLog.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            CityMgr.getInstance().guiMainBottom.hideMailNotice();
            return;
        }// end function

        public function sendSetNameCmd(param1:String) : void
        {
            var _loc_2:* = new SetNameCmd();
            _loc_2.name = param1;
            bzConnector.send(_loc_2);
            GameDataMgr.getInstance().myInfo.uName = param1;
            return;
        }// end function

        private function onGetSetNameMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new SetNameMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                this.guiMainTopLeft.labelUsername.text = GameDataMgr.getInstance().myInfo.uName;
                this.guiNPC1.hide();
                TutorialMgr.getInstance().nextStep();
            }
            return;
        }// end function

        private function onGetUserJoinClan(param1:MsgInfo) : void
        {
            var _loc_3:ClanMemberInfo = null;
            var _loc_2:* = new NewUserJoinClanMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                if (_loc_2.userId == GameDataMgr.getInstance().myInfo.uId)
                {
                    return;
                }
                _loc_3 = new ClanMemberInfo();
                _loc_3.uId = _loc_2.userId;
                _loc_3.clanTitle = GlobalVar.CLAN_MEMBER;
                _loc_3.trophy = _loc_2.trophy;
                _loc_3.level = _loc_2.level;
                _loc_3.name = _loc_2.name;
                GameDataMgr.getInstance().addNewClanMember(_loc_3);
            }
            return;
        }// end function

        public function showSideQuestBoard(param1:String) : void
        {
            this.guiSideQuest.showBoard(param1);
            return;
        }// end function

        public function sendQuestInfoCmd() : void
        {
            var _loc_1:* = new QuestInfoCmd();
            bzConnector.send(_loc_1);
            return;
        }// end function

        private function onGetQuestInfoMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new QuestInfoMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                SideQuestMgr.getInstance().updateQuestInfo(_loc_2);
            }
            return;
        }// end function

        public function sendClaimRewardCmd(param1:String, param2:int) : void
        {
            SideQuestMgr.getInstance().curQuest = param1;
            var _loc_3:* = new ClaimRewardCmd();
            _loc_3.questType = param1;
            _loc_3.questId = param2;
            bzConnector.send(_loc_3);
            return;
        }// end function

        private function onGetClaimRewardMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new ClaimRewardMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                SideQuestMgr.getInstance().claimCurrentReward();
            }
            return;
        }// end function

        public function sendFinishBuilding(param1:String, param2:int) : void
        {
            var _loc_3:* = new FinishBuildingCmd();
            _loc_3.type = param1;
            _loc_3.autoId = param2;
            bzConnector.send(_loc_3);
            return;
        }// end function

        public function sendFinishTraningTroop(param1:String, param2:int) : void
        {
            var _loc_3:* = new FinishTrainTroopCmd();
            _loc_3.troopType = param1;
            _loc_3.barrackId = param2;
            bzConnector.send(_loc_3);
            return;
        }// end function

        public function sendRemoveObstacle(param1:String, param2:int, param3:int) : void
        {
            var _loc_4:* = new RemoveObstaclesCmd(Command.REMOVE_OBSTACLES, param1, param2, param3);
            bzConnector.send(_loc_4);
            return;
        }// end function

        public function sendFinishRemoveObstacle(param1:String, param2:int) : void
        {
            var _loc_3:* = new RemoveObstaclesCmd(Command.REMOVE_OBSTACLES_COMPLETED, param1, param2, 0);
            bzConnector.send(_loc_3);
            return;
        }// end function

        public function removeObstacle() : void
        {
            var _loc_4:int = 0;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_9:int = 0;
            var _loc_1:* = GameDataMgr.getInstance().tempObject as ObstacleObject;
            if (!_loc_1)
            {
                return;
            }
            var _loc_2:* = Utility.getInfoToRemove(_loc_1.type);
            var _loc_3:* = GameDataMgr.getInstance().getFreeBuilder();
            if (_loc_3 >= 0)
            {
                _loc_1.startTime = Utility.getCurTime();
                this.guiBuildingAction.curObject = null;
                this.showBuildingActionGui(_loc_1);
                GameDataMgr.getInstance().addMoney(_loc_2.cost.type, -_loc_2.cost.value);
                GameDataMgr.getInstance().takeBuilder(_loc_3, _loc_1.autoId, _loc_1.startTime + _loc_1.info.removalTime);
                this.sendRemoveObstacle(_loc_1.type, _loc_1.autoId, _loc_3);
                GameDataMgr.getInstance().tempObject = null;
            }
            else
            {
                _loc_4 = GameDataMgr.getInstance().getNearestBusyBuilder();
                _loc_5 = Utility.getCurTime();
                _loc_6 = GameDataMgr.getInstance().myInfo.builderList[_loc_4].endTime;
                _loc_7 = Localization.getInstance().getString("NotEnoughBuilder0");
                _loc_8 = Localization.getInstance().getString("NotEnoughBuilder1");
                _loc_9 = Utility.getCostToBuyTime(_loc_6 - _loc_5).value;
                GameDataMgr.getInstance().quickFinishCost = _loc_9;
                this.guiBuyResource.showGuiByTime(_loc_7, _loc_8, _loc_9, this.acceptFreeUpBuilder, null, [_loc_4, this.removeObstacle]);
            }
            return;
        }// end function

        public function prepareRemoveObstacle(param1:MapObject) : void
        {
            var _loc_4:int = 0;
            this.saveFnCallBack = null;
            GameDataMgr.getInstance().tempObject = param1;
            var _loc_2:* = Utility.getInfoToRemove(param1.type);
            var _loc_3:* = GameDataMgr.getInstance().getMoney(_loc_2.cost.type);
            if (_loc_3 >= _loc_2.cost.value)
            {
                this.removeObstacle();
            }
            else
            {
                _loc_4 = _loc_2.cost.value - _loc_3;
                this.guiBuyResource.showGuiBuyResource(_loc_2.cost.type, _loc_4, this.acceptBuyResource, [_loc_2.cost.type, _loc_4, this.removeObstacle]);
            }
            return;
        }// end function

        public function finishRemoveObstacle(param1:String, param2:int) : void
        {
            this.sendFinishRemoveObstacle(param1, param2);
            return;
        }// end function

        private function onGetRemoveObstacleComp(param1:MsgInfo) : void
        {
            var _loc_3:MapObject = null;
            var _loc_2:* = new RemoveObstacleCompMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                _loc_3 = GameDataMgr.getInstance().getBuildingByAutoId(_loc_2.autoId);
                if (_loc_2.exp > 0)
                {
                    GameDataMgr.getInstance().addExp(_loc_2.exp);
                    _loc_3.showExpEffect(_loc_2.exp);
                }
                if (_loc_2.coin > 0)
                {
                    GameDataMgr.getInstance().addMoney(MoneyType.COIN, _loc_2.coin);
                    _loc_3.showCoinEffect(_loc_2.coin);
                    CityMgr.getInstance().guiNotify.addReceiveMoney(new MoneyType(MoneyType.COIN, _loc_2.coin));
                }
                GameDataMgr.getInstance().removeObstacle(_loc_2.autoId);
                this.builderReturnHome(_loc_2.autoId);
                if (this.guiBuildingAction.isShowing && this.guiBuildingAction.curObject && this.guiBuildingAction.curObject.autoId == _loc_2.autoId)
                {
                    this.hideBuildingActionGui();
                }
                if (this.saveFnCallBack != null)
                {
                    this.saveFnCallBack.apply();
                }
            }
            return;
        }// end function

        private function onGetRemoveObstacle(param1:MsgInfo) : void
        {
            var _loc_2:* = new RemoveObstacleMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        public function createBuilder(param1:int, param2:MapObject, param3:int) : void
        {
            var _loc_5:int = 0;
            var _loc_6:BuilderObject = null;
            if (param2 == null)
            {
                return;
            }
            var _loc_4:* = new Builder();
            new Builder().setInfo(param1, param2);
            if (param3 > 0)
            {
                _loc_5 = 0;
                while (_loc_5 < this.buidlerList.length)
                {
                    
                    if (this.buidlerList[_loc_5].builderHurtIndex == param1)
                    {
                        this.buidlerList[_loc_5].updateBuilding(param2);
                        return;
                    }
                    _loc_5++;
                }
                _loc_6 = GameDataMgr.getInstance().builderHutList[param1];
                _loc_4.move.curCell = MapMgr.getInstance().battleMap.isoToCell(_loc_6.posX * 3, _loc_6.posY * 3);
                _loc_6.hideIdleEffect();
            }
            else
            {
                _loc_4.move.curCell = MapMgr.getInstance().battleMap.isoToCell(param2.posX * 3, param2.posY * 3);
            }
            this.buidlerList.push(_loc_4);
            return;
        }// end function

        public function updateIsoBuilder(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:int = 0;
            while (_loc_4 < this.buidlerList.length)
            {
                
                if (this.buidlerList[_loc_4].buildingAutoId == param3)
                {
                    this.buidlerList[_loc_4].updateCellBuilding(param1, param2, 1);
                }
                _loc_4++;
            }
            return;
        }// end function

        public function createAvartarBuilder() : void
        {
            var _loc_3:MapObject = null;
            var _loc_4:BuilderObject = null;
            var _loc_1:* = GameDataMgr.getInstance().uInfo;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1.builderList.length)
            {
                
                if (_loc_1.builderList[_loc_2].endTime > 0)
                {
                    _loc_3 = GameDataMgr.getInstance().getBuildingByAutoId(_loc_1.builderList[_loc_2].buildingAutoId);
                    CityMgr.getInstance().createBuilder(_loc_2, _loc_3, 0);
                }
                else if (_loc_2 < GameDataMgr.getInstance().builderHutList.length)
                {
                    _loc_4 = GameDataMgr.getInstance().builderHutList[_loc_2];
                    _loc_4.showIdleEffect();
                }
                _loc_2++;
            }
            return;
        }// end function

        public function builderReturnHome(param1:int) : void
        {
            var _loc_3:int = 0;
            var _loc_4:BuilderObject = null;
            var _loc_2:int = 0;
            while (_loc_2 < this.buidlerList.length)
            {
                
                if (this.buidlerList[_loc_2].buildingAutoId == param1)
                {
                    this.buidlerList[_loc_2].returnBuildingHurt();
                    _loc_3 = this.buidlerList[_loc_2].builderHurtIndex;
                    _loc_4 = GameDataMgr.getInstance().builderHutList[_loc_3];
                    _loc_4.showIdleEffect();
                    return;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function removeBuilder(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.buidlerList.length)
            {
                
                if (this.buidlerList[_loc_2].builderHurtIndex == param1)
                {
                    this.buidlerList[_loc_2].destroy();
                    this.buidlerList[_loc_2] = null;
                    this.buidlerList.splice(_loc_2, 1);
                    return;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function removeCityTroop(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.troopList.length)
            {
                
                if (this.troopList[_loc_2].troopIndex == param1)
                {
                    this.troopList[_loc_2].destroy();
                    this.troopList[_loc_2] = null;
                    this.troopList.splice(_loc_2, 1);
                    return;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function removeFarmer(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.farmerList.length)
            {
                
                if (this.farmerList[_loc_2].idFarmer == param1)
                {
                    this.farmerList[_loc_2].destroy();
                    this.farmerList[_loc_2] = null;
                    this.farmerList.splice(_loc_2, 1);
                    return;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function removeAngryBird(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.birdList.length)
            {
                
                if (this.birdList[_loc_2].birdId == param1)
                {
                    this.birdList[_loc_2].destroy();
                    this.birdList[_loc_2] = null;
                    this.birdList.splice(_loc_2, 1);
                    return;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function allFarmerReturnHome() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.farmerList.length)
            {
                
                this.farmerList[_loc_1].returnHome();
                _loc_1++;
            }
            this.farmerId = 0;
            return;
        }// end function

        private function getArrObj(param1:Boolean) : Array
        {
            var _loc_3:int = 0;
            var _loc_5:Vector.<WallObject> = null;
            var _loc_2:* = new Array();
            _loc_3 = 0;
            while (_loc_3 < this.buidlerList.length)
            {
                
                if (this.buidlerList[_loc_3].avatar)
                {
                    _loc_2.push(this.buidlerList[_loc_3].avatar);
                }
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < this.troopList.length)
            {
                
                if (this.troopList[_loc_3].avatar)
                {
                    _loc_2.push(this.troopList[_loc_3].avatar);
                }
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < this.farmerList.length)
            {
                
                if (this.farmerList[_loc_3].avatar)
                {
                    _loc_2.push(this.farmerList[_loc_3].avatar);
                }
                _loc_3++;
            }
            var _loc_4:* = GameDataMgr.getInstance().getHouseList();
            _loc_3 = 0;
            while (_loc_3 < _loc_4.length)
            {
                
                if (_loc_4[_loc_3].type == null || Utility.getTypeObject(_loc_4[_loc_3].type) == BuildingType.WAL)
                {
                }
                else if (_loc_4[_loc_3].bgImage)
                {
                    _loc_2.push(_loc_4[_loc_3].avatar);
                }
                _loc_3++;
            }
            if (param1)
            {
                _loc_5 = GameDataMgr.getInstance().wallList;
                _loc_3 = 0;
                while (_loc_3 < _loc_5.length)
                {
                    
                    if (_loc_5[_loc_3].type == null)
                    {
                    }
                    else if (_loc_5[_loc_3].bgImage)
                    {
                        _loc_2.push(_loc_5[_loc_3].avatar);
                    }
                    _loc_3++;
                }
            }
            _loc_2.sortOn("y", Array.NUMERIC);
            return _loc_2;
        }// end function

        public function getIndexAvatar(param1:DisplayObjectContainer) : int
        {
            var _loc_2:* = this.getArrObj(true);
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3].y > param1.y)
                {
                    return _loc_2[_loc_3].parent.getChildIndex(_loc_2[_loc_3]);
                }
                _loc_3++;
            }
            return -1;
        }// end function

        public function renderObj(param1:Boolean = false) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_2:* = this.getArrObj(param1);
            var _loc_3:int = 0;
            while (_loc_3 < (_loc_2.length - 1))
            {
                
                _loc_4 = _loc_2[_loc_3].parent.getChildIndex(_loc_2[_loc_3]);
                _loc_5 = _loc_2[(_loc_3 + 1)].parent.getChildIndex(_loc_2[(_loc_3 + 1)]);
                if (_loc_4 > _loc_5)
                {
                    _loc_2[_loc_3].parent.swapChildrenAt(_loc_4, _loc_5);
                }
                _loc_3++;
            }
            return;
        }// end function

        public function showLayerGui(param1:Boolean) : void
        {
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI);
            var _loc_3:* = param1 == true ? (1) : (0);
            if (_loc_3 == 1)
            {
                _loc_2.visible = true;
            }
            TweenMax.to(_loc_2, 0.2, {alpha:_loc_3, onComplete:this.onCompleteshowLayerGui, onCompleteParams:[_loc_2]});
            return;
        }// end function

        private function onCompleteshowLayerGui(param1:Layer) : void
        {
            param1.visible = param1.alpha == 0 ? (false) : (true);
            return;
        }// end function

        public function destroySpriteList() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.spriteList.length)
            {
                
                this.spriteList[_loc_1].parent.removeChild(this.spriteList[_loc_1]);
                this.spriteList[_loc_1] = null;
                _loc_1++;
            }
            this.spriteList = new Vector.<Sprite>;
            return;
        }// end function

        public function sendLevelUp() : void
        {
            return;
        }// end function

        private function onGetFinishBuilding(param1:MsgInfo) : void
        {
            var _loc_3:MapObject = null;
            var _loc_2:* = new FinishBuildingMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                _loc_3 = GameDataMgr.getInstance().getBuildingByAutoId(_loc_2.autoId);
                if (_loc_3)
                {
                    _loc_3.hasSent = false;
                }
                this.sendGetCurTime();
            }
            else
            {
                _loc_3 = GameDataMgr.getInstance().getBuildingByAutoId(_loc_2.autoId);
                if (_loc_3)
                {
                    _loc_3.finishBuilding(_loc_3.finishType);
                }
            }
            return;
        }// end function

        private function onGetSingleEnd(param1:MsgInfo) : void
        {
            var _loc_2:* = new SingleEndMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                this.guiFindMath.guiSingleMap.updateSingleMap(_loc_2.currentLevel);
            }
            return;
        }// end function

        private function onGetEndAttack(param1:MsgInfo) : void
        {
            var _loc_2:* = new EndAttackMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else if (this.guiWarning.beingAttack)
            {
                this.reloadGame();
            }
            return;
        }// end function

        private function onGetBattleEnd(param1:MsgInfo) : void
        {
            var _loc_2:* = new BattleEndMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            return;
        }// end function

        public function sendChargeCard(param1:String, param2:String, param3:String) : void
        {
            var _loc_4:* = Localization.getInstance().getString("ChargeCard0");
            var _loc_5:* = Localization.getInstance().getString("ChargeCard1");
            this.guiPopup.showLoading(_loc_4, _loc_5);
            var _loc_6:* = new ChargeCardCmd();
            new ChargeCardCmd().type = param1;
            _loc_6.code = param2;
            _loc_6.serial = param3;
            bzConnector.send(_loc_6);
            return;
        }// end function

        private function onGetChargeCard(param1:MsgInfo) : void
        {
            var _loc_3:String = null;
            this.guiPopup.hide(true);
            var _loc_2:* = new ChargeCardMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 1)
            {
                _loc_3 = Localization.getInstance().getString("ChargeCardResult_" + _loc_2.errorCode);
                if (!_loc_3)
                {
                    _loc_3 = Localization.getInstance().getString("ChargeCardResult");
                }
                this.showMessage(Localization.getInstance().getString("ChargeCard0"), _loc_3, "Thử lại", null, null, false);
            }
            else if (_loc_2.coin >= 0)
            {
                GameDataMgr.getInstance().setMoney(MoneyType.COIN, _loc_2.coin);
                this.guiPopup.showChargeCardSuccess(_loc_2.coin);
            }
            return;
        }// end function

        private function onGetUpdateCoin(param1:MsgInfo) : void
        {
            var _loc_2:* = new UpdateCoinMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else if (_loc_2.coin >= 0)
            {
                if (!GameDataMgr.getInstance().myInfo.isChargedUser)
                {
                    GameDataMgr.getInstance().myInfo.isChargedUser = true;
                    this.guiMainTopRight.bmpThongBao.visible = false;
                }
                GameDataMgr.getInstance().setMoney(MoneyType.COIN, _loc_2.coin);
                this.guiPopup.showChargeCardSuccess(_loc_2.coin);
            }
            return;
        }// end function

        public function pushCmd(param1:Object) : void
        {
            this.listCmd.push(param1);
            return;
        }// end function

        public function traceListCmd() : void
        {
            return;
        }// end function

        private function onGetCurrentTime(param1:MsgInfo) : void
        {
            var _loc_2:* = new GetCurTimeMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
            }
            else
            {
                Utility.setCurTime(_loc_2.curTime);
            }
            return;
        }// end function

        public function prepareToSell(param1:MapObject) : void
        {
            if (!param1)
            {
                return;
            }
            var _loc_2:* = Utility.getInfoToBuild(param1.type, 1);
            _loc_2.cost.value = _loc_2.cost.value * TrapObject(param1).info.sellRate;
            var _loc_3:* = param1.status == MapObject.BUILDING ? (Command.CANCEL_PLACING) : (Command.CANCEL_UPGRADING);
            var _loc_4:* = Localization.getInstance().getString("SellBuildingTitle");
            var _loc_5:* = Localization.getInstance().getString("SellBuildingMsg");
            _loc_5 = Localization.getInstance().getString("SellBuildingMsg").replace("@name", Localization.getInstance().getString(param1.type));
            _loc_5 = _loc_5.replace("@money", Utility.standardNumber(_loc_2.cost.value));
            _loc_5 = _loc_5.replace("@type", Localization.getInstance().getString(_loc_2.cost.type));
            this.guiPopup.showConfirmBox(_loc_4, _loc_5, "BÁN", this.sellBuilding, this.showBuildingActionGui, [param1, _loc_2.cost], [param1]);
            return;
        }// end function

        public function sellBuilding(param1:MapObject, param2:MoneyType) : void
        {
            if (!param1)
            {
                return;
            }
            var _loc_3:* = Utility.getStorageType(param2.type);
            var _loc_4:* = GameDataMgr.getInstance().getTotalResourceStorage(_loc_3);
            var _loc_5:* = GameDataMgr.getInstance().getMoney(param2.type);
            if (GameDataMgr.getInstance().getMoney(param2.type) + param2.value <= _loc_4)
            {
                GameDataMgr.getInstance().addMoney(param2.type, param2.value);
                GameDataMgr.getInstance().removeBuilding(param1);
                this.sendCancelBuilding(param1.autoId, param1.type, Command.CANCEL_PLACING);
            }
            else
            {
                this.showNotEnoughResoureStorages(param2.type, "2");
            }
            return;
        }// end function

        public function sendSearchClan(param1:String) : void
        {
            var _loc_2:* = new SearchClanCmd();
            _loc_2.key = param1;
            bzConnector.send(_loc_2);
            return;
        }// end function

        private function onGetUserKickedMsg(param1:MsgInfo) : void
        {
            var _loc_3:UserInfo = null;
            var _loc_4:String = null;
            var _loc_5:String = null;
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            var _loc_2:* = new UserKickedMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                _loc_3 = GameDataMgr.getInstance().myInfo;
                if (_loc_3.uId == _loc_2.userId)
                {
                    _loc_4 = Localization.getInstance().getString("Title_TB");
                    _loc_5 = Localization.getInstance().getString("ClanMsgKickedOut");
                    this.guiPopup.showMessageBox(_loc_4, _loc_5, "ĐÓNG", null);
                    GameDataMgr.getInstance().leaveClan();
                    this.guiDonateTroop.hide();
                    this.hideClanGui();
                }
            }
            return;
        }// end function

        private function onGetUserLeaveClan(param1:MsgInfo) : void
        {
            var _loc_3:String = null;
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            var _loc_2:* = new UserLeaveClanMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                _loc_3 = Localization.getInstance().getString("ClanMsg8");
                if (GameDataMgr.getInstance().myClanMembers[_loc_2.userId])
                {
                    this.guiContentChat.removeAllItemOfPlayer(_loc_2.userId);
                }
            }
            return;
        }// end function

        private function onGetMemberChangedTitle(param1:MsgInfo) : void
        {
            var _loc_2:* = new MemberChangedTitleMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                GameDataMgr.getInstance().changeMemberTitle(_loc_2.memberId, _loc_2.newTitle, _loc_2.promotingId);
            }
            return;
        }// end function

        private function onGetSearchClan(param1:MsgInfo) : void
        {
            var _loc_2:* = new GetClansMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else if (this.guiClan.isShowing)
            {
                this.guiClan.guiSearchClan.loadClans(_loc_2.list);
            }
            else if (this.guiRanking.isShowing)
            {
                this.guiRanking.guiSearchClan.loadClans(_loc_2.list);
            }
            return;
        }// end function

        public function sendClearRIP() : void
        {
            this.hasSendClearRIP = true;
            var _loc_1:* = new BaseCmd(Command.CLEAR_RIP);
            bzConnector.send(_loc_1);
            return;
        }// end function

        public function cityTroopGoAway(param1:String) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.troopList.length)
            {
                
                if (this.troopList[_loc_2].troopId == param1 && !this.troopList[_loc_2].isBelongClan)
                {
                    this.troopList[_loc_2].moveToIso(new Point(MapMgr.getInstance().battleMap.maxRow - 2, MapMgr.getInstance().battleMap.maxCol / 2));
                    this.troopList[_loc_2].isBelongClan = true;
                    break;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function cityTroopJoinClan(param1:Troop) : void
        {
            var _loc_2:* = new CityTroop();
            _loc_2.setInfo(param1.type, param1.level, 0, 0);
            if (this.troopList.length > 0)
            {
                _loc_2.troopIndex = this.troopList[(this.troopList.length - 1)].troopIndex + 1;
            }
            _loc_2.isBelongClan = true;
            _loc_2.move.curCell = MapMgr.getInstance().battleMap.isoToCell(MapMgr.getInstance().battleMap.maxRow - 2, MapMgr.getInstance().battleMap.maxCol - 2);
            _loc_2.moveToIso(new Point(GameDataMgr.getInstance().clanCastle.posX * 3 + 9, GameDataMgr.getInstance().clanCastle.posY * 3 + 9));
            this.troopList.push(_loc_2);
            return;
        }// end function

        public function showGuiRanking() : void
        {
            this.guiRanking.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        public function sendGetRankingList() : void
        {
            var _loc_1:* = new GetRankingList();
            bzConnector.send(_loc_1);
            return;
        }// end function

        public function editClan(param1:ClanInfo) : void
        {
            var _loc_2:* = new CreateClanCmd();
            _loc_2.typeId = Command.EDIT_CLAN;
            _loc_2.name = param1.name;
            _loc_2.icon = param1.icon;
            _loc_2.type = param1.type;
            _loc_2.requiredTrophy = param1.requiredTrophy;
            _loc_2.description = param1.description;
            bzConnector.send(_loc_2);
            this.hideClanGui();
            return;
        }// end function

        private function onGetRankingListMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new RankingListMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                this.guiRanking.loadTopPlayers(_loc_2);
            }
            return;
        }// end function

        private function onGetClearRIP(param1:MsgInfo) : void
        {
            var _loc_2:* = new GetClansMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
                this.hasSendClearRIP = false;
            }
            else
            {
                this.clearRIP();
            }
            return;
        }// end function

        private function onGetBuyShield(param1:MsgInfo) : void
        {
            var _loc_2:* = new BuyShieldMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                this.addShield();
            }
            return;
        }// end function

        private function addShield() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().saveShieldId;
            var _loc_2:* = JsonMgr.getInstance().getShieldData(_loc_1);
            var _loc_3:* = _loc_2.cdown * 3600 * 24;
            GameDataMgr.getInstance().myInfo.shieldList[(_loc_1 - 1)] = Utility.getCurTime() + _loc_3;
            GameDataMgr.getInstance().addShieldTime(_loc_2.days * 3600 * 24);
            GameDataMgr.getInstance().addMoney(MoneyType.COIN, -_loc_2.coin);
            return;
        }// end function

        private function clearRIP() : void
        {
            var _loc_4:Sprite = null;
            var _loc_5:TooltipText = null;
            var _loc_6:int = 0;
            var _loc_1:* = GameDataMgr.getInstance().graveStoneList;
            GameDataMgr.getInstance().addMoney(MoneyType.ELIXIR, _loc_1.length * 20);
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            var _loc_3:int = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                _loc_4 = new Sprite();
                _loc_5 = new TooltipText(false, true, true, 29);
                _loc_5.textColor = 16711935;
                _loc_5.text = "20";
                _loc_4.addChild(_loc_5);
                _loc_4.x = _loc_1[_loc_3].x;
                _loc_4.y = _loc_1[_loc_3].y;
                _loc_4.alpha = 0.7;
                _loc_2.addChild(_loc_4);
                TweenMax.to(_loc_4, 1, {alpha:0, bezier:[{x:_loc_4.x, y:_loc_4.y - 150}]});
                TweenMax.to(_loc_1[_loc_3], 1, {alpha:0, onComplete:this.onCompleteClearRIP, onCompleteParams:[_loc_1[_loc_3], _loc_4]});
                _loc_6 = MapMgr.getInstance().cityMap.pointToCell(_loc_1[_loc_3].x, _loc_1[_loc_3].y);
                MapMgr.getInstance().cityMap.setCellType(_loc_6, 0);
                _loc_3++;
            }
            _loc_1.splice(0, _loc_1.length);
            return;
        }// end function

        private function onCompleteClearRIP(param1:Sprite, param2:Sprite) : void
        {
            if (param1 && param1.parent)
            {
                param1.parent.removeChild(param1);
                param1.visible = false;
                param1 = null;
            }
            if (param2 && param2.parent)
            {
                param2.parent.removeChild(param2);
                param2.visible = false;
                param2 = null;
            }
            this.hasSendClearRIP = false;
            return;
        }// end function

        public function visitPlayer(param1:int) : void
        {
            GameDataMgr.getInstance().curObject = null;
            this.setState(GlobalVar.STATE_FRIEND);
            this.sendVisitFriend(param1);
            return;
        }// end function

        public function acceptBuyShield(param1:int) : void
        {
            var _loc_4:BuyShieldCmd = null;
            var _loc_2:* = JsonMgr.getInstance().getShieldData(param1);
            var _loc_3:* = GameDataMgr.getInstance().getMoney(MoneyType.COIN);
            if (_loc_3 >= _loc_2.coin)
            {
                GameDataMgr.getInstance().saveShieldId = param1;
                _loc_4 = new BuyShieldCmd();
                _loc_4.shieldId = param1;
                bzConnector.send(_loc_4);
            }
            else
            {
                this.showShopBuyG();
            }
            return;
        }// end function

        private function onGetUpdateMoney(param1:MsgInfo) : void
        {
            var _loc_2:* = new UpdateMoneyMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                GameDataMgr.getInstance().setMoney(MoneyType.COIN, _loc_2.coin);
            }
            return;
        }// end function

        private function onGetLevelUp(param1:MsgInfo) : void
        {
            var _loc_2:* = new LevelUpMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode != 0)
            {
                this.showErrorCode(_loc_2.errorCode);
            }
            else
            {
                this.guiLevelUp.showLevelUp(_loc_2.level);
                if (_loc_2.level >= FeedMgr.LEVEL_PLAYER)
                {
                    FeedMgr.getInstance().sendRequestFeedWall(FeedMgr.UP_LEVEL);
                }
            }
            return;
        }// end function

        private function onGetFinishTrainTroop(param1:MsgInfo) : void
        {
            var _loc_2:* = new FinishTrainTroopMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            this.guiTrainTroop.onGetFinishTrainTroop(_loc_2);
            return;
        }// end function

        public function getWallList(param1:MapObject, param2:int) : Vector.<WallObject>
        {
            var _loc_9:WallObject = null;
            var _loc_3:* = GameDataMgr.getInstance().wallList;
            var _loc_4:* = new Vector.<WallObject>;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            if (param2 == 0)
            {
                _loc_5 = 1;
            }
            else
            {
                _loc_6 = 1;
            }
            var _loc_7:* = param1.posX;
            var _loc_8:* = param1.posY;
            var _loc_10:* = MapMgr.getInstance().cityMap.maxRow;
            while (_loc_7 <= _loc_10)
            {
                
                _loc_7 = _loc_7 + _loc_5;
                _loc_8 = _loc_8 + _loc_6;
                _loc_9 = GameDataMgr.getInstance().getWallAt(_loc_7, _loc_8);
                if (_loc_9)
                {
                    _loc_4.push(_loc_9);
                    continue;
                }
                break;
            }
            _loc_7 = param1.posX;
            _loc_8 = param1.posY;
            while (_loc_7 >= 0)
            {
                
                _loc_7 = _loc_7 - _loc_5;
                _loc_8 = _loc_8 - _loc_6;
                _loc_9 = GameDataMgr.getInstance().getWallAt(_loc_7, _loc_8);
                if (_loc_9)
                {
                    _loc_4.push(_loc_9);
                    continue;
                }
                break;
            }
            return _loc_4;
        }// end function

        public function sendGetTransitionID() : void
        {
            var _loc_1:* = new GetTransactionId();
            bzConnector.send(_loc_1);
            return;
        }// end function

        public function disconnect() : void
        {
            bzConnector.disconnect();
            return;
        }// end function

        private function onGetTransitionIDMsg(param1:MsgInfo) : void
        {
            var _loc_2:* = new GetTransitionIDMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                this.makeHTTPRequestToPayment(_loc_2.transId, _loc_2.appId, _loc_2.appData);
            }
            return;
        }// end function

        private function makeHTTPRequestToPayment(param1:Number, param2:int, param3:String) : void
        {
            var _loc_4:* = new URLRequest(GlobalVar.SUBMIT_TRANS_URL);
            new URLRequest(GlobalVar.SUBMIT_TRANS_URL).method = URLRequestMethod.POST;
            var _loc_5:* = new URLVariables();
            new URLVariables().transId = param1;
            _loc_5.appId = param2;
            _loc_5.appData = param3;
            _loc_4.data = _loc_5;
            var _loc_6:* = new URLLoader();
            new URLLoader().load(_loc_4);
            return;
        }// end function

        private function onGetServerMaintain(param1:MsgInfo) : void
        {
            var _loc_3:Layer = null;
            var _loc_2:* = new ServerMaintainMsg(param1.Data);
            this.timeToMaintain = Utility.getCurTime() + _loc_2.time;
            if (!this.notifyMaintain)
            {
                this.notifyMaintain = new TooltipText(true, true, true, 30);
                _loc_3 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_LOADING);
                _loc_3.addChild(this.notifyMaintain);
                this.notifyMaintain.textColor = 13762560;
            }
            return;
        }// end function

        public function sendDisconect() : void
        {
            var _loc_1:* = new SendDisconectCmd();
            bzConnector.send(_loc_1);
            return;
        }// end function

        public function sendBetaUserPromote() : void
        {
            var _loc_1:* = new BetaUserPromoteCmd();
            bzConnector.send(_loc_1);
            return;
        }// end function

        public function sendBetaPayUserPromote() : void
        {
            var _loc_1:* = new BetaUserPromoteCmd();
            _loc_1.typeId = Command.BETA_PAY_USER_PROMO_RECEIVED;
            bzConnector.send(_loc_1);
            return;
        }// end function

        private function onGetBetaUserPromote(param1:MsgInfo) : void
        {
            var _loc_2:* = new BetaUserPromoteMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                this.guiPromoteLevel.setPromoteG(_loc_2.promoteG);
                this.guiPromoteLevel.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_LOADING), true);
                GameDataMgr.getInstance().setMoney(MoneyType.COIN, _loc_2.coin);
            }
            return;
        }// end function

        private function onGetPromoG(param1:MsgInfo) : void
        {
            var _loc_2:* = new PromoGMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                GameDataMgr.getInstance().setMoney(MoneyType.COIN, _loc_2.coin);
                this.guiPopup.showPromoSuccess(_loc_2.promoG, _loc_2.coin);
            }
            return;
        }// end function

        private function onGetBetaPayUserPromote(param1:MsgInfo) : void
        {
            var _loc_2:* = new BetaUserPromoteMsg(param1.Data);
            logger.debug("msg", ErrorCode.getReason(_loc_2.errorCode));
            if (_loc_2.errorCode == 0)
            {
                this.guiPromotePayG.setPromoteG(_loc_2.promoteG);
                this.guiPromotePayG.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_LOADING), true);
                GameDataMgr.getInstance().setMoney(MoneyType.COIN, _loc_2.coin);
            }
            return;
        }// end function

        public function sendTurnSound() : void
        {
            var _loc_1:* = new BaseCmd();
            _loc_1.typeId = Command.UPDATE_SOUND_SETTING;
            bzConnector.send(_loc_1);
            return;
        }// end function

        public function sendTurnMusic() : void
        {
            var _loc_1:* = new BaseCmd();
            _loc_1.typeId = Command.UPDATE_MUSIC_SETTING;
            bzConnector.send(_loc_1);
            return;
        }// end function

        public static function getInstance() : CityMgr
        {
            if (_inst == null)
            {
                _inst = new CityMgr;
            }
            return _inst;
        }// end function

    }
}
