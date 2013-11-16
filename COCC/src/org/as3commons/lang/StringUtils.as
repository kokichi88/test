package org.as3commons.lang
{

    final public class StringUtils extends Object
    {
        private static const WHITE:uint = 32;
        private static const INDEX_NOT_FOUND:int = -1;
        private static const EMPTY:String = "";
        private static const FILENAME_CHARS_NOT_ALLOWED:RegExp = new RegExp("/|\\\\|:|\\*|\\?|<|>|\\||%|\"");
        private static const PAD_LIMIT:uint = 8192;

        public function StringUtils()
        {
            return;
        }// end function

        public static function rightTrimForChar(param1:String, param2:String) : String
        {
            if (param2.length != 1)
            {
                throw new IllegalArgumentError("The Second Attribute char [" + param2 + "] must exactly one character.");
            }
            return rightTrimForChars(param1, param2);
        }// end function

        public static function leftPadChar(param1:String, param2:int, param3:String) : String
        {
            if (param1 == null)
            {
                return null;
            }
            var _loc_4:* = param2 - param1.length;
            if (param2 - param1.length <= 0)
            {
                return param1;
            }
            if (_loc_4 > PAD_LIMIT)
            {
                return leftPad(param1, param2, param3);
            }
            return padding(_loc_4, param3).concat(param1);
        }// end function

        public static function isNumeric(param1:String) : Boolean
        {
            return testString(param1, /^[0-9]*$""^[0-9]*$/);
        }// end function

        public static function rightTrimForChars(param1:String, param2:String) : String
        {
            var _loc_3:Number = 0;
            var _loc_4:* = param1.length - 1;
            while (_loc_3 < _loc_4 && param2.indexOf(param1.charAt(_loc_4)) >= 0)
            {
                
                _loc_4 = _loc_4 - 1;
            }
            return _loc_4 >= 0 ? (param1.substr(_loc_3, (_loc_4 + 1))) : (param1);
        }// end function

        public static function left(param1:String, param2:int) : String
        {
            if (param1 == null)
            {
                return null;
            }
            if (param2 < 0)
            {
                return EMPTY;
            }
            if (param1.length <= param2)
            {
                return param1;
            }
            return param1.substring(0, param2);
        }// end function

        public static function deleteWhitespace(param1:String) : String
        {
            return deleteFromString(param1, /\s""\s/g);
        }// end function

        public static function isNotEmpty(param1:String) : Boolean
        {
            return !isEmpty(param1);
        }// end function

        public static function leftPad(param1:String, param2:int, param3:String) : String
        {
            var _loc_7:Array = null;
            var _loc_8:Array = null;
            var _loc_9:int = 0;
            if (param1 == null)
            {
                return null;
            }
            if (isEmpty(param3))
            {
                param3 = " ";
            }
            var _loc_4:* = param3.length;
            var _loc_5:* = param1.length;
            var _loc_6:* = param2 - _loc_5;
            if (param2 - _loc_5 <= 0)
            {
                return param1;
            }
            if (_loc_4 == 1 && _loc_6 <= PAD_LIMIT)
            {
                return leftPadChar(param1, param2, param3.charAt(0));
            }
            if (_loc_6 == _loc_4)
            {
                return param3.concat(param1);
            }
            if (_loc_6 < _loc_4)
            {
                return param3.substring(0, _loc_6).concat(param1);
            }
            _loc_7 = [];
            _loc_8 = param3.split("");
            _loc_9 = 0;
            while (_loc_9 < _loc_6)
            {
                
                _loc_7[_loc_9] = _loc_8[_loc_9 % _loc_4];
                _loc_9++;
            }
            return _loc_7.join("").concat(param1);
        }// end function

        public static function replaceAt(param1:String, param2, param3:int, param4:int) : String
        {
            param3 = Math.max(param3, 0);
            param4 = Math.min(param4, param1.length);
            var _loc_5:* = param1.substr(0, param3);
            var _loc_6:* = param1.substr(param4, param1.length);
            return _loc_5 + param2 + _loc_6;
        }// end function

        private static function padding(param1:int, param2:String) : String
        {
            var _loc_3:String = "";
            var _loc_4:int = 0;
            while (_loc_4 < param1)
            {
                
                _loc_3 = _loc_3 + param2;
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public static function remove(param1:String, param2:String) : String
        {
            return safeRemove(param1, new RegExp(param2, "g"));
        }// end function

        public static function fixNewlines(param1:String) : String
        {
            return param1.replace(/\r\
n""\r\n/gm, "\n");
        }// end function

        public static function nthIndexOf(param1:String, param2:uint, param3:String, param4:Number = 0) : int
        {
            var _loc_6:int = 0;
            var _loc_5:* = param4;
            if (param2 >= 1)
            {
                _loc_5 = param1.indexOf(param3, _loc_5);
                _loc_6 = 1;
                while (_loc_5 != -1 && _loc_6 < param2)
                {
                    
                    _loc_5 = param1.indexOf(param3, (_loc_5 + 1));
                    _loc_6++;
                }
            }
            return _loc_5;
        }// end function

        public static function trimToEmpty(param1:String) : String
        {
            return param1 == null ? (EMPTY) : (trim(param1));
        }// end function

        public static function strip(param1:String, param2:String) : String
        {
            if (isEmpty(param1))
            {
                return param1;
            }
            return stripEnd(stripStart(param1, param2), param2);
        }// end function

        public static function isNotBlank(param1:String) : Boolean
        {
            return !isBlank(param1);
        }// end function

        public static function contains(param1:String, param2:String) : Boolean
        {
            if (param1 == null || param2 == null)
            {
                return false;
            }
            return new RegExp("(" + param2 + ")", "g").test(param1);
        }// end function

        public static function endsWithIgnoreCase(param1:String, param2:String) : Boolean
        {
            if (param1 != null && param2 != null && param1.length >= param2.length)
            {
                return param1.toUpperCase().substr(param1.length - param2.length, param1.length) == param2.toUpperCase();
            }
            return false;
        }// end function

        public static function containsIgnoreCase(param1:String, param2:String) : Boolean
        {
            if (param1 == null || param2 == null)
            {
                return false;
            }
            return new RegExp("(" + param2.toUpperCase() + ")", "g").test(param1.toUpperCase());
        }// end function

        public static function substringAfter(param1:String, param2:String) : String
        {
            if (isEmpty(param1))
            {
                return param1;
            }
            if (param2 == null)
            {
                return EMPTY;
            }
            var _loc_3:* = param1.indexOf(param2);
            if (_loc_3 == INDEX_NOT_FOUND)
            {
                return EMPTY;
            }
            return param1.substring(_loc_3 + param2.length);
        }// end function

        public static function countMatches(param1:String, param2:String) : int
        {
            if (isEmpty(param1) || isEmpty(param2))
            {
                return 0;
            }
            return param1.match(new RegExp("(" + param2 + ")", "g")).length;
        }// end function

        public static function indexOfAnyBut(param1:String, param2:String) : int
        {
            if (isEmpty(param1) || isEmpty(param2))
            {
                return INDEX_NOT_FOUND;
            }
            return param1.search(new RegExp("[^" + param2 + "]", ""));
        }// end function

        public static function ordinalIndexOf(param1:String, param2:String, param3:int) : int
        {
            if (param1 == null || param2 == null || param3 <= 0)
            {
                return INDEX_NOT_FOUND;
            }
            if (param2.length == 0)
            {
                return 0;
            }
            var _loc_4:int = 0;
            var _loc_5:* = INDEX_NOT_FOUND;
            do
            {
                
                _loc_5 = param1.indexOf(param2, (_loc_5 + 1));
                if (_loc_5 < 0)
                {
                    return _loc_5;
                }
                _loc_4++;
            }while (_loc_4 < param3)
            return _loc_5;
        }// end function

        public static function characterIsWhitespace(param1:String) : Boolean
        {
            return param1.charCodeAt(0) <= 32;
        }// end function

        public static function trim(param1:String) : String
        {
            if (param1 == null)
            {
                return null;
            }
            return param1.replace(/^\s*""^\s*/, "").replace(/\s*$""\s*$/, "");
        }// end function

        public static function stripStart(param1:String, param2:String) : String
        {
            if (isEmpty(param1))
            {
                return param1;
            }
            var _loc_3:* = new RegExp("^[" + (param2 != null ? (param2) : (" ")) + "]*", "");
            return param1.replace(_loc_3, "");
        }// end function

        public static function abbreviate(param1:String, param2:int, param3:int) : String
        {
            if (param1 == null)
            {
                return param1;
            }
            if (param3 < 4)
            {
                throw new IllegalArgumentError("Minimum abbreviation width is 4");
            }
            if (param1.length <= param3)
            {
                return param1;
            }
            if (param2 > param1.length)
            {
                param2 = param1.length;
            }
            if (param1.length - param2 < param3 - 3)
            {
                param2 = param1.length - (param3 - 3);
            }
            if (param2 <= 4)
            {
                return param1.substring(0, param3 - 3) + "...";
            }
            if (param3 < 7)
            {
                throw new IllegalArgumentError("Minimum abbreviation width with offset is 7");
            }
            if (param2 + (param3 - 3) < param1.length)
            {
                return "..." + abbreviate(param1.substring(param2), 0, param3 - 3);
            }
            return "..." + param1.substring(param1.length - (param3 - 3));
        }// end function

        public static function defaultIfEmpty(param1:String, param2:String) : String
        {
            return isEmpty(param1) ? (param2) : (param1);
        }// end function

        public static function substringBefore(param1:String, param2:String) : String
        {
            if (isEmpty(param1) || param2 == null)
            {
                return param1;
            }
            if (param2.length == 0)
            {
                return EMPTY;
            }
            var _loc_3:* = param1.indexOf(param2);
            if (_loc_3 == INDEX_NOT_FOUND)
            {
                return param1;
            }
            return param1.substring(0, _loc_3);
        }// end function

        public static function stripEnd(param1:String, param2:String) : String
        {
            if (isEmpty(param1))
            {
                return param1;
            }
            var _loc_3:* = new RegExp("[" + (param2 != null ? (param2) : (" ")) + "]*$", "");
            return param1.replace(_loc_3, "");
        }// end function

        public static function replace(param1:String, param2:String, param3:String) : String
        {
            if (param1 == null || isEmpty(param2) || param3 == null)
            {
                return param1;
            }
            return param1.replace(new RegExp(param2, "g"), param3);
        }// end function

        public static function naturalCompare(param1:String, param2:String) : int
        {
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_9:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_10:Boolean = true;
            if (!param1)
            {
                param1 = "";
            }
            if (!param2)
            {
                param2 = "";
            }
            var _loc_11:Boolean = false;
            if (param1.toLocaleLowerCase() == param2.toLocaleLowerCase())
            {
                _loc_11 = true;
            }
            else
            {
                param1 = param1.toLowerCase();
                param2 = param2.toLowerCase();
            }
            while (true)
            {
                
                var _loc_12:int = 0;
                _loc_6 = 0;
                _loc_5 = _loc_12;
                _loc_7 = param1.charAt(_loc_3);
                _loc_8 = param2.charAt(_loc_4);
                while (StringUtils.characterIsWhitespace(_loc_7) || _loc_7 == "0")
                {
                    
                    if (_loc_7 == "0")
                    {
                        _loc_5++;
                    }
                    else
                    {
                        _loc_5 = 0;
                    }
                    _loc_7 = param1.charAt(++_loc_3);
                }
                while (StringUtils.characterIsWhitespace(_loc_8) || _loc_8 == "0")
                {
                    
                    if (_loc_8 == "0")
                    {
                        _loc_6++;
                    }
                    else
                    {
                        _loc_6 = 0;
                    }
                    _loc_8 = param2.charAt(++_loc_4);
                }
                if (StringUtils.characterIsDigit(_loc_7) && StringUtils.characterIsDigit(_loc_8))
                {
                    var _loc_12:* = compareRight(param1.substring(++_loc_3), param2.substring(++_loc_4));
                    _loc_9 = compareRight(param1.substring(++_loc_3), param2.substring(++_loc_4));
                    if (_loc_12 != 0)
                    {
                        return _loc_9;
                    }
                }
                if (_loc_7.length == 0 && _loc_8.length == 0)
                {
                    return _loc_5 - _loc_6;
                }
                if (_loc_11)
                {
                    if (_loc_7 != _loc_8)
                    {
                        if (_loc_7 < _loc_8)
                        {
                            return _loc_10 ? (1) : (-1);
                        }
                        else if (_loc_7 > _loc_8)
                        {
                            return _loc_10 ? (-1) : (1);
                        }
                    }
                }
                if (_loc_7 < _loc_8)
                {
                    return -1;
                }
                if (_loc_7 > _loc_8)
                {
                    return 1;
                }
                _loc_3++;
                _loc_4++;
            }
            return 0;
        }// end function

        public static function leftTrimForChar(param1:String, param2:String) : String
        {
            if (param2.length != 1)
            {
                throw new IllegalArgumentError("The Second Attribute char [" + param2 + "] must exactly one character.");
            }
            return leftTrimForChars(param1, param2);
        }// end function

        public static function removeEnd(param1:String, param2:String) : String
        {
            return safeRemove(param1, new RegExp(param2 + "$", ""));
        }// end function

        public static function deleteSpaces(param1:String) : String
        {
            return deleteFromString(param1, /\	t|\r|\
n|\b""\t|\r|\n|\b/g);
        }// end function

        public static function isAlphanumeric(param1:String) : Boolean
        {
            return testString(param1, /^[a-zA-Z0-9]*$""^[a-zA-Z0-9]*$/);
        }// end function

        public static function characterIsDigit(param1:String) : Boolean
        {
            var _loc_2:* = param1.charCodeAt(0);
            return _loc_2 >= 48 && _loc_2 <= 57;
        }// end function

        public static function compareToIgnoreCase(param1:String, param2:String) : int
        {
            if (param1 == null)
            {
                param1 = "";
            }
            if (param2 == null)
            {
                param2 = "";
            }
            return compareTo(param1.toLowerCase(), param2.toLowerCase());
        }// end function

        public static function substitute(param1:String, ... args) : String
        {
            var _loc_4:Array = null;
            var _loc_6:* = undefined;
            if (param1 == null)
            {
                return "";
            }
            args = args.length;
            if (args == 1 && args[0] is Array)
            {
                _loc_4 = args[0] as Array;
                args = _loc_4.length;
            }
            else
            {
                _loc_4 = args;
            }
            var _loc_5:int = 0;
            while (_loc_5 < args)
            {
                
                _loc_6 = _loc_4[_loc_5];
                param1 = param1.split("{" + _loc_5.toString() + "}").join(_loc_6 != null ? (_loc_6.toString()) : ("[null]"));
                _loc_5++;
            }
            return param1;
        }// end function

        public static function difference(param1:String, param2:String) : String
        {
            if (param1 == null)
            {
                return param2;
            }
            if (param2 == null)
            {
                return param1;
            }
            var _loc_3:* = indexOfDifference(param1, param2);
            if (_loc_3 == -1)
            {
                return EMPTY;
            }
            return param2.substring(_loc_3);
        }// end function

        public static function chompString(param1:String, param2:String) : String
        {
            if (isEmpty(param1) || param2 == null)
            {
                return param1;
            }
            return param1.replace(new RegExp(param2 + "$", ""), "");
        }// end function

        public static function equals(param1:String, param2:String) : Boolean
        {
            return param1 === param2;
        }// end function

        public static function startsWithIgnoreCase(param1:String, param2:String) : Boolean
        {
            if (param1 != null && param2 != null && param1.length >= param2.length)
            {
                return param1.toUpperCase().substr(0, param2.length) == param2.toUpperCase();
            }
            return false;
        }// end function

        public static function substringAfterLast(param1:String, param2:String) : String
        {
            if (isEmpty(param1))
            {
                return param1;
            }
            if (isEmpty(param2))
            {
                return EMPTY;
            }
            var _loc_3:* = param1.lastIndexOf(param2);
            if (_loc_3 == INDEX_NOT_FOUND || _loc_3 == param1.length - param2.length)
            {
                return EMPTY;
            }
            return param1.substring(_loc_3 + param2.length);
        }// end function

        public static function isEmpty(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return true;
            }
            return param1.length == 0;
        }// end function

        public static function uncapitalize(param1:String) : String
        {
            if (isEmpty(param1))
            {
                return param1;
            }
            return param1.charAt(0).toLowerCase() + param1.substring(1);
        }// end function

        public static function startsWith(param1:String, param2:String) : Boolean
        {
            if (param1 != null && param2 != null && param1.length >= param2.length)
            {
                return param1.substr(0, param2.length) == param2;
            }
            return false;
        }// end function

        public static function isWhitespace(param1:String) : Boolean
        {
            return testString(param1, /^[\s]*$""^[\s]*$/);
        }// end function

        public static function equalsIgnoreCase(param1:String, param2:String) : Boolean
        {
            if (param1 == null && param2 == null)
            {
                return true;
            }
            if (param1 == null || param2 == null)
            {
                return false;
            }
            return equals(param1.toLowerCase(), param2.toLowerCase());
        }// end function

        public static function leftTrim(param1:String) : String
        {
            return leftTrimForChars(param1, "\n\t\n ");
        }// end function

        public static function toInitials(param1:String) : String
        {
            if (isEmpty(param1))
            {
                return param1;
            }
            return param1.match(/[A-Z]""[A-Z]/g).join("").toLowerCase();
        }// end function

        public static function isAlphaSpace(param1:String) : Boolean
        {
            return testString(param1, /^[a-zA-Z\s]*$""^[a-zA-Z\s]*$/);
        }// end function

        public static function addAt(param1:String, param2, param3:int) : String
        {
            if (param3 > param1.length)
            {
                param3 = param1.length;
            }
            var _loc_4:* = param1.substring(0, param3);
            var _loc_5:* = param1.substring(param3, param1.length);
            return _loc_4 + param2 + _loc_5;
        }// end function

        public static function chomp(param1:String) : String
        {
            return chompString(param1, "(\r\n|\r|\n)");
        }// end function

        public static function overlay(param1:String, param2:String, param3:int, param4:int) : String
        {
            var _loc_6:int = 0;
            if (param1 == null)
            {
                return null;
            }
            if (param2 == null)
            {
                param2 = EMPTY;
            }
            var _loc_5:* = param1.length;
            if (param3 < 0)
            {
                param3 = 0;
            }
            if (param3 > _loc_5)
            {
                param3 = _loc_5;
            }
            if (param4 < 0)
            {
                param4 = 0;
            }
            if (param4 > _loc_5)
            {
                param4 = _loc_5;
            }
            if (param3 > param4)
            {
                _loc_6 = param3;
                param3 = param4;
                param4 = _loc_6;
            }
            return param1.substring(0, param3).concat(param2).concat(param1.substring(param4));
        }// end function

        public static function isBlank(param1:String) : Boolean
        {
            return isEmpty(trimToEmpty(param1));
        }// end function

        public static function isNumericSpace(param1:String) : Boolean
        {
            return testString(param1, /^[0-9\s]*$""^[0-9\s]*$/);
        }// end function

        public static function rightPadChar(param1:String, param2:int, param3:String) : String
        {
            if (param1 == null)
            {
                return null;
            }
            var _loc_4:* = param2 - param1.length;
            if (param2 - param1.length <= 0)
            {
                return param1;
            }
            if (_loc_4 > PAD_LIMIT)
            {
                return rightPad(param1, param2, param3);
            }
            return param1.concat(padding(_loc_4, param3));
        }// end function

        public static function center(param1:String, param2:int, param3:String) : String
        {
            if (param1 == null || param2 <= 0)
            {
                return param1;
            }
            if (isEmpty(param3))
            {
                param3 = " ";
            }
            var _loc_4:* = param1.length;
            var _loc_5:* = param2 - _loc_4;
            if (param2 - _loc_4 <= 0)
            {
                return param1;
            }
            param1 = leftPad(param1, _loc_4 + _loc_5 / 2, param3);
            param1 = rightPad(param1, param2, param3);
            return param1;
        }// end function

        public static function replaceTo(param1:String, param2:String, param3:String, param4:int) : String
        {
            if (param1 == null || isEmpty(param2) || param3 == null || param4 == 0)
            {
                return param1;
            }
            var _loc_5:String = "";
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            do
            {
                
                _loc_5 = _loc_5 + (param1.substring(_loc_6, _loc_7) + param3);
                _loc_6 = _loc_7 + param2.length;
                if (--param4 == 0)
                {
                    break;
                }
                var _loc_8:* = param1.indexOf(param2, _loc_6);
                _loc_7 = param1.indexOf(param2, _loc_6);
            }while (_loc_8 != -1)
            var _loc_8:* = _loc_5 + param1.substring(_loc_6);
            _loc_5 = _loc_5 + param1.substring(_loc_6);
            return _loc_8;
        }// end function

        public static function rightPad(param1:String, param2:int, param3:String) : String
        {
            var _loc_7:Array = null;
            var _loc_8:Array = null;
            var _loc_9:int = 0;
            if (param1 == null)
            {
                return null;
            }
            if (isEmpty(param3))
            {
                param3 = " ";
            }
            var _loc_4:* = param3.length;
            var _loc_5:* = param1.length;
            var _loc_6:* = param2 - _loc_5;
            if (param2 - _loc_5 <= 0)
            {
                return param1;
            }
            if (_loc_4 == 1 && _loc_6 <= PAD_LIMIT)
            {
                return rightPadChar(param1, param2, param3.charAt(0));
            }
            if (_loc_6 == _loc_4)
            {
                return param1.concat(param3);
            }
            if (_loc_6 < _loc_4)
            {
                return param1.concat(param3.substring(0, _loc_6));
            }
            _loc_7 = [];
            _loc_8 = param3.split("");
            _loc_9 = 0;
            while (_loc_9 < _loc_6)
            {
                
                _loc_7[_loc_9] = _loc_8[_loc_9 % _loc_4];
                _loc_9++;
            }
            return param1.concat(_loc_7.join(""));
        }// end function

        public static function compareTo(param1:String, param2:String) : int
        {
            if (param1 == null)
            {
                param1 = "";
            }
            if (param2 == null)
            {
                param2 = "";
            }
            return param1.localeCompare(param2);
        }// end function

        private static function compareRight(param1:String, param2:String) : int
        {
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            while (true)
            {
                
                _loc_6 = param1.charAt(_loc_4);
                _loc_7 = param2.charAt(_loc_5);
                if (!StringUtils.characterIsDigit(_loc_6) && !StringUtils.characterIsDigit(_loc_7))
                {
                    return _loc_3;
                }
                if (!StringUtils.characterIsDigit(_loc_6))
                {
                    return -1;
                }
                if (!StringUtils.characterIsDigit(_loc_7))
                {
                    return 1;
                }
                if (_loc_6 < _loc_7)
                {
                    if (_loc_3 == 0)
                    {
                        _loc_3 = -1;
                    }
                }
                else if (_loc_6 > _loc_7)
                {
                    if (_loc_3 == 0)
                    {
                        _loc_3 = 1;
                    }
                }
                else if (_loc_6.length == 0 && _loc_7.length == 0)
                {
                    return _loc_3;
                }
                _loc_4++;
                _loc_5++;
            }
            return 0;
        }// end function

        public static function isAlpha(param1:String) : Boolean
        {
            return testString(param1, /^[a-zA-Z]*$""^[a-zA-Z]*$/);
        }// end function

        public static function replaceOnce(param1:String, param2:String, param3:String) : String
        {
            if (param1 == null || isEmpty(param2) || param3 == null)
            {
                return param1;
            }
            return param1.replace(new RegExp(param2, ""), param3);
        }// end function

        public static function endsWith(param1:String, param2:String) : Boolean
        {
            if (param1 != null && param2 != null && param1.length >= param2.length)
            {
                return param1.substr(param1.length - param2.length, param1.length) == param2;
            }
            return false;
        }// end function

        public static function removeStart(param1:String, param2:String) : String
        {
            return safeRemove(param1, new RegExp("^" + param2, ""));
        }// end function

        public static function indexOfAny(param1:String, param2:String) : int
        {
            if (isEmpty(param1) || isEmpty(param2))
            {
                return INDEX_NOT_FOUND;
            }
            return param1.search(new RegExp("[" + param2 + "]", ""));
        }// end function

        public static function trimToNull(param1:String) : String
        {
            var _loc_2:* = trim(param1);
            return isEmpty(_loc_2) ? (null) : (_loc_2);
        }// end function

        public static function isAlphanumericSpace(param1:String) : Boolean
        {
            return testString(param1, /^[a-zA-Z0-9\s]*$""^[a-zA-Z0-9\s]*$/);
        }// end function

        private static function deleteFromString(param1:String, param2:RegExp) : String
        {
            if (isEmpty(param1))
            {
                return param1;
            }
            return param1.replace(param2, "");
        }// end function

        public static function hasText(param1:String) : Boolean
        {
            if (!param1)
            {
                return false;
            }
            return StringUtils.trim(param1).length > 0;
        }// end function

        public static function tokenizeToArray(param1:String, param2:String) : Array
        {
            var _loc_8:String = null;
            var _loc_3:Array = [];
            var _loc_4:* = param1.length;
            var _loc_5:Boolean = false;
            var _loc_6:String = "";
            var _loc_7:int = 0;
            while (_loc_7 < _loc_4)
            {
                
                _loc_8 = param1.charAt(_loc_7);
                if (param2.indexOf(_loc_8) == -1)
                {
                    _loc_6 = _loc_6 + _loc_8;
                }
                else
                {
                    _loc_3.push(_loc_6);
                    _loc_6 = "";
                }
                if (_loc_7 == (_loc_4 - 1))
                {
                    _loc_3.push(_loc_6);
                }
                _loc_7++;
            }
            return _loc_3;
        }// end function

        public static function containsOnly(param1:String, param2:String) : Boolean
        {
            if (param1 == null || isEmpty(param2))
            {
                return false;
            }
            if (param1.length == 0)
            {
                return true;
            }
            return new RegExp("^[" + param2 + "]*$", "g").test(param1);
        }// end function

        public static function capitalize(param1:String) : String
        {
            if (isEmpty(param1))
            {
                return param1;
            }
            return param1.charAt(0).toUpperCase() + param1.substring(1);
        }// end function

        public static function substringBeforeLast(param1:String, param2:String) : String
        {
            if (isEmpty(param1) || isEmpty(param2))
            {
                return param1;
            }
            var _loc_3:* = param1.lastIndexOf(param2);
            if (_loc_3 == INDEX_NOT_FOUND)
            {
                return param1;
            }
            return param1.substring(0, _loc_3);
        }// end function

        public static function removeAt(param1:String, param2:int, param3:int) : String
        {
            return StringUtils.replaceAt(param1, "", param2, param3);
        }// end function

        private static function testString(param1:String, param2:RegExp) : Boolean
        {
            return param1 != null && param2.test(param1);
        }// end function

        private static function safeRemove(param1:String, param2:RegExp) : String
        {
            if (isEmpty(param1))
            {
                return param1;
            }
            return param1.replace(param2, "");
        }// end function

        public static function isValidFileName(param1:String) : Boolean
        {
            if (!isEmpty(param1))
            {
                return FILENAME_CHARS_NOT_ALLOWED.exec(param1) == null;
            }
            return false;
        }// end function

        public static function indexOfDifference(param1:String, param2:String) : int
        {
            var _loc_3:int = 0;
            if (param1 == param2)
            {
                return INDEX_NOT_FOUND;
            }
            if (isEmpty(param1) || isEmpty(param2))
            {
                return 0;
            }
            _loc_3 = 0;
            while (_loc_3 < param1.length && _loc_3 < param2.length)
            {
                
                if (param1.charAt(_loc_3) != param2.charAt(_loc_3))
                {
                    break;
                }
                _loc_3++;
            }
            if (_loc_3 < param2.length || _loc_3 < param1.length)
            {
                return _loc_3;
            }
            return INDEX_NOT_FOUND;
        }// end function

        public static function rightTrim(param1:String) : String
        {
            return rightTrimForChars(param1, "\n\t\n ");
        }// end function

        public static function substringBetween(param1:String, param2:String, param3:String) : String
        {
            var _loc_5:int = 0;
            if (param1 == null || param2 == null || param3 == null)
            {
                return null;
            }
            var _loc_4:* = param1.indexOf(param2);
            if (param1.indexOf(param2) != INDEX_NOT_FOUND)
            {
                _loc_5 = param1.indexOf(param3, _loc_4 + param2.length);
                if (_loc_5 != INDEX_NOT_FOUND)
                {
                    return param1.substring(_loc_4 + param2.length, _loc_5);
                }
            }
            return null;
        }// end function

        public static function titleize(param1:String) : String
        {
            if (isEmpty(param1))
            {
                return param1;
            }
            var _loc_2:* = param1.toLowerCase().split(" ");
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_2[_loc_3] = capitalize(_loc_2[_loc_3]);
                _loc_3++;
            }
            return _loc_2.join(" ");
        }// end function

        public static function leftTrimForChars(param1:String, param2:String) : String
        {
            var _loc_3:Number = 0;
            var _loc_4:* = param1.length;
            while (_loc_3 < _loc_4 && param2.indexOf(param1.charAt(_loc_3)) >= 0)
            {
                
                _loc_3 = _loc_3 + 1;
            }
            return _loc_3 > 0 ? (param1.substr(_loc_3, _loc_4)) : (param1);
        }// end function

        public static function containsNone(param1:String, param2:String) : Boolean
        {
            if (isEmpty(param1) || param2 == null)
            {
                return true;
            }
            return new RegExp("^[^" + param2 + "]*$", "").test(param1);
        }// end function

    }
}
