package com.mauft.Editor{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    public class WindowOptions extends Sprite{
        internal static var layers:Array=new Array
        internal static var items:Array=new Array
        internal static var currentLayer:Layer
        internal static var pen:Pen=new PenPlotter
        internal static var overwrite:Boolean=true
        
        internal static var penPlotter:Button=new Button("Pen: Plotter", "Allows you to 'plot'. In other words it draws exactly where you click!")
        internal static var penEraser:Button=new Button("Pen: Eraser", "Removes all items on the selected layer which are under the mouse pointer.")
        internal static var penLiner:Button=new Button("Pen: Line Tool", "Allows you to draw continously")
        internal static var penRectangle:Button=new Button("Pen: Rectangle Tool", "Allows you to fill rectangular areas")
        
        public function WindowOptions(){
            graphics.beginFill(0x333333)
            graphics.drawRect(0, 0, Editor.stage.stageWidth, 184)
            
            penPlotter.x=150
            penEraser.x=150
            penLiner.x=150
            penRectangle.x=150
            penPlotter.y=20
            penEraser.y=40
            penLiner.y=60
            penRectangle.y=80
            
            penPlotter.addEventListener(MouseEvent.CLICK, function():void{
                pen.remove()
                pen=new PenPlotter()
                pen.add()
            })
            penEraser.addEventListener(MouseEvent.CLICK, function():void{
                pen.remove()
                pen=new PenEraser()
                pen.add()
            })
            penLiner.addEventListener(MouseEvent.CLICK, function():void{
                pen.remove()
                pen=new PenLiner()
                pen.add()
            })
            penRectangle.addEventListener(MouseEvent.CLICK, function():void{
                pen.remove()
                pen=new PenRectangle()
                pen.add()
            })
            
            addChild(penPlotter)
            addChild(penEraser)
            addChild(penLiner)
            addChild(penRectangle)
        }
        
        internal function addLayer(lay:Layer):void{
            var newButt:Button=new Button("Select Layer "+(layers.length+1).toString())
            newButt.tempObject=lay
            newButt.x=20
            newButt.y=20+layers.length*30
            newButt.addEventListener(MouseEvent.CLICK, function():void{
                Editor.selectLayer(newButt.tempObject as Layer)
            })
            layers.push(newButt)
            addChild(newButt)
        }
        internal function addItem(it:Item):void{
            items.push(it)
        }
        
    }
}