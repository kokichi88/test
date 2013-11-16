package modules.battle.graphics
{
    import flash.display.*;
    import flash.text.*;
    import resMgr.*;

    public class BarProgress extends Sprite
    {
        public var spBg:Sprite;
        public var spBar:Sprite;
        public var spMask:Sprite;
        public var labelContent:TextField;

        public function BarProgress(param1:int)
        {
            switch(param1)
            {
                case 1:
                {
                    this.spBg = ResMgr.getInstance().getMovieClip("spBgProgress") as Sprite;
                    this.spBar = ResMgr.getInstance().getMovieClip("spBarProgressMe") as Sprite;
                    break;
                }
                case 2:
                {
                    this.spBg = ResMgr.getInstance().getMovieClip("spBgProgress") as Sprite;
                    this.spBar = ResMgr.getInstance().getMovieClip("spBarProgress") as Sprite;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.addChild(this.spBg);
            this.addChild(this.spBar);
            this.spMask = new Sprite();
            this.spMask.graphics.beginFill(16776960, 1);
            this.spMask.graphics.drawRect(0, 0, this.spBar.width, this.spBar.height);
            this.spMask.graphics.endFill();
            this.addChild(this.spMask);
            this.spBar.mask = this.spMask;
            this.labelContent = new TextField();
            this.labelContent.defaultTextFormat = new TextFormat("Arial", 12, 16777215, true);
            this.labelContent.text = "0%";
            this.labelContent.autoSize = TextFieldAutoSize.CENTER;
            this.labelContent.mouseEnabled = false;
            this.updateSpPos();
            return;
        }// end function

        private function updateSpPos() : void
        {
            this.spBg.x = 0;
            this.spBg.y = 0;
            this.spBar.x = this.spBg.width / 2 - this.spBar.width / 2;
            this.spBar.y = this.spBar.height / 2 - this.spBar.height / 2;
            this.labelContent.x = this.spBar.width / 2 - this.labelContent.textWidth / 2;
            this.labelContent.y = this.spBar.height / 2 - this.labelContent.textHeight / 2 - 2;
            return;
        }// end function

        public function setPos(param1:int, param2:int) : void
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function setText(param1:String) : void
        {
            this.labelContent.text = param1;
            this.labelContent.x = this.spBar.width / 2 - this.labelContent.textWidth / 2;
            this.labelContent.y = this.spBar.height / 2 - this.labelContent.textHeight / 2 - 2;
            return;
        }// end function

        public function setPercent(param1:Number) : void
        {
            if (param1 < 0)
            {
                param1 = 0;
            }
            if (param1 > 1)
            {
                param1 = 1;
            }
            var _loc_2:* = this.spBar.width * param1;
            this.spMask.graphics.clear();
            this.spMask.graphics.beginFill(16776960, 1);
            this.spMask.graphics.drawRect(0, 0, _loc_2, this.spBar.height);
            this.spMask.graphics.endFill();
            this.spBar.mask = this.spMask;
            var _loc_3:* = param1 * 100;
            this.labelContent.text = _loc_3.toString() + "%";
            return;
        }// end function

    }
}
