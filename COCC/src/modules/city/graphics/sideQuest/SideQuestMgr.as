package modules.city.graphics.sideQuest
{
    import flash.display.*;
    import flash.geom.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.graphics.effectSeed.*;
    import network.receive.*;
    import resMgr.*;
    import utility.*;

    public class SideQuestMgr extends Object
    {
        public var questList:Object;
        public var curQuest:String = null;
        private static var _inst:SideQuestMgr;

        public function SideQuestMgr()
        {
            var _loc_2:DataSideQuest = null;
            this.questList = new Object();
            var _loc_1:int = 0;
            while (_loc_1 < GlobalVar.MAX_QUEST_TYPE)
            {
                
                _loc_2 = new DataSideQuest();
                _loc_2.questType = GlobalVar.SIDE_QUEST[_loc_1];
                this.questList[_loc_2.questType] = _loc_2;
                _loc_1++;
            }
            return;
        }// end function

        public function updateQuest(param1:int, param2:String, param3:int = 1) : void
        {
            var _loc_5:String = null;
            var _loc_4:int = 0;
            while (_loc_4 < GlobalVar.MAX_QUEST_TYPE)
            {
                
                _loc_5 = GlobalVar.SIDE_QUEST[_loc_4];
                if (this.questList[_loc_5].actionId == param1)
                {
                    if (this.questList[_loc_5].actionParam == param2)
                    {
                        this.questList[_loc_5].currentAmount = this.questList[_loc_5].currentAmount + param3;
                        CityMgr.getInstance().guiSideQuest.upadteQuestStatus();
                        break;
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        public function updateQuestInfo(param1:QuestInfoMsg) : void
        {
            var _loc_3:String = null;
            var _loc_4:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < GlobalVar.MAX_QUEST_TYPE)
            {
                
                _loc_3 = GlobalVar.SIDE_QUEST[_loc_2];
                _loc_4 = 0;
                while (_loc_4 < param1.questList.length)
                {
                    
                    if (this.questList[_loc_3].questType == param1.questList[_loc_4].questType)
                    {
                        this.questList[_loc_3].currentAmount = param1.questList[_loc_4].currentAmount;
                        if (param1.questList[_loc_4].id == 0)
                        {
                            param1.questList[_loc_4].id = 1;
                        }
                        this.questList[_loc_3].id = param1.questList[_loc_4].id;
                        this.loadQuestConfig(_loc_3);
                        break;
                    }
                    _loc_4++;
                }
                _loc_2++;
            }
            CityMgr.getInstance().guiSideQuest.upadteQuestStatus(true);
            return;
        }// end function

        public function loadQuestConfig(param1:String) : void
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_2:* = JsonMgr.getInstance().getDataQuest(param1, this.questList[param1].id);
            if (_loc_2)
            {
                this.questList[param1].questName = Localization.getInstance().getString(param1 + "_" + _loc_2.id);
                this.questList[param1].questName = this.questList[param1].questName.replace("@number@", _loc_2.requiredAmount);
                if (_loc_2.actionParam && _loc_2.actionParam != "")
                {
                    _loc_3 = _loc_2.actionParam.split("@");
                    _loc_4 = 0;
                    while (_loc_4 < _loc_3.length)
                    {
                        
                        this.questList[param1].questName = this.questList[param1].questName.replace("@param" + (_loc_4 + 1) + "@", _loc_3[_loc_4]);
                        _loc_4++;
                    }
                }
                this.questList[param1].actionParam = _loc_2.actionParam;
                this.questList[param1].actionId = _loc_2.actionId;
                this.questList[param1].requiredAmount = _loc_2.requiredAmount;
                this.questList[param1].requiredQuest = _loc_2.requiredQuest;
                this.questList[param1].id = _loc_2.id;
                this.questList[param1].exp = _loc_2.exp;
                this.questList[param1].coin = _loc_2.coin;
            }
            else
            {
                this.questList[param1].id = 999;
            }
            return;
        }// end function

        public function isQuestFinished(param1:String) : Boolean
        {
            if (this.questList[param1].currentAmount >= this.questList[param1].requiredAmount)
            {
                return true;
            }
            return false;
        }// end function

        public function isQuestAvaiable(param1:String, param2:int = 0) : Boolean
        {
            var _loc_3:Array = null;
            if (this.questList[param1].id < 1)
            {
                return false;
            }
            if (this.questList[param1].id == 999)
            {
                return false;
            }
            if (this.questList[param1].requiredQuest != "")
            {
                _loc_3 = this.questList[param1].requiredQuest.split("_");
                return this.questList[_loc_3[0]].id > _loc_3[1];
            }
            if (param2 > 0)
            {
                return this.questList[param1].actionId == param2;
            }
            return true;
        }// end function

        public function claimCurrentReward() : void
        {
            if (!this.curQuest)
            {
                return;
            }
            var _loc_1:* = new MoneyType();
            var _loc_2:* = Localization.getInstance().getString("ReceiveReward");
            if (this.questList[this.curQuest].exp > 0)
            {
                _loc_1.type = MoneyType.EXP;
                _loc_1.value = this.questList[this.curQuest].exp;
                GameDataMgr.getInstance().addExp(_loc_1.value);
            }
            else
            {
                _loc_2 = _loc_2 + (" " + this.questList[this.curQuest].coin + " " + Localization.getInstance().getString("Coin"));
                _loc_1.type = MoneyType.COIN;
                _loc_1.value = this.questList[this.curQuest].coin;
                GameDataMgr.getInstance().addMoney(MoneyType.COIN, this.questList[this.curQuest].coin);
            }
            CityMgr.getInstance().guiNotify.addReceiveMoney(_loc_1);
            this.curQuest = null;
            this.runIconEff(_loc_1.type);
            return;
        }// end function

        public function runIconEff(param1:String) : void
        {
            var _loc_5:Point = null;
            var _loc_2:* = CityMgr.getInstance().guiSideQuest.getPos();
            var _loc_3:* = CityMgr.getInstance().guiSideQuest.guiSideQuestBoard.getPos();
            var _loc_4:* = CityMgr.getInstance().guiSideQuest.guiSideQuestBoard.iconReward;
            if (!CityMgr.getInstance().guiSideQuest.guiSideQuestBoard.iconReward)
            {
                return;
            }
            _loc_2.x = _loc_2.x + (_loc_3.x + _loc_4.x);
            _loc_2.y = _loc_2.y + (_loc_3.y + _loc_4.y);
            if (param1 == MoneyType.EXP)
            {
                _loc_5 = CityMgr.getInstance().guiMainTopLeft.getPos();
                CityMgr.getInstance().guiMainTopLeft.getPos().x = _loc_5.x + CityMgr.getInstance().guiMainTopLeft.labelExp.x;
                _loc_5.y = _loc_5.y + CityMgr.getInstance().guiMainTopLeft.labelExp.y;
            }
            else
            {
                _loc_5 = CityMgr.getInstance().guiMainTopRight.getPos();
                CityMgr.getInstance().guiMainTopRight.getPos().x = _loc_5.x + (CityMgr.getInstance().guiMainTopRight.imageG.x - _loc_4.width / 2);
                _loc_5.y = _loc_5.y + (CityMgr.getInstance().guiMainTopRight.imageG.y - _loc_4.height / 2);
            }
            var _loc_6:* = new IconEffectSeed();
            _loc_6.create("image_" + param1, _loc_2, _loc_5);
            return;
        }// end function

        public static function getInstance() : SideQuestMgr
        {
            if (_inst == null)
            {
                _inst = new SideQuestMgr;
            }
            return _inst;
        }// end function

    }
}
