/**
 * Created by Skell on 12.12.13.
 */
package net.retrocade.tacticengine.monstro.gui.windows {
	import flash.geom.Point;

	import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
	import net.retrocade.retrocamel.global.RetrocamelEventsQueue;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.core.MonstroField;
	import net.retrocade.tacticengine.core.Tile;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
	import net.retrocade.tacticengine.monstro.global.enum.EnumUnitController;
	import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroFieldRenderer;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroUnitClip;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.MonstroPlayerTurnProcess;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
	import net.retrocade.tacticengine.monstro.ingame.utils.MonstroPathmapper;
	import net.retrocade.utils.UtilsNumber;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class MonstroIntroductionTutorial extends Sprite implements IDisposable{
        public static const STATE_1_0:uint = 0;
        public static const STATE_1_1:uint = 1;
        public static const STATE_1_2:uint = 2;
        public static const STATE_1_3:uint = 3;
        public static const STATE_1_4:uint = 4;
        public static const STATE_1_5:uint = 5;

        public static const STATE_2_0:uint = 6;
        public static const STATE_2_1:uint = 7;
        public static const STATE_2_2:uint = 8;

        public static const STATE_3_0:uint = 9;
        public static const STATE_3_1:uint = 10;
        public static const STATE_3_2:uint = 11;

        public static const STATE_4_0:uint = 12;
        public static const STATE_4_1:uint = 13;

        public static const STATE_5_0:uint = 14;
        public static const STATE_5_1:uint = 15;

        public static const STATE_6_0:uint = 16;

        public static const STATE_7_0:uint = 17;
        public static const STATE_7_1:uint = 18;

        public static const STATE_8_0:uint = 19;

        [Inject]
        public var field:MonstroField;

        [Inject]
        public var fieldRenderer:MonstroFieldRenderer;

        [Inject]
        public var stateIngame:MonstroStateIngame;

        public var background:MonstroGrid9;
        public var textField:TextField;
        public var arrow:Image;

        public var currentState:uint = STATE_1_0;

        public var timer:Number = 0;

        public var tutorialLayer:RetrocamelLayerStarling;
		public var isEnabled:Boolean;
		public var fadeOut:Boolean;

		public var callbacks:Vector.<Function>;

        public function MonstroIntroductionTutorial() {
			callbacks = new <Function>[
				updateState_1_0,
				updateState_1_1,
				updateState_1_2,
				updateState_1_3,
				updateState_1_4,
				updateState_DisplayMessageForever,

				updateState_2_0,
				updateState_2_1,
				updateState_2_2,

				updateState_3_0,
				updateState_3_1,
				updateState_3_2,

				updateState_4_0,
				updateState_4_1,

				updateState_5_0,
				updateState_5_1,

				updateState_DisplayMessageForever,

				updateState_7_0,
				updateState_DisplayMessageForever,

				updateState_DisplayMessageForever
			];
		}

        public function init():void{
            tutorialLayer = new RetrocamelLayerStarling();
            tutorialLayer.add(this);

            background = MonstroGfx.getGrid9Parchment();
            textField = new TextField(200, 40, "", MonstroConsts.FONT_EBORACUM_48, 22, 0x382010);
            arrow = MonstroGfx.getArrowDown();

            textField.hAlign = HAlign.CENTER;
            textField.vAlign = VAlign.CENTER;

            addChild(background);
            addChild(textField);
            addChild(arrow);

			isEnabled = false;
			if (!field.isLoadedFromContinue && stateIngame.currentCampaignType === EnumCampaignType.INTRODUCTION){
				isEnabled = true;
				if (stateIngame.currentLevelIndex === 0){
					setState(STATE_1_0);
				} else if (stateIngame.currentLevelIndex === 1) {
					setState(STATE_2_0);
				} else if (stateIngame.currentLevelIndex === 2) {
					setState(STATE_3_0);
				} else if (stateIngame.currentLevelIndex === 3) {
					setState(STATE_4_0);
				} else if (stateIngame.currentLevelIndex === 4) {
					setState(STATE_5_0);
				} else if (stateIngame.currentLevelIndex === 5) {
					setState(STATE_6_0);
				} else if (stateIngame.currentLevelIndex === 6) {
					setState(STATE_7_0);
				} else if (stateIngame.currentLevelIndex === 7) {
					setState(STATE_8_0);
				} else {
					isEnabled = false;
				}
			}

			addEventListener(TouchEvent.TOUCH, onTouched);
			visible = isEnabled;
        }

		override public function dispose():void {
			removeChildren();

			background.dispose();
			textField.dispose();
			arrow.dispose();
			tutorialLayer.dispose();

			background = null;
			textField = null;
			arrow = null;
			tutorialLayer = null;

			field = null;
			fieldRenderer = null;

			super.dispose();
		}

        public function update():void{
			if (!isEnabled){
				return;
			}

			if (fadeOut){
				alpha -= 0.05;

				if (alpha <= 0){
					alpha = 0;
					visible = false;
				}
			}
            timer++;

			callbacks[currentState]();

            RetrocamelEventsQueue.clear();
        }

        private function updateState_1_0():void{
			setPositionToEntity(movableUnit);

            if (RetrocamelEventsQueue.occuredWith(MonstroConsts.EVENT_UNIT_SELECTED, movableUnit)){
                setState(STATE_1_1);
            }
        }

        private function updateState_1_1():void{
			setPositionToTile(field.getTileAt(4, 2));

            if (RetrocamelEventsQueue.occured(MonstroConsts.EVENT_UNIT_MOVED)){
                setState(STATE_1_2);

            } else if (RetrocamelEventsQueue.occured(MonstroConsts.EVENT_UNIT_DESELECTED)){
				setState(STATE_1_0);

			} else if (RetrocamelEventsQueue.occured(MonstroConsts.EVENT_TURN_ENDED)){
                setState(STATE_1_4);
            }
        }

		private function updateState_1_2():void{
			setPositionToMiddle();

			if (RetrocamelEventsQueue.occured(MonstroConsts.EVENT_TURN_ENDED)){
				setState(STATE_1_3);
			}
		}

        private function updateState_1_3():void{
			setPositionToMiddle();

			var playerUnit:MonstroEntity = movableUnit;
			var enemyUnit:MonstroEntity = anyEnemyUnit;

            if (MonstroPathmapper.getDistance(playerUnit.x, playerUnit.y, enemyUnit.x, enemyUnit.y, playerUnit, field) < 8 && playerUnit.getStatistics().movesLeft > 0){
                setState(STATE_1_4);
            }
        }

        private function updateState_1_4():void{
            var unitClip:MonstroUnitClip = anyEnemyUnitClip;

            if (unitClip){
                var point:Point = new Point(unitClip.width / 2, 0);
                point = unitClip.localToGlobal(point);

                setPositionTo(point.x, point.y);
            }

            if (RetrocamelEventsQueue.occuredWith(MonstroConsts.EVENT_SHOW_TILEMARKS, anyEnemyUnit)){
                setState(STATE_1_5);
            }
        }

        private function updateState_2_0():void{
			setPositionToMiddle();

			if (RetrocamelEventsQueue.occured(MonstroConsts.EVENT_TURN_ENDED)){
				visible = false;
			}

            if (RetrocamelEventsQueue.occured(MonstroConsts.EVENT_HOVERED_OVER_STATS)){
                setState(STATE_2_1);

            } else if (RetrocamelEventsQueue.occuredWith(MonstroConsts.EVENT_DEFENSE_RESTORED, anyEnemyUnit)){
				setState(STATE_2_2);
			}
        }

        private function updateState_2_1():void{
			setPositionToMiddle();

			if (RetrocamelEventsQueue.occured(MonstroConsts.EVENT_TURN_ENDED) || RetrocamelEventsQueue.occuredWith(MonstroConsts.EVENT_UNIT_DAMAGED, anyEnemyUnit)){
				visible = false;
			}

			if (RetrocamelEventsQueue.occuredWith(MonstroConsts.EVENT_DEFENSE_RESTORED, anyEnemyUnit)){
				setState(STATE_2_2);
			}
        }

        private function updateState_2_2():void{
			setPositionToMiddle();
        }

        private function updateState_3_0():void{
			setPositionToMiddle();

			var playerUnit:MonstroEntity = anyPlayerUnit;
			var distanceFirst:uint = MonstroPathmapper.getDistance(playerUnit.x, playerUnit.y, 6, 2, playerUnit, field);
			var distanceSecond:uint = MonstroPathmapper.getDistance(playerUnit.x, playerUnit.y, 3, 5, playerUnit, field);

			if (distanceFirst > playerUnit.getStatistics().movesLeft && distanceSecond > playerUnit.getStatistics().movesLeft){
				setState(STATE_3_1);
			}

			if (RetrocamelEventsQueue.occured(MonstroConsts.EVENT_TURN_ENDED)){
				if ((playerUnit.x === 6 && playerUnit.y === 2) || (playerUnit.x === 3 && playerUnit.y === 5)){
					setState(STATE_3_2);
				} else {
					setState(STATE_3_1);
				}
			}
        }

        private function updateState_3_1():void{
			setPositionToMiddle();

			var playerUnit:MonstroEntity = anyPlayerUnit;
			var distanceFirst:uint = MonstroPathmapper.getDistance(playerUnit.x, playerUnit.y, 6, 2, playerUnit, field);
			var distanceSecond:uint = MonstroPathmapper.getDistance(playerUnit.x, playerUnit.y, 3, 5, playerUnit, field);

			if (playerUnit.hasMoved || playerUnit.statusIsStunned || !isPlayerTurn){
				return;
			}

			if (distanceFirst <= playerUnit.getStatistics().movesLeft && distanceSecond <= playerUnit.getStatistics().movesLeft){
				setState(STATE_3_0);
			}
        }

        private function updateState_3_2():void{
			setPositionToMiddle();
        }

        private function updateState_4_0():void{
			setPositionToEntity(fakeWall);

			if (RetrocamelEventsQueue.occuredWith(MonstroConsts.EVENT_UNIT_KILLED, fakeWall)){
				setState(STATE_4_1);
			}
        }

		private function updateState_4_1():void{
			setPositionToMiddle();
		}

		private function updateState_5_0():void {
			setPositionToMiddle();

			var archer:MonstroEntity = archerUnit;
			for each (var entity:MonstroEntity in field.getAllEntities()) {
				if (entity.controlledBy.isEnemy()) {
					if (UtilsNumber.distanceManhattan(archer.x, archer.y, entity.x, entity.y) < archer.getStatistics().attackRangeMax) {
						setState(STATE_5_1);
						return;
					}
				}
			}
		}

		private function updateState_5_1():void{
			setPositionToMiddle();

			if (RetrocamelEventsQueue.occuredWith(MonstroConsts.EVENT_UNIT_ATTACKED_OTHER_UNIT, archerUnit)){
				visible = false;
			}
		}

		private function updateState_7_0():void{
			setPositionToEntity(anyPlayerUnit);

			if (RetrocamelEventsQueue.occured(MonstroConsts.EVENT_SHOWN_STATS_FOR_SPECIALIZATION)){
				setState(STATE_7_1)
			}
		}

		private function updateState_DisplayMessageForever():void{
			setPositionToMiddle();
		}

        private function setState(state:uint):void{
            currentState = state;
			arrow.visible = true;
            setTextTo(_("tut.step_" + state));

			fadeOut = false;
			alpha = 1;
			visible = true;

            update();
        }

        private function setPositionTo(x:Number, y:Number):void{
            arrow.center = x;
            arrow.bottom = y - 10 + Math.cos(timer / 5) * 3;
            textField.center = x;
            textField.bottom = y - 20;
            background.x = textField.x - 5;
            background.y = textField.y - 5;
        }

        private function setPositionToEntity(entity:MonstroEntity):void{
			if (entity){
				setPositionToTile(entity.tile);
			}
        }

        private function setPositionToTile(tile:Tile):void{
			var tileImage:Image = fieldRenderer.getTileImageForTile(tile);

			if (tileImage){
				var point:Point = new Point(tileImage.width / 2,  0);
				point = tileImage.localToGlobal(point);

				setPositionTo(point.x, point.y);
			}
        }

		private function setPositionToMiddle():void {
			setPositionTo(MonstroConsts.gameWidth / 2, background.height + 30 + Math.cos(timer / 20) * 8);
			arrow.visible = false;
		}

        private function setTextTo(text:String):void{
            if (!text || text.length === 0){
                textField.visible = false;
                background.visible = false;
            } else {
                textField.visible = true;
                background.visible = true;

                textField.text = text;
                textField.width = MonstroConsts.gameWidth / 2;
                textField.height = MonstroConsts.gameHeight / 2;

                var textFieldWidth:Number = textField.textWidth;
                var textFieldHeight:Number = textField.textHeight;

                textField.width = textFieldWidth + 35;
                textField.height = textFieldHeight + 35;

                background.width = textField.width + 15;
                background.height = textField.height + 15;
            }
        }

        private function get movableUnit():MonstroEntity{
            for each(var unit:MonstroEntity in field.getAllEntities()){
                if (unit && unit.controlledBy === EnumUnitController.PLAYER && unit.hasMoved == false){
                    return unit;
                }
            }

            return null;
        }

        private function get anyPlayerUnit():MonstroEntity{
            for each(var unit:MonstroEntity in field.getAllEntities()){
                if (unit && unit.controlledBy.isPlayer()){
                    return unit;
                }
            }

            return null;
        }

        private function get anyEnemyUnit():MonstroEntity{
            for each(var unit:MonstroEntity in field.getAllEntities()){
                if (unit && unit.controlledBy.isEnemy()){
                    return unit;
                }
            }

            return null;
        }

        private function get anyEnemyUnitClip():MonstroUnitClip{
            for each(var unit:MonstroEntity in field.getAllEntities()){
                if (unit && unit.controlledBy.isEnemy()){
					return fieldRenderer.getUnitClipForEntity(unit);
                }
            }

            return null;
        }

        private function get fakeWall():MonstroEntity{
            for each(var unit:MonstroEntity in field.getAllEntities()){
                if (unit && unit.unitType === EnumUnitType.FAKE_WALL){
                    return unit;
                }
            }

            return null;
        }

        private function get archerUnit():MonstroEntity{
            for each(var unit:MonstroEntity in field.getAllEntities()){
                if (unit && unit.unitType === EnumUnitType.ARCHER){
                    return unit;
                }
            }

            return null;
        }

		private function get isPlayerTurn():Boolean{
			return stateIngame.processManager.currentProcess is MonstroPlayerTurnProcess;
		}

		final protected function onTouched(event:TouchEvent):void {
			var touch:Touch = event.getTouch(this);

			if (touch && touch.phase == TouchPhase.ENDED) {
				fadeOut = true;
				event.stopImmediatePropagation();
			}
		}
    }
}
