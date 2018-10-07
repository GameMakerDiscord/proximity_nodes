time+=time_inc;

var _r = range;
// _r*=(1+dsin(time))/2; // uncomment to make the range depend in time and interpolate between 0 and 1

shader_set(shd_line);
shader_set_uniform_f(shader_get_uniform(shd_line,"time"),time);
shader_set_uniform_f(shader_get_uniform(shd_line,"boundary"),room_width,room_height);
shader_set_uniform_f(shader_get_uniform(shd_line,"range"),_r);
shader_set_uniform_f(shader_get_uniform(shd_line,"depth"),depth); // since the Z coordinate is used for the angle, set it here as a uniform!
/*
var _col = make_color_hsv(time mod 360,255,255),
    r = _col & $ff,            // Red [0-255]  
    g = (_col >> 8) & $ff,     // Green [0-255]    
    b = (_col >> 16) & $ff;    // Blue [0-255] 
shader_set_uniform_f(shader_get_uniform(shd_line,"col"),r/255,g/255,b/255);
*/
shader_set_uniform_f(shader_get_uniform(shd_line,"col"),127/255,167/255,255/255);
vertex_submit(line_buffer,pr_linelist,-1);
shader_reset();