package resMgr
{
    import flash.display.*;
    import flash.events.*;

    public class MovieClipEx extends MovieClip
    {
        private var img:DisplayObject;
        private var url:String;
        public static const EVENT_LOADED:String = "ResLoaded";
        public static const EVENT_LOADED_COMP:String = "ResLoadedComp";

        public function MovieClipEx()
        {
            var _loc_1:* = new MovieClip();
            this.img = _loc_1;
            addChild(this.img);
            return;
        }// end function

        public function setEvent(param1:String) : void
        {
            this.url = param1;
            ResMgr.getInstance().addEventListener(param1, this.onLoaded);
            return;
        }// end function

        private function onLoaded(event:Event) : void
        {
            ResMgr.getInstance().removeEventListener(this.url, this.onLoaded);
            removeChild(this.img);
            this.img = ResMgr.getInstance().getMovieClip(this.url);
            addChild(this.img);
            dispatchEvent(new Event(EVENT_LOADED));
            return;
        }// end function

    }
}
