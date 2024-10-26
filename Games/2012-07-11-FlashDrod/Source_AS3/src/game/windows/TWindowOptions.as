package game.windows{
    import flash.display.Bitmap;
    import flash.display.BlendMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import game.global.CaravelConnect;
    import game.global.Core;
    import game.global.Make;
    import game.global.Sfx;
    import game.interfaces.TDragButton;
    import game.states.TStateGame;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UString;

    import net.retrocade.camel.core.rWindow;
    import net.retrocade.standalone.Grid9;

    public class TWindowOptions extends rWindow {

        private static var EFFECT_DURATION:uint = 400;

        private static var _instance:TWindowOptions = new TWindowOptions();

        public static function show():void{
            _instance.show();
        }



        /****************************************************************************************************************/
        /**                                                                                                   INSTANCE  */
        /****************************************************************************************************************/

        private var bg          :Grid9;
        private var header      :Text;

        private var cnetHeader  :Text;

        private var cnetDesc    :Text;
        private var cnetNameDesc:Text;
        private var cnetPassDesc:Text;
        private var cnetNameBG:Grid9;
        private var cnetPassBG:Grid9;
        private var cnetNameInput:Text;
        private var cnetPassInput:Text;
        private var cnetUpload:Button;
        private var cnetConnect:Button;

        private var volume :Text;
        private var music  :Text;
        private var effects:Text;
        private var voices :Text;

        private var movementRepeat:Text;

        private var voicesDrag :TDragButton;
        private var musicDrag  :TDragButton;
        private var effectsDrag:TDragButton;
        private var repeatDrag :TDragButton;

        private var repeatTextSlow:Text;
        private var repeatTextFast:Text;

        private var redefineButton:Button;
        private var closeButton   :Button;

        // Block all input
        private var _locked:Boolean = false;

        public function set locked(to:Boolean):void{
            _locked = to;

            mouseChildren = mouseEnabled = !to;
        }


        public function TWindowOptions() {

            // Creation

            bg      = Grid9.getGrid("window", true);

            cnetNameBG = Grid9.getGrid("textInput");
            cnetPassBG = Grid9.getGrid("textInput");

            header         = Make.text(36);
            cnetHeader     = Make.text(24);
            cnetDesc       = Make.text(14);
            cnetNameDesc   = Make.text(18);
            cnetPassDesc   = Make.text(18);
            cnetNameInput  = Make.text(18);
            cnetPassInput  = Make.text(18);
            cnetUpload     = Make.buttonColor(onUploadAllScores, _("optUploadAll"));
            cnetConnect    = Make.buttonColor(onConnect, _("optConnect"));
            redefineButton = Make.buttonColor(onRedefine, _("optRedefine"));
            closeButton    = Make.buttonColor(onClose, _("close"));

            volume  = Make.text(24);
            music   = Make.text(18);
            effects = Make.text(18);
            voices  = Make.text(18);

            voicesDrag  = new TDragButton();
            effectsDrag = new TDragButton();
            musicDrag   = new TDragButton();
            repeatDrag  = new TDragButton();

            movementRepeat = Make.text(24);
            repeatTextFast = Make.text(14);
            repeatTextSlow = Make.text(14);



            // Setting initial properties

            header.text = _("optHeader");

            cnetPassInput.autoSizeNone();
            cnetNameInput.autoSizeNone();
            cnetPassInput.displayAsPassword = true;

            cnetDesc.autoSizeNone();
            cnetDesc.wordWrap = true;

            cnetHeader.text 		 = _("optCnetHeader");
			cnetHeader.color         = 0x0000DD;
			cnetHeader.underline     = true;
			cnetHeader.mouseEnabled  = true;
			cnetHeader.mouseChildren = true;
			cnetHeader.buttonMode    = true;
			cnetHeader.useHandCursor = true;
			cnetHeader.selectable    = false;

            cnetDesc  .text = _("cnetDescription");
            cnetDesc.lineSpacing = -2;

            cnetNameDesc.text = _("optCnetUser");
            cnetPassDesc.text = _("optCnetKey");

            volume .text = _("optCnetVolume");
            music  .text = _("optCnetMusic");
            effects.text = _("optCnetSound");
            voices .text = _("optCnetVoices");

            movementRepeat .text = _("optMoveAnim");
            repeatTextFast .text = _("opyMoveFast");
            repeatTextSlow .text = _("optMoveSmooth");


            // Sizing and Positioning

            bg.width  = 680;
            bg.height = 400+40;

            header          .setSizePosition( 15,  -5, 200,  51);
            cnetHeader      .setSizePosition( 15,  38, 321,  35);
            cnetDesc        .setSizePosition( 15,  72, 321,  120);
            cnetNameDesc    .setSizePosition( 15, 195, 134,  28);
            cnetPassDesc    .setSizePosition( 15, 226, 134,  28);
            cnetNameBG      .setSizePosition(149, 195, 186,  28);
            cnetPassBG      .setSizePosition(149, 226, 186,  28);
            cnetNameInput   .setSizePosition(154, 195, 176,  28);
            cnetPassInput   .setSizePosition(154, 226, 176,  28);
            cnetUpload      .setSizePosition( 15, 262, 320,  33);
            cnetConnect     .setSizePosition( 15, 302, 320,  33);
            volume          .setSizePosition(348,  38, 317,  35);
            music           .setSizePosition(348,  81,  84,  28);
            effects         .setSizePosition(348, 112,  84,  28);
            voices          .setSizePosition(348, 143,  84,  28);
            movementRepeat  .setSizePosition(348, 178, 317,  35);
            musicDrag       .setSizePosition(438,  81, 200,  28);
            effectsDrag     .setSizePosition(438, 112, 200,  28);
            voicesDrag      .setSizePosition(438, 143, 200,  28);
            repeatDrag      .setSizePosition(348, 240, 317,  28);
            redefineButton  .setSizePosition(175, 312+40, 320,  33);
            closeButton     .setSizePosition(195, 352+40, 280,  33);

            header.fitSize();
            header.alignCenterParent(0, bg.width);

            repeatTextFast.right  = repeatDrag.right;
            repeatTextFast.bottom = repeatDrag.y - 5;

            repeatTextSlow.x      = repeatDrag.x;
            repeatTextSlow.bottom = repeatDrag.y - 5;




            // Add children

            addChild(bg);
            addChild(cnetNameBG);
            addChild(cnetPassBG);
            addChild(header);
            addChild(cnetHeader);
            addChild(cnetDesc);
            addChild(cnetNameDesc);
            addChild(cnetPassDesc);
            addChild(cnetNameInput);
            addChild(cnetPassInput);
            addChild(cnetUpload);
            addChild(cnetConnect);
            addChild(volume);
            addChild(music);
            addChild(effects);
            addChild(voices);
            addChild(movementRepeat);
            addChild(voicesDrag);
            addChild(musicDrag);
            addChild(effectsDrag);
            addChild(repeatDrag);
            addChild(repeatTextFast);
            addChild(repeatTextSlow);
            addChild(redefineButton);
            addChild(closeButton);


            // Add Events

            voicesDrag .addEventListener(Event.CHANGE, dragChanged);
            effectsDrag.addEventListener(Event.CHANGE, dragChanged);
            musicDrag  .addEventListener(Event.CHANGE, dragChanged);
            repeatDrag .addEventListener(Event.CHANGE, dragChanged);

            voicesDrag .addEventListener(MouseEvent.MOUSE_UP, dragFinished);
            effectsDrag.addEventListener(MouseEvent.MOUSE_UP, dragFinished);

			// cnetHeader.addEventListener(MouseEvent.CLICK, onCnetClick);

            center();

			graphics.beginFill(0, 0.6);
			graphics.drawRect( -x, -y, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT);

            // Caravel Net options are disabled
            cnetHeader.alpha = 0.25;
            cnetDesc.alpha = 0.25;
            cnetNameDesc.alpha = 0.25;
            cnetPassDesc.alpha = 0.25;
            cnetNameBG.alpha = 0.25;
            cnetPassBG.alpha = 0.25;
            cnetNameInput.alpha = 0.25;
            cnetPassInput.alpha = 0.25;
            cnetUpload.alpha = 0.25;
            cnetConnect.alpha = 0.25;

            cnetNameInput
        }

        override public function show():void {
            super.show();

            repeatDrag   .value = 1 - Core.repeatRate;
            voicesDrag   .value = Core.volumeVoices;
            musicDrag    .value = Core.volumeMusic;
            effectsDrag  .value = Core.volumeEffects;
            cnetNameInput.text  = CaravelConnect.cnetName;
            cnetPassInput.text  = CaravelConnect.cnetPass;

            mouseChildren = false;
            new rEffFade(this, 0, 1, 400, onFadedIn);
        }

        override public function update():void {
            if (rInput.isKeyHit(Key.ESCAPE) && mouseChildren)
                onClose();
        }

        private function dragChanged(e:Event):void {
            if (e.target == voicesDrag)
                Core.volumeVoices = voicesDrag.value;

            else if (e.target == musicDrag){
                Core.volumeMusic = rSound.soundVolume = musicDrag.value;
                Sfx.volume = musicDrag.value;
            }

            else if (e.target == effectsDrag)
                Core.volumeEffects = effectsDrag.value;

            else if (e.target == repeatDrag)
                Core.repeatRate = 1 - repeatDrag.value;
        }

        private function dragFinished(e:MouseEvent):void {
            if (e.target == voicesDrag){
                Sfx.optionVoiceText();
                e.stopImmediatePropagation();

            } else if (e.target == effectsDrag)
                Sfx.monsterKilled();
        }

        private function onRedefine():void {
            TWindowRedefineKeys.show();

            Sfx.buttonClick();
        }

        private function onFadedIn():void {
            mouseChildren = true;
        }

        private function onClose():void {
			rSave.setStorage(S.SAVE_OPTIONS_STORAGE);
            rSave.save(C.SETTING_VOLUME_EFFECTS, effectsDrag  .value);
            rSave.save(C.SETTING_VOLUME_MUSIC,   musicDrag    .value);
            rSave.save(C.SETTING_VOLUME_VOICES,  voicesDrag   .value);
            rSave.save(C.SETTING_REPEAT,         1 - repeatDrag   .value);
            rSave.flush(C.SETTINGS_SAVE_SIZE);
			rSave.setStorage(S.SAVE_STORAGE_NAME);

            CaravelConnect.cnetName = UString.trim(cnetNameInput.text).substr(0, 32);
            CaravelConnect.cnetPass = UString.trim(cnetPassInput.text).substr(0, 32);

            CaravelConnect.saveCnetCredentials();

            TStateGame.offsetSpeed = Core.repeatRate * 12;

            new rEffFade(this, 1, 0, EFFECT_DURATION, close);
            mouseChildren = false;

            rTooltip.hide();
        }

        private function onUploadAllScores():void {
            CaravelConnect.cnetName = UString.trim(cnetNameInput.text).substr(0, 32);
            CaravelConnect.cnetPass = UString.trim(cnetPassInput.text).substr(0, 32);

            CaravelConnect.saveCnetCredentials();

            TWindowUploadDemos.show();
            Sfx.buttonClick();
        }

        private function onConnect():void {
            CaravelConnect.cnetName = UString.trim(cnetNameInput.text).substr(0, 32);
            CaravelConnect.cnetPass = UString.trim(cnetPassInput.text).substr(0, 32);

            CaravelConnect.saveCnetCredentials();

            TWindowLogin.show();
        }

		private function onCnetClick(e:MouseEvent):void {
			navigateToURL(new URLRequest("http://caravelgames.com/Articles/Games_2/CaravelNet.html"), "_blank");
		}
    }
}