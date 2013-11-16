package component.avatar.model.animation
{

    dynamic public class AnLoadData extends Object
    {
        public var y:int;
        public var ready:Boolean = false;
        public var priority:int = 0;
        public var loaded:Boolean = false;
        public var preload:Boolean = false;
        public var name:String;
        public var ref:int = 0;
        public var loadings:int = 0;
        public var x:int;
        public var content:Object;
        public var category:String;
        public var isfiler:Boolean = false;
        public var frInfo:Array;

        public function AnLoadData(param1:String, param2:String, param3:int = 0)
        {
            this.frInfo = new Array();
            this.x = (-AnConst.PEOPLE_WIDTH) / 2;
            this.y = -AnConst.PEOPLE_HEIGHT;
            this.name = param2;
            this.category = param1;
            this.priority = param3;
            return;
        }// end function

        public function getFrameInfo() : Array
        {
            if (!this.ready)
            {
                return null;
            }
            return this.frInfo;
        }// end function

    }
}
