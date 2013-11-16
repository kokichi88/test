﻿package org.as3commons.reflect
{
    import flash.system.*;
    import org.as3commons.lang.*;

    public class Field extends AbstractMember
    {

        public function Field(param1:String, param2:String, param3:String, param4:Boolean, param5:ApplicationDomain, param6:HashArray = null)
        {
            super(param1, param2, param3, param4, param5, param6);
            return;
        }// end function

        public function getValue(param1 = null)
        {
            if (!param1)
            {
                param1 = declaringType.clazz;
            }
            return param1[name];
        }// end function

    }
}
