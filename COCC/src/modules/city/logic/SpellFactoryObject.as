package modules.city.logic
{
    import resMgr.*;
    import resMgr.data.*;

    public class SpellFactoryObject extends MapObject
    {
        public var info:DataSpellFactory;
        public var objConf:Object;
        private var hasAttackRange:Boolean = false;

        public function SpellFactoryObject()
        {
            return;
        }// end function

        override public function loadConfigData() : void
        {
            this.info = JsonMgr.getInstance().getSpelFactoryData(level);
            width = this.info.width;
            height = this.info.height;
            this.objConf = JsonMgr.getInstance().getTroopBase();
            return;
        }// end function

        public function getTotalTroopTraining() : int
        {
            return 0;
        }// end function

        public function getMaxCapacity() : int
        {
            return 0;
        }// end function

    }
}
