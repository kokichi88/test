package gameData
{
    import __AS3__.vec.*;
    import gameData.clan.*;

    public class UserInfo extends Object
    {
        public var uId:int;
        public var uName:String = "";
        public var uAvatar:String = "";
        public var exp:int;
        public var level:int;
        public var trophy:int;
        public var gold:int;
        public var coin:int;
        public var elixir:int;
        public var darkElixir:int;
        public var lastTimeLogin:Number = 0;
        public var shieldTime:Number = 0;
        public var attackingTime:Number = 0;
        public var builderList:Vector.<DataBuilder>;
        public var shieldList:Array;
        public var topAutoId:int;
        public var clanInfo:ClanInfo;
        public var tutStep:int;
        public var townHallLevel:int = 1;
        public var isChargedUser:Boolean;
        public var sound:int;
        public var music:int;

        public function UserInfo()
        {
            this.builderList = new Vector.<DataBuilder>;
            this.shieldList = new Array();
            this.clanInfo = new ClanInfo();
            return;
        }// end function

    }
}
