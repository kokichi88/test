package component
{
    import com.greensock.*;
    import flash.display.*;
    import flash.geom.*;

    public class PageMgr extends Sprite
    {
        private var typePage:int = 0;
        private var wR:int = 0;
        private var hR:int = 0;
        private var wD:int = 0;
        private var hD:int = 0;
        public var totalPage:int;
        private var _iPage:int;
        private var speed:int = 1;
        private var offset:int = 0;
        public var smooth:Boolean = true;
        public var rectM:Sprite;
        public var data:Sprite;
        public static const VERTICAL:int = 0;
        public static const HOZIRONTOL:int = 1;
        public static const WIDTH:int = 400;
        public static const HEIGHT:int = 200;
        public static const X:int = 10;
        public static const Y:int = 10;

        public function PageMgr(param1:Object)
        {
            param1.addChild(this);
            return;
        }// end function

        public function setData(param1:Sprite, param2:int, param3:int, param4:int = 10, param5:int = 1, param6:Boolean = true, param7:int = 1) : void
        {
            this.clear();
            this.typePage = param5;
            this.wR = param2;
            this.hR = param3;
            this.data = param1;
            this.wD = this.data.width;
            this.hD = this.data.height;
            this.smooth = param6;
            this.speed = param7;
            this.offset = param4;
            this.rectM = new Sprite();
            this.rectM.graphics.beginFill(0, 1);
            this.rectM.graphics.drawRect(0, 0, this.wR, this.hR);
            this.rectM.graphics.endFill();
            this.addChild(this.rectM);
            this.addChild(this.data);
            this.data.mask = this.rectM;
            switch(this.typePage)
            {
                case VERTICAL:
                {
                    this.hD = this.hD + param4;
                    this.totalPage = this.hD % this.hR == 0 ? (this.hD / this.hR) : ((this.int(this.hD / this.hR) + 1));
                    break;
                }
                case HOZIRONTOL:
                {
                    this.wD = this.wD + param4;
                    this.totalPage = this.wD % this.wR == 0 ? (this.wD / this.wR) : ((this.int(this.wD / this.wR) + 1));
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.data.x = param4;
            this.data.y = param4;
            this.iPage = 0;
            return;
        }// end function

        public function set iPage(param1:int) : void
        {
            this._iPage = param1;
            this.changePage();
            return;
        }// end function

        public function get iPage() : int
        {
            return this._iPage;
        }// end function

        public function get pwidth() : int
        {
            return this.wR;
        }// end function

        public function get pheight() : int
        {
            return this.hR;
        }// end function

        public function canNext() : Boolean
        {
            if (this.iPage < (this.totalPage - 1))
            {
                return true;
            }
            return false;
        }// end function

        public function canPrev() : Boolean
        {
            if (this.iPage > 0)
            {
                return true;
            }
            return false;
        }// end function

        public function nextPage() : void
        {
            if (!this.canNext())
            {
                return;
            }
            (this.iPage + 1);
            return;
        }// end function

        public function prevPage() : void
        {
            if (!this.canPrev())
            {
                return;
            }
            (this.iPage - 1);
            return;
        }// end function

        public function lastPage() : void
        {
            if (!this.canNext())
            {
                return;
            }
            this.iPage = this.totalPage - 1;
            return;
        }// end function

        public function firstPage() : void
        {
            if (!this.canPrev())
            {
                return;
            }
            this.iPage = 0;
            return;
        }// end function

        private function changePage() : void
        {
            var _loc_1:* = this.getPosPage();
            if (this.smooth)
            {
                TweenLite.to(this.data, this.speed, {x:_loc_1.x, y:_loc_1.y});
            }
            else
            {
                this.data.x = _loc_1.x;
                this.data.y = _loc_1.y;
            }
            return;
        }// end function

        private function getPosPage() : Point
        {
            var _loc_1:* = new Point();
            switch(this.typePage)
            {
                case VERTICAL:
                {
                    _loc_1.x = this.offset;
                    _loc_1.y = -this.hR * this.iPage + this.offset;
                    break;
                }
                case HOZIRONTOL:
                {
                    _loc_1.x = -this.wR * this.iPage + this.offset;
                    _loc_1.y = this.offset;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        public function setPos(param1:int, param2:int) : void
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function getPagebyPos(param1:Point) : int
        {
            var _loc_2:int = 0;
            switch(this.typePage)
            {
                case VERTICAL:
                {
                    _loc_2 = int(param1.y / this.hR);
                    break;
                }
                case HOZIRONTOL:
                {
                    _loc_2 = int(param1.x / this.wR);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function clear() : void
        {
            while (this.numChildren > 0)
            {
                
                this.removeChildAt(0);
            }
            return;
        }// end function

        public function destructor() : void
        {
            this.clear();
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

    }
}
