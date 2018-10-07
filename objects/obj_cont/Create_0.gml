// === Settings === //
time = 0; // starting time - can be anything
time_inc = 1; // added to time each frame => speed!
range = 50;
points = 1000;
randomize();
show_debug_overlay(true);
var _window_width = 1280,
	_window_height = 720;
// ================ //


/* === Internal: View / Camera / Display Setup === //
to hide the points wrapping room boundaries
make the room slightly larger than the window.
the camera will be the size of the window anc centered within the room!
*/
room_width=_window_width+range	
room_height=_window_height+range;
var _vp=0,
	_ww=_window_width,
	_hh=_window_height,
	_dww=display_get_width(),
	_dhh=display_get_height(),
	_cam=camera_create();
view_enabled=true; 
view_visible[0]=true; 
view_camera[0]=_cam;
camera_set_view_size(_cam,_ww,_hh);	
camera_set_view_pos(_cam,(room_width-_ww) div 2,(room_height-_hh) div 2);	// center camera in room
window_set_rectangle((_dww-_ww) div 2,(_dhh-_hh) div 2,_ww,_hh); // center window on display
surface_resize(application_surface,_ww,_hh);
display_set_gui_size(_ww,_hh);

// === Line and Vertex Buffer Setup === //
enum EProp{
	x, y, angle, size
}
var _g = ds_grid_create(points,EProp.size);
var i=0; repeat(points){
	_g[# i, EProp.x]=irandom_range(0,room_width);
	_g[# i, EProp.y]=irandom_range(0,room_height);
	_g[# i, EProp.angle] = random_range(0,359);
++i}

// define format - 2 positions (x,y,angle) + (x,y,angle);
vertex_format_begin()
vertex_format_add_position_3d();
vertex_format_add_custom(vertex_type_float3,vertex_usage_texcoord); // vertex_usages are generally broken, but this one seemed to work.
format = vertex_format_end();

line_buffer = vertex_create_buffer();
var _b = line_buffer;
vertex_begin(_b,format);

// create every connection once!
var i=0; repeat(points-1){
	var j=i+1; repeat(points-j){
		// vertex 1 - the first point defining the line
		vertex_position_3d(_b,_g[# i,EProp.x],_g[# i,EProp.y],_g[# i,EProp.angle]); // info on point1
		vertex_float3(_b,_g[# j,EProp.x],_g[# j,EProp.y],_g[# j,EProp.angle]); // info on point 2
		
		// vertex 2 - the second point defining the line
		vertex_position_3d(_b,_g[# j,EProp.x],_g[# j,EProp.y],_g[# j,EProp.angle]); // info on point2
		vertex_float3(_b,_g[# i,EProp.x],_g[# i,EProp.y],_g[# i,EProp.angle]); // info in point1
	++j}
++i}

vertex_end(_b);
vertex_freeze(_b);
ds_grid_destroy(_g);