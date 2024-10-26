
SetGraphicsDriver GLMax2DDriver() 
Global GraphicsObject:TGraphics = CreateGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_DEPTH, 60, GRAPHICS_BACKBUFFER) 
SetGraphics GraphicsObject

SetBlend(AlphaBlend)
EnablePolledInput()