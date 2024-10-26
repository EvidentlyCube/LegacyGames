package game.widgets {
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.utils.getTimer;
    import game.global.Core;
    import game.objects.TEffectRoomSlide;

    import game.global.DB;
    import game.global.Game;
    import game.managers.VOCharacterCommand;
    import game.managers.VOCoord;
    import game.managers.VOSpeech;
    import game.managers.VOSpeechCommand;
    import game.objects.TGameObject;
    import game.objects.actives.TCharacter;
    import game.objects.actives.TMonster;
    import game.objects.effects.TEffectSubtitle;

    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.rSound;

	/**
     * ...
     * @author
     */
    public class TWidgetSpeech {
        private static var subtitles          :Array = [];
        private static var speechSoundChannels:Array = [];

        public static var nextSpeechTime:Number = 0;
        public static var speeches:rGroup = new rGroup();

        public static function update():void {
            if (TEffectRoomSlide.instance || getTimer() < nextSpeechTime)
                return;

            if (speeches.length == 0 && nextSpeechTime) {
                nextSpeechTime = 0;

                showPlayerFace(true);
                return;
            }

            if (Game.player.placingDoubleType)
                return;

            while (speeches.length) {
                var command:VOSpeechCommand = speeches.getFirst() as VOSpeechCommand;

                speeches.nullify(command);

                if (!processSpeechSpeaker(command))
                    continue;

                var speech      :VOSpeech = command.command.speech;
                var playingSound:Boolean  = false;
                var delay       :uint     = speech.delay;

                if (command.playSound){
                    var sound:Sound = DB.getSound(speech.soundID);

                    if (sound){
                        var sc:* = rSound.playSound(sound, null, Core.volumeVoices);

                        if (sc) {
                            speechSoundChannels.push(sc);

                            if (!delay) {
                                delay = sound.length;
                            }
                        }
                    }
                }

                if (!delay)
                    delay = 1000 + _(speech.message).length * 50;

                addSubtitle(command, delay);
                nextSpeechTime = getTimer() + delay;

                break;
            }
        }

        public static function parseSpeechEvent(speech:VOSpeechCommand):void {
            if (!speech.flush) {
                if (speech.command.speech) {
                    prepareCustomSpeaker(speech);
                    speeches.add(speech);
                }
            } else {
                // @TODO Speech Flush
            }
        }

        private static function prepareCustomSpeaker(speechCmd:VOSpeechCommand):void {
            var command:VOCharacterCommand = speechCmd.command;
            var speech :VOSpeech           = command  .speech;

            if (speech.character == C.SPEAK_Custom) {
                ASSERT(F.isValidColRow(command.x, command.y));
                var monster:TMonster = Game.room.tilesActive[command.x + command.y * S.LEVEL_WIDTH];
                if (monster) {
                    speechCmd.speakingEntity = monster;

                } else {
                    var character:TCharacter = speechCmd.executingNPC as TCharacter;
                    var speaker  :TCharacter = new TCharacter();
                    speaker.prevX = speaker.x = command.x;
                    speaker.prevY = speaker.y = command.y;

                    speaker.logicalIdentity = character.logicalIdentity;
                    speaker.identity        = character.identity;

                    speechCmd.speakingEntity = speaker;
                }
            }
        }

        private static function processSpeechSpeaker(command:VOSpeechCommand):Boolean {
            var entity:TGameObject = Game.getSpeakingEntity(command);

            if (entity == command.executingNPC && !command.executingNPC.isAlive)
                return false;

            var speech:VOSpeech = command.command.speech;
            var speaker:uint = speech.character;

            if (speech.character == C.SPEAK_None){
                showPlayerFace(true);

            } else {
                TWidgetFace.setMood(speech.mood, 0, true);
                if (speech.character != C.SPEAK_Custom && speech.character != C.SPEAK_Self){
                    TWidgetFace.setSpeaker(speaker, true);

                } else {
                    speaker = F.getSpeakerType(command.speakingEntity.getIdentity());
                    if (speaker != C.SPEAK_None)
                        TWidgetFace.setSpeaker(speaker, true);
                }
            }

            return true;
        }

        public static function showPlayerFace(overrideLock:Boolean = false):void{
            if (overrideLock || (TWidgetFace.getSpeaker() != C.SPEAK_Beethro &&
                    !TWidgetFace.isLocked())){
                TWidgetFace.setSpeaker(C.SPEAK_Beethro, false);
                TWidgetFace.setMood(TWidgetFace.MOOD_NORMAL);
            }
        }

        private static function addSubtitle(command:VOSpeechCommand, duration:uint):void{
            var speaker:TGameObject = Game.getSpeakingEntity(command);
            var speech :VOSpeech    = command.command.speech;
            var text   :String      = _(speech.message);

            var subtitle:TEffectSubtitle = getSubtitle(speaker);

            if (subtitle){
                subtitle.addTextLine(text, duration);
                return;
            }

            var speakerIdentity:uint = speech.character;
            if (speakerIdentity == C.SPEAK_Custom || speakerIdentity == C.SPEAK_Self)
                speakerIdentity = C.SPEAK_None;

            var color:uint;
            if (speakerIdentity != C.SPEAK_None)
                color = C.SPEAKER_COLOUR[speakerIdentity];

            else {
                speakerIdentity = command.speakingEntity.getIdentity();

                color = C.SPEAKER_COLOUR[F.getSpeakerType(speakerIdentity)];
            }

            subtitles.push(new TEffectSubtitle(speaker, text, 0, color, duration));
        }

        public static function addInfoSubtitle(coords:TGameObject, text:String, duration:Number,
                                               displayLines:uint = 1, color:uint = 0, fadeDuration:Number = 500):void {

            for each(var subtitle:TEffectSubtitle in subtitles) {
                if (subtitle.coords == coords){
                    subtitle.addTextLine(text, duration);
                    return;
                }
            }

            subtitles.push(new TEffectSubtitle(coords, text, color, C.SPEAKER_COLOUR[C.SPEAK_None],
                                                duration, displayLines, fadeDuration));
        }

        private static function getSubtitle(forEntity:TGameObject):TEffectSubtitle{
            for each(var i:TEffectSubtitle in subtitles){
                if (i.coords == forEntity)
                    return i;
            }

            return null;
        }

        public static function removeSubtitle(subtitle:TEffectSubtitle):void{
            var index:uint = subtitles.indexOf(subtitle);

            if (index != -1)
                subtitles.splice(index);
        }

        public static function clear():void{
            for each(var sc:SoundChannel in speechSoundChannels){
                sc.stop();
            }

            speechSoundChannels.length = 0;

            subtitles.length = 0;
            speeches .clear();

            nextSpeechTime = 0;

            showPlayerFace(true);
        }

        public static function stopAllSpeech():void {
            for each(var sc:SoundChannel in speechSoundChannels){
                if (sc) {
                    sc.stop();
                }
            }

            for each(var s:TEffectSubtitle in subtitles) {
                if (s) {
                    s.stop();
                }
            }

            speechSoundChannels.length = 0;
            subtitles          .length = 0;
            speeches           .clear();

            nextSpeechTime = 0;

            showPlayerFace(true);
        }
    }
}