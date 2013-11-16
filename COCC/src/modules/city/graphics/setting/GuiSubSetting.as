package modules.city.graphics.setting
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import map.*;
    import modules.city.*;
    import modules.sound.*;
    import resMgr.*;
    import utility.*;

    public class GuiSubSetting extends BaseGui
    {
        public var bmpZoomOut:BitmapButton;
        public var bmpZoomIn:BitmapButton;
        public var bmpMusic:BitmapButton;
        public var bmpSound:BitmapButton;
        public var imageMusicOn:MovieClip;
        public var imageMusicOff:MovieClip;
        public var imageSoundOn:MovieClip;
        public var imageSoundOff:MovieClip;
        public var imageZoomOut:MovieClip;
        public var imageZoomIn:MovieClip;
        private static const BMP_ZOOM_IN:String = "bmpZoomIn";
        private static const BMP_ZOOM_OUT:String = "bmpZoomOut";
        private static const BMP_SOUND:String = "bmpSound";
        private static const BMP_MUSIC:String = "bmpMusic";

        public function GuiSubSetting()
        {
            super(ResMgr.getInstance().getMovieClip("MainGui_Sub_Setting"));
            this.imageMusicOn.mouseChildren = false;
            this.imageMusicOn.mouseEnabled = false;
            this.imageMusicOff.mouseChildren = false;
            this.imageMusicOff.mouseEnabled = false;
            this.imageSoundOn.mouseChildren = false;
            this.imageSoundOn.mouseEnabled = false;
            this.imageSoundOff.mouseChildren = false;
            this.imageSoundOff.mouseEnabled = false;
            this.imageZoomIn.mouseChildren = false;
            this.imageZoomIn.mouseEnabled = false;
            this.imageZoomOut.mouseChildren = false;
            this.imageZoomOut.mouseEnabled = false;
            this.bmpZoomOut.setTooltipDisplayObj(Utility.getTooltipString("Thu nhỏ"));
            this.bmpZoomIn.setTooltipDisplayObj(Utility.getTooltipString("Phóng to"));
            this.bmpMusic.setTooltipDisplayObj(Utility.getTooltipString("Nhạc nền"));
            this.bmpSound.setTooltipDisplayObj(Utility.getTooltipString("Âm thanh"));
            this.loadUserData();
            return;
        }// end function

        public function turnSound(param1:Boolean) : void
        {
            this.imageSoundOn.visible = param1;
            this.imageSoundOff.visible = !param1;
            SoundModule.getInstance().muteSound(!param1);
            return;
        }// end function

        public function turnMusic(param1:Boolean) : void
        {
            this.imageMusicOn.visible = param1;
            this.imageMusicOff.visible = !param1;
            SoundModule.getInstance().muteBgMusic(!param1);
            return;
        }// end function

        public function loadUserData() : void
        {
            this.turnSound(true);
            this.turnMusic(true);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            var _loc_3:Boolean = false;
            var _loc_4:Boolean = false;
            switch(param1)
            {
                case BMP_ZOOM_IN:
                {
                    MapMgr.getInstance().zoomInMap(true);
                    break;
                }
                case BMP_ZOOM_OUT:
                {
                    MapMgr.getInstance().zoomOutMap(true);
                    break;
                }
                case BMP_MUSIC:
                {
                    _loc_3 = this.imageMusicOn.visible;
                    this.turnMusic(!_loc_3);
                    CityMgr.getInstance().sendTurnMusic();
                    break;
                }
                case BMP_SOUND:
                {
                    _loc_4 = this.imageSoundOn.visible;
                    this.turnSound(!_loc_4);
                    CityMgr.getInstance().sendTurnSound();
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
