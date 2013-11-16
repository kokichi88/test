package modules.city.logic
{
    import __AS3__.vec.*;
    import component.avatar.model.animation.*;
    import component.avatar.things.*;
    import flash.geom.*;
    import map.*;
    import modules.battle.logic.bean.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class AngryBird extends Object
    {
        public var birdId:int;
        private var deepLevel:int = 50;
        private var avatar:Avatar;
        private var moveSpeed:int = 80;
        public var move:BaseMoving;
        private var countDownFrame:int = 70;
        private static const FRAME_STAND:int = 70;

        public function AngryBird()
        {
            this.move = new BaseMoving();
            return;
        }// end function

        public function setInfo(param1:int) : void
        {
            this.birdId = param1;
            this.create(AnCategory.AVATAR, "ANGRY_BIRD");
            return;
        }// end function

        public function create(param1:String, param2:String) : void
        {
            var _loc_5:Point = null;
            var _loc_6:Point = null;
            this.avatar = new Avatar();
            this.avatar.create(param1, param2, 1);
            this.avatar.hideShadow();
            this.avatar.anSetting.currDir = 5;
            var _loc_3:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
            _loc_3.addChild(this.avatar);
            this.avatar.mouseChildren = false;
            this.avatar.mouseEnabled = false;
            var _loc_4:* = Utility.randomNumber(1, 4);
            _loc_6 = this.randomOfType(_loc_4);
            switch(_loc_4)
            {
                case 1:
                {
                    _loc_5 = this.randomOfType(3);
                    break;
                }
                case 2:
                {
                    _loc_5 = this.randomOfType(4);
                    break;
                }
                case 3:
                {
                    _loc_5 = this.randomOfType(1);
                    break;
                }
                case 4:
                {
                    _loc_5 = this.randomOfType(2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.move.curCell = MapMgr.getInstance().battleMap.isoToCell(_loc_6.x, _loc_6.y);
            var _loc_7:* = new Vector.<int>;
            _loc_7 = MapMgr.getInstance().battleMap.pathTo(this.move.curCell, MapMgr.getInstance().battleMap.isoToCell(_loc_5.x, _loc_5.y), this.deepLevel, false, false, true);
            this.move.moveTo(_loc_7, this.moveSpeed);
            this.setAction(AnConst.RUN, this.move.dir);
            return;
        }// end function

        private function randomOfType(param1:int) : Point
        {
            var _loc_2:* = new Point();
            switch(param1)
            {
                case 1:
                {
                    _loc_2.y = 0;
                    _loc_2.x = Utility.randomNumber(0, 131);
                    break;
                }
                case 2:
                {
                    _loc_2.x = 131;
                    _loc_2.y = Utility.randomNumber(0, 131);
                    break;
                }
                case 3:
                {
                    _loc_2.y = 131;
                    _loc_2.x = Utility.randomNumber(0, 131);
                    break;
                }
                case 4:
                {
                    _loc_2.x = 0;
                    _loc_2.y = Utility.randomNumber(0, 131);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function setAction(param1:int, param2:int, param3:int = -1) : void
        {
            if (this.avatar)
            {
                this.avatar.addFrameScript();
                switch(param1)
                {
                    case AnConst.RUN:
                    case AnConst.ATTACK:
                    {
                        this.avatar.updatefrs(1);
                        break;
                    }
                    case AnConst.STAND:
                    {
                        this.avatar.updatefrs(4);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.avatar.setAction(param1, param2, Utility.randomNumber(2, 3), 1);
            }
            return;
        }// end function

        public function loop() : void
        {
            this.move.updateLogic();
            this.avatar.x = this.move.x;
            this.avatar.y = this.move.y;
            if (this.avatar.anSetting.currDir != this.move.dir)
            {
                this.avatar.anSetting.currDir = this.move.dir;
            }
            if (this.move.status == AnConst.STAND)
            {
                CityMgr.getInstance().removeAngryBird(this.birdId);
            }
            if (this.avatar && this.avatar.anSetting.currAction == AnConst.STAND)
            {
                var _loc_1:String = this;
                var _loc_2:* = this.countDownFrame - 1;
                _loc_1.countDownFrame = _loc_2;
            }
            if (this.avatar && this.countDownFrame <= 0)
            {
                this.avatar.setAction(AnConst.RUN, this.move.dir, Utility.randomNumber(2, 3), 1);
                this.countDownFrame = FRAME_STAND;
            }
            return;
        }// end function

        public function destroy() : void
        {
            if (this.avatar != null && this.avatar.parent != null)
            {
                this.avatar.destroy();
                this.avatar.parent.removeChild(this.avatar);
                this.avatar.visible = false;
                this.avatar = null;
            }
            return;
        }// end function

    }
}
