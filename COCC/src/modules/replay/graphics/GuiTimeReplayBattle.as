package modules.replay.graphics
{
    import component.*;
    import flash.display.*;
    import flash.text.*;
    import resMgr.*;
    import utility.*;

    public class GuiTimeReplayBattle extends BaseGui
    {
        private var startTime:Number;
        public var labelTime:TextField;
        public var time:Number;
        private var endTime:Number;

        public function GuiTimeReplayBattle()
        {
            super(ResMgr.getInstance().getMovieClip("GuiTimeReplayBattle"));
            autoAlign = AUTO_ALIGN_TOP_CENTER;
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            this.labelTime.text = Utility.convertTimeToShortString(this.time);
            super.show(param1);
            this.startTime = Utility.getCurTime();
            this.endTime = this.startTime + this.time;
            return;
        }// end function

        override public function loop() : void
        {
            var _loc_1:* = Utility.getCurTime();
            this.time = this.endTime - _loc_1;
            this.time = Math.max(0, this.time);
            this.labelTime.text = Utility.convertTimeToShortString(this.time);
            return;
        }// end function

    }
}
