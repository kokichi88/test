package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import gameData.*;

    public class QuestInfoMsg extends BaseMsg
    {
        public var questList:Vector.<DataSideQuest>;

        public function QuestInfoMsg(param1:Object)
        {
            this.questList = new Vector.<DataSideQuest>;
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_3:DataSideQuest = null;
            errorCode = readInt();
            var _loc_1:* = readInt();
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new DataSideQuest();
                _loc_3.questType = readStr();
                _loc_3.id = readInt();
                _loc_3.currentAmount = readInt();
                this.questList.push(_loc_3);
                _loc_2++;
            }
            return true;
        }// end function

    }
}
