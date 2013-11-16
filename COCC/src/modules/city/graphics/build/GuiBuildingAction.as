package modules.city.graphics.build
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import component.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import gameData.*;
    import map.*;
    import modules.city.*;
    import modules.city.graphics.tutorial.*;
    import modules.city.logic.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class GuiBuildingAction extends BaseGui
    {
        public var labelBuildingName:TextField;
        public var mapObject:MapObject;
        public var imageBg:MovieClip;
        public var imageBgInfo4:MovieClip;
        public var imageBgInfo3:MovieClip;
        public var imageBgInfo2:MovieClip;
        public var listItem:Vector.<GuiBuildingActioItem>;
        public var curObject:MapObject = null;
        public var buildingInfo:DataBuildingInfo = null;
        private var saveTween:TweenMax = null;

        public function GuiBuildingAction()
        {
            this.listItem = new Vector.<GuiBuildingActioItem>;
            super(ResMgr.getInstance().getMovieClip("BuildingActionGui_New"));
            return;
        }// end function

        private function removeAllItem() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                this.listItem[_loc_1].parent.removeChild(this.listItem[_loc_1]);
                this.listItem[_loc_1] = null;
                _loc_1++;
            }
            this.listItem.splice(0, this.listItem.length);
            this.listItem = new Vector.<GuiBuildingActioItem>;
            return;
        }// end function

        private function addItem(param1:String, param2:MoneyType = null) : void
        {
            var _loc_3:* = new GuiBuildingActioItem();
            _loc_3.loadAction(param1, param2);
            this.listItem.push(_loc_3);
            return;
        }// end function

        private function setAvaiablePosition() : void
        {
            var _loc_1:* = new Point(this.curObject.bgImage.x + this.curObject.bgImage.width / 2, this.curObject.bgImage.y);
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            _loc_1 = _loc_2.localToGlobal(_loc_1);
            var _loc_3:* = new Point(_loc_1.x, _loc_1.y);
            _loc_3.x = _loc_1.x - MapMgr.getInstance().cityMap.MaxHalfWidth * this.curObject.width * MapMgr.curScale - this.widthBg;
            if (_loc_3.y <= 0)
            {
                _loc_3.y = 10;
            }
            if (_loc_3.y + this.heightBg >= GlobalVar.SCREEN_HEIGHT)
            {
                _loc_3.y = GlobalVar.SCREEN_HEIGHT - this.heightBg - 10;
            }
            if (_loc_3.x <= 0)
            {
                _loc_3.x = _loc_1.x + MapMgr.getInstance().cityMap.MaxHalfWidth * this.curObject.width * MapMgr.curScale;
            }
            setPos(_loc_3.x, _loc_3.y);
            return;
        }// end function

        private function showBgInfo() : void
        {
            this.imageBgInfo2.visible = false;
            this.imageBgInfo3.visible = false;
            this.imageBgInfo4.visible = false;
            switch(this.listItem.length)
            {
                case 1:
                case 2:
                {
                    this.imageBgInfo2.visible = true;
                    break;
                }
                case 3:
                {
                    this.imageBgInfo3.visible = true;
                    break;
                }
                case 4:
                {
                    this.imageBgInfo4.visible = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function reArrangeItems() : void
        {
            var _loc_1:int = 0;
            var _loc_5:GuiBuildingActioItem = null;
            this.showBgInfo();
            _loc_1 = 0;
            var _loc_2:int = 10;
            var _loc_3:* = (this.listItem.length - 1) * _loc_2;
            _loc_1 = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                _loc_3 = _loc_3 + this.listItem[_loc_1].width;
                _loc_1++;
            }
            var _loc_4:* = (this.widthBg - _loc_3) / 2;
            _loc_1 = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                _loc_5 = this.listItem[_loc_1];
                this.listItem[_loc_1].x = _loc_4 + (this.listItem[_loc_1].width + _loc_2) * _loc_1;
                this.listItem[_loc_1].y = 50;
                this.listItem[_loc_1].addActionText();
                this.img.addChild(this.listItem[_loc_1]);
                _loc_1++;
            }
            return;
        }// end function

        public function showShopCancelAction() : void
        {
            this.labelBuildingName.text = "";
            this.removeAllItem();
            this.addItem(BuildingActionType.CANCEL);
            this.reArrangeItems();
            this.curObject = null;
            this.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI));
            return;
        }// end function

        public function loadActions(param1:MapObject) : void
        {
            var _loc_3:String = null;
            var _loc_6:MoneyType = null;
            this.removeAllItem();
            if (this.curObject && this.curObject.avatar)
            {
                if (this.curObject != param1)
                {
                    if (this.curObject is DefenseObject)
                    {
                    }
                    this.curObject.colorMatrixFilterReturn();
                }
            }
            this.curObject = param1;
            var _loc_2:* = Utility.getTypeObject(param1.type);
            if (_loc_2 != BuildingType.BH && _loc_2 != BuildingType.OBS && _loc_2 != BuildingType.TRA)
            {
                _loc_3 = Localization.getInstance().getString(param1.type) + " Cấp " + param1.level;
            }
            else
            {
                _loc_3 = Localization.getInstance().getString(param1.type);
            }
            this.labelBuildingName.text = _loc_3.toUpperCase();
            if (_loc_2 == BuildingType.OBS)
            {
                if (param1.startTime <= 0 && GlobalVar.state == GlobalVar.STATE_MYHOME)
                {
                    this.buildingInfo = Utility.getInfoToRemove(this.curObject.type);
                    this.addItem(BuildingActionType.REMOVE_OBSTACLE, this.buildingInfo.cost);
                }
            }
            else if (_loc_2 != BuildingType.TRA)
            {
                this.addItem(BuildingActionType.INFO);
            }
            var _loc_4:* = new MoneyType();
            var _loc_5:Number = 0;
            if (GlobalVar.state == GlobalVar.STATE_MYHOME)
            {
                if (_loc_2 == BuildingType.TRA)
                {
                    this.addItem(BuildingActionType.SELL);
                }
                else if (_loc_2 == BuildingType.OBS && param1.startTime > 0)
                {
                    this.buildingInfo = Utility.getInfoToRemove(this.curObject.type);
                    _loc_4 = Utility.getCostToBuyTime(this.buildingInfo.buildTime - (Utility.getCurTime() - param1.startTime));
                    this.addItem(BuildingActionType.QUICK_FINISH, _loc_4);
                }
                else
                {
                    this.buildingInfo = null;
                    if (param1.status == MapObject.BUILDING)
                    {
                        this.buildingInfo = Utility.getInfoToBuild(param1.type, param1.level);
                    }
                    else if ((param1.level + 1) <= JsonMgr.getInstance().getConfigMaxLevel(param1.type))
                    {
                        this.buildingInfo = Utility.getInfoToBuild(param1.type, (param1.level + 1));
                    }
                    if ((param1.status == MapObject.BUILDING || param1.status == MapObject.UPGRADING) && param1.type != BuildingType.WALL && _loc_2 != BuildingType.BH && _loc_2 != BuildingType.OBS)
                    {
                        _loc_4 = Utility.getCostToBuyTime(this.buildingInfo.buildTime - (Utility.getCurTime() - param1.startTime));
                        this.addItem(BuildingActionType.CANCEL);
                        this.addItem(BuildingActionType.QUICK_FINISH, _loc_4);
                        if (param1.type == BuildingType.CLAN_CASTLE)
                        {
                            if (GameDataMgr.getInstance().getClanId() > 0)
                            {
                                this.addItem(BuildingActionType.REQUEST_TROOP);
                            }
                            this.addItem(BuildingActionType.CLAN);
                        }
                    }
                    else if (_loc_2 != BuildingType.BH && _loc_2 != BuildingType.OBS)
                    {
                        if (this.buildingInfo && this.buildingInfo.cost.value > 0)
                        {
                            this.addItem(BuildingActionType.UPGRADE, this.buildingInfo.cost);
                        }
                        switch(param1.type)
                        {
                            case BuildingType.BARRACK:
                            {
                                this.addItem(BuildingActionType.TRAIN_TROOP);
                                break;
                            }
                            case BuildingType.LABORATORY:
                            {
                                if (LaboratoryObject(param1).troopType && LaboratoryObject(param1).troopType != "")
                                {
                                    if (!this.buildingInfo)
                                    {
                                        this.buildingInfo = new DataBuildingInfo();
                                    }
                                    this.buildingInfo.buildTime = LaboratoryObject(param1).researchTime;
                                    _loc_6 = Utility.getCostToBuyTime(this.buildingInfo.buildTime - (Utility.getCurTime() - param1.startTime));
                                    this.addItem(BuildingActionType.QUICK_FINISH, _loc_6);
                                }
                                else
                                {
                                    this.addItem(BuildingActionType.RESEARCH);
                                }
                                break;
                            }
                            case BuildingType.CLAN_CASTLE:
                            {
                                if (GameDataMgr.getInstance().getClanId() > 0)
                                {
                                    this.addItem(BuildingActionType.REQUEST_TROOP);
                                }
                                this.addItem(BuildingActionType.CLAN);
                                break;
                            }
                            case BuildingType.GOLD_MINE:
                            {
                                this.addItem(BuildingActionType.HARVEST_GOLD);
                                break;
                            }
                            case BuildingType.ELIXIR_COLLECTOR:
                            {
                                this.addItem(BuildingActionType.HARVEST_ELIXIR);
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                }
            }
            this.reArrangeItems();
            return;
        }// end function

        public function onItemClick(param1:String) : void
        {
            var _loc_2:MapObject = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:String = null;
            _loc_2 = this.curObject;
            if (!_loc_2 && param1 != BuildingActionType.CANCEL)
            {
                return;
            }
            var _loc_3:Boolean = true;
            switch(param1)
            {
                case BuildingActionType.TRAIN_TROOP:
                {
                    if (_loc_2.type == BuildingType.BARRACK)
                    {
                        _loc_4 = 0;
                        while (_loc_4 < GameDataMgr.getInstance().barrackList.length)
                        {
                            
                            if (GameDataMgr.getInstance().barrackList[_loc_4].autoId == _loc_2.autoId)
                            {
                                _loc_6 = _loc_4;
                                break;
                            }
                            _loc_4++;
                        }
                        CityMgr.getInstance().showGuiTrainTroop(_loc_6);
                        if (TutorialMgr.getInstance().isTutorial)
                        {
                            TutorialMgr.getInstance().nextStep();
                        }
                    }
                    break;
                }
                case BuildingActionType.RESEARCH:
                {
                    CityMgr.getInstance().showLaboratoryGui();
                    break;
                }
                case BuildingActionType.MOVE:
                {
                    GameDataMgr.getInstance().saveObjPosX = _loc_2.posX;
                    GameDataMgr.getInstance().saveObjPosY = _loc_2.posY;
                    MapMgr.getInstance().unSetBuilding(_loc_2);
                    _loc_2.hide();
                    GlobalVar.mouseState = GlobalVar.MOVE_BUILDING;
                    GameDataMgr.getInstance().curObject = _loc_2;
                    MouseMgr.getInstance().changeBuildingMouseIcon(_loc_2);
                    break;
                }
                case BuildingActionType.UPGRADE:
                {
                    _loc_5 = JsonMgr.getInstance().getConfigMaxLevel(_loc_2.type);
                    if (_loc_2.level == _loc_5)
                    {
                        _loc_7 = Localization.getInstance().getString("ReachMaxLevel");
                        _loc_7 = _loc_7.replace("@name@", Localization.getInstance().getString(_loc_2.type));
                        CityMgr.getInstance().guiNotify.addNewNotify(_loc_7);
                    }
                    else
                    {
                        CityMgr.getInstance().showUpgradeBuildingGui(_loc_2);
                    }
                    if (TutorialMgr.getInstance().isTutorial)
                    {
                        TutorialMgr.getInstance().nextStep();
                    }
                    break;
                }
                case BuildingActionType.QUICK_FINISH:
                {
                    CityMgr.getInstance().prepareToQuickFinish(_loc_2);
                    if (TutorialMgr.getInstance().isTutorial)
                    {
                        TutorialMgr.getInstance().nextStep();
                    }
                    break;
                }
                case BuildingActionType.INFO:
                {
                    CityMgr.getInstance().showBuildingInfo(_loc_2);
                    break;
                }
                case BuildingActionType.REQUEST_TROOP:
                {
                    CityMgr.getInstance().sendRequestTroopCmd("");
                    break;
                }
                case BuildingActionType.CLAN:
                {
                    CityMgr.getInstance().showClanGui();
                    break;
                }
                case BuildingActionType.CANCEL:
                {
                    if (_loc_2)
                    {
                        CityMgr.getInstance().prepareCancelBuilding(_loc_2);
                    }
                    else if (MouseMgr.getInstance().mouseIcon != null)
                    {
                        MouseMgr.getInstance().removeMouseIcon();
                    }
                    break;
                }
                case BuildingActionType.REMOVE_OBSTACLE:
                {
                    CityMgr.getInstance().prepareRemoveObstacle(_loc_2);
                    _loc_3 = false;
                    break;
                }
                case BuildingActionType.HARVEST_ELIXIR:
                case BuildingActionType.HARVEST_GOLD:
                {
                    ResourceObject(this.curObject).prepareToHarvest();
                    _loc_3 = false;
                    break;
                }
                case BuildingActionType.SELL:
                {
                    CityMgr.getInstance().prepareToSell(_loc_2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_3)
            {
                this.hide();
            }
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            super.show(param1, param2);
            if (this.curObject && TutorialMgr.getInstance().isTutorial)
            {
                TutorialMgr.getInstance().showDisableScreen();
            }
            this.bgImg.y = GlobalVar.SCREEN_HEIGHT;
            this.bgImg.x = (GlobalVar.SCREEN_WIDTH - this.bgImg.width) / 2;
            if (this.saveTween)
            {
                this.saveTween.kill();
                this.saveTween = null;
            }
            this.saveTween = TweenMax.to(this.bgImg, 0.4, {bezier:[{y:GlobalVar.SCREEN_HEIGHT - this.heightBg}], ease:Back.easeOut, onComplete:this.moveDone2});
            if (CityMgr.getInstance().guiShop.isShowing)
            {
                CityMgr.getInstance().guiShop.hide(true);
            }
            if (CityMgr.getInstance().guiFriendsList.isShowing)
            {
                CityMgr.getInstance().guiFriendsList.hide(true);
            }
            return;
        }// end function

        private function moveDone() : void
        {
            return;
        }// end function

        private function moveDone2() : void
        {
            if (this.curObject && TutorialMgr.getInstance().isTutorial)
            {
                TutorialMgr.getInstance().nextStep();
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            if (!isShowing)
            {
                return;
            }
            isShowing = false;
            if (this.curObject && this.curObject.avatar)
            {
                if (this.curObject is DefenseObject)
                {
                    DefenseObject(this.curObject).hideAttackRange();
                }
                this.curObject.hideSelected();
                this.curObject.colorMatrixFilterReturn();
                this.curObject = null;
            }
            MouseMgr.getInstance().rollBackMoveBuilding();
            if (this.saveTween)
            {
                this.saveTween.kill();
                this.saveTween = null;
            }
            this.saveTween = TweenMax.to(this.bgImg, 0.4, {bezier:[{y:GlobalVar.SCREEN_HEIGHT}], ease:Back.easeIn, onComplete:super.hide});
            return;
        }// end function

        private function moveUpDone() : void
        {
            return;
        }// end function

        private function moveOutDone() : void
        {
            return;
        }// end function

        public function getItemHarvest() : int
        {
            var _loc_1:* = this.listItem.length - 1;
            while (_loc_1 >= 0)
            {
                
                if (this.listItem[_loc_1].typeAction == BuildingActionType.HARVEST_GOLD || this.listItem[_loc_1].typeAction == BuildingActionType.HARVEST_ELIXIR)
                {
                    return _loc_1;
                }
                _loc_1 = _loc_1 - 1;
            }
            return -1;
        }// end function

    }
}
