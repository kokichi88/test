package modules.battle.logic
{
    import component.avatar.controls.*;
    import component.avatar.things.*;
    import flash.geom.*;
    import modules.battle.*;
    import resMgr.*;

    public class TownHall extends HouseResources
    {

        public function TownHall()
        {
            objectType = OBJTYPE_TEMPLE;
            return;
        }// end function

        override public function onDealDamage(param1:DataObject, param2:Number = 0, param3:int = -1) : void
        {
            var _loc_6:Layer = null;
            var _loc_7:AniEffect = null;
            var _loc_4:* = baseInfo.curHp / baseInfo.maxHp * 100;
            var _loc_5:* = 4 - _loc_4 / 25;
            if (aniEffects.length < _loc_5 && avatar)
            {
                _loc_6 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                switch(_loc_5)
                {
                    case 1:
                    {
                        _loc_7 = EffectDraw.play("contructs_damaged", new Point(avatar.x, avatar.y), _loc_6, 0);
                        break;
                    }
                    case 2:
                    {
                        _loc_7 = EffectDraw.play("contructs_damaged", new Point(avatar.x - 40, avatar.y + 20), _loc_6, 0);
                        break;
                    }
                    case 3:
                    {
                        _loc_7 = EffectDraw.play("contructs_damaged", new Point(avatar.x + 50, avatar.y + 10), _loc_6, 0);
                        break;
                    }
                    case 4:
                    {
                        _loc_7 = EffectDraw.play("contructs_damaged", new Point(avatar.x, avatar.y - 50), _loc_6, 0);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                aniEffects.push(_loc_7);
            }
            super.onDealDamage(param1, param2, param3);
            return;
        }// end function

        override public function death() : void
        {
            BattleModule.getInstance().upStar();
            super.death();
            return;
        }// end function

    }
}
