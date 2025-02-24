


package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.tacticengine.core.injector.injectCreate;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.global.oldProgressImporter.OldProgressImporter;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateRetrocade;
	import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;

	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.VAlign;

	public class MonstroWindowImportData extends RetrocamelWindowStarling{
        public static function show():MonstroWindowImportData{
            var instance:MonstroWindowImportData = injectCreate(MonstroWindowImportData);

            instance.show();

            return instance;
        }

		private var _background:MonstroPrettyWindowGrid9;
		private var _parchment:MonstroGrid9;
        private var _text:TextField;
        private var _importButton:MonstroTextButton;
        private var _cancelButton:MonstroTextButton;

		private var _sliderCounter:WindowSliderCounter;

		override public function show():void{
			MonstroWindowModal.show();

			initCreateObjects();
			initializeObjectProperties();

			var displayGroup:MonstroDisplayGroup = new MonstroDisplayGroup();

            displayGroup.addElement(_text);
			_parchment.wrapAround(_text);

			_importButton.forcedWidth = _parchment.innerWidth * 0.4;
			_cancelButton.forcedWidth = _parchment.innerWidth * 0.4;
			_importButton.alignCenterParent(0, _parchment.width / 2);
			_cancelButton.alignCenterParent(_parchment.width / 2, _parchment.width / 2);
			_importButton.y = _parchment.bottom;
			_cancelButton.y = _parchment.bottom;

            displayGroup.addElement(_parchment);
			displayGroup.addElement(_importButton);
			displayGroup.addElement(_cancelButton);
			_background.wrapAround(displayGroup);

            addChildren([_background, _parchment, _text, _importButton, _cancelButton]);

            super.show();
            resize();

			displayGroup.dispose();
        }

		override public function update():void {
			if (_sliderCounter.update()){
				refreshPosition();
			}

			if (_sliderCounter.isFullyHidden){
				contnueGame();
				hide();
			}
		}

		private function initCreateObjects():void {
			_background = new MonstroPrettyWindowGrid9();
			_parchment = MonstroGfx.getGrid9Parchment();
			_text = new TextField(500 - 180, 500, textToShow, MonstroConsts.FONT_EBORACUM_48, 24, 0x382010);
			_importButton = new MonstroTextButton("Import", importHandler);
			_cancelButton = new MonstroTextButton("Cancel", onClose);

			_sliderCounter = new WindowSliderCounter(1);
		}

		private function initializeObjectProperties():void {
			_background.header = "Import progress";

			_text.htmlText = true;
			_text.autoSize = TextFieldAutoSize.VERTICAL;
			_text.vAlign = VAlign.TOP;

			_sliderCounter.onStartHiding.add(makeUntouchable);
			_sliderCounter.onFinishedShowing.add(makeTouchable);

			touchable = false;
		}

		private function refreshPosition():void {
			var calculatedPosition:Number = _sliderCounter.positionFactor;
			center = MonstroConsts.gameWidth / 2 + calculatedPosition * (MonstroConsts.gameWidth / 2 + width);

			alignMiddle();
		}

		private function get textToShow():String {
			return "Monstro has detected that you have progress from the old version of Monstro lying around. Would you like to try to import it?";
		}

		override public function hide():void {
            removeChildren();

            _background.dispose();
            _text.dispose();
            _importButton.dispose();

            _background = null;
            _text = null;
            _importButton = null;

            super.hide();
        }

        private function importHandler():void{
			OldProgressImporter.importProgress();
			onClose();
        }

		private function contnueGame():void{
			MonstroStateRetrocade.show();
		}

        private function onClose():void{
			_sliderCounter.hide();
        }

        override public function resize():void {
            super.resize();

            refreshPosition();
        }
    }
}