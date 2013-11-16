package modules.battle.graphics
{
    import component.*;
    import flash.display.*;
    import flash.text.*;
    import modules.battle.*;
    import resMgr.*;
    import utility.*;

    public class GuiBattleTopLeft extends BaseGui
    {
        public var labelName:TextField;

        public function GuiBattleTopLeft()
        {
            super(ResMgr.getInstance().getMovieClip("GuiTopLeftBattle"));
            autoAlign = AUTO_ALIGN_TOP_LEFT;
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            if (GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
            {
                this.labelName.text = Localization.getInstance().getString("SingleMap_" + BattleModule.getInstance().uId);
            }
            else
            {
                this.labelName.text = BattleModule.getInstance().uName;
            }
            super.show(param1);
            return;
        }// end function

    }
}
