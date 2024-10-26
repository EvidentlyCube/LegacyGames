package com.mauft{
    import flash.display.InteractiveObject;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class EventUtils{
        public static function basic(object:InteractiveObject, step:Function = null, rollOver:Function = null, rollOut:Function = null, click:Function = null):void{
            if (step     != null){ object.addEventListener(Event.     ENTER_FRAME, step);                       }
            if (rollOver != null){ object.addEventListener(MouseEvent.ROLL_OVER,   rollOver, false, 0, true);   }
            if (rollOut  != null){ object.addEventListener(MouseEvent.ROLL_OUT,    rollOut,  false, 0, true );  }
            if (click    != null){ object.addEventListener(MouseEvent.CLICK,       click,    false, 0, true);   }
            
            var removedFromStage:Function = function():void
            { 
                if (step     != null){ object.removeEventListener(Event.     ENTER_FRAME, step);     }
                if (rollOver != null){ object.removeEventListener(MouseEvent.ROLL_OVER,   rollOver); }
                if (rollOut  != null){ object.removeEventListener(MouseEvent.ROLL_OUT,    rollOut);  }
                if (click    != null){ object.removeEventListener(MouseEvent.CLICK,       click);    }
            };
            
            //object.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage, false, 0, true); 
        }
    }
}

