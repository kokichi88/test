package modules.replay.graphics
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
	import modules.replay.data.LogBattleData;
    import resMgr.*;

    public class GuiLogBattle extends BaseGui
    {
        public var bmp2TabLogDefences:BitmapButton;
        public var bmp2TabLogAttack:BitmapButton;
        public var bmp2Mail:BitmapButton;
        public var guiLogDefences:GuiLogDefences;
        public var guiLogAttack:GuiLogDefences;
        private static const BMP_CLOSE:String = "bmpClose";
        private static const BMP_DEFENCES:String = "bmp2TabLogDefences";
        private static const BMP_ATTACK:String = "bmp2TabLogAttack";

        public function GuiLogBattle()
        {
            super(ResMgr.getInstance().getMovieClip("GuiLogBattle"));
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.bmp2TabLogDefences.setTabSelected();
            this.bmp2Mail.visible = false;
            setPos((GlobalVar.SCREEN_WIDTH - 690) / 2, (GlobalVar.SCREEN_HEIGHT - this.heightBg) / 2);
            this.guiLogDefences = new GuiLogDefences();
            this.guiLogAttack = new GuiLogDefences();
            return;
        }// end function

        public function setInfo(param1:Vector.<LogBattleData>, param2:Vector.<LogBattleData>) : void
        {
            if (this.guiLogDefences)
            {
                this.guiLogDefences.destroyBaseGUI();
                this.guiLogDefences = null;
            }
            if (this.guiLogAttack)
            {
                this.guiLogAttack.destroyBaseGUI();
                this.guiLogAttack = null;
            }
            this.guiLogDefences = new GuiLogDefences();
            this.guiLogDefences.setInfo(param1, 0);
            addGui(this.guiLogDefences);
            this.guiLogDefences.setPos(27, 94);
            this.guiLogAttack = new GuiLogDefences();
            this.guiLogAttack.setInfo(param2, 1);
            addGui(this.guiLogAttack);
            this.guiLogAttack.setPos(27, 94);
            this.updateStatus();
            return;
        }// end function

        private function updateStatus(param1:int = -1) : void
        {
            if (param1 == -1)
            {
                if (this.bmp2TabLogAttack.lock == true)
                {
                    param1 = 1;
                }
                if (this.bmp2TabLogDefences.lock == true)
                {
                    param1 = 0;
                }
                switch(param1)
                {
                    case 0:
                    {
                        this.bmp2TabLogAttack.setTabNormal();
                        this.bmp2TabLogDefences.setTabSelected();
                        this.guiLogDefences.bgImg.visible = true;
                        this.guiLogAttack.bgImg.visible = false;
                        break;
                    }
                    case 1:
                    {
                        this.bmp2TabLogAttack.setTabSelected();
                        this.bmp2TabLogDefences.setTabNormal();
                        this.guiLogDefences.bgImg.visible = false;
                        this.guiLogAttack.bgImg.visible = true;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }
            switch(param1)
            {
                case 0:
                {
                    this.bmp2TabLogAttack.setTabNormal();
                    this.bmp2TabLogDefences.setTabSelected();
                    this.guiLogDefences.bgImg.visible = true;
                    this.guiLogAttack.bgImg.visible = false;
                    this.guiLogDefences.addEvent();
                    this.guiLogAttack.cleanEvent();
                    break;
                }
                case 1:
                {
                    this.bmp2TabLogAttack.setTabSelected();
                    this.bmp2TabLogDefences.setTabNormal();
                    this.guiLogDefences.bgImg.visible = false;
                    this.guiLogAttack.bgImg.visible = true;
                    this.guiLogDefences.cleanEvent();
                    this.guiLogAttack.addEvent();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_CLOSE:
                {
                    this.hide(true);
                    break;
                }
                case BMP_DEFENCES:
                {
                    this.updateStatus(0);
                    break;
                }
                case BMP_ATTACK:
                {
                    this.updateStatus(1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            super.show(param1, param2);
            if (this.bmp2TabLogAttack.lock == true)
            {
                this.updateStatus(1);
            }
            if (this.bmp2TabLogDefences.lock == true)
            {
                this.updateStatus(0);
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            super.hide(param1);
            if (this.guiLogDefences)
            {
                this.guiLogDefences.cleanEvent();
            }
            if (this.guiLogAttack)
            {
                this.guiLogAttack.cleanEvent();
            }
            return;
        }// end function

    }
}
