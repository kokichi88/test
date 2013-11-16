package resMgr.data
{
    import gameData.*;

    public class DataBuildingInfo extends Object
    {
        public var buildTime:int;
        public var cost:MoneyType;
        public var curCount:int;
        public var maxCount:int;
        public var type:String;
        public var townHallLevelRequired:int = 0;

        public function DataBuildingInfo()
        {
            this.cost = new MoneyType();
            return;
        }// end function

    }
}
