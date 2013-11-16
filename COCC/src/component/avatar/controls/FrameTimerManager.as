package component.avatar.controls
{
    import flash.utils.*;

    public class FrameTimerManager extends Object
    {
        private static var dic:Dictionary = new Dictionary();
        public static var isActivate:Boolean = true;
        private static var timerDic:Dictionary = new Dictionary();

        public function FrameTimerManager()
        {
            return;
        }// end function

        public static function getInstance(param1:String = "default") : FrameTimer
        {
            if (dic[param1] == null)
            {
                dic[param1] = new FrameTimer();
            }
            return dic[param1];
        }// end function

        public static function freeInstance(param1:String = "default") : void
        {
            delete dic[param1];
            return;
        }// end function

        public static function getTimer(param1:String = "default") : FrameTimer
        {
            if (timerDic[param1] == null)
            {
                timerDic[param1] = new FrameTimer(true, 1000);
            }
            return timerDic[param1];
        }// end function

        public static function freeTimer(param1:String = "default") : void
        {
            delete timerDic[param1];
            return;
        }// end function

        public static function jsTimer() : void
        {
            if (isActivate)
            {
                return;
            }
            var _loc_1:* = null;
            for each (_loc_1 in dic)
            {
                
                _loc_1.onHandler();
            }
            return;
        }// end function

    }
}
