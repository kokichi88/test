package modules.city.graphics.shop
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import gameData.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class GuiShopType extends BaseGui
    {
        public var bmpPrev:BitmapButton;
        public var bmpNext:BitmapButton;
        public var pageItem:PageMgr;
        public var listItem:Vector.<GuiShopItem>;
        public var listTreasures:Vector.<Object>;
        private static const BMP_PREVIOUS:String = "bmpPrev";
        private static const BMP_NEXT:String = "bmpNext";
        private static const NUM_ROW:int = 2;
        private static const NUM_COL:int = 5;

        public function GuiShopType()
        {
            this.listItem = new Vector.<GuiShopItem>;
            this.listTreasures = new Vector.<Object>;
            super(ResMgr.getInstance().getMovieClip("ShopTypeGui"));
            this.pageItem = new PageMgr(img);
            this.pageItem.x = 11;
            this.pageItem.y = 10;
            return;
        }// end function

        public function initItem(param1:Array) : void
        {
            var _loc_10:GuiShopItem = null;
            var _loc_2:Number = 590;
            var _loc_3:Number = 315;
            var _loc_4:* = new Sprite();
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:Number = 3.95;
            var _loc_8:Number = 157.4;
            var _loc_9:int = 0;
            while (_loc_9 < param1.length)
            {
                
                _loc_10 = new GuiShopItem();
                _loc_4.addChild(_loc_10.bgImg);
                _loc_10.setPos(_loc_9 % NUM_COL * (_loc_10.widthBg + _loc_7) + int(_loc_9 / 10) * 590, _loc_6 + Math.floor(_loc_9 % 10 / NUM_COL) * _loc_8);
                _loc_10.setIcon(param1[_loc_9]);
                this.listItem.push(_loc_10);
                _loc_9++;
            }
            this.pageItem.setData(_loc_4, _loc_2, _loc_3, 0, PageMgr.HOZIRONTOL, true, 1);
            var _loc_11:* = this.pageItem.totalPage > 1;
            this.bmpPrev.visible = this.pageItem.totalPage > 1;
            this.bmpNext.visible = _loc_11;
            this.bmpNext.enable = this.pageItem.canNext();
            this.bmpPrev.enable = this.pageItem.canPrev();
            return;
        }// end function

        private function removeAllItem() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                this.listItem[_loc_1].destroyBaseGUI();
                this.listItem[_loc_1] = null;
                _loc_1++;
            }
            this.listItem.splice(0, this.listItem.length);
            this.listItem = new Vector.<GuiShopItem>;
            return;
        }// end function

        private function removeAllItemListTreasure() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listTreasures.length)
            {
                
                this.listTreasures[_loc_1] = null;
                _loc_1++;
            }
            this.listTreasures.splice(0, this.listTreasures.length);
            this.listTreasures = new Vector.<Object>;
            return;
        }// end function

        public function updateShopState() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                this.listItem[_loc_1].updateState();
                _loc_1++;
            }
            return;
        }// end function

        public function getShopTreasures() : void
        {
            var _loc_9:GuiShopItem = null;
            this.removeAllItem();
            this.removeAllItemListTreasure();
            this.getListTreasures(MoneyType.GOLD);
            this.getListTreasures(MoneyType.ELIXIR);
            var _loc_1:Number = 590;
            var _loc_2:Number = 315;
            var _loc_3:* = new Sprite();
            var _loc_4:int = 0;
            var _loc_5:int = 5;
            var _loc_6:int = 0;
            var _loc_7:int = 159;
            var _loc_8:int = 0;
            while (_loc_8 < this.listTreasures.length)
            {
                
                _loc_9 = new GuiShopItem();
                _loc_3.addChild(_loc_9.bgImg);
                _loc_9.setPos(_loc_8 % NUM_COL * (_loc_9.widthBg + _loc_5), _loc_6 + Math.floor(_loc_8 / NUM_COL) * _loc_7);
                _loc_9.setIconTreasures(this.listTreasures[_loc_8].type, this.listTreasures[_loc_8].value, this.listTreasures[_loc_8].shopType);
                this.listItem.push(_loc_9);
                _loc_8++;
            }
            this.pageItem.setData(_loc_3, _loc_1, _loc_2, 0, PageMgr.HOZIRONTOL, true, 1);
            var _loc_10:* = this.pageItem.totalPage > 1;
            this.bmpPrev.visible = this.pageItem.totalPage > 1;
            this.bmpNext.visible = _loc_10;
            this.bmpNext.enable = this.pageItem.canNext();
            this.bmpPrev.enable = this.pageItem.canPrev();
            return;
        }// end function

        private function getListTreasures(param1:String) : void
        {
            var _loc_3:Object = null;
            var _loc_2:int = 0;
            while (_loc_2 < 3)
            {
                
                _loc_3 = this.getTreasureItems(param1, _loc_2);
                if (_loc_3)
                {
                    this.listTreasures.push(_loc_3);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function getTreasureItems(param1:String, param2:int) : Object
        {
            var _loc_3:Object = null;
            var _loc_4:* = GameDataMgr.getInstance().getMaxCapacity(param1);
            var _loc_5:* = GameDataMgr.getInstance().getMoney(param1);
            var _loc_6:int = 0;
            switch(param2)
            {
                case 0:
                {
                    _loc_6 = Math.floor(_loc_4 * 0.1);
                    break;
                }
                case 1:
                {
                    _loc_6 = Math.floor(_loc_4 * 0.5);
                    break;
                }
                case 2:
                {
                    _loc_6 = _loc_4 - _loc_5;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_6 > 0 && _loc_5 + _loc_6 <= _loc_4)
            {
                _loc_3 = new Object();
                _loc_3.type = param1;
                _loc_3.value = _loc_6;
                _loc_3.shopType = param2 + 1;
            }
            return _loc_3;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_NEXT:
                {
                    this.pageItem.nextPage();
                    this.bmpNext.enable = this.pageItem.canNext();
                    this.bmpPrev.enable = this.pageItem.canPrev();
                    break;
                }
                case BMP_PREVIOUS:
                {
                    this.pageItem.prevPage();
                    this.bmpNext.enable = this.pageItem.canNext();
                    this.bmpPrev.enable = this.pageItem.canPrev();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function initShieldShop() : void
        {
            var _loc_9:DataShield = null;
            var _loc_10:GuiShopItem = null;
            this.removeAllItem();
            var _loc_1:Number = 590;
            var _loc_2:Number = 315;
            var _loc_3:* = new Sprite();
            var _loc_4:int = 0;
            var _loc_5:int = 5;
            var _loc_6:int = 0;
            var _loc_7:int = 159;
            var _loc_8:int = 0;
            while (_loc_8 < 3)
            {
                
                _loc_9 = JsonMgr.getInstance().getShieldData((_loc_8 + 1));
                _loc_10 = new GuiShopItem();
                _loc_3.addChild(_loc_10.bgImg);
                _loc_10.setPos(_loc_8 % NUM_COL * (_loc_10.widthBg + _loc_5), _loc_6 + Math.floor(_loc_8 / NUM_COL) * _loc_7);
                _loc_10.setShieldIcon((_loc_8 + 1), _loc_9);
                this.listItem.push(_loc_10);
                _loc_8++;
            }
            this.pageItem.setData(_loc_3, _loc_1, _loc_2, 0, PageMgr.HOZIRONTOL, true, 1);
            var _loc_11:* = this.pageItem.totalPage > 1;
            this.bmpPrev.visible = this.pageItem.totalPage > 1;
            this.bmpNext.visible = _loc_11;
            this.bmpNext.enable = this.pageItem.canNext();
            this.bmpPrev.enable = this.pageItem.canPrev();
            return;
        }// end function

        public function updateShieldIcon() : void
        {
            var _loc_3:Number = NaN;
            var _loc_1:* = GameDataMgr.getInstance().myInfo.shieldList;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = Utility.getCurTime();
                if (_loc_1[_loc_2] <= _loc_3)
                {
                    this.listItem[_loc_2].enableShield();
                }
                else
                {
                    if (this.listItem[_loc_2].bmpShopItem.enable)
                    {
                        this.listItem[_loc_2].disableShieild();
                    }
                    this.listItem[_loc_2].labelTime.text = Utility.convertTimeToShortString(_loc_1[_loc_2] - _loc_3);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function updateShieldState() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().myInfo.shieldList;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                this.listItem[_loc_2].updateShieldState();
                _loc_2++;
            }
            return;
        }// end function

    }
}
