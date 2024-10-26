package com.mauft.Editor{
    import com.adobe.utils.ArrayUtil;
    
    import flash.display.Sprite;
    
    public class Layer    {
        private static var num:uint=0
        internal var id:uint
        internal var display:Sprite
        internal var arr:Array
        
        internal var gridForced:Boolean
        internal var gridWidth:uint
        internal var gridHeight:uint
        public function Layer(_gridForced:Boolean, _gridWidth:uint, _gridHeight:uint){
            num++
            id=num
            display=new Sprite
            
            gridForced=_gridForced
            gridWidth=_gridWidth
            gridHeight=_gridHeight
            
            if (gridForced){
                arr=new Array()//(Editor.levelW*Editor.levelH)
            } else {
                arr=new Array()
            }
            
            Editor.newLayer(this)
        }
        
        public function drawItem(i:Item, x:Number, y:Number):void{
            var f:FieldItem=overwrite(i, x, y)
            while (f){
                if (WindowOptions.overwrite){
                    ArrayUtil.removeValueFromArray(arr, f)
                    display.removeChild(f)
                } else {
                    WindowHelp.SetText("Cannot draw here! This place is occupied by other object/tile and the Overwrite mode is turned off! Please turn the overwirte mode ON or use the Eraser tool!")
                    return
                }
                f=overwrite(i, x, y)
            }
            f=new FieldItem(i, x, y)
            display.addChild(f)
            arr.push(f)
            
            return
            
            if (gridForced){
                x=Math.floor(x/gridWidth)*gridWidth
                y=Math.floor(y/gridHeight)*gridHeight
                if (arr[x/gridWidth+Editor.levelW*y/gridHeight]){
                    if (WindowOptions.overwrite){
                        display.removeChild(arr[x/gridWidth+Editor.levelW*y/gridHeight])
                    } else {
                        WindowHelp.SetText("Cannot draw here! This place is occupied by other object/tile and the Overwrite mode is turned off! Please turn the overwirte mode ON or use the Eraser tool!")
                    }
                }
                arr[x/gridWidth+Editor.levelW*y/gridHeight]=new FieldItem(i, x, y)
                display.addChild(arr[x/gridWidth+Editor.levelW*y/gridHeight])
            } else {
                var f:FieldItem=overwrite(i, x, y)
                if (f){
                    if (WindowOptions.overwrite){
                        ArrayUtil.removeValueFromArray(arr, f)
                        display.removeChild(f)
                    } else {
                        WindowHelp.SetText("Cannot draw here! This place is occupied by other object/tile and the Overwrite mode is turned off! Please turn the overwirte mode ON or use the Eraser tool!")
                        return
                    }
                }
                f=new FieldItem(i, x, y)
                display.addChild(f)
                arr.push(f)
            }
        }
        public function clearItem(x:Number, y:Number):void{
            var f:FieldItem
            var tempX:Number
            var tempY:Number
            for (var i:int=arr.length-1; i>=0; i--){
                f=arr[i]
                tempX=f.x-x
                tempY=f.y-y
                if (tempX>-f.guru.w && tempX<1 && tempY>-f.guru.h && tempY<1){
                    display.removeChild(f)
                    ArrayUtil.removeValueFromArray(arr, f)
                }
            }
            
            return
            if (gridForced){
                x=Math.floor(x/gridWidth)
                y=Math.floor(y/gridHeight)
                if (arr[x+Editor.levelW*y]){
                    display.removeChild(arr[x+Editor.levelW*y])
                }
                arr[x+Editor.levelW*y]=null
            } else {
                var f:FieldItem
                var tempX:Number
                var tempY:Number
                for (var i:int=arr.length-1; i>=0; i--){
                    f=arr[i]
                    tempX=f.x-x
                    tempY=f.y-y
                    if (tempX>-f.guru.w && tempX<1 && tempY>-f.guru.h && tempY<1){
                        display.removeChild(f)
                        ArrayUtil.removeValueFromArray(arr, f)
                    }
                }
            }
        }
        private function overwrite(it:Item, x:Number, y:Number):FieldItem{
            if (!it.solid){return null}
            var f:FieldItem
            var tempX:Number
            var tempY:Number
            for (var i:int=arr.length-1; i>=0; i--){
                f=arr[i]
                if (!f.guru.solid){continue}
                tempX=f.x-x
                tempY=f.y-y
                if (tempX>-f.guru.w && tempX<it.w && tempY>-f.guru.h && tempY<it.h){
                    return f;
                }
            }
            return null;
        }
    }
}