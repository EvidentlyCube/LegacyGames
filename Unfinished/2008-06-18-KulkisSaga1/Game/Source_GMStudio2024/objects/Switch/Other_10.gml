var base, backup;
base=0
repeat (actions){
    switch(a_type[base]){
    case(0):
        switch(a_mode[base]){
            case(0):
                with(Door){
                    if (type=1 && color=other.a_t_z[base]){
                        Open_Door(id)
                    }
                }
            break;
            case(1):
                with(Door){
                    if (group=other.a_t_z[base]){
                        Open_Door(id)
                    }
                }
            break;
            case(2):
                backup=instance_place(a_t_x[base],a_t_y[base],Door)
                if instance_exists(backup){
                    with(backup){
                            Open_Door(id)
                    }
                }
            break;
        }
    break;
    case(1):
        
    break;
    case(2):
        
    break;
    }
}


//a_type[0]=0
/*--------------------Type of Action:
0 - Open Door
1 - Close Door
2 - Toggle Door*/

//a_mode[0]=0
/*--------------------Mode of Action:
For type 0,1,2:
0 - By Color
1 - By id
2 - By X,Y
*/




//a_t_x[0]=0
//a_t_y[0]=0
/*--------------------X & Y of Action:
Type 0,1,2:
    Mode 3:
        X and Y coordinates of door which is meant to be opened
*/

//a_t_z[0]=0
/*--------------------Z of Action:
Type 0,1,2:
    Mode 1:
        Color of the doors meant to be opened
    Mode 2:
        ID of the door meant to be opened
*/
/* */
/*  */
