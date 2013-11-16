package modules.replay.graphics
{
    import component.*;
    import flash.text.*;
    import resMgr.*;
    import utility.*;

    public class BeenAttackedItem extends BaseGui
    {
        public var labelLevel:TextField;
        public var labelName:TextField;
        public var labelTime:TextField;

        public function BeenAttackedItem()
        {
            super(ResMgr.getInstance().getMovieClip("BeenAttackedItem"));
            return;
        }// end function

        public function setInfo(param1:int, param2:String, param3:Number) : void
        {
            this.labelLevel.text = param1.toString();
            this.labelName.text = param2;
            var _loc_4:* = Utility.getCurTime() - param3;
            this.labelTime.text = Utility.convertTimeToShortString(_loc_4) + " trước";
            return;
        }// end function

    }
}
