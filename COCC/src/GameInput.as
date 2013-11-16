package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import map.logic.*;
    import modules.battle.*;
    import modules.city.graphics.tutorial.*;
    import resMgr.*;
    import utility.*;

    public class GameInput extends Object
    {
        private var lastMouseDownPos:Point;
        private var lastMapPos:Point;
        public var isMouseDown:Boolean = false;
        public var isMouseDrag:Boolean = false;
        public var isDragging:Boolean = false;
        private var isMoving:Boolean = false;
        private var timer:Timer;
        private var downTime:int = 0;
        private var kt:Boolean = false;
        private var timeMouseDown:Number;
        public static var TIME_DROP_TROOP:int = 350;
        public static const TIME_DRAW:int = 100;
        private static var instance:GameInput;

        public function GameInput()
        {
            this.lastMouseDownPos = new Point(0, 0);
            this.lastMapPos = new Point(0, 0);
            GlobalVar.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            TIME_DROP_TROOP = 350;
            this.timer = new Timer(100);
            this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            return;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            var _loc_2:Layer = null;
            if (this.downTime == 0)
            {
                return;
            }
            BaseMap.startDown = getTimer();
            if (getTimer() - this.downTime > TIME_DROP_TROOP)
            {
                this.downTime = getTimer();
                BattleModule.getInstance().onClickMap();
                _loc_2 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
                _loc_2.stopDrag();
                this.kt = true;
                TIME_DROP_TROOP = 100;
            }
            return;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            var _loc_2:int = 0;
            switch(event.keyCode)
            {
                case Keyboard.S:
                {
                    break;
                }
                case Keyboard.G:
                {
                    break;
                }
                case Keyboard.V:
                {
                    break;
                }
                case Keyboard.C:
                {
                    break;
                }
                case Keyboard.R:
                {
                    break;
                }
                case Keyboard.B:
                {
                    break;
                }
                case Keyboard.H:
                {
                    break;
                }
                case Keyboard.F1:
                {
                    break;
                }
                case Keyboard.F2:
                {
                    break;
                }
                case Keyboard.R:
                {
                    break;
                }
                default:
                {
                    if (GlobalVar.state == GlobalVar.STATE_BATTLE || GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
                    {
                        _loc_2 = event.keyCode - Keyboard.NUMBER_0;
                        if (_loc_2 >= 0 && _loc_2 < 10)
                        {
                            _loc_2 = _loc_2 - 1;
                            _loc_2 = _loc_2 + 11;
                            _loc_2 = _loc_2 % 11;
                            BattleModule.getInstance().guiBattleTroop.focusTroop(_loc_2);
                        }
                    }
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function onMouseDown(event:MouseEvent) : void
        {
            this.isMouseDown = true;
            this.timeMouseDown = Utility.getCurTime();
            if (!TutorialMgr.getInstance().isTutorial)
            {
                if (this.isTargetLayer(event, GlobalVar.LAYER_BG) || this.isTargetLayer(event, GlobalVar.LAYER_GAME))
                {
                    this.lastMouseDownPos.x = event.stageX;
                    this.lastMouseDownPos.y = event.stageY;
                    if (GlobalVar.state == GlobalVar.STATE_BATTLE || GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
                    {
                        this.downTime = getTimer();
                        this.timer.start();
                        this.kt = false;
                    }
                }
            }
            else if (this.isTargetLayer(event, GlobalVar.LAYER_BG) || this.isTargetLayer(event, GlobalVar.LAYER_GAME))
            {
                this.lastMouseDownPos.x = event.stageX;
                this.lastMouseDownPos.y = event.stageY;
                if (GlobalVar.state == GlobalVar.STATE_BATTLE || GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
                {
                    this.downTime = getTimer();
                    this.timer.start();
                    this.kt = false;
                }
            }
            return;
        }// end function

        public function onMouseMove(event:MouseEvent) : void
        {
            if (this.isTargetLayer(event, GlobalVar.LAYER_BG) || this.isTargetLayer(event, GlobalVar.LAYER_GAME))
            {
                if (this.isMouseDown)
                {
                    this.isMoving = true;
                    GlobalVar.mouseState = GlobalVar.MOVE_MAP;
                }
            }
            if (!this.kt)
            {
                this.downTime = 0;
                this.timer.stop();
            }
            if (this.isMouseDrag)
            {
                this.isDragging = true;
            }
            else
            {
                this.isDragging = false;
            }
            return;
        }// end function

        public function onMouseUp(event:MouseEvent) : void
        {
            GlobalVar.mouseState = GlobalVar.NONE_STATE;
            this.isMouseDown = false;
            this.isMouseDrag = false;
            var _loc_2:* = Utility.getCurTime() - this.timeMouseDown;
            if (!this.isMoving)
            {
                if (this.isTargetLayer(event, GlobalVar.LAYER_BG))
                {
                    if (GlobalVar.state == GlobalVar.STATE_BATTLE || GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
                    {
                        BattleModule.getInstance().onClickMap();
                    }
                }
            }
            else if (_loc_2 < 0.15)
            {
                if (this.isTargetLayer(event, GlobalVar.LAYER_BG))
                {
                    if (GlobalVar.state == GlobalVar.STATE_BATTLE || GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
                    {
                        BattleModule.getInstance().onClickMap();
                    }
                }
            }
            this.isMoving = false;
            var _loc_3:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
            _loc_3.stopDrag();
            this.downTime = 0;
            TIME_DROP_TROOP = 350;
            this.timer.stop();
            this.kt = false;
            return;
        }// end function

        public function onMouseWheel(event:MouseEvent) : void
        {
            return;
        }// end function

        public function onMouseOver(event:MouseEvent) : void
        {
            return;
        }// end function

        public function onMouseOut(event:MouseEvent) : void
        {
            return;
        }// end function

        public function onMouseClick(event:MouseEvent) : void
        {
            return;
        }// end function

        private function isTargetLayer(event:MouseEvent, param2:int) : Boolean
        {
            var _loc_3:* = event.target as Sprite;
            if (this.checkInLayer(_loc_3, param2))
            {
                return true;
            }
            return false;
        }// end function

        private function checkInLayer(param1:Sprite, param2:int = 0) : Boolean
        {
            var _loc_3:Layer = null;
            if (param1)
            {
                if (param1.alpha == 0)
                {
                    return true;
                }
                _loc_3 = LayerMgr.getInstance().getLayer(param2);
                if (param1 == _loc_3 || _loc_3.contains(param1))
                {
                    return true;
                }
                return this.checkInLayer(param1.parent as Sprite, param2);
            }
            return false;
        }// end function

        public static function getInstance() : GameInput
        {
            if (!instance)
            {
                instance = new GameInput;
            }
            return instance;
        }// end function

    }
}
