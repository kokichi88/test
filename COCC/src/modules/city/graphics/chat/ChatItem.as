package modules.city.graphics.chat
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import gameData.clan.*;
    import gameData.donation.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class ChatItem extends Sprite
    {
        public var type:int;
        public var uId:int;
        public var uName:String = "";
        public var msg:String = "";
        public var created:Number;
        public var labelNumber:TooltipText;
        public var bmpDonate:BitmapButton;
        private var bg:Sprite;
        private var bar:Sprite;
        public static var padingLeft:int = 15;
        public static var fontSize:int = 14;

        public function ChatItem()
        {
            return;
        }// end function

        public function setMessageType(param1:int, param2:String, param3:Number, param4:String = "") : void
        {
            var _loc_8:ClanMemberInfo = null;
            this.type = 0;
            this.msg = param2;
            if (param1 > 0)
            {
                _loc_8 = GameDataMgr.getInstance().myClanMembers[param1];
                if (!_loc_8)
                {
                    return;
                }
                this.uName = _loc_8.name;
            }
            else
            {
                this.uName = "Hệ thống";
            }
            this.uId = param1;
            this.created = param3;
            var _loc_5:* = new TooltipText(false, true);
            _loc_5.x = padingLeft;
            _loc_5.width = 280;
            var _loc_6:String = "#FDC877";
            if (param4 != "")
            {
                _loc_6 = param4;
            }
            var _loc_7:* = "<font color =\'#FFFFFF\' size=\'" + fontSize + "\'>" + this.uName + ":</font>";
            _loc_7 = "<font color =\'#FFFFFF\' size=\'" + fontSize + "\'>" + this.uName + ":</font>" + ("<font color =\'" + _loc_6 + "\' size=\'" + fontSize + "\'> " + this.msg + "</font>");
            _loc_5.htmlText = _loc_7;
            this.addChild(_loc_5);
            return;
        }// end function

        public function setRequestType(param1:TroopRequestInfo) : void
        {
            var _loc_7:ClanMemberInfo = null;
            this.type = 1;
            if (this.uId != GameDataMgr.getInstance().myInfo.uId)
            {
                _loc_7 = GameDataMgr.getInstance().myClanMembers[this.uId.toString()];
                if (!_loc_7)
                {
                    return;
                }
                this.uName = _loc_7.name;
            }
            else
            {
                this.uName = "Bạn";
            }
            this.created = param1.created;
            var _loc_2:* = new TooltipText(false, true);
            _loc_2.x = padingLeft;
            _loc_2.width = 280;
            var _loc_3:* = "<font color =\'#FDC877\' size=\'" + fontSize + "\'>" + this.uName + ":</font>";
            _loc_3 = _loc_3 + ("<font color =\'#FFFFFF\' size=\'" + fontSize + "\'> xin quân</font>");
            _loc_2.htmlText = _loc_3;
            this.addChild(_loc_2);
            var _loc_4:* = padingLeft;
            var _loc_5:* = _loc_2.y + _loc_2.height;
            this.bg = ResMgr.getInstance().getMovieClip("DonateTroopBgBar") as Sprite;
            this.addChild(this.bg);
            this.bg.x = _loc_2.x + (_loc_2.width - this.bg.width) / 2;
            this.bg.y = _loc_5 + 5;
            this.bar = ResMgr.getInstance().getMovieClip("DonateTroopBar") as Sprite;
            this.addChild(this.bar);
            this.bar.x = this.bg.x;
            this.bar.y = this.bg.y;
            _loc_5 = this.bar.y + this.bar.height;
            this.labelNumber = new TooltipText(true, true);
            this.labelNumber.autoSize = TextFieldAutoSize.RIGHT;
            this.updateCapacity(param1);
            this.labelNumber.x = this.bar.x - this.labelNumber.textWidth - 5;
            this.labelNumber.y = this.bar.y + this.bar.height - this.labelNumber.textHeight;
            this.addChild(this.labelNumber);
            var _loc_6:* = this.isDonated(param1);
            this.bmpDonate = null;
            if (this.uId != GameDataMgr.getInstance().myInfo.uId && !_loc_6)
            {
                this.bmpDonate = new BitmapButton(ResMgr.getInstance().getMovieClip("bmpDonate"), 1);
                this.bmpDonate.img.addEventListener(MouseEvent.CLICK, this.onClickDonate);
                this.addChild(this.bmpDonate.img);
                this.bmpDonate.img.x = _loc_2.x + (_loc_2.width - this.bmpDonate.img.width) / 2;
                this.bmpDonate.img.y = _loc_5 + 5;
                _loc_4 = this.bmpDonate.img.x + this.bmpDonate.img.width + 10;
                _loc_5 = this.bmpDonate.img.y + this.bmpDonate.height;
            }
            if (_loc_6)
            {
                this.sayThankyou(param1);
            }
            return;
        }// end function

        private function sayThankyou(param1:TroopRequestInfo) : void
        {
            var _loc_2:* = Localization.getInstance().getString("ClanThanks");
            var _loc_3:* = this.getExp(param1);
            _loc_2 = _loc_2.replace("@number", _loc_3.toString());
            var _loc_4:* = new TooltipText(true, true);
            _loc_4.autoSize = TextFieldAutoSize.CENTER;
            _loc_4.htmlText = "<p align=\'center\'><textformat leading=\'-4\'><font color =\'#23E2DE\' size=\'" + fontSize + "\'> " + _loc_2 + "</font></textformat></p></br>";
            _loc_4.x = this.bg.x + (this.bg.width - _loc_4.width) / 2;
            _loc_4.y = this.bg.y + this.bg.height - 5;
            this.addChild(_loc_4);
            return;
        }// end function

        private function getExp(param1:TroopRequestInfo) : int
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            while (_loc_3 < param1.myDonation.length)
            {
                
                _loc_2 = _loc_2 + param1.myDonation[_loc_3].num * Utility.getHousingSpace(param1.myDonation[_loc_3].type);
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function isDonated(param1:TroopRequestInfo) : Boolean
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            while (_loc_3 < param1.myDonation.length)
            {
                
                _loc_2 = _loc_2 + param1.myDonation[_loc_3].num;
                _loc_3++;
            }
            return _loc_2 == GlobalVar.CLAN_MAX_DONATION;
        }// end function

        public function updateCapacity(param1:TroopRequestInfo) : void
        {
            this.labelNumber.htmlText = "<font color =\'#FFFFFF\' size=\'" + fontSize + "\'>" + param1.curCapacity + "/" + param1.maxCapacity + " </font> </br>";
            this.bar.scaleX = Math.min(1, param1.curCapacity / param1.maxCapacity);
            if (this.bmpDonate && this.bmpDonate.visible && this.isDonated(param1))
            {
                this.bmpDonate.visible = false;
                this.sayThankyou(param1);
            }
            if (param1.curCapacity == param1.maxCapacity)
            {
                if (this.bmpDonate)
                {
                    this.bmpDonate.visible = false;
                }
                CityMgr.getInstance().guiContentChat.removeItemAfterDonateFull(this.uId);
            }
            return;
        }// end function

        private function onClickDonate(event:MouseEvent) : void
        {
            CityMgr.getInstance().guiContentChat.onChatItemClick(this.uId);
            return;
        }// end function

    }
}
