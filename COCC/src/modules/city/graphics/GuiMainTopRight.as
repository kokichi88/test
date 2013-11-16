package modules.city.graphics
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.graphics.effectSeed.*;
    import modules.city.graphics.tutorial.*;
    import resMgr.*;
    import utility.*;

    public class GuiMainTopRight extends BaseGui
    {
        public var labelMaxGold:TextField;
        public var labelGold:TextField;
        public var labelMaxElixir:TextField;
        public var labelElixir:TextField;
        public var labelG:TextField;
        public var imageGoldBar:MovieClip;
        public var imageElixirBar:MovieClip;
        public var imageG:MovieClip;
        public var imageGold:MovieClip;
        public var imageElixir:MovieClip;
        public var bmpBuyG:BitmapButton;
        public var bmpThongBao:BitmapButton;
        private var maxGoldCapacity:int = -1;
        private var gold:int = -1;
        private var maxElixirCapacity:int = -1;
        private var elixir:int = -1;
        private var maxDarkElixirCapacity:int = -1;
        private var darkElixir:int = -1;
        private var g:int = -1;
        public var u:UserInfo;
        private var d:int = 2;
        private var firstScale:Number = 0.85;
        private static const BMP_ACTTACK:String = "bmpActtack";
        private static const BMP_BUYG:String = "bmpBuyG";
        private static const BMP_THONG_BAO:String = "bmpThongBao";

        public function GuiMainTopRight()
        {
            super(ResMgr.getInstance().getMovieClip("MainGui_Right"));
            autoAlign = AUTO_ALIGN_RIGHT_TOP;
            this.bmpBuyG.setTooltipDisplayObj(Utility.getTooltipString("Nạp G"));
            this.bmpThongBao.setTooltipDisplayObj(Utility.getTooltipString("Sự kiện"));
            return;
        }// end function

        public function updateGold() : void
        {
            var _loc_1:Number = NaN;
            if (this.maxGoldCapacity != GameDataMgr.getInstance().maxGoldCapacity)
            {
                this.labelMaxGold.text = "Tối đa:  " + Utility.standardNumber(GameDataMgr.getInstance().maxGoldCapacity);
                this.maxGoldCapacity = GameDataMgr.getInstance().maxGoldCapacity;
                this.imageGoldBar.scaleX = Math.min(this.u.gold / this.maxGoldCapacity, 1);
            }
            if (this.gold != this.u.gold)
            {
                this.gold = -1;
                _loc_1 = Utility.convertStringToInt(this.labelGold.text);
                if (_loc_1 != this.u.gold)
                {
                    if (this.u.gold > _loc_1)
                    {
                        _loc_1 = _loc_1 + Math.round((this.u.gold - _loc_1) / this.d);
                    }
                    else
                    {
                        _loc_1 = _loc_1 - Math.round((_loc_1 - this.u.gold) / this.d);
                    }
                }
                else
                {
                    this.gold = this.u.gold;
                }
                this.imageGoldBar.scaleX = Math.min(_loc_1 / this.maxGoldCapacity, 1);
                this.labelGold.text = Utility.standardNumber(_loc_1);
            }
            return;
        }// end function

        public function updateElixir() : void
        {
            var _loc_1:Number = NaN;
            if (this.maxElixirCapacity != GameDataMgr.getInstance().maxElixirCapacity)
            {
                this.labelMaxElixir.text = "Tối đa:  " + Utility.standardNumber(GameDataMgr.getInstance().maxElixirCapacity);
                this.maxElixirCapacity = GameDataMgr.getInstance().maxElixirCapacity;
                this.imageElixirBar.scaleX = Math.min(this.u.elixir / this.maxElixirCapacity, 1);
            }
            if (this.elixir != this.u.elixir)
            {
                this.elixir = -1;
                _loc_1 = Utility.convertStringToInt(this.labelElixir.text);
                if (_loc_1 != this.u.elixir)
                {
                    if (this.u.elixir > _loc_1)
                    {
                        _loc_1 = _loc_1 + Math.round((this.u.elixir - _loc_1) / this.d);
                    }
                    else
                    {
                        _loc_1 = _loc_1 - Math.round((_loc_1 - this.u.elixir) / this.d);
                    }
                }
                else
                {
                    this.elixir = this.u.elixir;
                }
                this.imageElixirBar.scaleX = Math.min(_loc_1 / this.maxElixirCapacity, 1);
                this.labelElixir.text = Utility.standardNumber(_loc_1);
            }
            return;
        }// end function

        public function updateDarkElixir() : void
        {
            return;
        }// end function

        public function updateG() : void
        {
            var _loc_1:Number = NaN;
            if (this.g != this.u.coin)
            {
                this.g = -1;
                _loc_1 = Utility.convertStringToInt(this.labelG.text);
                if (_loc_1 != this.u.coin)
                {
                    if (this.u.coin > _loc_1)
                    {
                        _loc_1 = _loc_1 + Math.round((this.u.coin - _loc_1) / this.d);
                    }
                    else
                    {
                        _loc_1 = _loc_1 - Math.round((_loc_1 - this.u.coin) / this.d);
                    }
                }
                else
                {
                    this.g = this.u.coin;
                }
                this.labelG.text = Utility.standardNumber(_loc_1);
            }
            return;
        }// end function

        public function updateData() : void
        {
            this.u = GameDataMgr.getInstance().myInfo;
            this.updateGold();
            this.updateElixir();
            this.updateDarkElixir();
            this.updateG();
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            CityMgr.getInstance().hideBuildingActionGui();
            switch(param1)
            {
                case BMP_BUYG:
                {
                    if (!TutorialMgr.getInstance().isTutorial)
                    {
                        if (!GameDataMgr.getInstance().myInfo.isChargedUser)
                        {
                            CityMgr.getInstance().guiFirstAddG.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
                        }
                        else
                        {
                            CityMgr.getInstance().guiNapThe.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
                        }
                    }
                    break;
                }
                case BMP_THONG_BAO:
                {
                    CityMgr.getInstance().guiFirstAddG.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
                    this.bmpThongBao.img.gotoAndStop(0);
                    break;
                }
                default:
                {
                    break;
                }
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

        public function runEffectG() : void
        {
            var _loc_1:* = new SeedResourcesEffect();
            _loc_1.create(this.imageG);
            _loc_1.runEffect();
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            super.show(param1, param2);
            this.bmpBuyG.visible = GlobalVar.state == GlobalVar.STATE_MYHOME;
            return;
        }// end function

    }
}
