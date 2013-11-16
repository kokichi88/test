package bitzero.engine
{
    import bitzero.engine.*;
    import bitzero.exceptions.*;
    import bitzero.logging.*;

    public class BaseController extends Object implements IController
    {
        protected var log:Logger;
        protected var _id:int = -1;

        public function BaseController()
        {
            this.log = Logger.getInstance();
            return;
        }// end function

        public function set id(param1:int) : void
        {
            if (this._id != -1)
            {
                throw new BZError("Controller ID is already set: " + this._id + ". Can\'t be changed at runtime!");
            }
            this._id = param1;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function handleMessage(param1:IMessage) : void
        {
            return;
        }// end function

    }
}
