package modules.battle.graphics
{
    import __AS3__.vec.*;
    import component.*;
    import component.avatar.controls.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import modules.*;
    import modules.battle.*;
    import modules.city.*;
    import modules.city.graphics.effectSeed.*;
    import modules.sound.*;
    import resMgr.*;
    import utility.*;

    public class GuiBattleEnd extends BaseGui
    {
        public var imageWin:MovieClip;
        public var imageLost:MovieClip;
        public var imageStar1:MovieClip;
        public var imageStar2:MovieClip;
        public var imageStar3:MovieClip;
        public var labelGold:TextField;
        public var labelElixir:TextField;
        public var labelTroopy:TextField;
        public var bmpReturnHome:BitmapButton;
        public var imageTroopUsed:MovieClip;
        public var imageGold:MovieClip;
        public var imageElixir:MovieClip;
        private var gold:int;
        private var elixir:int;
        private var darkElixir:int;
        private var troopy:int;
        private var strTrooy:String = "";
        private var curGold:int;
        private var curElixir:int;
        private var curDarkElixir:int;
        private var curTroopy:int;
        private var numStar:int = 0;
        private var indexStar:int = 1;
        private var countDownFrame:int = 0;
        private static const BMP_RETURN_HOME:String = "bmpReturnHome";
        private static const COUNT_FRAME:int = 4;
        private static const DURATION:int = 2;

        public function GuiBattleEnd()
        {
            super(ResMgr.getInstance().getMovieClip("GuiEndBattle"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            showDisableScreen(0.4);
            return;
        }// end function

        public function setInfo() : void
        {
            var _loc_8:int = 0;
            var _loc_9:ItemBattleTroop = null;
            SoundModule.getInstance().stopBgMusic();
            if (BattleModule.getInstance().numStar > 0)
            {
                this.imageLost.visible = false;
                this.imageWin.visible = true;
                SoundModule.getInstance().playSound(SoundModule.VICTORY);
            }
            else
            {
                this.imageLost.visible = true;
                this.imageWin.visible = false;
                SoundModule.getInstance().playSound(SoundModule.DEFEATED);
            }
            this.gold = BattleModule.getInstance().goldRop;
            this.elixir = BattleModule.getInstance().elixirRop;
            this.curGold = 0;
            this.curElixir = 0;
            this.curDarkElixir = 0;
            this.curTroopy = 0;
            this.imageStar1.visible = false;
            this.imageStar2.visible = false;
            this.imageStar3.visible = false;
            this.numStar = BattleModule.getInstance().numStar;
            this.indexStar = 1;
            if (this.numStar > 0)
            {
                _loc_8 = this.numStar / 3 * BattleModule.getInstance().trophyReceive;
                this.troopy = _loc_8;
                this.labelTroopy.text = Utility.numToStr(_loc_8);
                this.strTrooy = "";
            }
            else
            {
                this.strTrooy = "-";
                this.troopy = BattleModule.getInstance().trophyLost;
            }
            this.showEffectStar();
            if (BattleModule.getInstance().status <= 1)
            {
                this.troopy = 0;
            }
            this.labelElixir.text = Utility.numToStr(this.curElixir);
            this.labelGold.text = Utility.numToStr(this.curGold);
            this.labelTroopy.text = Utility.numToStr(this.curTroopy);
            this.countDownFrame = 0;
            img.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            var _loc_1:* = BattleModule.getInstance().listTroopDrop;
            var _loc_2:Number = 50;
            var _loc_3:* = _loc_1.length * _loc_2;
            var _loc_4:* = (this.imageTroopUsed.width - _loc_3) / 2;
            var _loc_5:int = 5;
            var _loc_6:int = 8;
            var _loc_7:int = 0;
            while (_loc_7 < _loc_1.length)
            {
                
                _loc_9 = new ItemBattleTroop(1);
                _loc_9.troop = _loc_1[_loc_7];
                _loc_9.index = _loc_7;
                _loc_9.setPos(_loc_4 + _loc_7 * _loc_2, _loc_6);
                this.imageTroopUsed.addChild(_loc_9.bgImg);
                _loc_9.img.mouseEnabled = false;
                _loc_9.img.mouseChildren = false;
                _loc_7++;
            }
            return;
        }// end function

        private function showEffectStar() : void
        {
            var _loc_1:MovieClip = null;
            if (img == null)
            {
                return;
            }
            this.numStar = Math.min(this.numStar, 3);
            if (this.numStar > 0)
            {
              
                this.numStar--;
                if (this.indexStar > 3)
                {
                    return;
                }
                this["imageStar" + this.indexStar].visible = true;
                EffectDraw.effShowHideAlpha(this["imageStar" + this.indexStar], 1, 0.5, 1, this.showEffectStar, null, 0);
                _loc_1 = ResMgr.getInstance().getMovieClip("StarGain");
                _loc_1.x = this["imageStar" + this.indexStar].x + this["imageStar" + this.indexStar].width / 2;
                _loc_1.y = this["imageStar" + this.indexStar].y + this["imageStar" + this.indexStar].height / 2;
                img.addChild(_loc_1);
                EffectDraw.effShowHideAlpha(_loc_1, 1, 0, 1, this.onEndEffectGainStar, [_loc_1], 0);
               
                this.indexStar++;
            }
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {            
            this.countDownFrame++;
            if (this.countDownFrame < COUNT_FRAME)
            {
                return;
            }
            this.countDownFrame = 0;
            var _loc_2:Boolean = true;
            if (this.curElixir < this.elixir)
            {
                this.curElixir = this.curElixir + Math.round((this.elixir - this.curElixir) / 2);
                this.labelElixir.text = Utility.numToStr(this.curElixir);
                _loc_2 = false;
                this.runElixirEffect();
            }
            if (this.curGold < this.gold)
            {
                this.curGold = this.curGold + Math.round((this.gold - this.curGold) / 2);
                this.labelGold.text = Utility.numToStr(this.curGold);
                _loc_2 = false;
                this.runMoneyEffect();
            }
            if (this.curTroopy < this.troopy)
            {
                this.curTroopy = this.curTroopy + Math.round((this.troopy - this.curTroopy) / 2);
                this.labelTroopy.text = this.strTrooy + Utility.numToStr(this.curTroopy);
                _loc_2 = false;
            }
            if (_loc_2)
            {
                if (img)
                {
                    img.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                }
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_RETURN_HOME:
                {
                    hide();
                    ModuleMgr.getInstance().doFunction(CityMgr.SHOW_TRANSITION_EFF, BattleModule.getInstance().returnHome);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onEndEffectGainStar(param1:MovieClip) : void
        {
            if (param1.parent != null)
            {
                param1.parent.removeChild(param1);
            }
            return;
        }// end function

        public function runMoneyEffect() : void
        {
            var _loc_1:* = new SeedResourcesEffect();
            _loc_1.create(this.imageGold);
            _loc_1.runEffect();
            return;
        }// end function

        public function runElixirEffect() : void
        {
            var _loc_1:* = new SeedResourcesEffect();
            _loc_1.create(this.imageElixir);
            _loc_1.runEffect();
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            var _loc_3:int = 0;
            super.show(param1, param2);
            if (GlobalVar.SCREEN_HEIGHT < 600)
            {
                _loc_3 = bgImg.y + this.bmpReturnHome.img.y - GlobalVar.SCREEN_HEIGHT + this.bmpReturnHome.img.height + 10;
                bgImg.y = bgImg.y - _loc_3;
            }
            return;
        }// end function

    }
}
