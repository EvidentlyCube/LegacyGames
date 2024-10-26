'This BMX file was edited with BLIde ( http://www.blide.org )

Paddle=TPaddle.MakeNew(10,100,10,50)
'For Local i:Short=0 To 100
	TBall.MakeNew(10,100,RndFloat()*360,RndFloat()*5+5,6)
'Next
CurrentRoom=New TRoom
Level.RoomsNO=1
Level.Rooms=[CurrentRoom]

TBrickBase.MakeNew(13,10,0,0)
TBrickBase.MakeNew(13,12,0,0)
TBrickBase.MakeNew(13,8,0,0)
TBrickBase.MakeNew(13,6,0,0)
TBrickBase.MakeNew(13,4,0,0)
TBrickBase.MakeNew(13,2,0,0)
TBrickBase.MakeNew(13,0,0,0)
TBrickBase.MakeNew(12,11,0,0)
TBrickBase.MakeNew(12,9,0,0)
TBrickBase.MakeNew(12,7,0,0)
TBrickBase.MakeNew(12,5,0,0)
TBrickBase.MakeNew(12,3,0,0)
TBrickBase.MakeNew(12,1,0,0)

Global FramesPerSec:Int
Global FrameCounter:Int
Global Start:Int

While Not KeyDown(KEY_ESCAPE)
	If AppSuspended()
		DrawRect(10,10,10,10)
		Flip 1
		Continue
	EndIf
	Paddle.Update()
	Lists.TraceBalls()
	Drawing.Bricks()
	Paddle.Draw()
	Drawing.Screen()
	UpdateFrameCounter()
	DrawText(FramesPerSec,1,1)
	DrawText("NO of balls:"+Lists.Balls.Count(),1,20)
	Flip 1
	Cls
Wend

Function UpdateFrameCounter()
  FrameCounter:+1
  If MilliSecs() > Start + 1000
    Start = MilliSecs()
    FramesPerSec = FrameCounter
    FrameCounter = 0
  EndIf
End Function