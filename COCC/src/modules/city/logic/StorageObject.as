package modules.city.logic
{
    import gameData.*;
    import modules.city.graphics.tutorial.*;
    import resMgr.*;
    import resMgr.data.*;

    public class StorageObject extends MapObject
    {
        public var info:DataStorages;
        public var curResource:int;

        public function StorageObject()
        {
            return;
        }// end function

        override public function loadConfigData() : void
        {
            this.info = JsonMgr.getInstance().getStoragesData(type, level);
            width = this.info.width;
            height = this.info.height;
            if ((level + 1) <= JsonMgr.getInstance().getConfigMaxLevel(type))
            {
                buildTimeNextLevel = JsonMgr.getInstance().storage[type][(level + 1)]["buildTime"];
            }
            else
            {
                buildTimeNextLevel = 0;
            }
            return;
        }// end function

        override public function finishBuilding(param1:int) : void
        {
            super.finishBuilding(param1);
            GameDataMgr.getInstance().updateMaxCapacity();
            if (TutorialMgr.getInstance().isTutorial)
            {
                if (type == BuildingType.ELIXIR_STORAGE)
                {
                    GameDataMgr.getInstance().addMoney(MoneyType.ELIXIR, 1500);
                }
                if (type == BuildingType.GOLD_STORAGE)
                {
                    GameDataMgr.getInstance().addMoney(MoneyType.GOLD, 1500);
                }
            }
            return;
        }// end function

        public function update() : void
        {
            var _loc_1:* = this.curResource / this.info.capacity * 100;
            var _loc_2:int = 5;
            if (_loc_1 <= 19)
            {
                _loc_2 = 5;
            }
            else if (_loc_1 <= 45)
            {
                _loc_2 = 6;
            }
            else if (_loc_1 <= 75)
            {
                _loc_2 = 7;
            }
            else
            {
                _loc_2 = 8;
            }
            avatar.setAction(avatar.anSetting.currAction, _loc_2);
            return;
        }// end function

    }
}
