package modules.city.logic
{
    import component.avatar.controls.*;
    import flash.geom.*;
    import gameData.*;
    import modules.city.*;
    import modules.feed.*;
    import resMgr.*;
    import resMgr.data.*;

    public class TownHallObject extends MapObject
    {
        public var info:DataTownHall;
        public var curResource:int;

        public function TownHallObject()
        {
            return;
        }// end function

        override public function loadConfigData() : void
        {
            this.info = JsonMgr.getInstance().getTownHallData(level);
            width = this.info.width;
            height = this.info.height;
            if ((level + 1) <= JsonMgr.getInstance().getConfigMaxLevel(type))
            {
                buildTimeNextLevel = JsonMgr.getInstance().townHall[BuildingType.TOWN_HALL][(level + 1)]["buildTime"];
            }
            else
            {
                buildTimeNextLevel = 0;
            }
            return;
        }// end function

        override public function addToCity(param1:Boolean = false) : void
        {
            super.addToCity(param1);
            if (GlobalVar.state == GlobalVar.STATE_MYHOME)
            {
                GameDataMgr.getInstance().myInfo.townHallLevel = level;
            }
            if (status != BUILDING)
            {
                this.addeffectFire();
            }
            return;
        }// end function

        public function addeffectFire() : void
        {
            switch(level)
            {
                case 7:
                {
                    CityMgr.getInstance().effectList.push(EffectDraw.play("towhall_flame", new Point(50, 51), avatar, 0));
                    CityMgr.getInstance().effectList.push(EffectDraw.play("towhall_flame", new Point(85, 25), avatar, 0));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function finishBuilding(param1:int) : void
        {
            super.finishBuilding(param1);
            if (GlobalVar.state == GlobalVar.STATE_MYHOME)
            {
                GameDataMgr.getInstance().myInfo.townHallLevel = level;
                if (level >= FeedMgr.LEVEL_TOWNHALL)
                {
                    FeedMgr.getInstance().sendRequestFeedWall(FeedMgr.UP_LEVEL_TOWNHALL);
                }
            }
            return;
        }// end function

    }
}
