Graphics 1024,768

SetBlend(ALPHABLEND)
While True 
	If KeyHit(KEY_ESCAPE)
		If D_Changes=0
			End
		Else
			If Confirm("There are unsaved changes. Are you sure you want to continue?")
				End
			End If
		EndIf
	EndIf
	mHit1=MouseHit(1)
	mHit2=MouseHit(2)
	SetColor(255,255,255)
	DrawImage(GFX_HUD,0,0)
	TOption.Hover()
	TOColor.Hover()
	TCurrBlock.Hover()
	TSetValues.Hover()
	TColorBar.Hover()
	TOGroup.Hover()
	CheckOpts()
	TGameField.Hover()
	TBlock.Draws()
	TColValue.Hover()
	TGroupValue.Hover()
	TLayer.Hover()
	DrawDesc()
	DrawGrid()
	Flip
	Cls
Wend