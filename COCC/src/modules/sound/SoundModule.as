package modules.sound
{
    import bitzero.net.events.*;
    import com.greensock.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import modules.*;
    import modules.city.graphics.tutorial.*;
    import network.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class SoundModule extends BaseModule
    {
        private var bgMusic:SoundChannel;
        private var bgVolume:Number;
        private var delayMusic:Number = 0;
        private var ambiences:Array;
        private var delayAmbience:Array;
        private var soundList:Object;
        private var isMuteBgMusic:Boolean = false;
        private var isMuteSound:Boolean = false;
        private var curBgSound:String = "";
        public static const ARM_1_ATK:String = "sword_swing";
        public static const ARM_1_DEAD:String = "barbarian_dead";
        public static const ARM_1_DEPLOY:String = "barbarian_deploy";
        public static const ARM_1_HIT:String = "sword_hit";
        public static const ARM_2_ATK:String = "arrow";
        public static const ARM_2_DEAD:String = "archer_dead";
        public static const ARM_2_DEPLOY:String = "archer_deploy";
        public static const ARM_2_HIT:String = "arrow_hit";
        public static const ARM_3_ATK:String = "globin_atk";
        public static const ARM_3_DEAD:String = "globin_dead";
        public static const ARM_3_DEPLOY:String = "globin_deploy";
        public static const ARM_4_ATK:String = "giant_atk";
        public static const ARM_4_DEAD:String = "giant_dead";
        public static const ARM_4_DEPLOY:String = "giant_deploy";
        public static const ARM_4_HIT:String = "giant_hit";
        public static const ARM_5_ATK:String = "explosion";
        public static const ARM_5_DEAD:String = "wallbreaker_dead";
        public static const ARM_5_DEPLOY:String = "wallbreaker_deploy";
        public static const ARM_6_ATK:String = "explosion";
        public static const ARM_6_DEAD:String = "ballon_dead";
        public static const ARM_6_DEPLOY:String = "ballon_deploy";
        public static const ARM_7_ATK:String = "mage_atk";
        public static const ARM_7_DEAD:String = "mage_dead";
        public static const ARM_7_DEPLOY:String = "mage_deploy";
        public static const ARM_7_HIT:String = "mage_hit";
        public static const ARM_8_ATK:String = "healer_cast";
        public static const ARM_8_DEPLOY:String = "healer_deploy";
        public static const ARM_8_HIT:String = "healer_hit";
        public static const ARM_9_ATK:String = "dragon_atk";
        public static const ARM_9_DEAD:String = "dragon_dead";
        public static const ARM_9_DEPLOY:String = "dragon_deploy";
        public static const ARM_10_ATK:String = "pekka_atk";
        public static const ARM_10_DEAD:String = "pekka_dead";
        public static const ARM_10_DEPLOY:String = "pekka_deploy";
        public static const ARM_10_HIT:String = "pekka_hit_1";
        public static const ARM_11_ATK:String = "bbking_atk";
        public static const ARM_11_DEPLOY:String = "bbking_deploy";
        public static const ARM_12_ATK:String = "queen_atk";
        public static const ARM_12_DEAD:String = "queen_dead";
        public static const ARM_12_DEPLOY:String = "queen_deploy";
        public static const AMC_1_PICKUP:String = "camp_pickup";
        public static const AMC_1_PLACE:String = "camp_place";
        public static const BAR_1_PICKUP:String = "traininghouse_pickup";
        public static const BAR_1_PLACE:String = "traininghouse_place";
        public static const BDH_1_PICKUP:String = "builderhut_pickup";
        public static const BDH_1_PLACE:String = "builderhut_place";
        public static const DEF_1_ATK:String = "cannon_fire";
        public static const DEF_1_PICKUP:String = "cannon_pickup";
        public static const DEF_1_PLACE:String = "cannon_place";
        public static const DEF_2_PICKUP:String = "achertower_pickup";
        public static const DEF_2_PLACE:String = "achertower_place";
        public static const DEF_3_ATK:String = "mortal_fire";
        public static const DEF_3_PICKUP:String = "mortal_pickup";
        public static const DEF_3_PLACE:String = "mortal_place";
        public static const DEF_4_ATK:String = "wizardtower_atk";
        public static const DEF_4_HIT:String = "wizardtower_hit";
        public static const DEF_4_PICKUP:String = "wizardtower_pickup";
        public static const DEF_4_PLACE:String = "wizardtower_place";
        public static const DEF_6_ATK:String = "xbow_atk";
        public static const DEF_6_PICKUP:String = "xbow_pickup";
        public static const DEF_6_PLACE:String = "xbow_place";
        public static const DEF_7_ATK:String = "xbow_atk";
        public static const DEF_7_LOAD:String = "xbow_load";
        public static const DEF_7_PICKUP:String = "xbow_pickup";
        public static const DEF_7_PLACE:String = "xbow_place";
        public static const DEF_8_ACTIVE:String = "tesla_appeare";
        public static const DEF_8_ATK:String = "tesla_atk";
        public static const DEF_8_PICKUP:String = "tesla_pickup";
        public static const DEF_8_PLACE:String = "tesla_place";
        public static const RES_1_PICKUP:String = "goldmine_pickup";
        public static const RES_1_PLACE:String = "goldmine_place";
        public static const RES_2_PICKUP:String = "elixirpump_pickup";
        public static const RES_2_PLACE:String = "elixirpump_place";
        public static const STO_1_PICKUP:String = "goldstorage_pickup";
        public static const STO_1_PLACE:String = "goldstorage_place";
        public static const STO_2_PICKUP:String = "elixirstorage_pickup";
        public static const STO_2_PLACE:String = "elixirstorage_place";
        public static const TOW_1_PICKUP:String = "townhall_pickup";
        public static const TOW_1_PLACE:String = "townhall_place";
        public static const WAL_1_PICKUP:String = "wall_pickup";
        public static const WAL_1_PLACE:String = "wall_place";
        public static const BREAK_BOTTLE_LIGHTING:String = "break_bottle_lighting";
        public static const BUILDING_CONTRUCT:String = "building_contruct";
        public static const BUILDING_DESTROYED:String = "building_destroyed";
        public static const BUILDING_FINISH:String = "building_finish";
        public static const BUTTON_CLICK:String = "button_click";
        public static const CLEAR_TOMB:String = "clear_tomb";
        public static const COLLECT_DARK_ELIXIR:String = "collect_dark_elixir";
        public static const COLLECT_DIAMONDS:String = "collect_diamonds";
        public static const COLLECT_ELIXIR:String = "collect_elixir";
        public static const COLLECT_GOLD:String = "collect_gold";
        public static const DARKELIXIRDRILL_PICKUP:String = "darkelixirdrill_pickup";
        public static const DARKELIXIRDRILL_PLACE:String = "darkelixirdrill_place";
        public static const DEFEATED:String = "defeated";
        public static const EXP_GAIN:String = "exp_gain";
        public static const FINISH_TRAINING:String = "training_finish";
        public static const ILLEGAN_MOVE:String = "illegan_move";
        public static const JUMP_TRAP_ACTIVE:String = "jump_trap_active";
        public static const LEVEL_UP:String = "xp_level_up";
        public static const MOVING:String = "moving";
        public static const STEAL_DARK_ELIXIR:String = "steal_dark_elixir";
        public static const STEAL_ELIXIR:String = "steal_elixir";
        public static const STEAL_GOLD:String = "steal_coin";
        public static const VICTORY:String = "victory";
        public static const GOBLIN_TALK:String = "golbintalk";
        public static const GOBLIN_ATTACK:String = "golbin_attacking";
        public static const PUNCHTRAP_ACTIVE:String = "punchtrap_active";
        public static const PUNCHTRAP_DROP:String = "punchtrap_drop";
        private static const MAX_AMBIENCE:int = 3;
        private static var instance:SoundModule;
        public static const MUSIC_BG_HOME:String = "theme";
        public static const MUSIC_BG_PREPARE_TO_FIGHT:String = "prepare";
        public static const MUSIC_BG_FIGHT:String = "fight";

        public function SoundModule()
        {
            this.ambiences = new Array();
            this.delayAmbience = new Array(0, 0, 0);
            return;
        }// end function

        override protected function onInit() : void
        {
            bzConnector.addResponseListener(Command.GET_BATTLE_INFO, this.playPrepareMusic);
            this.soundList = new Object();
            var _loc_1:* = SharedObject.getLocal("SavedSetting");
            var _loc_2:* = _loc_1.data["saved"];
            if (_loc_2 != null)
            {
                if (_loc_2["sound"] != null && _loc_2["sound"])
                {
                    this.isMuteSound = false;
                    this.muteSound(false);
                }
                else
                {
                    this.isMuteSound = true;
                    this.muteSound(true);
                }
                if (_loc_2["music"] != null && _loc_2["music"])
                {
                    this.isMuteBgMusic = false;
                    this.muteBgMusic(false);
                }
                else
                {
                    this.isMuteBgMusic = true;
                    this.muteBgMusic(true);
                }
            }
            else
            {
                this.isMuteBgMusic = false;
                this.isMuteSound = false;
                this.muteBgMusic(false);
                this.muteSound(false);
            }
            return;
        }// end function

        public function playBgMusic(param1:String = "theme") : void
        {
            if (this.curBgSound == param1)
            {
                return;
            }
            if (this.bgMusic != null && param1 != MUSIC_BG_FIGHT)
            {
                TweenMax.to(this.bgMusic, 1.5, {volume:0, onComplete:this.playNewBgMusic, onCompleteParams:[param1]});
            }
            else
            {
                this.playNewBgMusic(param1);
            }
            return;
        }// end function

        private function playNewBgMusic(param1:String) : void
        {
            var loop:int;
            var bg:Sound;
            var url:URLRequest;
            var name:* = param1;
            if (this.bgMusic)
            {
                this.bgMusic.stop();
            }
            var dataSound:* = JsonMgr.getInstance().getMusic(name);
            if (!dataSound)
            {
                return;
            }
            this.curBgSound = name;
            if (this.curBgSound == MUSIC_BG_HOME)
            {
                if (Utility.getCurTime() < this.delayMusic)
                {
                    return;
                }
                loop;
            }
            else
            {
                loop;
                this.stopAllAmbience();
            }
            name = dataSound.name;
            this.bgVolume = dataSound.volume / 100;
            var pan:Number;
            if (name in this.soundList)
            {
                bg = this.soundList[name];
            }
            else
            {
                url = new URLRequest(Config.getStaticUrl() + "sound/" + name + "?v=" + Config.gameVersion);
                bg = new Sound();
                bg.addEventListener(IOErrorEvent.IO_ERROR, function (event:IOErrorEvent) : void
            {
                return;
            }// end function
            );
                bg.load(url);
                this.soundList[name] = bg;
            }
            this.bgMusic = bg.play(0, loop);
            this.bgMusic.addEventListener(Event.SOUND_COMPLETE, this.stopBgMusic);
            this.muteBgMusic(this.isMuteBgMusic);
            return;
        }// end function

        public function stopBgMusic(event:Event = null) : void
        {
            this.delayMusic = Utility.getCurTime() + Utility.randomNumber(40, 60);
            if (this.bgMusic == null)
            {
                return;
            }
            this.bgMusic.stop();
            this.bgMusic.removeEventListener(Event.SOUND_COMPLETE, this.stopBgMusic);
            this.bgMusic = null;
            return;
        }// end function

        public function muteBgMusic(param1:Boolean) : void
        {
            this.isMuteBgMusic = param1;
            if (!this.bgMusic)
            {
                return;
            }
            if (this.isMuteBgMusic && this.bgMusic != null)
            {
                this.bgMusic.soundTransform = new SoundTransform(0);
            }
            if (!this.isMuteBgMusic)
            {
                this.bgMusic.soundTransform = new SoundTransform(this.bgVolume);
            }
            return;
        }// end function

        public function playSound(param1:String) : void
        {
            var url:URLRequest;
            var sound:Sound;
            var vol:Number;
            var pan:Number;
            var channel:SoundChannel;
            var name:* = param1;
            if (this.isMuteSound || !name)
            {
                return;
            }
            var dataSound:* = JsonMgr.getInstance().getSoundRandom(name);
            vol = dataSound.volume / 100;
            pan;
            name = dataSound.name;
            if (name in this.soundList)
            {
                sound = this.soundList[name];
                channel = sound.play(0, 1, new SoundTransform(vol, pan));
            }
            else
            {
                url = new URLRequest(Config.getStaticUrl() + "sound/sfx/" + name + "?v=" + Config.gameVersion);
                sound = new Sound(url);
                sound.addEventListener(IOErrorEvent.IO_ERROR, function (event:IOErrorEvent) : void
            {
                return;
            }// end function
            );
                sound.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                if (!soundList[name])
                {
                    soundList[name] = sound;
                }
                channel = sound.play(0, 1, new SoundTransform(vol, pan));
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function muteSound(param1:Boolean) : void
        {
            var _loc_2:int = 0;
            var _loc_3:SoundChannel = null;
            this.isMuteSound = param1;
            if (this.isMuteSound)
            {
                _loc_2 = 0;
                while (_loc_2 < this.ambiences.length)
                {
                    
                    _loc_3 = this.ambiences[_loc_2];
                    if (_loc_3)
                    {
                        _loc_3.stop();
                        _loc_3.removeEventListener(Event.SOUND_COMPLETE, this.stopAmbience);
                        this.ambiences[_loc_2] = null;
                        _loc_3 = null;
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        public function update() : void
        {
            this.playAmbience();
            if (this.bgMusic == null && Utility.getCurTime() > this.delayMusic && !TutorialMgr.getInstance().isTutorial)
            {
                this.playNewBgMusic(MUSIC_BG_HOME);
            }
            return;
        }// end function

        private function playHomeMusic(param1:MsgInfo) : void
        {
            this.playBgMusic();
            return;
        }// end function

        private function playPrepareMusic(param1:MsgInfo) : void
        {
            this.playBgMusic(MUSIC_BG_PREPARE_TO_FIGHT);
            return;
        }// end function

        private function stopAllAmbience() : void
        {
            var _loc_1:int = 0;
            var _loc_2:SoundChannel = null;
            _loc_1 = 0;
            while (_loc_1 < this.ambiences.length)
            {
                
                _loc_2 = this.ambiences[_loc_1];
                if (_loc_2)
                {
                    _loc_2.stop();
                    _loc_2.removeEventListener(Event.SOUND_COMPLETE, this.stopAmbience);
                    this.ambiences[_loc_1] = null;
                    _loc_2 = null;
                }
                _loc_1++;
            }
            return;
        }// end function

        private function playAmbience() : void
        {
            var i:int;
            var ambience:SoundChannel;
            var dataSound:DataSound;
            var name:String;
            var vol:Number;
            var pan:Number;
            var url:URLRequest;
            var bg:Sound;
            if (this.isMuteSound)
            {
                return;
            }
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            i;
            while (i < this.delayAmbience.length)
            {
                
                if (this.ambiences[i] == null && Utility.getCurTime() >= this.delayAmbience[i])
                {
                    dataSound = JsonMgr.getInstance().getAmbienceRandom();
                    if (!dataSound)
                    {
                        return;
                    }
                    name = dataSound.name;
                    vol = dataSound.volume / 100;
                    pan;
                    url = new URLRequest(Config.getStaticUrl() + "sound/ambience/" + name + "?v=" + Config.gameVersion);
                    if (name in this.soundList)
                    {
                        bg = this.soundList[name];
                    }
                    else
                    {
                        bg = new Sound();
                        bg.addEventListener(IOErrorEvent.IO_ERROR, function (event:IOErrorEvent) : void
            {
                return;
            }// end function
            );
                        bg.load(url);
                        this.soundList[name] = bg;
                    }
                    ambience = bg.play(0, 1, new SoundTransform(vol, pan));
                    if (ambience != null)
                    {
                        ambience.addEventListener(Event.SOUND_COMPLETE, this.stopAmbience);
                        this.ambiences[i] = ambience;
                    }
                }
                i = (i + 1);
            }
            return;
        }// end function

        private function stopAmbience(event:Event) : void
        {
            var _loc_2:* = event.target as SoundChannel;
            var _loc_3:* = this.ambiences.indexOf(_loc_2);
            _loc_2.removeEventListener(Event.SOUND_COMPLETE, this.stopAmbience);
            this.ambiences[_loc_3] = null;
            _loc_2 = null;
            this.delayAmbience[_loc_3] = Utility.getCurTime() + Utility.randomNumber(1, 6);
            return;
        }// end function

        public static function getInstance() : SoundModule
        {
            if (instance == null)
            {
                instance = new SoundModule;
            }
            return instance;
        }// end function

    }
}
