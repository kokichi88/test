package modules.battle.logic.bean
{
    import resMgr.data.*;

    public class BaseInfo extends Object
    {
        public var maxHp:int = 0;
        public var curHp:int;
        public var moveSpeed:Number = 200;
        public var attackRange:Number;
        public var minAttackRange:Number;
        public var attackSpeed:int = 30;
        public var damagePerAttack:int = 20;
        public var attackArea:int;
        public var attackRadius:Number;
        public var attackType:int;
        public var dmgScale:int;
        public var favoriteTarget:String;
        public var id:String;
        public var level:int;
        public var healsPerAttack:int;
        public var numHousingSpace:int;
        public static const WIDTH_CELL:Number = 38;
        public static const HEIGHT_CELL:Number = 28.5;
        public static const SCALE_MAP:Number = 1.333;
        public static const SCALE_SPEED:Number = 1.2;

        public function BaseInfo()
        {
            this.attackRange = new Number(100);
            this.minAttackRange = new Number(0);
            return;
        }// end function

        public function setTroopInfo(param1:TroopInfo) : void
        {
            this.maxHp = param1.hitpoints;
            this.curHp = this.maxHp;
            this.attackSpeed = param1.attackSpeed * GlobalVar.stage.frameRate;
            this.attackRange = param1.attackRange * WIDTH_CELL;
            this.damagePerAttack = param1.damagePerAttack;
            var _loc_2:* = param1.moveSpeed / 8 * WIDTH_CELL * SCALE_SPEED * 10;
            this.moveSpeed = _loc_2 / 10;
            this.attackArea = param1.attackArea;
            this.attackRadius = param1.attackRadius * WIDTH_CELL;
            this.attackType = param1.attackType;
            this.dmgScale = param1.dmgScale;
            this.favoriteTarget = param1.favoriteTarget;
            this.id = param1.id;
            this.level = param1.level;
            this.healsPerAttack = param1.healsPerAttack;
            this.numHousingSpace = param1.housingSpace;
            return;
        }// end function

        public function setDefensesInfo(param1:DataDefenses) : void
        {
            this.maxHp = param1.hitpoints;
            this.attackSpeed = GlobalVar.stage.frameRate * param1.attackSpeed;
            this.attackRange = param1.maxRange * WIDTH_CELL * SCALE_MAP;
            this.minAttackRange = param1.minRange * WIDTH_CELL * SCALE_MAP;
            this.damagePerAttack = param1.damagePerShot;
            this.attackRadius = param1.attackRadius * WIDTH_CELL;
            this.curHp = this.maxHp;
            this.id = param1.id;
            return;
        }// end function

        public function setTrapInfo(param1:DataTrap) : void
        {
            this.maxHp = 1;
            this.attackSpeed = param1.timeActive * GlobalVar.stage.frameRate;
            this.attackRange = param1.triggerRadius * WIDTH_CELL * SCALE_MAP;
            this.minAttackRange = 0;
            this.damagePerAttack = param1.damage;
            this.attackRadius = param1.blastRadius * WIDTH_CELL * SCALE_MAP;
            this.curHp = this.maxHp;
            this.id = param1.id;
            this.numHousingSpace = param1.skillSlotsWorth;
            return;
        }// end function

        public function setSpellInfo(param1:DataSpell) : void
        {
            this.attackRange = param1.randomRadius;
            this.attackRadius = param1.radius;
            this.id = param1.id;
            this.level = param1.level;
            this.damagePerAttack = param1.damagePerStrike;
            this.attackSpeed = 1 * GlobalVar.stage.frameRate;
            return;
        }// end function

    }
}
