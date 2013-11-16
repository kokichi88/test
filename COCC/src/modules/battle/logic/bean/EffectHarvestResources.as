package modules.battle.logic.bean
{
    import gameData.*;

    public class EffectHarvestResources extends Object
    {
        private var num:int;
        private var type:String;
        private var px:Number;
        private var py:Number;

        public function EffectHarvestResources()
        {
            return;
        }// end function

        public function setInfo(param1:String, param2:int, param3:Number, param4:Number) : void
        {
            param2 = Math.min(param2, 6);
            this.type = param1;
            this.px = param3;
            this.py = param4;
            switch(param1)
            {
                case MoneyType.ELIXIR:
                case MoneyType.GOLD:
                {
                    this.num = param2;
                    this.createEffect();
                    break;
                }
                default:
                {
                    this.num = param2;
                    this.createEffect();
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function createEffect() : void
        {
            var _loc_2:SeedEffect = null;
            var _loc_1:int = 0;
            while (_loc_1 < this.num)
            {
                
                _loc_2 = new SeedEffect();
                _loc_2.create(this.type, this.px, this.py);
                _loc_1++;
            }
            return;
        }// end function

        private function onFinishTween() : void
        {
            return;
        }// end function

    }
}
