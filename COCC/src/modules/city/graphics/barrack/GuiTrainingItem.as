package modules.city.graphics.barrack
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiTrainingItem extends BaseGui
    {
        public var labelNum:TextField;
        public var labelTime:TextField;
        public var bmpDeleteTroop:BitmapButton;
        public var bmpTroopTraining:BitmapButton;
        public var imageStatusBar:Object;
        public var imageStatusBg:Object;
        public var curType:String;
        public var objConf:Object;
        public var barrackId:int;
        public static const ARM:String = "ARM";
        public static const SEPARATE:String = "_";
        private static const BMP_DELETE:String = "bmpDeleteTroop";
        private static const BMP_CANCEL:String = "bmpTroopTraining";

        public function GuiTrainingItem(param1:String)
        {
            super(ResMgr.getInstance().getMovieClip("ctnTroopTraining"));
            this.imageStatusBar.visible = false;
            this.imageStatusBg.visible = false;
            var _loc_2:* = ResMgr.getInstance().getMovieClip(param1 + "_Research_Icon") as Sprite;
            this.bmpTroopTraining.img.addChild(_loc_2);
            _loc_2.x = (this.bmpTroopTraining.width - _loc_2.width) / 2;
            _loc_2.y = (this.bmpTroopTraining.height - _loc_2.height) / 2;
            _loc_2.mouseEnabled = false;
            _loc_2.mouseChildren = false;
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

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            CityMgr.getInstance().guiTrainTroop2.listItem[this.barrackId].cancelTroop(this.curType);
            return;
        }// end function

        override public function onMouseDown(param1:String, param2:MouseEvent) : void
        {
            CityMgr.getInstance().guiTrainTroop2.mouseDownTroopType = this.curType;
            CityMgr.getInstance().guiTrainTroop2.mouseDownType = GuiTrainTroop2.MOUSE_DOWN_TYPE_CANCEL;
            CityMgr.getInstance().guiTrainTroop2.mouseDownDelay = Utility.getCurTime() * 1000 + GuiTrainTroop2.MOUSE_DOWN_DELAY_TO_START;
            return;
        }// end function

    }
}
