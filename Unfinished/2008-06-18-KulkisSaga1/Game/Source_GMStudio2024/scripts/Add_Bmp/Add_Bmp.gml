function Add_Bmp(filename, imgnumb, isPrecise, isTransparent, isSmooth, preload, origX, origY) {
	/*Add Sprite From Lightly Coded BMP file
	Add_Bmp(filename,imgnumb,precise,transparent,smooth,preload,xorig,yorig)
	filename - path to the designated file
	imgnumb - Number of images
	precise - Precise collision checking?
	transparent - is transparent?
	smooth - smooth edges?
	preload - preload?
	xorig & yorig - x and y origin
	*/
	var bin_file, sprite_shortcut, path;
	path="./gfx/"+filename;
	bin_file=file_bin_open(path,2)
	file_bin_seek(bin_file,0)
	file_bin_write_byte(bin_file,66)
	file_bin_seek(bin_file,1)
	file_bin_write_byte(bin_file,77)
	file_bin_close(bin_file)
	file_rename(path,filename_change_ext(path,".bmp"))
	sprite_shortcut=sprite_add(
		filename_change_ext(path, ".bmp"),
		imgnumb,
		isTransparent,
		isSmooth,
		origX,
		origY
	)
	file_rename(filename_change_ext(path,".bmp"),path)
	bin_file=file_bin_open(path,2)
	file_bin_seek(bin_file,0)
	file_bin_write_byte(bin_file,65)
	file_bin_seek(bin_file,1)
	file_bin_write_byte(bin_file,76)
	file_bin_close(bin_file)
	return(sprite_shortcut)



}
