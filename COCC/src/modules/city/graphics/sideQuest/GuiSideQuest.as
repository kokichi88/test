package modules.city.graphics.sideQuest
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import component.*;
    import flash.display.*;
    import flash.geom.*;
    import modules.city.*;
    import resMgr.*;

    public class GuiSideQuest extends BaseGui
    {
        public var listItem:Vector.<SideQuestItem>;
        public var guiSideQuestBoard:GuiSideQuestBoard;
        private var curQuestType:SideQuestItem;

        public function GuiSideQuest()
        {
            this.listItem = new Vector.<SideQuestItem>;
            super(new MovieClip());
            this.guiSideQuestBoard = new GuiSideQuestBoard();
            addGui(this.guiSideQuestBoard);
            this.guiSideQuestBoard.bgImg.visible = false;
            this.initItem();
            return;
        }// end function

        public function initItem() : void
        {
            var _loc_3:SideQuestItem = null;
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < GlobalVar.MAX_QUEST_TYPE)
            {
                
                _loc_3 = new SideQuestItem();
                _loc_3.loadType(GlobalVar.SIDE_QUEST[_loc_2]);
                _loc_3.y = _loc_1;
                this.img.addChild(_loc_3);
                _loc_1 = _loc_1 + (_loc_3.height + 5);
                _loc_3.visible = false;
                this.listItem.push(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            super.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), param2);
            var _loc_3:* = CityMgr.getInstance().guiMainTopLeft.getPos();
            setPos(5, _loc_3.y + CityMgr.getInstance().guiMainTopLeft.heightBg + 70);
            return;
        }// end function

        public function showBoard(param1:String) : void
        {
            var _loc_3:SideQuestItem = null;
            if (this.guiSideQuestBoard.bgImg.visible && this.guiSideQuestBoard.curQuestType == param1)
            {
                this.guiSideQuestBoard.bgImg.visible = false;
                return;
            }
            this.guiSideQuestBoard.bgImg.visible = true;
            this.guiSideQuestBoard.getQuestStatus(param1);
            SideQuestMgr.getInstance().curQuest = param1;
            var _loc_2:int = 0;
            while (_loc_2 < this.listItem.length)
            {
                
                if (this.listItem[_loc_2].questType == param1)
                {
                    _loc_3 = this.listItem[_loc_2];
                    this.curQuestType = _loc_3;
                    var _loc_4:int = 1;
                    this.listItem[_loc_2].scaleY = 1;
                    this.listItem[_loc_2].scaleX = _loc_4;
                    this.guiSideQuestBoard.setPos(_loc_3.x + _loc_3.width - 40, _loc_3.y - 45);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function startIncrease() : void
        {
            TweenMax.to(this.curQuestType, 0.7, {colorMatrixFilter:{contrast:1.3, brightness:1.4}, onComplete:this.IncreaseDone});
            return;
        }// end function

        private function IncreaseDone() : void
        {
            TweenMax.to(this.curQuestType, 0.7, {colorMatrixFilter:{contrast:1.1, brightness:1.1}, onComplete:this.startIncrease});
            return;
        }// end function

        public function refreshButtons() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                TweenMax.to(this.listItem[_loc_1], 0.1, {colorMatrixFilter:{contrast:1, brightness:1}});
                var _loc_2:int = 1;
                this.listItem[_loc_1].scaleY = 1;
                this.listItem[_loc_1].scaleX = _loc_2;
                _loc_1++;
            }
            return;
        }// end function

        public function moveToOriginalPositionExcept(param1:String) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.listItem.length)
            {
                
                if (this.listItem[_loc_2].questType != param1)
                {
                    TweenLite.to(this.listItem[_loc_2], 0.2, {x:0});
                }
                _loc_2++;
            }
            return;
        }// end function

        public function upadteQuestStatus(param1:Boolean = false) : void
        {
            var _loc_5:Boolean = false;
            var _loc_2:Boolean = false;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            while (_loc_4 < GlobalVar.MAX_QUEST_TYPE)
            {
                
                if (SideQuestMgr.getInstance().isQuestAvaiable(GlobalVar.SIDE_QUEST[_loc_4]))
                {
                    _loc_2 = true;
                    this.listItem[_loc_4].visible = true;
                    this.listItem[_loc_4].y = _loc_3;
                    this.listItem[_loc_4].x = this.listItem[_loc_4].width / 2;
                    if (_loc_4 == 0)
                    {
                        this.listItem[_loc_4].x = this.listItem[_loc_4].x + 4;
                    }
                    _loc_3 = _loc_3 + (this.listItem[_loc_4].height + 5);
                    _loc_5 = SideQuestMgr.getInstance().isQuestFinished(GlobalVar.SIDE_QUEST[_loc_4]);
                    this.listItem[_loc_4].showNotify(_loc_5);
                    if (GlobalVar.SIDE_QUEST[_loc_4] == this.guiSideQuestBoard.curQuestType)
                    {
                        this.guiSideQuestBoard.getQuestStatus(this.guiSideQuestBoard.curQuestType);
                    }
                }
                else
                {
                    this.listItem[_loc_4].visible = false;
                }
                _loc_4++;
            }
            this.show();
            return;
        }// end function

    }
}
