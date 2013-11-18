package modules.city.graphics.tutorial
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import component.*;
    import component.avatar.controls.*;
    import component.avatar.things.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import gameData.*;
    import map.*;
    import map.logic.*;
    import modules.battle.*;
    import modules.battle.data.*;
    import modules.battle.logic.*;
    import modules.city.*;
    import modules.city.graphics.build.*;
    import modules.city.graphics.shop.*;
    import modules.city.graphics.sideQuest.*;
    import modules.city.logic.*;
    import modules.sound.*;
    import network.receive.*;
    import resMgr.*;
    import utility.*;

    public class TutorialMgr extends Object
    {
        public var curStep:int = 0;
        public var isTutorial:Boolean = false;
        public var layer:Layer;
        public var arrow:Sprite = null;
        public var guideText:TooltipText = null;
        public var numGoblin:int = 2;
        private var timer:Timer = null;
        public var myInfo:UserInfo;
        public var listBuilding:Vector.<MapObject>;
        private var startPos:Point;
        private var endPos:Point;
        private var temp:int = 0;
        private var stateArrow:int = 0;
        private var numRun:int = 0;
        private var numShow:int = 0;
        public var isMovingBox:Boolean = false;
        private static var _inst:TutorialMgr;
        public static var canonPos:Point = new Point(25, 22);
        public static var townHallPos:Point = new Point(20, 20);
        public static var canon2Pos:Point = new Point(30, 30);
        public static var bhPos:Point = new Point(28, 21);
        public static var elixirStoragePos:Point = new Point(25, 25);
        public static var goldStoragePos:Point = new Point(28, 25);
        public static var posBar:Point = new Point(21, 29);
        private static const MAX_RUN:int = 3;
        private static const MAX_SHOW:int = 2;

        public function TutorialMgr()
        {
            this.myInfo = new UserInfo();
            this.listBuilding = new Vector.<MapObject>;
            this.startPos = new Point();
            this.endPos = new Point();
            this.layer = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP);
            this.layer.mouseEnabled = true;
            return;
        }// end function

        private function rollbackStep() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            switch(this.curStep)
            {
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:
                case 6:
                {
                    this.curStep = 0;
                    break;
                }
                case 8:
                case 9:
                {
                    this.curStep = 7;
                    break;
                }
                case 11:
                {
                    this.curStep = 10;
                    break;
                }
                case 15:
                {
                    this.curStep = 14;
                    break;
                }
                case 17:
                case 18:
                case 19:
                case 20:
                {
                    this.curStep = 16;
                    break;
                }
                case 22:
                case 23:
                case 24:
                case 25:
                {
                    this.curStep = 21;
                    break;
                }
                case 27:
                case 28:
                {
                    if (GameDataMgr.getInstance().storageList[0].status == MapObject.BUILDING)
                    {
                        this.curStep = 26;
                    }
                    break;
                }
                case 31:
                case 32:
                case 33:
                case 34:
                {
                    this.curStep = 30;
                    break;
                }
                case 36:
                case 37:
                {
                    this.curStep = 35;
                    break;
                }
                case 38:
                {
                    this.finishStep();
                    this.curStep = 39;
                    break;
                }
                case 40:
                case 41:
                case 42:
                case 43:
                {
                    this.curStep = 39;
                    break;
                }
                case 45:
                case 46:
                {
                    this.curStep = 44;
                    break;
                }
                case 47:
                {
                    this.finishStep();
                    this.curStep = 48;
                    break;
                }
                case 49:
                case 50:
                case 51:
                {
                    this.curStep = 48;
                    break;
                }
                case 52:
                case 53:
                {
                    _loc_1 = GameDataMgr.getInstance().getCurrentHousingSpace();
                    if (_loc_1 < 20)
                    {
                        this.curStep = 48;
                    }
                    break;
                }
                case 54:
                case 55:
                case 56:
				case 57:
                {
                    this.curStep = 53;
                    break;
                }
                case 58:
                {
                    _loc_2 = GameDataMgr.getInstance().getCurrentHousingSpace();
                    if (_loc_2 < 20)
                    {
                        this.finishStep();
                        this.curStep = 59;
                    }
                    else
                    {
                        this.curStep = 53;
                    }
                    break;
                }
                case 60:
                {
                    this.curStep = 59;
                    break;
                }
                case 62:
                case 63:
                case 64:
                {
                    this.curStep = 61;
                    break;
                }
                case 66:
                case 67:
                {
                    this.curStep = 65;
                    break;
                }
                case 70:
                {
                    this.finishStep();
                    this.curStep = 71;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function initNewTut() : void
        {
            if (!this.timer)
            {
                this.timer = new Timer(2000, 0);
            }
            this.curStep = GameDataMgr.getInstance().myInfo.tutStep;
            this.rollbackStep();
            this.isTutorial = true;
            return;
        }// end function

        public function removeArrow() : void
        {
            if (this.arrow)
            {
                this.arrow.parent.removeChild(this.arrow);
                this.arrow = null;
            }
            this.removeGuideText();
            return;
        }// end function

        public function showArrow(param1:int, param2:int, param3:int = 0) : void
        {
            this.stateArrow = param3;
            this.removeArrow();
            this.arrow = ResMgr.getInstance().getMovieClip("Tutorial_Arrow") as Sprite;
            this.arrow.x = param1 - this.arrow.width / 2;
            this.arrow.y = param2 - this.arrow.height;
            this.startPos.x = this.arrow.x;
            this.startPos.y = this.arrow.y;
            this.endPos.x = this.startPos.x;
            this.endPos.y = this.startPos.y - 20;
            this.layer.addChild(this.arrow);
            this.startArrow();
            return;
        }// end function

        public function showRightArrow(param1:int, param2:int) : void
        {
            this.removeArrow();
            this.arrow = ResMgr.getInstance().getMovieClip("Tutorial_Arrow") as Sprite;
            this.arrow.rotation = -90;
            this.arrow.x = param1 - this.arrow.width;
            this.arrow.y = param2 + this.arrow.height / 2;
            this.startPos.x = this.arrow.x;
            this.startPos.y = this.arrow.y;
            this.endPos.x = this.startPos.x - 20;
            this.endPos.y = this.startPos.y;
            this.layer.addChild(this.arrow);
            this.startArrow();
            return;
        }// end function

        public function showLeftArrow(param1:int, param2:int) : void
        {
            this.removeArrow();
            this.arrow = ResMgr.getInstance().getMovieClip("Tutorial_Arrow") as Sprite;
            this.arrow.rotation = 90;
            this.arrow.mouseEnabled = false;
            this.arrow.mouseChildren = false;
            this.arrow.x = param1 + this.arrow.width;
            this.arrow.y = param2 - 20;
            this.startPos.x = this.arrow.x;
            this.startPos.y = this.arrow.y;
            this.endPos.x = this.startPos.x + 20;
            this.endPos.y = this.startPos.y;
            this.layer.addChild(this.arrow);
            this.startArrow();
            return;
        }// end function

        public function showDeployTownhall() : void
        {
            this.numRun = 0;
            this.numShow = 0;
            this.showDeployTroop(townHallPos.x, townHallPos.y + 9);
            return;
        }// end function

        public function showDeployTroop(param1:int, param2:int) : void
        {
            var _loc_3:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            var _loc_4:* = MapMgr.getInstance().cityMap.isoToPoint(param1, param2);
            _loc_4 = _loc_3.localToGlobal(_loc_4);
            this.showDeployTroopPosition(_loc_4.x, _loc_4.y);
            var _loc_5:* = Localization.getInstance().getString("Tutorial_Append3");
            this.showGuideText(_loc_5);
            return;
        }// end function

        public function showDeployTroopPosition(param1:int, param2:int) : void
        {
            this.showArrow(param1, param2 - 5, 1);
            return;
        }// end function

        private function startArrow() : void
        {
            if (this.arrow == null)
            {
                return;
            }
            TweenLite.to(this.arrow, 0.3, {x:this.endPos.x, y:this.endPos.y, onComplete:this.endArrow});
            return;
        }// end function

        private function endArrow() : void
        {
            var _loc_1:Layer = null;
            var _loc_2:Point = null;
            var _loc_3:AniEffect = null;
            if (this.arrow == null)
            {
                return;
            }
            if (this.stateArrow == 1)
            {
                _loc_1 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                _loc_2 = new Point(this.endPos.x + this.arrow.width / 2, this.endPos.y + this.arrow.height + 40);
                _loc_2 = _loc_1.globalToLocal(_loc_2);
                _loc_3 = EffectDraw.play("drop_troops", _loc_2, _loc_1);
                var _loc_4:int = 2;
                _loc_3.scaleY = 2;
                _loc_3.scaleX = _loc_4;
            }
            TweenLite.to(this.arrow, 0.3, {x:this.startPos.x, y:this.startPos.y, onComplete:this.startArrow});
            return;
        }// end function

        private function endMoveArrow() : void
        {
            if (this.arrow == null)
            {
                return;
            }
            this.numShow++;
            this.showDeployTroopPosition(this.startPos.x + 100 + this.arrow.width / 2, this.startPos.y + 100 + this.arrow.height);
            return;
        }// end function

        public function onMouseClick(event:MouseEvent) : void
        {
            if (this.isMovingBox)
            {
                return;
            }
            this.layer.removeEventListener(MouseEvent.CLICK, this.onMouseClick);
            switch(this.curStep)
            {
                case 0:
                case 3:
                case 17:
                case 22:
                case 31:
                case 40:
                case 48:
                case 53:
                case 61:
                case 70:
                {
                    CityMgr.getInstance().guiNPC1.moveOut();
                    break;
                }
                case 2:
                case 12:
                case 13:
                case 16:
                case 21:
                case 30:
                case 59:
                case 60:
                case 69:
                {
                    this.nextStep();
                    break;
                }
                case 1:
                case 39:
                {
                    CityMgr.getInstance().guiNPC2.moveOut();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function run(param1:int = 0) : void
        {
            var _loc_3:BitmapButton = null;
            var _loc_4:DefenseObject = null;
            var _loc_5:int = 0;
            var _loc_6:Boolean = false;
            var _loc_7:StorageObject = null;
            var _loc_8:StorageObject = null;
            var _loc_9:BarrackObject = null;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:BitmapButton = null;
            var _loc_15:BitmapButton = null;
            var _loc_16:Point = null;
            var _loc_17:BitmapButton = null;
            var _loc_18:TownHallObject = null;
            var _loc_19:Layer = null;
            var _loc_20:String = null;
            var _loc_21:BitmapButton = null;
            var _loc_22:TownHallObject = null;
            if (param1 > 0)
            {
                this.removeArrow();
                this.layer.ShowTutorialScreen(0, 0, 0, 0);
                this.timer.start();
                this.timer.addEventListener(TimerEvent.TIMER, this.run);
                param1 = 0;
                return;
            }
            this.timer.removeEventListener(TimerEvent.TIMER, this.run);
            this.timer.stop();
            var _loc_2:* = new Point();
            switch(this.curStep)
            {
                case 0:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(0);
                    break;
                }
                case 1:
                {
                    CityMgr.getInstance().guiNPC2.showTutorialStep(1);
                    break;
                }
                case 2:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(2);
                    break;
                }
                case 3:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(3, null, true);
                    break;
                }
                case 4:
                case 18:
                case 23:
                case 32:
                case 41:
                {
                    _loc_3 = CityMgr.getInstance().guiMainBottom.bmpShop;
                    _loc_2 = CityMgr.getInstance().guiMainBottom.getPos();
                    this.layer.ShowTutorialScreen(_loc_2.x + _loc_3.img.x + _loc_3.width / 2, _loc_2.y + _loc_3.img.y + _loc_3.height / 2, 35, 0);
                    this.showArrow(_loc_2.x + _loc_3.img.x + _loc_3.width / 2, _loc_2.y + _loc_3.img.y + _loc_3.height / 2 - 20);
                    if (this.curStep == 4)
                    {
                        this.showGuideText(Localization.getInstance().getString("Tutorial_Append4"));
                    }
                    break;
                }
                case 5:
                {
                    CityMgr.getInstance().guiShop.showDefenseShop();
                    this.showShopItem(2);
                    break;
                }
                case 6:
                {
                    this.showPositionOnMap(canonPos.x, canonPos.y, 3);
                    break;
                }
                case 7:
                {
                    _loc_4 = GameDataMgr.getInstance().defenseList[0];
                    if (_loc_4.status == MapObject.BUILDING)
                    {
                        this.removeArrow();
                        this.showPositionOnMap(canonPos.x, canonPos.y, 3, 0);
                    }
                    else
                    {
                        this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 8:
                {
                    if (GameDataMgr.getInstance().defenseList[0].status == MapObject.BUILDING)
                    {
                        this.focusAction(BuildingActionType.QUICK_FINISH);
                    }
                    else
                    {
                        this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 27:
                {
                    if (GameDataMgr.getInstance().storageList[0].status == MapObject.BUILDING)
                    {
                        this.focusAction(BuildingActionType.QUICK_FINISH);
                    }
                    else
                    {
                        this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 36:
                {
                    if (GameDataMgr.getInstance().storageList[1].status == MapObject.BUILDING)
                    {
                        this.focusAction(BuildingActionType.QUICK_FINISH);
                    }
                    else
                    {
                       this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 45:
                {
                    if (GameDataMgr.getInstance().barrackList[0].status == MapObject.BUILDING)
                    {
                        this.focusAction(BuildingActionType.QUICK_FINISH);
                    }
                    else
                    {
                       this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 50:
                {
                    _loc_5 = GameDataMgr.getInstance().getCurrentHousingSpace();
                    if (_loc_5 < 20)
                    {
                        this.focusAction(BuildingActionType.TRAIN_TROOP);
                    }
                    else
                    {
                       this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 9:
                {
                    if (GameDataMgr.getInstance().defenseList[0].status == MapObject.BUILDING)
                    {
                        if (GlobalVar.QUICK_FINISH_NEED_CONFIRM)
                        {
                            this.focusQuickFinish();
                        }
                    }
                    else
                    {
                        this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 28:
                {
                    if (GameDataMgr.getInstance().storageList[0].status == MapObject.BUILDING)
                    {
                        if (GlobalVar.QUICK_FINISH_NEED_CONFIRM)
                        {
                            this.focusQuickFinish();
                        }
                    }
                    else
                    {
                       this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 37:
                {
                    if (GameDataMgr.getInstance().storageList[1].status == MapObject.BUILDING)
                    {
                        if (GlobalVar.QUICK_FINISH_NEED_CONFIRM)
                        {
                            this.focusQuickFinish();
                        }
                    }
                    else
                    {
                      this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 46:
                {
                    if (GameDataMgr.getInstance().barrackList[0].status == MapObject.BUILDING)
                    {
                        if (GlobalVar.QUICK_FINISH_NEED_CONFIRM)
                        {
                            this.focusQuickFinish();
                        }
                    }
                    else
                    {
                       this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 10:
                {
                    this.removeArrow();
                    CityMgr.getInstance().guiNPC2.showTutorialStep(4, "TẤN CÔNG");
                    SoundModule.getInstance().playSound(SoundModule.GOBLIN_ATTACK);
                    break;
                }
                case 11:
                {
                    CityMgr.getInstance().guiNPC2.hide(true);
                    this.removeArrow();
                    this.runAnamationScene11();
                    this.layer.ShowTutorialScreen(0, 0, 0, 0);
                    break;
                }
                case 12:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(5);
                    SoundModule.getInstance().playBgMusic(SoundModule.MUSIC_BG_HOME);
                    break;
                }
                case 13:
                {
                    _loc_6 = CityMgr.getInstance().guiNPC1.isShowing;
                    CityMgr.getInstance().guiNPC1.showTutorialStep(6, null, _loc_6);
                    break;
                }
                case 14:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(7, "Tấn công", CityMgr.getInstance().guiNPC1.isShowing);
                    break;
                }
                case 15:
                {
                    CityMgr.getInstance().guiNPC1.hide(true);
                    this.makeScene15();
                    break;
                }
                case 16:
                {
                    this.removeArrow();
                    CityMgr.getInstance().guiNPC1.showTutorialStep(9);
                    SoundModule.getInstance().playBgMusic(SoundModule.MUSIC_BG_HOME);
                    break;
                }
                case 17:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(10, null, CityMgr.getInstance().guiNPC1.isShowing);
                    break;
                }
                case 19:
                {
                    CityMgr.getInstance().guiShop.showResourceShop();
                    this.showShopItem(5);
                    break;
                }
                case 20:
                {
                    this.showPositionOnMap(bhPos.x, bhPos.y, 2);
                    break;
                }
                case 21:
                {
                    this.removeArrow();
                    this.finishStep();
                    CityMgr.getInstance().guiNPC1.showTutorialStep(11);
                    break;
                }
                case 22:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(12, null, CityMgr.getInstance().guiNPC1.isShowing);
                    break;
                }
                case 24:
                {
                    this.showShopItem(4);
                    break;
                }
                case 25:
                {
                    this.showPositionOnMap(elixirStoragePos.x, elixirStoragePos.y, 3);
                    break;
                }
                case 26:
                {
                    _loc_7 = GameDataMgr.getInstance().storageList[0];
                    if (_loc_7.status == MapObject.BUILDING)
                    {
                        this.showPositionOnMap(elixirStoragePos.x, elixirStoragePos.y, 3, 0);
                    }
                    else
                    {
                       this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 29:
                {
                    this.removeArrow();
                    this.nextStep(1);
                    break;
                }
                case 30:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(13);
                    break;
                }
                case 31:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(14, null, CityMgr.getInstance().guiNPC1.isShowing);
                    break;
                }
                case 33:
                {
                    this.showShopItem(3);
                    break;
                }
                case 34:
                {
                    this.showPositionOnMap(goldStoragePos.x, goldStoragePos.y, 3);
                    break;
                }
                case 35:
                {
                    _loc_8 = GameDataMgr.getInstance().storageList[1];
                    if (_loc_8.status == MapObject.BUILDING)
                    {
                        this.showPositionOnMap(goldStoragePos.x, goldStoragePos.y, 3, 0);
                    }
                    else
                    {
                        this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 38:
                {
                    this.removeArrow();
                    this.nextStep(1);
                    break;
                }
                case 39:
                {
                    CityMgr.getInstance().guiNPC2.showTutorialStep(15);
                    break;
                }
                case 40:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(16);
                    break;
                }
                case 42:
                {
                    CityMgr.getInstance().guiShop.showArmyShop();
                    this.showShopItem(2);
                    break;
                }
                case 43:
                {
                    this.showPositionOnMap(posBar.x, posBar.y, 3);
                    break;
                }
                case 44:
                {
                    _loc_9 = GameDataMgr.getInstance().barrackList[0];
                    if (_loc_9.status == MapObject.BUILDING)
                    {
                        this.showPositionOnMap(posBar.x, posBar.y, 3, 0);
                    }
                    else
                    {
                       this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 47:
                {
                    this.removeArrow();
                    this.nextStep(1);
                    break;
                }
                case 48:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(17);
                    break;
                }
                case 49:
                {
                    _loc_10 = GameDataMgr.getInstance().getCurrentHousingSpace();
                    if (_loc_10 < 20)
                    {
                        _loc_2 = MapMgr.getInstance().cityMap.isoToPoint(posBar.x, posBar.y);
                        _loc_19 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
                        _loc_2 = _loc_19.localToGlobal(_loc_2);
                        _loc_2.y = _loc_2.y + 40;
                        this.layer.ShowTutorialScreen(_loc_2.x, _loc_2.y, 50, 0);
                        this.showArrow(_loc_2.x, _loc_2.y - 45);
                    }
                    else
                    {
                       this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 51:
                {
                    _loc_11 = GameDataMgr.getInstance().getCurrentHousingSpace();
                    _loc_12 = CityMgr.getInstance().guiTrainTroop2.getTrainHousingSpace();
                    if (_loc_11 < 20 && _loc_12 < 20)
                    {
                        _loc_2 = CityMgr.getInstance().guiTrainTroop2.getPos();
                        _loc_2.x = _loc_2.x + 66;
                        _loc_2.y = _loc_2.y + 240;
                        this.layer.ShowTutorialScreenRect(_loc_2.x, _loc_2.y, 102, 132, 0);
                        this.showArrow(_loc_2.x + 51, _loc_2.y);
                        _loc_20 = Localization.getInstance().getString("Tutorial_Append0");
                        _loc_20 = _loc_20.replace("@count@", _loc_12);
                        this.showGuideText(_loc_20);
                    }
                    else
                    {
                        this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 52:
                {
                    _loc_13 = GameDataMgr.getInstance().getCurrentHousingSpace();
                    if (_loc_13 < 20)
                    {
                        this.removeGuideText();
                        _loc_2 = CityMgr.getInstance().guiTrainTroop2.getPos();
                        _loc_21 = CityMgr.getInstance().guiTrainTroop2.bmpQuickFinish;
                        _loc_2.x = _loc_2.x + _loc_21.img.x;
                        _loc_2.y = _loc_2.y + _loc_21.img.y;
                        this.layer.ShowTutorialScreenRect(_loc_2.x, _loc_2.y, 120, 52, 0);
                        this.showArrow(_loc_2.x + 60, _loc_2.y);
                    }
                    else
                    {
                        this.curStep++;
                        this.finishStep();
                        this.run(1);
                    }
                    break;
                }
                case 53:
                {
                    this.removeArrow();
                    CityMgr.getInstance().guiNPC1.showTutorialStep(18);
                    break;
                }
                case 54:
                {
                    _loc_2 = CityMgr.getInstance().guiMainBottom.getPos();
                    _loc_14 = CityMgr.getInstance().guiMainBottom.bmpAttack;
                    _loc_2.x = _loc_2.x + _loc_14.img.x;
                    _loc_2.y = _loc_2.y + _loc_14.img.y;
                    this.layer.ShowTutorialScreen(_loc_2.x - 2 + _loc_14.width / 2, _loc_2.y + 50, 45, 0);
                    this.showRightArrow(_loc_2.x + _loc_14.width / 2 - 50, _loc_2.y + 20);
                    break;
                }
                case 55:
                {
                    _loc_2 = CityMgr.getInstance().guiFindMath.getPos();
                    _loc_15 = CityMgr.getInstance().guiFindMath.bmpSingleMap;
                    _loc_2.x = _loc_2.x + _loc_15.img.x;
                    _loc_2.y = _loc_2.y + _loc_15.img.y;
                    this.layer.ShowTutorialScreenRect(_loc_2.x - 2, _loc_2.y - 2, _loc_15.width + 4, _loc_15.height + 4, 0);
                    this.showArrow(_loc_2.x + _loc_15.width / 2, _loc_2.y);
                    break;
                }
                case 56:
                case 57:
                {
                    _loc_16 = CityMgr.getInstance().guiFindMath.guiSingleMap.getPos();
                    _loc_17 = CityMgr.getInstance().guiFindMath.guiSingleMap.bmpAttack;
                    _loc_2.x = _loc_17.img.x + _loc_16.x + CityMgr.getInstance().guiFindMath.guiSingleMap.imageBg.x + CityMgr.getInstance().guiFindMath.guiSingleMap.pageMap.x;
                    _loc_2.y = _loc_17.img.y + _loc_16.y + CityMgr.getInstance().guiFindMath.guiSingleMap.imageBg.y + CityMgr.getInstance().guiFindMath.guiSingleMap.pageMap.y;
                    this.layer.ShowTutorialScreenRect(_loc_2.x, _loc_2.y, _loc_17.width, _loc_17.height, 0);
                    this.showArrow(_loc_2.x + _loc_17.width / 2, _loc_2.y);
                    break;
                }
                case 58:
                {
                    this.layer.hideFog();
                    this.removeArrow();
                    this.makeSceneAttackSingleMap();
                    break;
                }
                case 59:
                {
                    this.removeArrow();
                    CityMgr.getInstance().guiNPC1.showTutorialStep(19);
                    break;
                }
                case 60:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(24, null, CityMgr.getInstance().guiNPC1.isShowing);
                    break;
                }
                case 61:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(20, null, CityMgr.getInstance().guiNPC1.isShowing);
                    break;
                }
                case 62:
                {
                    _loc_18 = GameDataMgr.getInstance().townHall;
                    this.showPositionOnMap(_loc_18.posX, _loc_18.posY, 4, 0);
                    break;
                }
                case 63:
                {
                    this.focusAction(BuildingActionType.UPGRADE);
                    break;
                }
                case 64:
                {
                    _loc_2 = CityMgr.getInstance().guiUpgradeBuilding.getPos();
                    _loc_2.x = _loc_2.x + 196;
                    _loc_2.y = _loc_2.y + 320;
                    this.layer.ShowTutorialScreenRect(_loc_2.x, _loc_2.y, 123, 46, 0);
                    this.showArrow(_loc_2.x + 55, _loc_2.y);
                    break;
                }
                case 65:
                {
                    if (GameDataMgr.getInstance().townHall.status == MapObject.UPGRADING)
                    {
                        _loc_22 = GameDataMgr.getInstance().townHall;
                        this.showPositionOnMap(_loc_22.posX, _loc_22.posY, 4, 0);
                    }
                    else
                    {
                       this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 66:
                {
                    if (GameDataMgr.getInstance().townHall.status == MapObject.UPGRADING)
                    {
                        this.focusAction(BuildingActionType.QUICK_FINISH);
                    }
                    else
                    {
                        this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 67:
                {
                    if (GameDataMgr.getInstance().townHall.status == MapObject.UPGRADING)
                    {
                        if (GlobalVar.QUICK_FINISH_NEED_CONFIRM)
                        {
                            this.focusQuickFinish();
                        }
                    }
                    else
                    {
                        this.curStep++;
                        this.finishStep();
                        this.run();
                    }
                    break;
                }
                case 68:
                {
                    this.removeArrow();
                    this.nextStep();
                    break;
                }
                case 69:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(21);
                    break;
                }
                case 70:
                {
                    CityMgr.getInstance().guiNPC1.showTutorialStep(22, null, CityMgr.getInstance().guiNPC1.isShowing);
                    break;
                }
                case 71:
                {
                    this.finishTutorial();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function makeSceneAttackSingleMap() : void
        {
            this.saveData();
            CityMgr.getInstance().showTransitionEff(CityMgr.getInstance().sendAttackSingleMap, 1);
            CityMgr.getInstance().setState(GlobalVar.STATE_SINGLE_MAP);
            SoundModule.getInstance().playBgMusic(SoundModule.MUSIC_BG_PREPARE_TO_FIGHT);
            return;
        }// end function

        private function focusAction(param1:String) : void
        {
            var _loc_4:GuiBuildingActioItem = null;
            var _loc_5:Point = null;
            var _loc_2:* = CityMgr.getInstance().guiBuildingAction.listItem;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3].typeAction == param1)
                {
                    _loc_4 = _loc_2[_loc_3];
                    _loc_5 = CityMgr.getInstance().guiBuildingAction.getPos();
                    CityMgr.getInstance().guiBuildingAction.getPos().x = _loc_5.x + _loc_4.x;
                    _loc_5.y = _loc_5.y + _loc_4.y;
                    this.layer.ShowTutorialScreenRect(_loc_5.x, _loc_5.y + 2, _loc_4.width, _loc_4.height - 13, 0);
                    this.showArrow(_loc_5.x + _loc_4.width / 2, _loc_5.y);
                }
                _loc_3++;
            }
            return;
        }// end function

        public function showPositionOnMap(param1:int, param2:int, param3:int, param4:int = 1) : void
        {
            var _loc_7:BaseMap = null;
            var _loc_8:int = 0;
            this.removeArrow();
            var _loc_5:* = MapMgr.getInstance().cityMap.isoToPoint(param1, param2);
            var _loc_6:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
            _loc_5 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG).localToGlobal(_loc_5);
            LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG).localToGlobal(_loc_5).y = _loc_5.y + 40;
            this.showDisableScreen();
            if (param4 == 1)
            {
                _loc_7 = MapMgr.getInstance().cityMap;
                _loc_8 = MapMgr.getInstance().cityMap.isoToCell(param1, param2);
                MapMgr.getInstance().drawCell(_loc_7, _loc_8, param3);
            }
            MapMgr.getInstance().focusObject(param1, param2, 1, this.showArrowOnCenter);
            return;
        }// end function

        private function showArrowOnCenter() : void
        {
            this.showArrow(GlobalVar.SCREEN_WIDTH / 2, GlobalVar.SCREEN_HEIGHT / 2);
            this.layer.ShowTutorialScreen(GlobalVar.SCREEN_WIDTH / 2 + 5, GlobalVar.SCREEN_HEIGHT / 2 + 50, 3 * 16, 0);
            return;
        }// end function

        public function showShopItem(param1:int) : void
        {
            var _loc_2:* = CityMgr.getInstance().guiShop.getPos();
            var _loc_3:* = CityMgr.getInstance().guiShop.resourceShop;
            var _loc_4:* = _loc_3.listItem[(param1 - 1)];
            _loc_2.x = _loc_2.x + (_loc_3.getPos().x + _loc_4.getPos().x + _loc_3.pageItem.x);
            _loc_2.y = _loc_2.y + (_loc_3.getPos().y + _loc_4.getPos().y + _loc_3.pageItem.y);
            this.layer.ShowTutorialScreenRect(_loc_2.x - 2, _loc_2.y - 2, 114, 153, 0);
            this.showArrow(_loc_2.x + 115 / 2, _loc_2.y - 25);
            return;
        }// end function

        private function runAnamationScene11() : void
        {
            MapMgr.getInstance().focusObject(25, 0, 2, this.makeScene11, true);
            return;
        }// end function

        private function scaleDone() : void
        {
            return;
        }// end function

        private function makeScene11() : void
        {
            this.layer.ShowTutorialScreen(0, 0, 0, 0);
            var _loc_1:* = GameDataMgr.getInstance().defenseList[0];
            _loc_1.hide();
            this.setBuildingToMap(_loc_1);
            this.numGoblin = 2;
            var _loc_2:* = new Point(69, 0);
            var _loc_3:* = MapMgr.getInstance().battleMap.isoToCell(_loc_2.x, _loc_2.y);
            BattleModule.getInstance().addTroop(DataObject.GOBLIN, _loc_3, 1);
            _loc_2.x = 81;
            _loc_2.y = 0;
            _loc_3 = MapMgr.getInstance().battleMap.isoToCell(_loc_2.x, _loc_2.y);
            BattleModule.getInstance().addTroop(DataObject.GOBLIN, _loc_3, 1);
            CityMgr.getInstance().setState(GlobalVar.STATE_BATTLE);
            MapMgr.getInstance().focusObject(canonPos.x, canonPos.y, 7);
            return;
        }// end function

        public function endScene11() : void
        {
            this.curStep++;
            this.timer.start();
            this.timer.addEventListener(TimerEvent.TIMER, this.endTimer);
            return;
        }// end function

        public function endTimer(event:TimerEvent) : void
        {
            this.timer.removeEventListener(TimerEvent.TIMER, this.endTimer);
            this.timer.stop();
            this.finishStep();
            this.run();
            return;
        }// end function

        private function makeScene15() : void
        {
            this.saveData();
            var _loc_1:* = new BattleInfoMsg();
            var _loc_2:* = new Object();
            _loc_2.objId = 0;
            _loc_2.objType = BuildingType.TOWN_HALL;
            _loc_2.level = 1;
            _loc_2.cell = MapMgr.getInstance().cityMap.isoToCell(townHallPos.x, townHallPos.y);
            _loc_2.gold = 500;
            _loc_2.elixir = 500;
            _loc_2.darkElixir = 0;
            _loc_1.dataList.push(_loc_2);
            var _loc_3:* = new Object();
            _loc_3.objId = 0;
            _loc_3.objType = BuildingType.CANON;
            _loc_3.level = 1;
            _loc_3.cell = MapMgr.getInstance().cityMap.isoToCell(canon2Pos.x, canon2Pos.y);
            _loc_3.gold = 0;
            _loc_3.elixir = 0;
            _loc_3.darkElixir = 0;
            var _loc_4:* = new Troop();
            _loc_4.type = DataObject.WINZAR;
            _loc_4.num = 5;
            _loc_4.level = 4;
            _loc_1.troopList.push(_loc_4);
            CityMgr.getInstance().showTransitionEff(CityMgr.getInstance().loadBattleInfo, _loc_1);
            CityMgr.getInstance().setState(GlobalVar.STATE_SINGLE_MAP);
            SoundModule.getInstance().playBgMusic(SoundModule.MUSIC_BG_PREPARE_TO_FIGHT);
            CityMgr.getInstance().destroyFarmerList();
            return;
        }// end function

        public function setBuildingToMap(param1:MapObject) : void
        {
            var _loc_3:DataHouse = null;
            var _loc_2:* = param1.type.split("_");
            switch(_loc_2[0])
            {
                case BuildingType.DEF:
                {
                    switch(param1.type)
                    {
                        case BuildingType.CANON:
                        {
                            _loc_3 = new Cannon();
                            break;
                        }
                        case BuildingType.ACHER_TOWER:
                        {
                            _loc_3 = new ArcherTower();
                            break;
                        }
                        case BuildingType.MOTAR:
                        {
                            _loc_3 = new Mortar();
                            break;
                        }
                        case BuildingType.WIZARD_TOWER:
                        {
                            _loc_3 = new WinzarTower();
                            break;
                        }
                        default:
                        {
                            _loc_3 = new HouseDefenses();
                            break;
                            break;
                        }
                    }
                    _loc_3.setDataHouse(param1);
                    break;
                }
                case "WAL":
                {
                    _loc_3 = new Wall();
                    _loc_3.responeCell = MapMgr.getInstance().battleMap.isoToCell(param1.posX * 3, param1.posY * 3);
                    _loc_3.setDataHouse(param1);
                    break;
                }
                case BuildingType.RES:
                case BuildingType.STO:
                {
                    _loc_3 = new HouseResources();
                    HouseResources(_loc_3).gold = param1.gold;
                    HouseResources(_loc_3).elixir = param1.elixir;
                    HouseResources(_loc_3).darkElixir = param1.darkElixir;
                    _loc_3.setDataHouse(param1);
                    break;
                }
                case BuildingType.TOW:
                {
                    _loc_3 = new TownHall();
                    TownHall(_loc_3).gold = param1.gold;
                    TownHall(_loc_3).elixir = param1.elixir;
                    TownHall(_loc_3).darkElixir = param1.darkElixir;
                    _loc_3.setDataHouse(param1);
                    break;
                }
                case BuildingType.CLAN:
                {
                    _loc_3 = new HouseClan();
                    _loc_3.setDataHouse(param1);
                    break;
                }
                default:
                {
                    _loc_3 = new HouseNormal();
                    _loc_3.setDataHouse(param1);
                    break;
                    break;
                }
            }
            _loc_3.team = 2;
            BattleModule.getInstance().battleData.addObj(_loc_3);
            MapMgr.getInstance().updateMapLogic(param1, _loc_3.objId);
            if (_loc_3 is Wall)
            {
                Wall(_loc_3).updateDir();
            }
            else
            {
                BattleModule.getInstance().totalHp = BattleModule.getInstance().totalHp + param1["info"]["hitpoints"];
            }
            return;
        }// end function

        public function finishTut() : void
        {
            GlobalVar.stage.removeEventListener(MouseEvent.CLICK, this.onMouseClick);
            return;
        }// end function

        public function saveData() : void
        {
            this.myInfo = GameDataMgr.getInstance().myInfo;
            this.listBuilding = GameDataMgr.getInstance().getBuildingList();
            return;
        }// end function

        public function removeGuideText() : void
        {
            if (this.guideText)
            {
                this.guideText.parent.removeChild(this.guideText);
                this.guideText = null;
            }
            return;
        }// end function

        public function showGuideText(param1:String) : void
        {
            this.removeGuideText();
            this.guideText = new TooltipText(false, true);
            this.guideText.htmlText = "<font size=\'20\'> " + param1 + " </font>";
            this.layer.addChild(this.guideText);
            this.guideText.x = this.arrow.x + (this.arrow.width - this.guideText.textWidth) / 2;
            this.guideText.y = this.arrow.y - 50;
            return;
        }// end function

        public function updateGuideText(param1:int) : void
        {
            var _loc_2:* = Localization.getInstance().getString("Tutorial_Append0");
            _loc_2 = _loc_2.replace("@count@", param1.toString());
            if (this.guideText == null)
            {
                this.showGuideText(_loc_2);
            }
            else
            {
                this.guideText.htmlText = "<font size=\'20\'> " + _loc_2 + " </font>";
            }
            return;
        }// end function

        public function forceSetBuilding() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().tempObject;
            switch(_loc_1.type)
            {
                case BuildingType.CANON:
                {
                    _loc_1.posX = TutorialMgr.canonPos.x;
                    _loc_1.posY = TutorialMgr.canonPos.y;
                    break;
                }
                case BuildingType.BARRACK:
                {
                    _loc_1.posX = TutorialMgr.posBar.x;
                    _loc_1.posY = TutorialMgr.posBar.y;
                    break;
                }
                case BuildingType.GOLD_STORAGE:
                {
                    _loc_1.posX = TutorialMgr.goldStoragePos.x;
                    _loc_1.posY = TutorialMgr.goldStoragePos.y;
                    break;
                }
                case BuildingType.ELIXIR_STORAGE:
                {
                    _loc_1.posX = TutorialMgr.elixirStoragePos.x;
                    _loc_1.posY = TutorialMgr.elixirStoragePos.y;
                    break;
                }
                case BuildingType.BUILDER_HUT:
                {
                    _loc_1.posX = TutorialMgr.bhPos.x;
                    _loc_1.posY = TutorialMgr.bhPos.y;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function focusQuickFinish() : void
        {
            var _loc_1:* = CityMgr.getInstance().guiBuyResource.getPos();
            var _loc_2:* = CityMgr.getInstance().guiBuyResource.bmpBuyResource;
            _loc_1.x = _loc_1.x + _loc_2.img.x;
            _loc_1.y = _loc_1.y + _loc_2.img.y;
            this.layer.ShowTutorialScreenRect(_loc_1.x, _loc_1.y, _loc_2.width, _loc_2.height, 0);
            this.showArrow(_loc_1.x + _loc_2.width / 2, _loc_1.y);
            return;
        }// end function

        public function finishStep() : void
        {
            if (this.curStep >= GameDataMgr.getInstance().myInfo.tutStep)
            {
                CityMgr.getInstance().sendFinishTutorialCmd();
                this.temp++;
            }
            return;
        }// end function

        public function nextStep(param1:int = 0) : void
        {
            this.finishStep();
           this.curStep++;
            this.run(param1);
            return;
        }// end function

        public function hideGuis() : void
        {
            this.removeArrow();
            CityMgr.getInstance().hideBuildingActionGui();
            CityMgr.getInstance().hideMessage();
            return;
        }// end function

        public function finishTutorial() : void
        {
            this.isTutorial = false;
            this.finishStep();
            SoundModule.getInstance().playBgMusic();
            this.showArrowForQuest();
            if (CityMgr.getInstance().guiMainTopRight.bmpThongBao && !GameDataMgr.getInstance().myInfo.isChargedUser)
            {
                CityMgr.getInstance().guiMainTopRight.bmpThongBao.visible = true;
                CityMgr.getInstance().guiFirstAddG.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            }
            return;
        }// end function

        public function showArrowForQuest() : void
        {
            var _loc_1:* = CityMgr.getInstance().guiSideQuest.listItem[0];
            var _loc_2:* = CityMgr.getInstance().guiSideQuest.getPos();
            var _loc_3:* = _loc_1.x + _loc_1.width + _loc_2.x;
            var _loc_4:* = _loc_1.y + _loc_1.height / 2 + _loc_2.y;
            this.showLeftArrow(_loc_3 - 30, _loc_4 - 55);
            return;
        }// end function

        public function showDisableScreen() : void
        {
            this.layer.ShowTutorialScreen(0, 0, 0, 0);
            return;
        }// end function

        public static function getInstance() : TutorialMgr
        {
            if (_inst == null)
            {
                _inst = new TutorialMgr;
            }
            return _inst;
        }// end function

    }
}
