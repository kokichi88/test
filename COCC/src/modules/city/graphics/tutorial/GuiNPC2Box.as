package modules.city.graphics.tutorial
{
    import component.*;
    import flash.events.*;
    import flash.text.*;
    import resMgr.*;
    import utility.*;

    public class GuiNPC2Box extends BaseGui
    {
        public var labelContent:TextField;
        public var bmpActionTut:BitmapButton;
        public var labelAction:TextField;
        public var labelClickToContinue:TextField;
        private static var BMP_ACTION:String = "bmpActionTut";

        public function GuiNPC2Box()
        {
            super(ResMgr.getInstance().getMovieClip("NPC2_Box_gui"));
            this.labelAction.mouseEnabled = false;
            return;
        }// end function

        public function showTutorialStep(param1:int, param2:String = null) : void
        {
            this.labelContent.text = Localization.getInstance().getString("Tutorial" + param1);
            var _loc_3:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP);
            if (param2)
            {
                this.bmpActionTut.visible = true;
                this.labelAction.visible = true;
                this.labelAction.text = param2;
                this.labelClickToContinue.visible = false;
            }
            else
            {
                this.bmpActionTut.visible = false;
                this.labelAction.visible = false;
                this.labelClickToContinue.visible = true;
            }
            _loc_3.addEventListener(MouseEvent.CLICK, TutorialMgr.getInstance().onMouseClick);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_ACTION:
                {
                    TutorialMgr.getInstance().nextStep();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
