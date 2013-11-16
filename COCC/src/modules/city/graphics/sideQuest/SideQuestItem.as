package modules.city.graphics.sideQuest
{
    import com.greensock.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import modules.*;
    import modules.city.*;
    import modules.city.graphics.tutorial.*;
    import resMgr.*;
    import utility.*;

    public class SideQuestItem extends Sprite
    {
        public var bmpQuest:BitmapButton = null;
        public var iconNotice:Sprite = null;
        public var questType:String;

        public function SideQuestItem()
        {
            return;
        }// end function

        public function loadType(param1:String) : void
        {
            this.questType = param1;
            this.bmpQuest = new BitmapButton(ResMgr.getInstance().getMovieClip("Quest_" + param1), 1);
            this.bmpQuest.img.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            this.addChild(this.bmpQuest.img);
            this.iconNotice = ResMgr.getInstance().getMovieClip("imageNotice") as Sprite;
            this.iconNotice.x = 8;
            this.iconNotice.y = -40;
            this.iconNotice.mouseChildren = false;
            this.iconNotice.mouseEnabled = false;
            this.addChild(this.iconNotice);
            this.iconNotice.visible = false;
            this.bmpQuest.setTooltipDisplayObj(Utility.getTooltipString(Localization.getInstance().getString(param1 + "_NAME")));
            return;
        }// end function

        public function showNotify(param1:Boolean) : void
        {
            this.iconNotice.visible = param1;
            return;
        }// end function

        private function onRotationDone() : void
        {
            TweenLite.to(this.iconNotice, 0.1, {rotation:0, onComplete:this.onDone});
            return;
        }// end function

        private function onDone() : void
        {
            this.showNotify(true);
            return;
        }// end function

        private function onMouseClick(event:MouseEvent) : void
        {
            ModuleMgr.getInstance().doFunction(CityMgr.HIDE_BUILDING_ACTION_GUI);
            CityMgr.getInstance().showSideQuestBoard(this.questType);
            TutorialMgr.getInstance().removeArrow();
            return;
        }// end function

    }
}
