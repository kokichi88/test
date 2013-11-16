package modules.city.graphics.findmatch
{
    import component.*;
    import flash.text.*;
    import resMgr.*;
    import utility.*;

    public class GuiAvaiableLoot extends BaseGui
    {
        public var labelAvaiableGoldLoot:TextField;
        public var labelAvaiableElixirLoot:TextField;

        public function GuiAvaiableLoot()
        {
            super(ResMgr.getInstance().getMovieClip("AvaiableLootGui"));
            return;
        }// end function

        public function setInfo(param1:int, param2:int) : void
        {
            this.labelAvaiableGoldLoot.text = Utility.standardNumber(param1);
            this.labelAvaiableElixirLoot.text = Utility.standardNumber(param2);
            return;
        }// end function

    }
}
