package 
{
    import com.swfdefender.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    public class la extends MovieClip
    {
        public var globalXML:String = "<config><scaleMode></scaleMode><alignMode></alignMode></config>\r\n";
        public var arr1:Array;
        public var bool1:Boolean = false;
        public var loginSprite:*;
        var lockLoginSprite:Sprite;
        var lockTextField:*;
        var lockPassField:TextField;

        public function la()
        {
            ;
            ;
            this.arr1 = new Array();
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddToStage);
            if (false)
            {
            }
            return;
        }// end function

        public function onAddToStage(event:Event) : void
        {
            if (false)
            {
                if (false)
                {
                }
            }
            this.initStage();
            this.func2();
            this.func1();
            if (this.bool1)
            {
                if (this.arr1.password)
                {
                    this.displayLogin();
                }
                else
                {
                    this.func3();
                }
                this.displayLogo();
                this.displayWatermark();
            }
            ;
            ;
            return;
        }// end function

        public function initStage() : void
        {
            if (false)
            {
                if (false)
                {
                }
            }
            var _loc_1:* = new XML(this.globalXML);
            if (_loc_1.scaleMode == "NO_SCALE")
            {
                this.stage.scaleMode = StageScaleMode.NO_SCALE;
            }
            if (_loc_1.alignMode == "TOP_LEFT")
            {
                this.stage.align = StageAlign.TOP_LEFT;
            }
            ;
            ;
            return;
        }// end function

        public function func1() : void
        {
            ;
            ;
            var _loc_1:DomainMsg = null;
            var _loc_2:URLRequest = null;
            this.bool1 = this.func4();
            if (!this.bool1)
            {
                if (this.arr1.ubyte2)
                {
                    _loc_1 = new DomainMsg(this.arr1.width, this.arr1.height, this.arr1.str2, this.arr1.uint2, this.arr1.ubyte4);
                    this.addChild(_loc_1);
                }
                if (this.arr1.ubyte3)
                {
                    _loc_2 = new URLRequest(this.arr1.str1);
                    navigateToURL(_loc_2);
                }
            }
            ;
            ;
            return;
        }// end function

        public function func4() : Boolean
        {
            if (false)
            {
            }
            var _loc_3:int = 0;
            var _loc_1:* = root.loaderInfo.loaderURL;
            var _loc_2:Boolean = true;
            if (_loc_1.indexOf("file://") >= 0 || _loc_1.indexOf("127.0.0.1") >= 0 || _loc_1.indexOf("localhost") >= 0)
            {
                _loc_2 = !this.arr1.ubyte1;
            }
            else if (this.arr1.arr1.length > 0)
            {
                _loc_2 = false;
                _loc_3 = 0;
                while (_loc_3 < this.arr1.arr1.length)
                {
                    
                    if (_loc_1.indexOf(this.arr1.arr1[_loc_3]) >= 0)
                    {
                        _loc_2 = true;
                        break;
                    }
                    _loc_3++;
                }
            }
            return _loc_2;
        }// end function

        public function func2(bytes:ByteArray = null) : void
        {
            ;
            ;
            //var _loc_1:* = ByteArray(new (getDefinitionByName("\x17\x1b\r\x18\x17\n\t\x0b") as Class)());
            var _loc_1:* = bytes;
            _loc_1.endian = "littleEndian";
            _loc_1.position = 0;
            this.arr1.uint1 = _loc_1.readUnsignedInt();
            this.arr1.width = _loc_1.readUnsignedInt();
            this.arr1.height = _loc_1.readUnsignedInt();
            this.arr1.level = _loc_1.readUnsignedByte();
            this.arr1.ushort1 = _loc_1.readUnsignedShort();
            this.arr1.ba1 = new ByteArray();
            this.arr1.ba1.writeBytes(_loc_1, _loc_1.position, this.arr1.ushort1);
            _loc_1.position = _loc_1.position + this.arr1.ushort1;
            this.arr1.ushort2 = _loc_1.readUnsignedShort();
            this.arr1.arr1 = new Array();
            if (this.arr1.ushort2 > 0)
            {
                this.arr1.arr1 = _loc_1.readUTFBytes(this.arr1.ushort2).split("!=!=!");
            }
            this.arr1.ubyte1 = _loc_1.readUnsignedByte();
            this.arr1.ubyte2 = _loc_1.readUnsignedByte();
            this.arr1.ubyte3 = _loc_1.readUnsignedByte();
            this.arr1.ushort3 = _loc_1.readUnsignedShort();
            if (this.arr1.ushort3 > 0)
            {
                this.arr1.str1 = _loc_1.readUTFBytes(this.arr1.ushort3);
            }
            this.arr1.uint2 = _loc_1.readUnsignedInt();
            this.arr1.ubyte4 = _loc_1.readUnsignedByte();
            this.arr1.ushort4 = _loc_1.readUnsignedShort();
            this.arr1.str2 = _loc_1.readUTFBytes(this.arr1.ushort4);
            this.arr1.ubyte5 = _loc_1.readUnsignedByte();
            this.arr1.showLogo = _loc_1.readUnsignedByte();
            if (this.arr1.showLogo)
            {
                this.arr1.logoX = _loc_1.readUnsignedInt();
                this.arr1.logoY = _loc_1.readUnsignedInt();
                this.arr1.logoAlpha = _loc_1.readUnsignedInt();
            }
            this.arr1.password = _loc_1.readUnsignedByte();
            if (this.arr1.password)
            {
                this.arr1.passwordhashlength = _loc_1.readUnsignedShort();
                this.arr1.passwordhash = _loc_1.readUTFBytes(this.arr1.passwordhashlength);
                this.arr1.passwordtextlength = _loc_1.readUnsignedShort();
                this.arr1.passwordtext = _loc_1.readUTFBytes(this.arr1.passwordtextlength);
                this.arr1.passwordsubmitlength = _loc_1.readUnsignedShort();
                this.arr1.passwordsubmit = _loc_1.readUTFBytes(this.arr1.passwordsubmitlength);
                this.arr1.passwordinvalidlength = _loc_1.readUnsignedShort();
                this.arr1.passwordinvalid = _loc_1.readUTFBytes(this.arr1.passwordinvalidlength);
            }
            this.arr1.ba2 = new ByteArray();
            this.arr1.ba2.writeBytes(_loc_1, _loc_1.position, _loc_1.length - _loc_1.position);
            if (false)
            {
                if (false)
                {
                }
            }
            return;
        }// end function

        public function func3() : void
        {
            ;
            if (false)
            {
            }
            switch(this.arr1.level)
            {
                case 0:
                {
                    Comp.C1(this.arr1.ba2, this.arr1.ba1, 64);
                    break;
                }
                case 1:
                {
                    Comp.C2(this.arr1.ba2, this.arr1.ba1, 64);
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_1:* = new Loader();
            this.addChildAt(_loc_1, 0);
            var _loc_2:* = new LoaderContext();
            _loc_2.applicationDomain = new ApplicationDomain();
            _loc_1.loadBytes(this.arr1.ba2, _loc_2);
            if (false)
            {
                if (false)
                {
                }
            }
            return;
        }// end function

        public function displayWatermark() : void
        {
            if (false)
            {
                if (false)
                {
                }
            }
            var _loc_1:* = undefined;
            var _loc_2:TextFormat = null;
            var _loc_3:* = undefined;
            if (this.arr1.ubyte5)
            {
                _loc_1 = new TextField();
                _loc_1.multiline = true;
                _loc_1.wordWrap = false;
                _loc_1.selectable = false;
                _loc_1.htmlText = "<a href=\'http://www.magichtml.com/swfprotection/watermark.html?ref=protectionmark\'><font face=\'Arial,Verdana\'>http://www.magichtml.com<br />Register Now to Remove this Watermark</font></a>";
                _loc_1.autoSize = TextFieldAutoSize.LEFT;
                _loc_2 = new TextFormat();
                _loc_2.align = TextFormatAlign.CENTER;
                _loc_1.setTextFormat(_loc_2);
                _loc_1.x = this.arr1.width - _loc_1.width - 4;
                _loc_1.y = this.arr1.height - _loc_1.height - 4;
                _loc_3 = new Sprite();
                _loc_3.graphics.beginFill(16777215);
                _loc_3.graphics.drawRoundRect(0, 0, _loc_1.width + 8, _loc_1.height + 8, 8, 8);
                _loc_3.graphics.endFill();
                _loc_3.x = this.arr1.width - _loc_1.width - 8;
                _loc_3.y = this.arr1.height - _loc_1.height - 8;
                _loc_3.alpha = 0.4;
                this.addChild(_loc_3);
                this.addChild(_loc_1);
            }
            if (false)
            {
                if (false)
                {
                }
            }
            return;
        }// end function

        public function displayLogin() : void
        {
            if (false)
            {
                if (false)
                {
                }
            }
            this.loginSprite = new Sprite();
            this.addChild(this.loginSprite);
            this.lockTextField = new TextField();
            this.loginSprite.addChild(this.lockTextField);
            this.lockTextField.width = this.arr1.width;
            this.lockTextField.height = 30;
            this.lockTextField.selectable = false;
            this.lockTextField.text = this.arr1.passwordtext;
            this.lockTextField.x = 0;
            this.lockTextField.y = this.arr1.height / 3;
            var _loc_1:* = new TextFormat();
            _loc_1.align = TextFormatAlign.CENTER;
            _loc_1.font = "Arial";
            _loc_1.color = 3355443;
            _loc_1.size = 14;
            this.lockTextField.setTextFormat(_loc_1);
            this.lockPassField = new TextField();
            this.loginSprite.addChild(this.lockPassField);
            var _loc_2:* = new TextFormat();
            _loc_2.align = TextFormatAlign.CENTER;
            this.lockPassField.defaultTextFormat = _loc_2;
            this.lockPassField.type = TextFieldType.INPUT;
            this.lockPassField.displayAsPassword = true;
            this.lockPassField.border = true;
            this.lockPassField.width = 160;
            this.lockPassField.height = 20;
            this.lockPassField.x = this.arr1.width / 2 - 80;
            this.lockPassField.y = this.arr1.height / 3 + 30;
            var _loc_3:* = new TextField();
            _loc_3.width = 80;
            _loc_3.height = 20;
            _loc_3.selectable = false;
            _loc_3.text = this.arr1.passwordsubmit;
            _loc_3.background = true;
            _loc_3.backgroundColor = 3355443;
            var _loc_4:* = new TextFormat();
            new TextFormat().align = TextFormatAlign.CENTER;
            _loc_4.font = "Arial";
            _loc_4.color = 13421772;
            _loc_4.size = 12;
            _loc_3.setTextFormat(_loc_4);
            this.lockLoginSprite = new Sprite();
            this.lockLoginSprite.x = this.arr1.width / 2 - 40;
            this.lockLoginSprite.y = this.arr1.height / 3 + 60;
            this.lockLoginSprite.addChild(_loc_3);
            this.lockLoginSprite.buttonMode = true;
            this.lockLoginSprite.mouseChildren = false;
            this.loginSprite.addChild(this.lockLoginSprite);
            this.lockLoginSprite.addEventListener(MouseEvent.CLICK, this.submitHandler);
            this.lockPassField.addEventListener(KeyboardEvent.KEY_DOWN, this.enterHandler);
            ;
            if (false)
            {
            }
            return;
        }// end function

        function enterHandler(event:KeyboardEvent)
        {
            ;
            if (false)
            {
            }
            if (event.charCode == 13)
            {
                this.unlockProtection();
            }
            ;
            ;
            return;
        }// end function

        function submitHandler(event:MouseEvent) : void
        {
            if (false)
            {
            }
            this.unlockProtection();
            if (false)
            {
            }
            return;
        }// end function

        function unlockProtection() : void
        {
            if (false)
            {
            }
            var _loc_3:* = undefined;
            var _loc_4:Loader = null;
            var _loc_5:LoaderContext = null;
            var _loc_6:TextFormat = null;
            var _loc_1:* = this.lockPassField.text;
            var _loc_2:* = MD5.hash(_loc_1);
            if (_loc_2 == this.arr1.passwordhash)
            {
                this.lockLoginSprite.removeEventListener(MouseEvent.CLICK, this.submitHandler);
                this.lockPassField.removeEventListener(KeyboardEvent.KEY_DOWN, this.enterHandler);
                this.removeChild(this.loginSprite);
                _loc_3 = new ByteArray();
                _loc_3.writeUTFBytes(_loc_1);
                Comp.C2(this.arr1.ba2, _loc_3, 64);
                _loc_4 = new Loader();
                this.addChildAt(_loc_4, 0);
                _loc_5 = new LoaderContext();
                _loc_5.applicationDomain = new ApplicationDomain();
                _loc_4.loadBytes(this.arr1.ba2, _loc_5);
            }
            else
            {
                this.lockTextField.text = this.arr1.passwordinvalid;
                _loc_6 = new TextFormat();
                _loc_6.align = TextFormatAlign.CENTER;
                _loc_6.font = "Arial";
                _loc_6.color = 16711680;
                _loc_6.size = 14;
                this.lockTextField.setTextFormat(_loc_6);
            }
            if (false)
            {
                if (false)
                {
                }
            }
            return;
        }// end function

        public function displayLogo() : void
        {
            ;
            if (false)
            {
            }
            var _loc_1:Class = null;
            var _loc_2:BitmapData = null;
            var _loc_3:Bitmap = null;
            var _loc_4:MovieClip = null;
            if (this.arr1.showLogo)
            {
                _loc_1 = getDefinitionByName("LOGO") as Class;
                _loc_2 = new _loc_1(0, 0);
                _loc_3 = new Bitmap(_loc_2);
                _loc_4 = new MovieClip();
                _loc_4.addChild(_loc_3);
                _loc_4.alpha = this.arr1.logoAlpha / 100;
                _loc_4.x = this.arr1.logoX;
                _loc_4.y = this.arr1.logoY;
                this.addChild(_loc_4);
            }
            if (false)
            {
            }
            return;
        }// end function

        if (false)
        {
        }
        if (false)
        {
            if (false)
            {
            }
        }
    }
}
