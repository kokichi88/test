package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import gameData.*;

    public class PlayerInfoMsg extends BaseMsg
    {
        public var uId:int;
        public var uName:String;
        public var uAvatar:String;
        public var exp:int;
        public var level:int;
        public var trophy:int;
        public var gold:int;
        public var coin:int;
        public var elixir:int;
        public var darkElixir:int;
        public var lastTimeLogin:Number;
        public var shieldTime:Number;
        public var attackingTime:Number;
        public var builderList:Vector.<DataBuilder>;
        public var shieldList:Array;
        public var currentTime:Number;
        public var topAutoId:int;
        public var tutStep:int;
        public var isChargedUser:Boolean;
        public var sound:int;
        public var music:int;

        public function PlayerInfoMsg(param1:Object)
        {
            this.builderList = new Vector.<DataBuilder>;
            this.shieldList = new Array();
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:DataBuilder = null;
            errorCode = readInt();
            this.uId = readInt();
            this.uName = readStr();
            this.uAvatar = readStr();
            this.exp = readInt();
            this.level = readInt();
            this.trophy = readInt();
            this.gold = readInt();
            this.coin = readLong();
            this.elixir = readInt();
            this.darkElixir = readInt();
            this.lastTimeLogin = readLong();
            this.shieldTime = readLong();
            this.shieldList[0] = readLong();
            this.shieldList[1] = readLong();
            this.shieldList[2] = readLong();
            this.attackingTime = readLong();
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new DataBuilder();
                _loc_3.buildingAutoId = readInt();
                _loc_3.buildingType = readStr();
                _loc_3.endTime = readLong();
                this.builderList.push(_loc_3);
                _loc_2++;
            }
            this.currentTime = readLong();
            this.topAutoId = readInt();
            this.tutStep = readInt();
            this.isChargedUser = readBoolean();
            this.sound = readInt();
            this.music = readInt();
            return true;
        }// end function

    }
}
