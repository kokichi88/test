package resMgr
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import map.*;

    public class LayerMgr extends Object
    {
        private var LayerArr:Array;
        private static var instance:LayerMgr = new LayerMgr;

        public function LayerMgr()
        {
            this.LayerArr = [];
            return;
        }// end function

        public function AddLayer(param1:Stage) : Layer
        {
            var _loc_2:* = new Layer(this.LayerArr.length);
            _loc_2.x = 0;
            _loc_2.y = 0;
            param1.addChild(_loc_2);
            this.LayerArr.push(_loc_2);
            return this.LayerArr[(this.LayerArr.length - 1)] as Layer;
        }// end function

        public function AddLayers(param1:Sprite, param2:int) : void
        {
            var _loc_3:Layer = null;
            var _loc_4:int = 0;
            _loc_4 = 0;
            while (_loc_4 < param2)
            {
                
                _loc_3 = new Layer(this.LayerArr.length);
                _loc_3.mouseEnabled = false;
                if (_loc_4 >= GlobalVar.LAYER_MOVE)
                {
                    param1.addChild(_loc_3);
                }
                this.LayerArr.push(_loc_3);
                _loc_4++;
            }
            _loc_3 = this.getLayer(GlobalVar.LAYER_MOVE);
            _loc_4 = 0;
            while (_loc_4 < GlobalVar.LAYER_MOVE)
            {
                
                _loc_3.addChild(this.getLayer(_loc_4));
                _loc_4++;
            }
            var _loc_5:* = GlobalVar.INIT_SCALE;
            _loc_3.scaleY = GlobalVar.INIT_SCALE;
            _loc_3.scaleX = _loc_5;
            _loc_3.addEventListener(MouseEvent.MOUSE_WHEEL, MapMgr.getInstance().onMouseWheel);
            return;
        }// end function

        public function clearLayer(param1:int) : void
        {
            var _loc_2:* = this.getLayer(param1);
            if (_loc_2)
            {
                _loc_2.clear();
            }
            return;
        }// end function

        public function clearAllLayers() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.LayerArr.length)
            {
                
                this.clearLayer(_loc_1);
                _loc_1++;
            }
            return;
        }// end function

        public function resetAllLayer() : void
        {
            var _loc_2:Layer = null;
            var _loc_1:int = 0;
            while (_loc_1 < this.LayerArr.length)
            {
                
                _loc_2 = this.getLayer(_loc_1);
                _loc_2.x = 0;
                _loc_2.y = 0;
                _loc_1++;
            }
            return;
        }// end function

        public function removeAllLayers() : void
        {
            this.LayerArr.splice(0, this.LayerArr.length);
            return;
        }// end function

        public function getTopLayer() : int
        {
            return (this.LayerArr.length - 1);
        }// end function

        public function getLayer(param1:int) : Layer
        {
            if (param1 < 0 || param1 >= this.LayerArr.length)
            {
                return null;
            }
            return this.LayerArr[param1] as Layer;
        }// end function

        public function getLayerIndex(param1:Object) : int
        {
            var _loc_2:int = 0;
            _loc_2 = 0;
            while (_loc_2 < this.LayerArr.length)
            {
                
                if (this.LayerArr[_loc_2] == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public function getLayerNumber() : int
        {
            return this.LayerArr.length;
        }// end function

        public function fillLayer(param1:int, param2:int) : void
        {
            var _loc_3:* = this.getLayer(param1);
            _loc_3.fillLayer(param2);
            return;
        }// end function

        public function vibreateAll(param1:int = 1) : void
        {
            return;
        }// end function

        public function getGlobal(param1:int, param2:Point) : Point
        {
            var _loc_3:* = this.getLayer(param1);
            param2 = _loc_3.localToGlobal(param2);
            return param2;
        }// end function

        public function getLocal(param1:int, param2:Point) : Point
        {
            var _loc_3:* = this.getLayer(param1);
            param2 = _loc_3.globalToLocal(param2);
            return param2;
        }// end function

        public static function getInstance() : LayerMgr
        {
            if (instance == null)
            {
                instance = new LayerMgr;
            }
            return instance;
        }// end function

        public static function clear() : void
        {
            instance = null;
            return;
        }// end function

    }
}
