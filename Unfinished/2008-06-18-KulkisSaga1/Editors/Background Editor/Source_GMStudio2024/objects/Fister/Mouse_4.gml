switch(global.hihi){
case(0):
    var sasa;
    file_bin_seek(global.file,koko)
    sasa=file_bin_read_byte(global.file)
    lev=get_integer("Level",sasa)
    file_bin_seek(global.file,koko)
    file_bin_write_byte(global.file,lev)
break;
case(1):
    var sasa;
    file_bin_seek(global.file,koko+928+928+928)
    sasa=file_bin_read_byte(global.file)
    va=get_integer("Variable A",sasa)
    file_bin_seek(global.file,koko+928+928+928)
    file_bin_write_byte(global.file,va)
break;
case(2):
    var sasa;
    file_bin_seek(global.file,koko+928+928+928+928)
    sasa=file_bin_read_byte(global.file)
    vb=get_integer("Variable B",sasa)
    file_bin_seek(global.file,koko+928+928+928+928)
    file_bin_write_byte(global.file,vb)
break;
case(3):
    var sasa;
    file_bin_seek(global.file,koko+928+928+928+928+928)
    sasa=file_bin_read_byte(global.file)
    vb=get_integer("Variable C",sasa)
    file_bin_seek(global.file,koko+928+928+928+928+928)
    file_bin_write_byte(global.file,vb)
break;
}

/*
file_bin_seek(global.file,koko)
lev=file_bin_read_byte(global.file)
file_bin_seek(global.file,koko+928+928+928)
va=file_bin_read_byte(global.file)
file_bin_seek(global.file,koko+928+928+928+928)
vb=file_bin_read_byte(global.file)
file_bin_seek(global.file,koko+928+928+928+928+928)
vc=file_bin_read_byte(global.file)
/* */
/*  */
