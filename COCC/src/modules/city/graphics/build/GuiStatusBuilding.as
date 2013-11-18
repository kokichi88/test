package modules.city.graphics.build
{
    import component.*;
    import flash.text.*;
    import resMgr.*;
    import utility.*;

    public class GuiStatusBuilding extends BaseGui
    {
        public var labelStatus:TextField;
        private var saveStatus:int = -1;
        public static var NONE:int = 0;
        public static var FREE:int = 1;
        public static var FULL:int = 2;
        public static var OVERLOAD:int = 3;
        public static var CAN_REQUEST:int = 4;

        public function GuiStatusBuilding()
        {
            super(ResMgr.getInstance().getMovieClip("StatusBuildingGui"));
            this.bgImg.mouseEnabled = false;
            this.bgImg.mouseChildren = false;
            return;
        }// end function

        public function setStatus(param1:int) : void
        {
            if (this.saveStatus == param1)
            {
                return;
            }
            this.saveStatus = param1;
            this.labelStatus.text = Localization.getInstance().getString("StatusBuilding" + param1);
            return;
        }// end function

    }
}
