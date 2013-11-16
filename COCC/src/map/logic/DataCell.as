package map.logic
{
    import flash.geom.*;

    public class DataCell extends Object
    {
        public var isoCell:Point;
        public var value:int = 0;

        public function DataCell()
        {
            this.isoCell = new Point();
            return;
        }// end function

    }
}
