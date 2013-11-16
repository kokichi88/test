package map.logic
{

    public class Vector2D extends Object
    {
        public var x:Number;
        public var y:Number;

        public function Vector2D(param1:Number = 0, param2:Number = 0)
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function clone() : Vector2D
        {
            return new Vector2D(this.x, this.y);
        }// end function

        public function get length() : Number
        {
            var _loc_1:* = Math.sqrt(this.x * this.x + this.y * this.y);
            return _loc_1;
        }// end function

        public function sub(param1:Vector2D) : Vector2D
        {
            var _loc_2:* = new Vector2D(this.x - param1.x, this.y - param1.y);
            return _loc_2;
        }// end function

        public function plus(param1:Vector2D) : Vector2D
        {
            var _loc_2:* = new Vector2D(this.x + param1.x, this.y + param1.y);
            return _loc_2;
        }// end function

        public function mul(param1:Vector2D) : Number
        {
            return this.x * param1.x + this.y * param1.y;
        }// end function

        public function mulf(param1:Number) : Vector2D
        {
            return new Vector2D(param1 * this.x, param1 * this.y);
        }// end function

        public function normalize(param1:Number = 1) : void
        {
            var _loc_2:* = this.length;
            if (_loc_2 == 0)
            {
                return;
            }
            var _loc_3:* = param1 / _loc_2;
            this.x = this.x * _loc_3;
            this.y = this.y * _loc_3;
            return;
        }// end function

        public function getAngle0() : Number
        {
            var _loc_1:Number = NaN;
            _loc_1 = Radian2Degree(this.getAngle());
            return _loc_1;
        }// end function

        public function getAngle() : Number
        {
            var a:Number;
            try
            {
                a = Math.atan(this.y / this.x);
                if (this.x < 0)
                {
                    a = a + Math.PI;
                }
                if (this.x >= 0 && this.y < 0)
                {
                    a = a + 2 * Math.PI;
                }
            }
            catch (e:Error)
            {
                a;
            }
            return a;
        }// end function

        public function getAngle0WithVector(param1:Vector2D) : Number
        {
            var _loc_2:* = this.getAngle0();
            var _loc_3:* = param1.getAngle0();
            var _loc_4:* = _loc_2 - _loc_3;
            if (_loc_2 - _loc_3 > 180)
            {
                _loc_4 = _loc_4 - 360;
            }
            else if (_loc_4 < -180)
            {
                _loc_4 = _loc_4 + 360;
            }
            return _loc_4;
        }// end function

        public function rotate(param1:Number) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            _loc_3 = Math.sin(param1 * Math.PI / 180);
            _loc_2 = Math.cos(param1 * Math.PI / 180);
            _loc_4 = this.x;
            _loc_5 = this.y;
            this.x = _loc_4 * _loc_2 - _loc_5 * _loc_3;
            this.y = _loc_4 * _loc_3 + _loc_5 * _loc_2;
            return;
        }// end function

        public static function Radian2Degree(param1:Number) : Number
        {
            return param1 * 180 / Math.PI;
        }// end function

        public static function Degree2Radian(param1:Number) : Number
        {
            return param1 / 180 * Math.PI;
        }// end function

    }
}
