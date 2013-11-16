package gameData
{

    public class MoneyType extends Object
    {
        public var type:String;
        public var value:int;
        public static var GOLD:String = "Gold";
        public static var ELIXIR:String = "Elixir";
        public static var DARK_ELIXIR:String = "DarkElixir";
        public static var COIN:String = "Coin";
        public static var EXP:String = "Exp";
        public static var TIME:String = "Time";

        public function MoneyType(param1:String = "Gold", param2:int = 0)
        {
            this.type = param1;
            this.value = param2;
            return;
        }// end function

    }
}
