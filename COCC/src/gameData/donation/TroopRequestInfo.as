package gameData.donation
{
    import __AS3__.vec.*;
    import modules.battle.data.*;

    public class TroopRequestInfo extends Object
    {
        public var requestId:int;
        public var msg:String;
        public var created:Number;
        public var curCapacity:int;
        public var maxCapacity:int;
        public var myDonation:Vector.<Troop>;

        public function TroopRequestInfo()
        {
            this.myDonation = new Vector.<Troop>;
            return;
        }// end function

    }
}
