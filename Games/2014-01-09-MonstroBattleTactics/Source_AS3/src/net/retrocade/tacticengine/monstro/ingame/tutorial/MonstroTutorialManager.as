
package net.retrocade.tacticengine.monstro.ingame.tutorial {
    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.global.core.MonstroData;
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
    import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLevelLoaded;
    import net.retrocade.tacticengine.monstro.ingame.tutorial.cards.MonstroTutorialCardBase;
    import net.retrocade.tacticengine.monstro.ingame.tutorial.cards.MonstroTutorialCardGenerator;

    import starling.display.Sprite;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    final public class MonstroTutorialManager extends Sprite implements IDisposable, IRetrocamelUpdatable {
        [Inject]
        public var field:MonstroField;
        [Inject]
        public var ingameState:MonstroStateIngame;

        private var _cards:Vector.<MonstroTutorialCardBase>;
        private var _cardsUpdatable:Vector.<MonstroTutorialCardBase>;
        private var _isCardFadingOut:Boolean = false;
        private var _currentCard:MonstroTutorialCardBase;

        public function MonstroTutorialManager() {
        }

        public function init():void {
            _cards = new Vector.<MonstroTutorialCardBase>();
            _cardsUpdatable = new Vector.<MonstroTutorialCardBase>();

            Eventer.listen(MonstroEventLevelLoaded.NAME, showCards, this);

            addEventListener(TouchEvent.TOUCH, onTouched);
        }

        override public function dispose():void {
            field = null;
            ingameState = null;

            removeChildren();

            for each(var card:MonstroTutorialCardBase in _cards) {
                card.dispose();
            }

            _cards.length = 0;
            _cards = null;

            _cardsUpdatable.length = 0;
            _cards = null;

            _currentCard = null;

            removeEventListener(TouchEvent.TOUCH, onTouched);
			Eventer.releaseContext(this);

            super.dispose();
        }

        public function update():void {
            if (ingameState.currentCampaignType === EnumCampaignType.HUMAN && ingameState.currentLevelIndex === 0){
                visible = false;
                return;
            } else {
                visible = true;
            }

            if (_currentCard) {
                _currentCard.update();

                if (_isCardFadingOut) {
                    _currentCard.alpha -= 0.06;

                    if (_currentCard.alpha <= 0) {
                        switchToNextCard();
                    }
                } else if (_currentCard.alpha < 1) {
                    _currentCard.alpha += 0.06;
                }

                if (_currentCard && !_isCardFadingOut && _currentCard.checkIfHide()) {
                    _isCardFadingOut = true;
                }
            }

            for each(var newCard:MonstroTutorialCardBase in _cardsUpdatable) {
                if (newCard != _currentCard) {
                    if (newCard.update()) {
                        removeCardFromUpdatable(newCard);

                        showCard(newCard);

                        if (_cards.length == 1) {
                            switchToNextCard();
                        }
                    }
                }
            }

            // rEvents.clear();
        }

        final protected function onTouched(event:TouchEvent):void {
            var touch:Touch = event.getTouch(this);

            if (touch && touch.phase == TouchPhase.ENDED) {
                _isCardFadingOut = true;
                event.stopImmediatePropagation();
            }
        }

        private function showCards():void {
            var cardDefinitions:Vector.<MonstroTutorialCardBase> = MonstroTutorialCardGenerator(field);

            for (var i:int = 0; i < cardDefinitions.length; i++) {
                var cardDefinition:MonstroTutorialCardBase = cardDefinitions[i];

                if (!MonstroData.getTutorialCompletion(cardDefinition.id)) {
                    if (cardDefinition.checkIfAppear()) {
                        showCard(cardDefinition);
                    }

                    if (cardDefinition.requiresConstantUpdate) {
                        _cardsUpdatable.push(cardDefinition);
                    }
                }
            }

            switchToNextCard();
        }

        private function showCard(card:MonstroTutorialCardBase):void {
            _cards.push(card);
            addChild(card);
        }

        private function switchToNextCard():void {
            _isCardFadingOut = false;

            if (_currentCard) {
                _currentCard.onHide();
                removeCardFromUpdatable(_currentCard);

                MonstroData.setTutorialCompletion(_currentCard.id, true);

                _currentCard.dispose();
                removeChild(_currentCard);
            }

            _currentCard = null;

            if (_cards.length > 0) {
                _currentCard = _cards.shift();
                _currentCard.visible = true;
                _currentCard.alpha = 0;
                _currentCard.onAppear();
            }
        }

        private function removeCardFromUpdatable(cardDefinition:MonstroTutorialCardBase):void {
            var index:int = _cardsUpdatable.indexOf(cardDefinition);

            if (index !== -1) {
                _cardsUpdatable.splice(index, 1);
            }
        }
    }
}
