package org.as3commons.lang
{
    import flash.utils.*;

    final public class Assert extends Object
    {

        public function Assert()
        {
            return;
        }// end function

        public static function arrayContains(param1:Array, param2, param3:String = "") : void
        {
            if (param1.indexOf(param2) == -1)
            {
                if (param3 == null || param3.length == 0)
                {
                    param3 = "[Assertion failed] - this Array argument does not contain the item \'" + param2 + "\'";
                }
                throw new IllegalArgumentError(param3);
            }
            return;
        }// end function

        public static function state(param1:Boolean, param2:String = "") : void
        {
            if (!param1)
            {
                if (param2 == null || param2.length == 0)
                {
                    param2 = "[Assertion failed] - this state invariant must be true";
                }
                throw new IllegalStateError(param2);
            }
            return;
        }// end function

        public static function notAbstract(param1:Object, param2:Class, param3:String = "") : void
        {
            var _loc_4:* = getQualifiedClassName(param1);
            var _loc_5:* = getQualifiedClassName(param2);
            if (_loc_4 == _loc_5)
            {
                if (param3 == null || param3.length == 0)
                {
                    param3 = "[Assertion failed] - instance is an instance of an abstract class";
                }
                throw new IllegalArgumentError(param3);
            }
            return;
        }// end function

        public static function hasText(param1:String, param2:String = "") : void
        {
            if (StringUtils.isBlank(param1))
            {
                if (param2 == null || param2.length == 0)
                {
                    param2 = "[Assertion failed] - this String argument must have text; it must not be <code>null</code>, empty, or blank";
                }
                throw new IllegalArgumentError(param2);
            }
            return;
        }// end function

        public static function isTrue(param1:Boolean, param2:String = "") : void
        {
            if (!param1)
            {
                if (param2 == null || param2.length == 0)
                {
                    param2 = "[Assertion failed] - this expression must be true";
                }
                throw new IllegalArgumentError(param2);
            }
            return;
        }// end function

        public static function implementationOf(param1, param2:Class, param3:String = "") : void
        {
            if (!ClassUtils.isImplementationOf(ClassUtils.forInstance(param1), param2))
            {
                if (param3 == null || param3.length == 0)
                {
                    param3 = "[Assertion failed] - this argument does not implement the interface \'" + param2 + "\'";
                }
                throw new IllegalArgumentError(param3);
            }
            return;
        }// end function

        public static function notNull(param1:Object, param2:String = "") : void
        {
            if (param1 == null)
            {
                if (param2 == null || param2.length == 0)
                {
                    param2 = "[Assertion failed] - this argument is required; it must not null";
                }
                throw new IllegalArgumentError(param2);
            }
            return;
        }// end function

        public static function dictionaryKeysOfType(param1:Dictionary, param2:Class, param3:String = "") : void
        {
            var _loc_4:Object = null;
            for (_loc_4 in param1)
            {
                
                if (!(_loc_4 is param2))
                {
                    if (param3 == null || param3.length == 0)
                    {
                        param3 = "[Assertion failed] - this Dictionary argument must have keys of type \'" + param2 + "\'";
                    }
                    throw new IllegalArgumentError(param3);
                }
            }
            return;
        }// end function

        public static function instanceOf(param1, param2:Class, param3:String = "") : void
        {
            if (!(param1 is param2))
            {
                if (param3 == null || param3.length == 0)
                {
                    param3 = "[Assertion failed] - this argument is not of type \'" + param2 + "\'";
                }
                throw new IllegalArgumentError(param3);
            }
            return;
        }// end function

        public static function arrayItemsOfType(param1:Array, param2:Class, param3:String = "") : void
        {
            var _loc_4:* = undefined;
            for each (_loc_4 in param1)
            {
                
                if (!(_loc_4 is param2))
                {
                    if (param3 == null || param3.length == 0)
                    {
                        param3 = "[Assertion failed] - this Array must have items of type \'" + param2 + "\'";
                    }
                    throw new IllegalArgumentError(param3);
                }
            }
            return;
        }// end function

        public static function subclassOf(param1:Class, param2:Class, param3:String = "") : void
        {
            if (!ClassUtils.isSubclassOf(param1, param2))
            {
                if (param3 == null || param3.length == 0)
                {
                    param3 = "[Assertion failed] - this argument is not a subclass of \'" + param2 + "\'";
                }
                throw new IllegalArgumentError(param3);
            }
            return;
        }// end function

    }
}
