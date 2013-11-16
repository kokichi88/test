package modules
{
    import map.*;
    import modules.battle.*;
    import modules.city.*;
    import modules.feed.*;
    import modules.replay.*;
    import modules.sound.*;
    import utility.*;

    public class ModuleMgr extends Object
    {
        private var funcList:Object;
        private static var instance:ModuleMgr;

        public function ModuleMgr()
        {
            this.funcList = new Object();
            return;
        }// end function

        public function init() : void
        {
            CityMgr.getInstance().initMainGui();
            BattleModule.getInstance().init();
            SoundModule.getInstance().init();
            ReplayMgr.getInstance().init();
            FeedMgr.getInstance().init();
            return;
        }// end function

        public function loop() : void
        {
            this.doFunction(CityMgr.CITY_LOOP);
            this.doFunction(MapMgr.MAP_LOOP);
            BattleModule.getInstance().loop();
            ReplayMgr.getInstance().loop();
            Utility.updateTime();
            SoundModule.getInstance().update();
            return;
        }// end function

        public function regFunction(param1:String, param2:Function) : void
        {
            if (param1 in this.funcList)
            {
                throw new Error("ModuleMgr::regFunction key trùng nhau " + param1);
            }
            var _loc_3:* = new Object();
            _loc_3["function"] = param2;
            this.funcList[param1] = _loc_3;
            return;
        }// end function

        public function doFunction(param1:String, ... args)
        {
            args = null;
            var _loc_4:Function = null;
            if (param1 in this.funcList)
            {
                args = this.funcList[param1];
                _loc_4 = args["function"] as Function;
                return _loc_4.apply(null, args);
            }
            return;
        }// end function

        public static function getInstance() : ModuleMgr
        {
            if (instance == null)
            {
                instance = new ModuleMgr;
            }
            return instance;
        }// end function

    }
}
