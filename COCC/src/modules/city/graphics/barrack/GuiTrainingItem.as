package modules.city.graphics.barrack
{
    import component.*;
    import flash.display.*;
    import flash.text.*;
    import resMgr.*;
    import utility.*;

    public class GuiTrainingItem extends BaseGui
    {
        public var labelNum:TextField;
        public var labelTime:TextField;
        public var bmpDeleteTroop:BitmapButton;
        public var imageStatusBar:Object;
        public var imageStatusBg:Object;
        public var curType:String;
        public var objConf:Object;
        public static const ARM:String = "ARM";
        public static const SEPARATE:String = "_";

        public function GuiTrainingItem(param1:String)
        {
            super(ResMgr.getInstance().getMovieClip("ctnTroopTraining"));
            this.imageStatusBar.visible = false;
            this.imageStatusBg.visible = false;
            var _loc_2:* = ResMgr.getInstance().getMovieClip(param1 + "_Research_Icon") as Sprite;
            this.img.addChildAt(_loc_2, 1);
            _loc_2.x = 62 - _loc_2.width;
            _loc_2.y = 72 - _loc_2.height;
            this.curType = param1;
            this.objConf = JsonMgr.getInstance().getTroopBase()[this.curType];
            return;
        }// end function

        public function update(param1:Number) : void
        {
            this.labelTime.text = Utility.convertTimeToShortString(param1);
            this.imageStatusBar.visible = true;
            this.imageStatusBg.visible = true;
            var _loc_2:* = Math.max(0, Math.min(1, (this.objConf["trainingTime"] - param1) / this.objConf["trainingTime"]));
            this.imageStatusBar.scaleX = Math.max(0, _loc_2);
            return;
        }// end function

    }
}
