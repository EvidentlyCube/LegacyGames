a-=0.025+(abs(a/1000))
if a>0{draw_set_color(c_white)
draw_set_alpha(a)
draw_rectangle(0,0,400,400,0)}
if a<-1{
draw_set_color(c_black)
draw_set_alpha(abs(a+1))
draw_rectangle(0,0,400,400,0)
}
if a<-2{game_end()}
