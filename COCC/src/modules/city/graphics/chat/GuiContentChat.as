package modules.city.graphics.chat
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;
    import gameData.*;
    import gameData.clan.*;
    import gameData.donation.*;
    import modules.battle.data.*;
    import modules.city.*;
    import mx.utils.*;
    import network.receive.*;
    import resMgr.*;
    import utility.*;

    public class GuiContentChat extends BaseGui
    {
        public var listItemChat:Vector.<ChatItem>;
        public var troopRequests:Object;
        private var startY:int = 0;
        private var mode:int = 1;
        public var labelInput:TextField;
        private var delayTime:int;
        private var receivedDataDonate:Boolean = false;
        private var receivedDataChat:Boolean = false;
        private var spChat:Sprite;
        private var scrollView:ScrollBar;
        public var imageBgBar:MovieClip;
        public var bmpTopArrow:BitmapButton;
        public var bmpBottomArrow:BitmapButton;
        public var bmpSlider:BitmapButton;
        public var bmpExpand:BitmapButton;
        public var bmpNormal:BitmapButton;
        private var scrollViewX2:ScrollBar;
        public var imageBgBarX2:MovieClip;
        public var bmpTopArrowX2:BitmapButton;
        public var bmpBottomArrowX2:BitmapButton;
        public var bmpSliderX2:BitmapButton;
        public var imageBgChat:MovieClip;
        public var imageBgChatX2:MovieClip;
        public var mouseDownTroopType:String = "";
        public var mouseDownType:String = "";
        public var mouseDownDelay:Number = 0;
        public static const BMP_SEND:String = "bmpSend";
        public static const BMP_EXPAND:String = "bmpExpand";
        public static const BMP_NORMAL:String = "bmpNormal";
        public static const MAX_CHAR:int = 200;
        public static const MODE_NORMAL:int = 1;
        public static const MODE_EXPAND:int = 2;
        public static const MOUSE_DOWN_DELAY_TO_START:int = 50;
        private static const MOUSE_DOWN_DELAY:int = 20;
        public static const MOUSE_DOWN:String = "mouseDown";
        public static const MOUSE_UP:String = "mouseUp";

        public function GuiContentChat()
        {
            this.listItemChat = new Vector.<ChatItem>;
            this.troopRequests = new Object();
            this.spChat = new Sprite();
            super(ResMgr.getInstance().getMovieClip("ContentChatGui"));
            this.img.mouseEnabled = false;
            this.bgImg.mouseEnabled = false;
            autoAlign = AUTO_ALIGN_BOTTOM_LEFT;
            this.labelInput.mouseEnabled = true;
            this.labelInput.maxChars = MAX_CHAR;
            var _loc_1:* = new Rectangle(0, 150, 310, 135);
            this.scrollView = new ScrollBar(this.imageBgBar, this.bmpSlider.img, this.bmpBottomArrow.img, this.bmpTopArrow.img, _loc_1);
            var _loc_2:* = new Rectangle(0, 0, 310, 285);
            this.scrollViewX2 = new ScrollBar(this.imageBgBarX2, this.bmpSliderX2.img, this.bmpBottomArrowX2.img, this.bmpTopArrowX2.img, _loc_2);
            this.spChat = new Sprite();
            this.img.addChild(this.spChat);
            this.labelInput.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            this.setNormalMode();
            return;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case Keyboard.ENTER:
                {
                    this.sendMessage();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function loadRequesList(param1:Object) : void
        {
            var _loc_2:String = null;
            var _loc_3:TroopRequestInfo = null;
            var _loc_4:ChatItem = null;
            this.receivedDataDonate = true;
            this.troopRequests = param1;
            for (_loc_2 in param1)
            {
                
                _loc_3 = param1[_loc_2];
                _loc_4 = new ChatItem();
                _loc_4.uId = int(_loc_2);
                _loc_4.setRequestType(_loc_3);
                this.listItemChat.push(_loc_4);
                if (GameDataMgr.getInstance().myInfo.uId == parseInt(_loc_2, 10))
                {
                }
            }
            this.drawChatList();
            return;
        }// end function

        private function compare(param1:ChatItem, param2:ChatItem) : int
        {
            if (param1.created > param2.created)
            {
                return 1;
            }
            if (param1.created < param2.created)
            {
                return -1;
            }
            return 0;
        }// end function

        private function drawChatList() : void
        {
            var _loc_1:int = 0;
            var _loc_2:ChatItem = null;
            if (!this.receivedDataDonate || !this.receivedDataChat)
            {
                return;
            }
            GameDataMgr.getInstance().getRequestClanList = true;
            this.listItemChat.sort(this.compare);
            this.startY = 0;
            _loc_1 = 0;
            while (_loc_1 < this.listItemChat.length)
            {
                
                _loc_2 = this.listItemChat[_loc_1];
                _loc_2.x = 10;
                _loc_2.y = this.startY;
                this.startY = this.startY + (_loc_2.height - 5);
                this.spChat.addChild(_loc_2);
                _loc_1++;
            }
            this.setMode(this.mode);
            return;
        }// end function

        public function onChatItemClick(param1:int) : void
        {
            CityMgr.getInstance().guiDonateTroop.setRequestTroopInfo(param1, this.troopRequests[param1]);
            return;
        }// end function

        public function addNewRequest(param1:RequestTroopMsg) : void
        {
            var _loc_2:* = this.getItemRequestByUID(param1.sender);
            if (_loc_2)
            {
                this.removeItemChatByUID(param1.sender);
            }
            var _loc_3:* = new TroopRequestInfo();
            _loc_3.curCapacity = param1.curTroopCapacity;
            _loc_3.maxCapacity = param1.maxTroopCapacity;
            _loc_3.msg = param1.msg;
            _loc_3.created = Utility.getCurTime();
            this.troopRequests[param1.sender] = _loc_3;
            var _loc_4:* = new ChatItem();
            new ChatItem().uId = param1.sender;
            _loc_4.setRequestType(_loc_3);
            this.spChat.addChild(_loc_4);
            _loc_4.x = 10;
            _loc_4.y = this.startY;
            this.startY = this.startY + _loc_4.height;
            this.listItemChat.push(_loc_4);
            this.setMode(this.mode);
            return;
        }// end function

        public function updateRequestAfterDonate(param1:int, param2:int, param3:Vector.<Troop>) : void
        {
            var _loc_6:Troop = null;
            var _loc_7:int = 0;
            var _loc_8:ChatItem = null;
            var _loc_9:Boolean = false;
            var _loc_10:String = null;
            var _loc_11:ClanMemberInfo = null;
            var _loc_4:* = this.troopRequests[param2.toString()];
            if (!this.troopRequests[param2.toString()])
            {
                return;
            }
            var _loc_5:int = 0;
            while (_loc_5 < param3.length)
            {
                
                _loc_6 = param3[_loc_5];
                _loc_7 = _loc_6.num * Utility.getHousingSpace(_loc_6.type);
                _loc_4.curCapacity = _loc_4.curCapacity + _loc_7;
                _loc_8 = this.getItemRequestByUID(param2);
                if (!_loc_8)
                {
                    return;
                }
                if (param1 == GameDataMgr.getInstance().myInfo.uId)
                {
                    Utility.addTroop(_loc_6, _loc_4.myDonation);
                    _loc_9 = _loc_8.isDonated(_loc_4);
                    CityMgr.getInstance().guiDonateTroop.donateSuccess(_loc_6);
                    GameDataMgr.getInstance().addExp(_loc_7);
                }
                _loc_8.updateCapacity(_loc_4);
                if (param2 == GameDataMgr.getInstance().myInfo.uId)
                {
                    CityMgr.getInstance().cityTroopJoinClan(_loc_6);
                    Utility.addTroop(_loc_6, GameDataMgr.getInstance().clanCastle.troopList);
                    _loc_10 = Localization.getInstance().getString("ClanMsg1");
                    _loc_10 = _loc_10.replace("@army@", "1 quân lính");
                    _loc_11 = GameDataMgr.getInstance().myClanMembers[param1.toString()];
                    _loc_10 = _loc_10.replace("@name@", _loc_11.name);
                    CityMgr.getInstance().guiNotify.addNewNotify(_loc_10);
                    GameDataMgr.getInstance().clanCastle.checkFull();
                }
                _loc_5++;
            }
            return;
        }// end function

        private function getItemRequestByUID(param1:int) : ChatItem
        {
            var _loc_2:int = 0;
            var _loc_3:ChatItem = null;
            _loc_2 = 0;
            while (_loc_2 < this.listItemChat.length)
            {
                
                _loc_3 = this.listItemChat[_loc_2];
                if (_loc_3.uId == param1 && _loc_3.type == 1)
                {
                    return _loc_3;
                }
                _loc_2++;
            }
            return null;
        }// end function

        private function removeItemChatByUID(param1:int) : void
        {
            var _loc_2:int = 0;
            var _loc_3:ChatItem = null;
            _loc_2 = 0;
            while (_loc_2 < this.listItemChat.length)
            {
                
                _loc_3 = this.listItemChat[_loc_2];
                if (_loc_3.uId == param1)
                {
                    _loc_3.parent.removeChild(_loc_3);
                    this.listItemChat.splice(_loc_2, 1);
                    this.resetListItemChat();
                    return;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function resetListItemChat() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listItemChat.length)
            {
                
                this.listItemChat[_loc_1].parent.removeChild(this.listItemChat[_loc_1]);
                _loc_1++;
            }
            this.drawChatList();
            return;
        }// end function

        public function removeAllItem() : void
        {
            var _loc_2:int = 0;
            var _loc_1:int = 0;
            while (_loc_1 < this.listItemChat.length)
            {
                
                _loc_2 = this.listItemChat[_loc_1].numChildren - 1;
                while (_loc_2 >= 0)
                {
                    
                    this.listItemChat[_loc_1].removeChildAt(_loc_2);
                    _loc_2 = _loc_2 - 1;
                }
                this.listItemChat[_loc_1].parent.removeChild(this.listItemChat[_loc_1]);
                this.listItemChat[_loc_1] = null;
                _loc_1++;
            }
            this.listItemChat.splice(0, this.listItemChat.length);
            this.listItemChat = new Vector.<ChatItem>;
            this.setMode(this.mode);
            return;
        }// end function

        public function removeItemAfterDonateFull(param1:int) : void
        {
            var _loc_2:* = this.getItemRequestByUID(param1);
            if (!_loc_2)
            {
                return;
            }
            var _loc_3:* = _loc_2.y;
            var _loc_4:* = _loc_2.height;
            var _loc_5:* = _loc_2.numChildren - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_2.removeChildAt(_loc_5);
                _loc_5 = _loc_5 - 1;
            }
            this.removeItemChatByUID(param1);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_SEND:
                {
                    this.sendMessage();
                    break;
                }
                case BMP_EXPAND:
                {
                    this.mode = MODE_EXPAND;
                    this.setMode(this.mode);
                    break;
                }
                case BMP_NORMAL:
                {
                    this.mode = MODE_NORMAL;
                    this.setMode(this.mode);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setMode(param1:int) : void
        {
            this.mode = param1;
            switch(param1)
            {
                case MODE_NORMAL:
                {
                    this.setNormalMode();
                    break;
                }
                case MODE_EXPAND:
                {
                    this.setExpandMode();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setExpandMode() : void
        {
            this.imageBgChatX2.visible = true;
            this.bmpSliderX2.visible = true;
            this.imageBgBarX2.visible = true;
            this.bmpTopArrowX2.visible = true;
            this.bmpBottomArrowX2.visible = true;
            this.bmpExpand.visible = false;
            this.bmpNormal.visible = true;
            this.imageBgChat.visible = false;
            this.imageBgBar.visible = false;
            this.bmpSlider.visible = false;
            this.bmpTopArrow.visible = false;
            this.bmpBottomArrow.visible = false;
            this.scrollView.clean();
            this.scrollView.removeMask();
            this.bmpSliderX2.img.height = 262;
            this.scrollViewX2.setData(this.spChat, 0, 0, 262, this.bmpTopArrowX2.img.y + this.bmpTopArrowX2.img.height);
            this.scrollViewX2.setEndBar();
            this.scrollViewX2.updateData();
            return;
        }// end function

        private function setNormalMode() : void
        {
            this.imageBgChatX2.visible = false;
            this.bmpSliderX2.visible = false;
            this.imageBgBarX2.visible = false;
            this.bmpTopArrowX2.visible = false;
            this.bmpBottomArrowX2.visible = false;
            this.bmpNormal.visible = false;
            this.bmpExpand.visible = true;
            this.imageBgChat.visible = true;
            this.bmpSlider.visible = true;
            this.imageBgBar.visible = true;
            this.bmpTopArrow.visible = true;
            this.bmpBottomArrow.visible = true;
            this.scrollViewX2.clean();
            this.scrollViewX2.removeMask();
            this.bmpSlider.img.height = 117;
            this.scrollView.setData(this.spChat, 0, 150, 117, this.bmpTopArrow.img.y + this.bmpTopArrow.img.height);
            this.scrollView.setEndBar();
            this.scrollView.updateData();
            return;
        }// end function

        private function sendMessage() : void
        {
            var _loc_1:* = StringUtil.trim(this.labelInput.text);
            if (_loc_1 != "")
            {
                CityMgr.getInstance().sendChat(_loc_1);
                this.labelInput.text = "";
            }
            return;
        }// end function

        public function update() : void
        {
            return;
        }// end function

        public function addDataChat(param1:Vector.<Object>, param2:String = "") : void
        {
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            var _loc_5:ChatItem = null;
            var _loc_6:String = null;
            this.receivedDataChat = true;
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3];
                if (_loc_4.sender != 0 && !GameDataMgr.getInstance().myClanMembers[_loc_4.sender])
                {
                }
                else
                {
                    _loc_5 = new ChatItem();
                    _loc_6 = _loc_4.msg;
                    if (_loc_4.sender == 0)
                    {
                        _loc_6 = Utility.getClanSystemMessage(_loc_4.msg);
                        param2 = Utility.getMessageColor(_loc_4.msg);
                    }
                    else
                    {
                        param2 = "";
                    }
                    _loc_5.setMessageType(_loc_4.sender, _loc_6, _loc_4.created, param2);
                    this.listItemChat.push(_loc_5);
                }
                _loc_3++;
            }
            this.drawChatList();
            return;
        }// end function

        public function addChat(param1:int, param2:String, param3:String = "") : void
        {
            if (param1 == 0)
            {
                param3 = Utility.getMessageColor(param2);
                param2 = Utility.getClanSystemMessage(param2);
            }
            var _loc_4:* = new ChatItem();
            new ChatItem().setMessageType(param1, param2, Utility.getCurTime(), param3);
            this.spChat.addChild(_loc_4);
            _loc_4.x = 10;
            _loc_4.y = this.startY;
            this.startY = this.startY + _loc_4.height;
            this.listItemChat.push(_loc_4);
            this.setMode(this.mode);
            return;
        }// end function

        override public function onMouseDown(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case "bmpTopArrow":
                case "bmpTopArrowX2":
                {
                    this.mouseDownType = MOUSE_UP;
                    this.mouseDownDelay = Utility.getCurTime() * 1000 + MOUSE_DOWN_DELAY_TO_START;
                    break;
                }
                case "bmpBottomArrow":
                case "bmpBottomArrowX2":
                {
                    this.mouseDownType = MOUSE_DOWN;
                    this.mouseDownDelay = Utility.getCurTime() * 1000 + MOUSE_DOWN_DELAY_TO_START;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function loop() : void
        {
            if (GameInput.getInstance().isMouseDown)
            {
                if (this.mouseDownType != "" && Utility.getCurTime() * 1000 > this.mouseDownDelay + MOUSE_DOWN_DELAY)
                {
                    if (this.mouseDownType == MOUSE_DOWN)
                    {
                        if (this.mode == MODE_NORMAL)
                        {
                            this.scrollView.onDownDown(null);
                        }
                        else
                        {
                            this.scrollViewX2.onDownDown(null);
                        }
                    }
                    else if (this.mouseDownType == MOUSE_UP)
                    {
                        if (this.mode == MODE_NORMAL)
                        {
                            this.scrollView.onDownUp(null);
                        }
                        else
                        {
                            this.scrollViewX2.onDownUp(null);
                        }
                    }
                    this.mouseDownDelay = Utility.getCurTime() * 1000;
                }
            }
            else
            {
                this.mouseDownType = "";
            }
            return;
        }// end function

        public function removeAllItemOfPlayer(param1:int) : void
        {
            var _loc_2:int = 0;
            var _loc_3:ChatItem = null;
            _loc_2 = this.listItemChat.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this.listItemChat[_loc_2];
                if (_loc_3.uId == param1)
                {
                    _loc_3.parent.removeChild(_loc_3);
                    this.listItemChat.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            this.resetListItemChat();
            return;
        }// end function

    }
}
