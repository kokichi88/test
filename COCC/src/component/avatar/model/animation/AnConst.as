package component.avatar.model.animation
{

    public class AnConst extends Object
    {
        public static const STAND:int = 0;
        public static const RUN:int = 1;
        public static const ATTACK:int = 2;
        public static const HELLO:int = 3;
        public static const DIE:int = 4;
        public static const WORKING:int = 5;
        public static const BUILD:int = 6;
        public static const RE_FIND:int = 7;
        public static const UP:int = 1;
        public static const RIGHT_DOWN:int = 4;
        public static const REST:int = 5;
        public static const LEFT_DOWN:int = 6;
        public static const LEFT:int = 7;
        public static const LEFT_UP:int = 8;
        public static var actionArr:Array = [STAND, RUN, ATTACK, HELLO, DIE, WORKING, BUILD];
        public static var PEOPLE_HEIGHT:int = 120;
        public static var PEOPLE_WIDTH:int = 120;
        public static var dirArr:Array = [DOWN, LEFT_DOWN, LEFT, LEFT_UP, UP, RIGHT_UP, RIGHT, RIGHT_DOWN];
        public static const DOWN:int = 5;
        public static const RIGHT:int = 3;
        public static const RIGHT_UP:int = 2;

        public function AnConst()
        {
            return;
        }// end function

    }
}
