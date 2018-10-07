///@desc control
range+=keyboard_check(vk_up)-keyboard_check(vk_down);
range=max(0,range);

time_inc+=0.1*(keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left))

var _cn = (points-1)/2*points;
draw_text(3,20,cstring(
	"time_inc [left/right]:", time_inc,
	"\nrange [up/down]:",range, 
	"\npoints: ",points, 
	"\nconnections: ",_cn,));
draw_sprite(spr_ariak,0,display_get_gui_width(),display_get_gui_height());