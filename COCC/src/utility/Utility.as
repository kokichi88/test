package utility
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.utils.*;
    import gameData.*;
    import map.*;
    import modules.battle.data.*;
    import modules.city.logic.*;
    import org.as3commons.reflect.*;
    import resMgr.*;
    import resMgr.data.*;

    public class Utility extends Object
    {
        public static const COMMA:String = ",";
        public static const SPACE:String = " ";
        private static var currentTime:Number = 0;
        private static var curClientTime:Number = 0;
        public static const DELTA_DELAY_TIME:Number = 2;
        private static var troopHousingSpace:Object;
        private static var saveFnCallBack:Function;

        public function Utility()
        {
            return;
        }// end function

        public static function randomNumber(param1:Number = 0, param2:Number = 1) : Number
        {
            return Math.floor(Math.random() * (1 + param2 - param1)) + param1;
        }// end function

        public static function convertTimeToString(param1:Number, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true, param5:Boolean = true) : String
        {
            var _loc_6:* = param1 / 3600;
            var _loc_7:* = param1 % 3600 / 60;
            var _loc_8:* = param1 - _loc_6 * 3600 - _loc_7 * 60;
            var _loc_9:* = _loc_6 / 24;
            _loc_6 = _loc_6 % 24;
            var _loc_10:String = "";
            if (_loc_9 > 0 && param2)
            {
                _loc_10 = _loc_10 + (_loc_9 + "d ");
            }
            if (_loc_6 > 0 && param3)
            {
                _loc_10 = _loc_10 + (_loc_6 + "h ");
            }
            if (_loc_7 > 0 && param4)
            {
                _loc_10 = _loc_10 + (_loc_7 + "m ");
            }
            if (_loc_8 > 0 && param5)
            {
                _loc_10 = _loc_10 + (_loc_8 + "s");
            }
            return _loc_10;
        }// end function

        public static function convertTimeToShortString(param1:Number) : String
        {
            var _loc_2:* = param1 / 3600;
            var _loc_3:* = param1 % 3600 / 60;
            var _loc_4:* = param1 - _loc_2 * 3600 - _loc_3 * 60;
            var _loc_5:* = _loc_2 / 24;
            _loc_2 = _loc_2 % 24;
            var _loc_6:String = "";
            if (_loc_5 > 0)
            {
                _loc_6 = _loc_5 + "d ";
                if (_loc_2 > 0)
                {
                    _loc_6 = _loc_6 + (_loc_2 + "h");
                }
                else
                {
                    _loc_6 = _loc_6 + "00h";
                }
            }
            else if (_loc_2 > 0)
            {
                _loc_6 = _loc_6 + (_loc_2 + "h ");
                if (_loc_3 > 0)
                {
                    _loc_6 = _loc_6 + (_loc_3 + "m");
                }
                else
                {
                    _loc_6 = _loc_6 + "00m";
                }
            }
            else if (_loc_3 > 0)
            {
                _loc_6 = _loc_6 + (_loc_3 + "m ");
                if (_loc_4 > 0)
                {
                    _loc_6 = _loc_6 + (_loc_4 + "s");
                }
                else
                {
                    _loc_6 = _loc_6 + "00s";
                }
            }
            else if (_loc_4 >= 0)
            {
                _loc_6 = _loc_6 + (_loc_4 + "s");
            }
            return _loc_6;
        }// end function

        public static function standardNumber(param1:Number) : String
        {
            var _loc_2:int = 0;
            var _loc_3:* = Math.abs(param1);
            var _loc_4:* = _loc_3.toString();
            var _loc_5:String = "";
            if (_loc_3 >= 1000)
            {
                _loc_4 = _loc_4.split("").reverse().join("");
                _loc_2 = 0;
                while (_loc_2 <= _loc_4.length)
                {
                    
                    _loc_5 = _loc_5.concat(_loc_4.substr(_loc_2, 3));
                    if (_loc_4.substr(_loc_2 + 3).length > 0)
                    {
                        _loc_5 = _loc_5.concat(COMMA);
                    }
                    _loc_2 = _loc_2 + 3;
                }
                _loc_4 = _loc_5.split("").reverse().join("");
            }
            if (param1 < 0)
            {
                _loc_4 = "-" + _loc_4;
            }
            return _loc_4;
        }// end function

        public static function numToStr(param1:Number) : String
        {
            var _loc_2:String = ".";
            var _loc_3:String = "";
            var _loc_4:* = param1.toString();
            var _loc_5:Boolean = false;
            if (param1 < 0)
            {
                _loc_5 = true;
                _loc_4 = _loc_4.slice(1, _loc_4.length);
            }
            var _loc_6:* = int(_loc_4.length);
            switch(int(_loc_6 / 3 - 0.1))
            {
                case 0:
                {
                    _loc_3 = _loc_4;
                    break;
                }
                case 1:
                {
                    _loc_3 = _loc_4.slice(0, _loc_4.length - 3) + _loc_2 + _loc_4.slice(_loc_4.length - 3, _loc_4.length);
                    break;
                }
                case 2:
                {
                    _loc_3 = _loc_4.slice(0, _loc_4.length - 6) + _loc_2 + _loc_4.slice(_loc_4.length - 6, _loc_4.length - 3) + _loc_2 + _loc_4.slice(_loc_4.length - 3, _loc_4.length);
                    break;
                }
                case 3:
                {
                    _loc_3 = _loc_4.slice(0, _loc_4.length - 9) + _loc_2 + _loc_4.slice(_loc_4.length - 9, _loc_4.length - 6) + _loc_2 + _loc_4.slice(_loc_4.length - 6, _loc_4.length - 3) + _loc_2 + _loc_4.slice(_loc_4.length - 3, _loc_4.length);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_5)
            {
                _loc_3 = "-" + _loc_3;
            }
            return _loc_3;
        }// end function

        public static function convertStringToInt(param1:String) : Number
        {
            while (param1.search(COMMA) >= 0)
            {
                
                param1 = param1.replace(COMMA, "");
            }
            return isNaN(Number(param1)) ? (0) : (Number(param1));
        }// end function

        public static function filterVietnameseCharacter(param1:String, param2:Boolean = true) : String
        {
            var _loc_3:* = param1;
            if (param2)
            {
                _loc_3 = param1.toLowerCase();
            }
            _loc_3 = _loc_3.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ""à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
            _loc_3 = _loc_3.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ""è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
            _loc_3 = _loc_3.replace(/ì|í|ị|ỉ|ĩ""ì|í|ị|ỉ|ĩ/g, "i");
            _loc_3 = _loc_3.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ""ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
            _loc_3 = _loc_3.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ""ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
            _loc_3 = _loc_3.replace(/ỳ|ý|ỵ|ỷ|ỹ""ỳ|ý|ỵ|ỷ|ỹ/g, "y");
            _loc_3 = _loc_3.replace(/đ""đ/g, "d");
            return _loc_3;
        }// end function

        public static function standardString(param1:String, param2:int = 20) : String
        {
            var _loc_3:String = "";
            if (param1 == null)
            {
                return "";
            }
            if (param1.length > param2)
            {
                _loc_3 = param1.substr(0, param2).concat("..");
                return _loc_3;
            }
            return param1;
        }// end function

        public static function convertToTime(param1:int, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true) : String
        {
            var _loc_13:String = null;
            if (param1 <= 0)
            {
                return "00:00:00";
            }
            var _loc_5:* = param1 / 3600;
            var _loc_6:* = param1 % 3600;
            var _loc_7:* = param1 % 3600 / 60;
            var _loc_8:* = _loc_6 % 60;
            var _loc_9:* = _loc_6 % 60;
            var _loc_10:* = _loc_5 < 10 ? ("0" + _loc_5) : (_loc_5.toString());
            var _loc_11:* = _loc_7 < 10 ? ("0" + _loc_7) : (_loc_7.toString());
            var _loc_12:* = _loc_9 < 10 ? ("0" + _loc_9) : (_loc_9.toString());
            if (param2)
            {
                _loc_13 = _loc_10 + ":" + _loc_11 + ":" + _loc_12;
            }
            else if (param3)
            {
                _loc_13 = _loc_11 + ":" + _loc_12;
            }
            else
            {
                _loc_13 = _loc_12;
            }
            return _loc_13;
        }// end function

        public static function convertTimeToDate(param1:Number, param2:Boolean = true, param3:Boolean = true) : String
        {
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_4:String = "";
            var _loc_5:* = new Date();
            new Date().setTime((param1 + 7 * 3600) * 1000);
            if (param3)
            {
                if (_loc_5.getUTCMinutes() < 10)
                {
                    _loc_6 = "0" + _loc_5.getUTCMinutes();
                }
                else
                {
                    _loc_6 = _loc_5.getUTCMinutes().toString();
                }
                if (_loc_5.getUTCHours() < 10)
                {
                    _loc_7 = "0" + _loc_5.getUTCHours();
                }
                else
                {
                    _loc_7 = _loc_5.getUTCHours().toString();
                }
                _loc_4 = _loc_4 + (_loc_7 + ":" + _loc_6);
                if (param2)
                {
                    _loc_4 = _loc_4 + " ";
                }
            }
            if (param2 == true)
            {
                switch(_loc_5.getUTCDay())
                {
                    case 0:
                    {
                        _loc_4 = _loc_4 + "Chủ Nhật, ";
                        break;
                    }
                    case 1:
                    {
                        _loc_4 = _loc_4 + "Thứ Hai, ";
                        break;
                    }
                    case 2:
                    {
                        _loc_4 = _loc_4 + "Thứ Ba, ";
                        break;
                    }
                    case 3:
                    {
                        _loc_4 = _loc_4 + "Thứ Tư, ";
                        break;
                    }
                    case 4:
                    {
                        _loc_4 = _loc_4 + "Thứ Năm, ";
                        break;
                    }
                    case 5:
                    {
                        _loc_4 = _loc_4 + "Thứ Sáu, ";
                        break;
                    }
                    case 6:
                    {
                        _loc_4 = _loc_4 + "Thứ Bảy, ";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_4 = _loc_4 + ("ngày " + _loc_5.getUTCDate() + "/" + (_loc_5.getUTCMonth() + 1));
            }
            return _loc_4;
        }// end function

        public static function setData(param1:Object, param2:Object) : void
        {
            var _loc_3:String = null;
            var _loc_4:Class = null;
            var _loc_5:int = 0;
            var _loc_6:* = param2;
            do
            {
                
                _loc_3 = _loc_6[_loc_5];
                try
                {
                    if (param1[_loc_3] is Vector)
                    {
                        _loc_4 = getDefinitionByName(getQualifiedClassName(param1[_loc_3][0])) as Class;
                    }
                    else
                    {
                        param1[_loc_3] = param2[_loc_3];
                    }
                }
                catch (err:Error)
                {
                }
            }while (_loc_6 in _loc_5)
            return;
        }// end function

        public static function getProperties(param1) : Array
        {
            var _loc_6:String = null;
            var _loc_2:* = ReflectionUtils.getTypeDescription(Class(getDefinitionByName(getQualifiedClassName(param1))));
            var _loc_3:* = _loc_2.factory.variable;
            var _loc_4:* = new Array();
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3.length())
            {
                
                _loc_6 = _loc_3[_loc_5].@name;
                _loc_4.push(_loc_6);
                _loc_5++;
            }
            return _loc_4;
        }// end function

        public static function compareObject(param1:Object, param2:Object) : Boolean
        {
            var _loc_6:int = 0;
            var _loc_3:* = new ByteArray();
            _loc_3.writeObject(param1);
            var _loc_4:* = new ByteArray();
            new ByteArray().writeObject(param2);
            var _loc_5:* = _loc_3.length;
            if (_loc_3.length == _loc_4.length)
            {
                _loc_3.position = 0;
                _loc_4.position = 0;
                while (_loc_3.position < _loc_5)
                {
                    
                    _loc_6 = _loc_3.readByte();
                    if (_loc_6 != _loc_4.readByte())
                    {
                        return false;
                    }
                }
                return true;
            }
            return false;
        }// end function

        public static function updateTime() : void
        {
            var _loc_1:* = getTimer();
            var _loc_2:* = _loc_1 - curClientTime;
            if (_loc_2 < 1000)
            {
                currentTime = currentTime + _loc_2 / 1000;
            }
            curClientTime = _loc_1;
            return;
        }// end function

        public static function getCurTime() : Number
        {
            return currentTime;
        }// end function

        public static function setCurTime(param1:Number) : void
        {
            currentTime = param1;
            curClientTime = getTimer();
            return;
        }// end function

        public static function getShopItem(param1:DataBuildingInfo) : DisplayObject
        {
            var _loc_17:int = 0;
            var _loc_18:int = 0;
            var _loc_2:* = new Sprite();
            var _loc_3:* = new TooltipText(true, true, true);
            var _loc_4:String = "";
            _loc_4 = "<p align=\'left\'><font size =\'15\' color =\'#FFFF00\' >";
            if (param1.type == "")
            {
                _loc_4 = _loc_4 + "No Name";
            }
            else
            {
                _loc_4 = _loc_4 + Localization.getInstance().getString(param1.type).toUpperCase();
            }
            _loc_4 = _loc_4 + "</font></p>";
            _loc_3.htmlText = _loc_4;
            var _loc_5:* = param1.buildTime;
            var _loc_6:* = param1.cost.value;
            var _loc_7:* = param1.maxCount;
            var _loc_8:* = param1.curCount;
            var _loc_9:* = param1.cost.type;
            var _loc_10:* = ResMgr.getInstance().getMovieClip(_loc_9 + "_Small_Icon") as Sprite;
            var _loc_11:* = new TooltipText(true);
            _loc_4 = "<font size =\'14\' color =\'#FFFFFF\' >";
            _loc_4 = _loc_4 + "Giá mua: \nThời gian xây dựng: ";
            if (_loc_7 > 0)
            {
                _loc_4 = _loc_4 + "\nSố lượng đã xây: ";
            }
            _loc_4 = _loc_4 + "</font>";
            var _loc_12:* = GameDataMgr.getInstance().townHall;
            if (GameDataMgr.getInstance().townHall)
            {
                if (_loc_12.level < param1.townHallLevelRequired)
                {
                    _loc_4 = _loc_4 + "\n<font size =\'14\' color =\'#FF4040\' >Yêu cầu cấp nhà chính: </font>";
                }
                if (_loc_7 > 0 && _loc_8 == _loc_7)
                {
                    _loc_17 = JsonMgr.getInstance().getConfigMaxLevel(BuildingType.TOWN_HALL);
                    _loc_18 = JsonMgr.getInstance().getLevelForGetMoreBuildings(param1.type, _loc_8);
                    if (_loc_18 == -1 || _loc_18 > _loc_17)
                    {
                        _loc_4 = _loc_4 + "\n<font size =\'14\' color =\'#FF4040\' >Đã đạt số lượng tối đa.</font>";
                    }
                    else
                    {
                        _loc_4 = _loc_4 + ("\n<font size =\'14\' color =\'#FF4040\' >Nâng nhà chính lên cấp " + _loc_18 + " để xây thêm.</font>");
                    }
                }
            }
            _loc_11.htmlText = _loc_4;
            var _loc_13:* = new TooltipText(true);
            var _loc_14:* = new TooltipText(true);
            var _loc_15:String = "";
            _loc_15 = "<font size =\'14\' color =\'#FFFFFF\' >";
            _loc_15 = _loc_15 + (numToStr(_loc_6) + "\n");
            _loc_15 = _loc_15 + "</font>";
            _loc_4 = "<font size =\'14\' color =\'#FFFFFF\' >";
            _loc_4 = _loc_4 + convertTimeToShortString(_loc_5);
            if (_loc_7 > 0)
            {
                _loc_4 = _loc_4 + ("\n" + _loc_8 + "/" + _loc_7);
            }
            _loc_4 = _loc_4 + "</font>";
            if (_loc_12)
            {
                if (_loc_12.level < param1.townHallLevelRequired)
                {
                    _loc_4 = _loc_4 + ("\n<font size =\'14\' color =\'#FF4040\' >" + param1.townHallLevelRequired + " </font>");
                }
            }
            _loc_13.htmlText = _loc_4;
            _loc_14.htmlText = _loc_15;
            var _loc_16:int = 5;
            _loc_2.addChild(_loc_3);
            _loc_2.addChild(_loc_11);
            _loc_2.addChild(_loc_13);
            _loc_2.addChild(_loc_14);
            _loc_11.y = _loc_3.y + _loc_3.height;
            _loc_11.x = _loc_16;
            _loc_14.x = _loc_11.x + _loc_11.width;
            _loc_14.y = _loc_11.y;
            _loc_13.x = _loc_14.x;
            _loc_13.y = _loc_14.y + _loc_14.textHeight;
            _loc_3.x = (_loc_2.width - _loc_3.width) / 2;
            if (_loc_10)
            {
                _loc_2.addChild(_loc_10);
                _loc_10.x = _loc_14.x + _loc_14.textWidth + 5;
                _loc_10.y = _loc_14.y - 2;
            }
            return _loc_2;
        }// end function

        public static function getTooltipTroop(param1:Troop) : DisplayObject
        {
            var _loc_2:* = new Sprite();
            var _loc_3:* = new TooltipText(true, false, true);
            var _loc_4:String = "";
            _loc_4 = "<p align=\'center\'><b><font size =\'20\' color =\'#FFFF00\' >";
            _loc_4 = _loc_4 + getName(param1.type);
            _loc_4 = _loc_4 + "</font></b></p>";
            _loc_3.htmlText = _loc_4;
            var _loc_5:* = JsonMgr.getInstance().getInfoTroop(param1.type, param1.level);
            var _loc_6:* = new TooltipText(true);
            _loc_4 = "<font size =\'14\' color =\'#FFFFFF\' >";
            _loc_4 = _loc_4 + "Sức mạnh: \nTốc độ: \nPhạm vi tấn công: \nMục tiêu ưu tiên:</font>";
            _loc_6.htmlText = _loc_4;
            var _loc_7:* = new TooltipText(true);
            _loc_4 = "<font size =\'14\' color =\'#FFFFFF\' >";
            _loc_4 = _loc_4 + (_loc_5.damagePerAttack + "\n");
            _loc_4 = _loc_4 + (int(_loc_5.moveSpeed / 8 * 30).toString() + "\n");
            _loc_4 = _loc_4 + (_loc_5.attackSpeed * 30 + "\n");
            _loc_4 = _loc_4 + (Localization.getInstance().getString("Favorite_" + _loc_5.favoriteTarget) + "\n");
            _loc_4 = _loc_4 + "</font>";
            _loc_7.htmlText = _loc_4;
            var _loc_8:int = 5;
            _loc_2.addChild(_loc_3);
            _loc_2.addChild(_loc_6);
            _loc_2.addChild(_loc_7);
            _loc_6.y = _loc_3.y + _loc_3.height;
            _loc_6.x = _loc_8;
            _loc_7.x = _loc_6.x + _loc_6.width;
            _loc_7.y = _loc_6.y;
            _loc_3.x = (_loc_2.width - _loc_3.width) / 2;
            return _loc_2;
        }// end function

        public static function getTooltipMapObject(param1:String, param2:int) : DisplayObject
        {
            var _loc_6:TooltipText = null;
            var _loc_3:* = new Sprite();
            var _loc_4:* = new TooltipText(true, true, true);
            var _loc_5:String = "";
            _loc_5 = "<p align=\'center\'><b><font size =\'11\' color =\'#FFFF80\' >";
            _loc_5 = _loc_5 + getName(param1);
            _loc_5 = _loc_5 + "</font></b></p>";
            _loc_4.htmlText = _loc_5.toUpperCase();
            _loc_3.addChild(_loc_4);
            _loc_4.x = 0;
            _loc_4.y = -4;
            if (getTypeObject(param1) != BuildingType.OBS && param1 != BuildingType.CLAN_CASTLE && getTypeObject(param1) != BuildingType.TRA)
            {
                _loc_6 = new TooltipText(true, true, true);
                _loc_5 = "";
                _loc_5 = "<p align=\'center\'><b><font size =\'9\' color =\'#FFFFFF\' >Cấp ";
                _loc_5 = _loc_5 + param2.toString();
                _loc_5 = _loc_5 + "</font></b></p>";
                _loc_6.htmlText = _loc_5;
                _loc_3.addChild(_loc_6);
                _loc_6.y = _loc_4.y + _loc_4.textHeight;
                _loc_6.x = 0;
                _loc_6.x = (_loc_4.textWidth - _loc_6.textWidth) / 2;
            }
            return _loc_3;
        }// end function

        public static function getTooltipMapPoint(param1:String, param2:int, param3:int) : DisplayObject
        {
            var _loc_4:* = new Sprite();
            var _loc_5:* = new TooltipText(true, true, true);
            var _loc_6:String = "";
            _loc_6 = "<p align=\'left\'><font size =\'15\' color =\'#FFFF00\' >";
            _loc_6 = _loc_6 + param1.toUpperCase();
            _loc_6 = _loc_6 + "</font></p>";
            _loc_5.htmlText = _loc_6;
            var _loc_7:* = ResMgr.getInstance().getMovieClip("Gold_Small_Icon") as Sprite;
            var _loc_8:* = ResMgr.getInstance().getMovieClip("Elixir_Small_Icon") as Sprite;
            var _loc_9:* = new TooltipText(true);
            _loc_6 = "<font size =\'14\' color =\'#FFFFFF\' ><textformat leading=\'8\'>";
            _loc_6 = _loc_6 + "Số vàng còn lại: \nSố dầu còn lại: ";
            _loc_6 = _loc_6 + "</textformat></font>";
            _loc_9.htmlText = _loc_6;
            _loc_6 = "";
            var _loc_10:* = new TooltipText(true);
            var _loc_11:* = new TooltipText(true);
            var _loc_12:* = new TooltipText(true);
            var _loc_13:String = "";
            var _loc_14:String = "";
            _loc_13 = "<font size =\'14\' color =\'#FFFFFF\' >";
            _loc_13 = _loc_13 + (numToStr(param2) + "\n");
            _loc_13 = _loc_13 + "</font>";
            _loc_14 = "<font size =\'14\' color =\'#FFFFFF\' >";
            _loc_14 = _loc_14 + (numToStr(param3) + "\n");
            _loc_14 = _loc_14 + "</font>";
            _loc_10.htmlText = _loc_6;
            _loc_11.htmlText = _loc_13;
            _loc_12.htmlText = _loc_14;
            var _loc_15:int = 5;
            _loc_4.addChild(_loc_5);
            _loc_4.addChild(_loc_9);
            _loc_4.addChild(_loc_10);
            _loc_4.addChild(_loc_11);
            _loc_4.addChild(_loc_12);
            _loc_9.y = _loc_5.y + _loc_5.height;
            _loc_9.x = _loc_15;
            _loc_11.x = _loc_9.x + _loc_9.width;
            _loc_11.y = _loc_9.y;
            _loc_12.x = _loc_11.x;
            _loc_12.y = _loc_11.y + _loc_11.textHeight + 8;
            _loc_10.x = _loc_11.x;
            _loc_10.y = _loc_11.y + _loc_11.textHeight;
            _loc_5.x = (_loc_4.width - _loc_5.width) / 2;
            if (_loc_7)
            {
                _loc_4.addChild(_loc_7);
                _loc_7.x = _loc_11.x + _loc_11.textWidth + 5;
                _loc_7.y = _loc_11.y - 2;
            }
            if (_loc_8)
            {
                _loc_4.addChild(_loc_8);
                _loc_8.x = _loc_12.x + _loc_12.textWidth + 5;
                _loc_8.y = _loc_12.y - 2;
            }
            return _loc_4;
        }// end function

        public static function getTooltipLevelUser(param1:int, param2:int) : DisplayObject
        {
            var _loc_5:int = 0;
            var _loc_3:* = JsonMgr.getInstance().levelUser;
            var _loc_4:String = "";
            if (_loc_3[(param1 + 1)] != null)
            {
                _loc_5 = _loc_3[(param1 + 1)] - param2;
                _loc_4 = Localization.getInstance().getString("LevelMsg1");
                _loc_4 = _loc_4.replace("@number@", _loc_5);
                _loc_4 = _loc_4.replace("@level@", standardNumber((param1 + 1)));
            }
            else
            {
                _loc_4 = Localization.getInstance().getString("LevelMsg0");
            }
            return getTooltipString(_loc_4);
        }// end function

        public static function getTooltipShowObjectName(param1:String) : DisplayObject
        {
            var _loc_2:* = new Sprite();
            var _loc_3:* = new TooltipText(true, true, false);
            var _loc_4:String = "";
            _loc_4 = "<p align=\'center\'><b><font size =\'14\' color =\'#FFFFFF\' >";
            _loc_4 = _loc_4 + param1;
            _loc_4 = _loc_4 + "</font></b></p>";
            _loc_3.htmlText = _loc_4;
            _loc_2.addChild(_loc_3);
            _loc_3.x = 0;
            _loc_3.y = -10;
            return _loc_2;
        }// end function

        public static function getTooltipString(param1:String) : DisplayObject
        {
            var _loc_2:* = new Sprite();
            var _loc_3:* = new TooltipText(true, true, true);
            var _loc_4:String = "";
            _loc_4 = "<p align=\'center\'><b><font size =\'11\' color =\'#FFFF80\' >";
            _loc_4 = _loc_4 + param1;
            _loc_4 = _loc_4 + "</font></b></p>";
            _loc_3.htmlText = _loc_4.toUpperCase();
            _loc_2.addChild(_loc_3);
            _loc_3.x = 0;
            _loc_3.y = -4;
            return _loc_2;
        }// end function

        public static function getName(param1:String) : String
        {
            return Localization.getInstance().getString(param1);
        }// end function

        public static function getInfoToBuild(param1:String, param2:int) : DataBuildingInfo
        {
            var _loc_5:MapObject = null;
            var _loc_6:int = 0;
            var _loc_7:Object = null;
            var _loc_8:TownHallObject = null;
            var _loc_9:ArmyCampObject = null;
            var _loc_10:BarrackObject = null;
            var _loc_11:ResourceObject = null;
            var _loc_12:StorageObject = null;
            var _loc_13:ResourceObject = null;
            var _loc_14:StorageObject = null;
            var _loc_15:LaboratoryObject = null;
            var _loc_16:ClanObject = null;
            var _loc_17:DefenseObject = null;
            var _loc_18:BuilderObject = null;
            var _loc_19:WallObject = null;
            var _loc_20:TrapObject = null;
            var _loc_3:* = new DataBuildingInfo();
            _loc_3.type = param1;
            var _loc_4:* = new MapObject();
            new MapObject().type = param1;
            _loc_4.level = param2;
            _loc_5 = MapMgr.copyMapObject(_loc_4);
            _loc_3.curCount = GameDataMgr.getInstance().getCurrentBuildingNumber(_loc_5.type);
            if (GameDataMgr.getInstance().townHall)
            {
                _loc_6 = GameDataMgr.getInstance().townHall.level;
                _loc_7 = JsonMgr.getInstance().townHall[BuildingType.TOWN_HALL][_loc_6];
                _loc_3.maxCount = _loc_7[_loc_5.type];
            }
            if (param1 == BuildingType.BUILDER_HUT)
            {
                _loc_5.level = GameDataMgr.getInstance().myInfo.builderList.length + 1;
                _loc_5.loadConfigData();
                _loc_3.maxCount = JsonMgr.getInstance().getConfigMaxLevel(BuildingType.BUILDER_HUT);
            }
            switch(_loc_5.type)
            {
                case BuildingType.TOWN_HALL:
                {
                    _loc_8 = _loc_5 as TownHallObject;
                    _loc_3.cost.type = MoneyType.GOLD;
                    _loc_3.cost.value = _loc_8.info.gold;
                    _loc_3.buildTime = _loc_8.info.buildTime;
                    break;
                }
                case BuildingType.ARMY_CAMP:
                {
                    _loc_9 = _loc_5 as ArmyCampObject;
                    _loc_3.cost.type = MoneyType.ELIXIR;
                    _loc_3.cost.value = _loc_9.info.elixir;
                    _loc_3.buildTime = _loc_9.info.buildTime;
                    break;
                }
                case BuildingType.BARRACK:
                {
                    _loc_10 = _loc_5 as BarrackObject;
                    _loc_3.cost.type = MoneyType.ELIXIR;
                    _loc_3.cost.value = _loc_10.info.elixir;
                    _loc_3.buildTime = _loc_10.info.buildTime;
                    break;
                }
                case BuildingType.GOLD_MINE:
                {
                    _loc_11 = _loc_5 as ResourceObject;
                    _loc_3.buildTime = _loc_11.info.buildTime;
                    _loc_3.cost.type = MoneyType.ELIXIR;
                    _loc_3.cost.value = _loc_11.info.elixir;
                    break;
                }
                case BuildingType.GOLD_STORAGE:
                case BuildingType.DARK_ELIXIR_STORAGE:
                {
                    _loc_12 = _loc_5 as StorageObject;
                    _loc_3.buildTime = _loc_12.info.buildTime;
                    _loc_3.cost.type = MoneyType.ELIXIR;
                    _loc_3.cost.value = _loc_12.info.elixir;
                    _loc_3.townHallLevelRequired = _loc_12.info.townHallLevelRequired;
                    break;
                }
                case BuildingType.ELIXIR_COLLECTOR:
                {
                    _loc_13 = _loc_5 as ResourceObject;
                    _loc_3.cost.type = MoneyType.GOLD;
                    _loc_3.cost.value = _loc_13.info.gold;
                    _loc_3.buildTime = _loc_13.info.buildTime;
                    break;
                }
                case BuildingType.ELIXIR_STORAGE:
                {
                    _loc_14 = _loc_5 as StorageObject;
                    _loc_3.cost.type = MoneyType.GOLD;
                    _loc_3.cost.value = _loc_14.info.gold;
                    _loc_3.buildTime = _loc_14.info.buildTime;
                    break;
                }
                case BuildingType.LABORATORY:
                {
                    _loc_15 = _loc_5 as LaboratoryObject;
                    _loc_3.cost.type = MoneyType.ELIXIR;
                    _loc_3.cost.value = _loc_15.info.elixir;
                    _loc_3.buildTime = _loc_15.info.buildTime;
                    _loc_3.townHallLevelRequired = _loc_15.info.townHallLevelRequired;
                    break;
                }
                case BuildingType.CLAN_CASTLE:
                {
                    _loc_16 = _loc_5 as ClanObject;
                    _loc_3.cost.type = MoneyType.GOLD;
                    _loc_3.cost.value = _loc_16.info.gold;
                    _loc_3.buildTime = _loc_16.info.upgradeTime;
                    break;
                }
                case BuildingType.CANON:
                case BuildingType.ACHER_TOWER:
                case BuildingType.MOTAR:
                case BuildingType.XBOW:
                case BuildingType.WIZARD_TOWER:
                case BuildingType.AIR_DEFENSES:
                {
                    _loc_17 = _loc_5 as DefenseObject;
                    _loc_3.cost.type = MoneyType.GOLD;
                    _loc_3.cost.value = _loc_17.info.gold;
                    _loc_3.buildTime = _loc_17.info.upgradeTime;
                    _loc_3.townHallLevelRequired = _loc_17.info.townHallLevelRequired;
                    break;
                }
                case BuildingType.BUILDER_HUT:
                {
                    _loc_18 = _loc_5 as BuilderObject;
                    _loc_3.cost.type = MoneyType.COIN;
                    _loc_3.cost.value = _loc_18.info.coin;
                    _loc_3.buildTime = 0;
                    break;
                }
                case BuildingType.WALL:
                {
                    _loc_19 = _loc_5 as WallObject;
                    _loc_3.cost.type = MoneyType.GOLD;
                    _loc_3.cost.value = _loc_19.info.gold;
                    _loc_3.buildTime = _loc_19.info.upgradeTime;
                    break;
                }
                case BuildingType.TRA_1:
                case BuildingType.TRA_2:
                case BuildingType.TRA_3:
                case BuildingType.TRA_4:
                case BuildingType.TRA_5:
                {
                    _loc_20 = _loc_5 as TrapObject;
                    if (_loc_20.info.gold > 0)
                    {
                        _loc_3.cost.type = MoneyType.GOLD;
                        _loc_3.cost.value = _loc_20.info.gold;
                    }
                    else if (_loc_20.info.darkElixir > 0)
                    {
                        _loc_3.cost.type = MoneyType.DARK_ELIXIR;
                        _loc_3.cost.value = _loc_20.info.darkElixir;
                    }
                    _loc_3.buildTime = 0;
                    _loc_3.townHallLevelRequired = _loc_20.info.townHallLevelRequired;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public static function getTroopHousingSpaceConfig() : void
        {
            var _loc_2:String = null;
            troopHousingSpace = new Object();
            var _loc_1:* = JsonMgr.getInstance().troopBase;
            for (_loc_2 in _loc_1)
            {
                
                troopHousingSpace[_loc_2] = _loc_1[_loc_2]["housingSpace"];
            }
            return;
        }// end function

        public static function getHousingSpace(param1:String) : int
        {
            return troopHousingSpace[param1];
        }// end function

        public static function getTroopIndex(param1:String) : int
        {
            var _loc_2:* = param1.split("_");
            var _loc_3:* = _loc_2[1];
            return _loc_3;
        }// end function

        public static function addTroop(param1:Troop, param2:Vector.<Troop>) : void
        {
            var _loc_3:int = 0;
            while (_loc_3 < param2.length)
            {
                
                if (param2[_loc_3].type == param1.type)
                {
                    param2[_loc_3].num = param2[_loc_3].num + param1.num;
                    if (param2[_loc_3].num == 0)
                    {
                        param2[_loc_3] = null;
                        param2.splice(_loc_3, 1);
                    }
                    return;
                }
                _loc_3++;
            }
            param2.push(param1);
            return;
        }// end function

        public static function getContentName(param1:String, param2:int) : String
        {
            var _loc_5:String = null;
            var _loc_3:String = "";
            var _loc_4:* = JsonMgr.getInstance().contentName[param1];
            if (JsonMgr.getInstance().contentName[param1])
            {
                _loc_5 = _loc_4[param2]["Content"];
                if (GlobalVar.state == GlobalVar.STATE_SINGLE_MAP && (param1 == BuildingType.TOWN_HALL || param1 == BuildingType.BARRACK))
                {
                    _loc_3 = param1 + "_GOBLIN_1";
                }
                else
                {
                    _loc_3 = param1 + "_" + _loc_5;
                }
                return _loc_3;
            }
            return param1;
        }// end function

        public static function getContentShadow(param1:String, param2:int) : String
        {
            var _loc_5:String = null;
            var _loc_3:String = "";
            var _loc_4:* = JsonMgr.getInstance().contentName[param1];
            if (JsonMgr.getInstance().contentName[param1])
            {
                _loc_5 = _loc_4[param2]["Shadow"];
                _loc_3 = param1 + "_" + _loc_5 + "_Shadow";
                return _loc_3;
            }
            return param1;
        }// end function

        public static function getContentImage(param1:String, param2:int, param3:Boolean = true) : String
        {
            var _loc_6:String = null;
            var _loc_4:String = "";
            if (getTypeObject(param1) == BuildingType.TRA)
            {
                return param1 + "_1";
            }
            var _loc_5:* = JsonMgr.getInstance().contentName[param1];
            if (JsonMgr.getInstance().contentName[param1])
            {
                _loc_6 = _loc_5[param2]["Image"];
                if (!param3)
                {
                    _loc_4 = param1 + "_" + _loc_6;
                }
                else
                {
                    _loc_4 = param1 + "_Full_" + _loc_6;
                }
                return _loc_4;
            }
            return param1;
        }// end function

        public static function pointInPolygon(param1:Number, param2:Number, param3:Vector.<Point>) : Boolean
        {
            var _loc_4:* = param3.length - 1;
            var _loc_5:Boolean = false;
            var _loc_6:int = 0;
            while (_loc_6 < param3.length)
            {
                
                if (param3[_loc_6].y < param2 && param3[_loc_4].y >= param2 || param3[_loc_4].y < param2 && param3[_loc_6].y >= param2)
                {
                    if (param3[_loc_6].x + (param2 - param3[_loc_6].y) / (param3[_loc_4].y - param3[_loc_6].y) * (param3[_loc_4].x - param3[_loc_6].x) < param1)
                    {
                        _loc_5 = !_loc_5;
                    }
                }
                _loc_4 = _loc_6;
                _loc_6++;
            }
            return _loc_5;
        }// end function

        public static function insidePolygon(param1:Vector.<Point>, param2:Point) : Boolean
        {
            var _loc_4:int = 0;
            var _loc_5:Number = NaN;
            var _loc_6:Point = null;
            var _loc_7:Point = null;
            if (param1.length == 0)
            {
                return false;
            }
            var _loc_3:int = 0;
            var _loc_8:* = param1.length;
            _loc_6 = param1[0];
            _loc_4 = 1;
            while (_loc_4 <= _loc_8)
            {
                
                _loc_7 = param1[_loc_4 % _loc_8];
                if (param2.y > Math.min(_loc_6.y, _loc_7.y))
                {
                    if (param2.y <= Math.max(_loc_6.y, _loc_7.y))
                    {
                        if (param2.x <= Math.max(_loc_6.x, _loc_7.x))
                        {
                            if (_loc_6.y != _loc_7.y)
                            {
                                _loc_5 = (param2.y - _loc_6.y) * (_loc_7.x - _loc_6.x) / (_loc_7.y - _loc_6.y) + _loc_6.x;
                                if (_loc_6.x == _loc_7.x || param2.x <= _loc_5)
                                {
                                    _loc_3++;
                                }
                            }
                        }
                    }
                }
                _loc_6 = _loc_7;
                _loc_4++;
            }
            if (_loc_3 % 2 == 0)
            {
                return false;
            }
            return true;
        }// end function

        public static function getTypeObject(param1:String) : String
        {
            var _loc_2:String = "";
            var _loc_3:* = param1.split("_");
            _loc_2 = _loc_3[0];
            return _loc_2;
        }// end function

        public static function getInfoToRemove(param1:String) : DataBuildingInfo
        {
            var _loc_2:* = new DataBuildingInfo();
            var _loc_3:* = JsonMgr.getInstance().getObstacleData(param1);
            _loc_2.buildTime = _loc_3.removalTime;
            _loc_2.cost.type = _loc_3.removalCostElixir > 0 ? (MoneyType.ELIXIR) : (MoneyType.GOLD);
            _loc_2.cost.value = _loc_3.removalCostElixir > 0 ? (_loc_3.removalCostElixir) : (_loc_3.removalCostGold);
            return _loc_2;
        }// end function

        public static function calculateExchangeCost(param1:int, param2:Array, param3:Array) : int
        {
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            if (param1 <= param2[0])
            {
                return param3[0];
            }
            var _loc_4:* = param2.length;
            var _loc_5:* = param2.length - 1;
            if (param1 > param2[_loc_5])
            {
                _loc_9 = int(param1 / param2[_loc_5]);
                _loc_10 = int(param1 % param2[_loc_5]);
                return _loc_9 * calculateExchangeCost(param2[_loc_5], param2, param3) + calculateExchangeCost(_loc_10, param2, param3);
            }
            var _loc_6:int = 0;
            while (_loc_6 < _loc_4)
            {
                
                if (param1 <= param2[_loc_6])
                {
                    _loc_5 = _loc_6;
                    break;
                }
                _loc_6++;
            }
            var _loc_7:* = (param1 - param2[(_loc_5 - 1)]) * (param3[_loc_5] - param3[(_loc_5 - 1)]);
            var _loc_8:* = param2[_loc_5] - param2[(_loc_5 - 1)];
            return Math.floor(_loc_7 / _loc_8 + param3[(_loc_5 - 1)]);
        }// end function

        public static function getCostToBuyTime(param1:int) : MoneyType
        {
            var _loc_2:* = new MoneyType(MoneyType.COIN, 0);
            _loc_2.value = Utility.calculateExchangeCost(param1, GlobalVar.TIME_RANGE, GlobalVar.TIME_COST);
            return _loc_2;
        }// end function

        public static function getCostToBuyResources(param1:int) : MoneyType
        {
            var _loc_2:* = new MoneyType(MoneyType.COIN, 0);
            _loc_2.value = Utility.calculateExchangeCost(param1, GlobalVar.RESOURCE_RANGE, GlobalVar.RESOURCE_COST);
            return _loc_2;
        }// end function

        public static function randomCellBuilding(param1:MapObject) : Point
        {
            var _loc_7:int = 0;
            var _loc_2:* = new Point();
            var _loc_3:* = param1.width * 3;
            var _loc_4:* = param1.height * 3;
            var _loc_5:* = Utility.randomNumber(0, _loc_3);
            var _loc_6:* = Utility.randomNumber(0, _loc_4);
            if (_loc_5 >= 1 && _loc_5 <= _loc_3 - 2)
            {
                _loc_7 = Utility.randomNumber(0, 1);
                _loc_5 = _loc_7 == 0 ? (0) : ((_loc_4 - 1));
            }
            _loc_2.x = param1.posX * 3 + _loc_5;
            _loc_2.y = param1.posY * 3 + _loc_6;
            return _loc_2;
        }// end function

        public static function getStorageType(param1:String) : String
        {
            var _loc_2:String = null;
            switch(param1)
            {
                case MoneyType.GOLD:
                {
                    _loc_2 = BuildingType.GOLD_STORAGE;
                    break;
                }
                case MoneyType.ELIXIR:
                {
                    _loc_2 = BuildingType.ELIXIR_STORAGE;
                    break;
                }
                default:
                {
                    _loc_2 = BuildingType.DARK_ELIXIR_STORAGE;
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function getCurrentMaxBarrackLevel() : int
        {
            var _loc_1:int = 0;
            var _loc_2:* = GameDataMgr.getInstance().barrackList;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_1 < _loc_2[_loc_3].level)
                {
                    _loc_1 = _loc_2[_loc_3].level;
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public static function getMessageColor(param1:String) : String
        {
            var _loc_2:String = "#FFFFFF";
            var _loc_3:* = param1.split("@");
            switch(_loc_3[0])
            {
                case "2":
                case "5":
                {
                    _loc_2 = GlobalVar.NEGATIVE_COLOR;
                    break;
                }
                case "1":
                case "3":
                case "4":
                case "6":
                {
                    _loc_2 = GlobalVar.POSITIVE_COLOR;
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function getClanSystemMessage(param1:String) : String
        {
            var _loc_2:String = "";
            var _loc_3:* = param1.split("@");
            switch(_loc_3[0])
            {
                case "1":
                {
                    _loc_2 = Localization.getInstance().getString("ClanMsg4");
                    _loc_2 = _loc_2.replace("@name", _loc_3[1]);
                    break;
                }
                case "2":
                {
                    _loc_2 = Localization.getInstance().getString("ClanMsg8");
                    _loc_2 = _loc_2.replace("@name", _loc_3[1]);
                    break;
                }
                case "3":
                {
                    _loc_2 = Localization.getInstance().getString("ClanMsg7");
                    _loc_2 = _loc_2.replace("@name2", _loc_3[1]);
                    _loc_2 = _loc_2.replace("@type", Localization.getInstance().getString("ClanTitle" + _loc_3[3]));
                    _loc_2 = _loc_2.replace("@name1", _loc_3[2]);
                    break;
                }
                case "4":
                {
                    _loc_2 = Localization.getInstance().getString("ClanMsg9");
                    _loc_2 = _loc_2.replace("@name", _loc_3[1]);
                    _loc_2 = _loc_2.replace("@type", Localization.getInstance().getString("ClanTitle" + _loc_3[2]));
                    break;
                }
                case "5":
                {
                    _loc_2 = Localization.getInstance().getString("ClanMsg10");
                    _loc_2 = _loc_2.replace("@name1", _loc_3[1]);
                    _loc_2 = _loc_2.replace("@name2", _loc_3[2]);
                    break;
                }
                case "6":
                {
                    _loc_2 = Localization.getInstance().getString("ClanMsg11");
                    _loc_2 = _loc_2.replace("@name", _loc_3[1]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function callURL(param1:String, param2:String = "_blank") : void
        {
            var _loc_3:* = new URLRequest(param1);
            navigateToURL(_loc_3, param2);
            return;
        }// end function

        public static function checkNameValid(param1:String) : Boolean
        {
            if (param1.length < 3 || param1.length > 30)
            {
                return false;
            }
            var _loc_2:* = new RegExp("^[a-z 0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼẾỀỂưăạảấầẩẫậắằẳẵặẹẻẽếềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ]+$");
            var _loc_3:* = _loc_2.test(param1);
            return _loc_3;
        }// end function

    }
}
