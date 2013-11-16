package modules.replay.data
{
    import __AS3__.vec.*;
    import modules.battle.data.*;

    public class LogBattleData extends Object
    {
        public var keyLog:int;
        public var uId:int;
        public var uName:String;
        public var clanName:String;
        public var clanIcon:int;
        public var gold:int;
        public var elixir:int;
        public var darkElixir:int;
        public var trophy:int;
        public var retTrophy:int;
        public var nStar:int;
        public var percentLife:int;
        public var startTime:Number;
        public var endTime:Number;
        public var useClan:Boolean;
        public var level:int;
        public var listTroop:Vector.<Troop>;
        public var isReplay:Boolean;
        public var isRevenge:Boolean;

        public function LogBattleData()
        {
            this.listTroop = new Vector.<Troop>;
            return;
        }// end function

    }
}
