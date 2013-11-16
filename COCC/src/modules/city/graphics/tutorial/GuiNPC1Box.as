package modules.city.graphics.tutorial
{
    import com.greensock.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import gameData.*;
    import modules.city.*;
    import mx.utils.*;
    import resMgr.*;
    import utility.*;

    public class GuiNPC1Box extends BaseGui
    {
        public var labelContent:TextField;
        public var bmpActionTut:BitmapButton;
        public var labelAction:TextField;
        public var imageBGText:MovieClip;
        public var labelName:TextField;
        public var labelError:TextField;
        public var labelClickToContinue:TextField;
        private static var BMP_ACTION:String = "bmpActionTut";

        public function GuiNPC1Box()
        {
            super(ResMgr.getInstance().getMovieClip("NPC1_Box_gui"));
            this.labelName.type = TextFieldType.INPUT;
            this.labelName.mouseEnabled = true;
            this.labelError.visible = false;
            this.labelClickToContinue.visible = false;
            this.labelName.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            return;
        }// end function

        public function showTutorialStep(param1:int, param2:String = null) : void
        {
            if (param1 == 24)
            {
                this.showNameBox();
                return;
            }
            this.labelContent.text = Localization.getInstance().getString("Tutorial" + param1);
            this.imageBGText.visible = false;
            this.labelName.visible = false;
            if (param2)
            {
                this.bmpActionTut.visible = true;
                this.labelAction.visible = true;
                this.labelAction.text = param2.toUpperCase();
                this.labelClickToContinue.visible = false;
            }
            else
            {
                this.bmpActionTut.visible = false;
                this.labelAction.visible = false;
                this.labelClickToContinue.visible = true;
            }
            var _loc_3:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP);
            _loc_3.addEventListener(MouseEvent.CLICK, TutorialMgr.getInstance().onMouseClick);
            return;
        }// end function

        public function showNameBox() : void
        {
            this.labelClickToContinue.visible = false;
            this.labelContent.text = Localization.getInstance().getString("Tutorial24");
            this.imageBGText.visible = true;
            this.labelName.visible = true;
            this.labelName.text = GameDataMgr.getInstance().myInfo.uName;
            this.labelAction.visible = true;
            this.bmpActionTut.visible = true;
            this.labelAction.text = "ĐỒNG Ý";
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_ACTION:
                {
                    this.checkName();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case Keyboard.ENTER:
                {
                    this.checkName();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function checkName() : void
        {
            if (this.labelName.visible)
            {
                this.labelName.text = StringUtil.trim(this.labelName.text);
                if (Utility.checkNameValid(this.labelName.text))
                {
                    CityMgr.getInstance().sendSetNameCmd(this.labelName.text);
                    this.labelError.visible = false;
                }
                else
                {
                    TweenMax.killAll();
                    this.labelError.alpha = 1;
                    this.labelError.visible = true;
                    TweenMax.to(this.labelError, 3, {alpha:0});
                    this.labelError.text = Localization.getInstance().getString("Tutorial_Append2");
                }
            }
            else
            {
                TutorialMgr.getInstance().nextStep();
            }
            return;
        }// end function

    }
}
