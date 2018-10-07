//
// Simple passthrough vertex shader
//
attribute vec3 in_Position; // x,y,z of point1 where we passed the ANGLE instead of Z (depth)
attribute vec3 oPos; // x,y,z of point2 where we passed the ANGLE instead of Z (depth)

uniform float time;
uniform float range; // max length to form connections
uniform vec2 boundary; // used to wrap points to the room!
uniform vec3 col; // what color to use
uniform float depth;

varying vec4 v_vColour;

void main()
{
	// First Point
	vec2 v1 = vec2(sin(in_Position.z),cos(in_Position.z)); // decode angle to x/y vector
	vec2 pos = mod(in_Position.xy + time * v1, boundary);	// add speeds (v1) * time to original position and wrap to room!
	// Second Point
	vec2 v2 = vec2(sin(oPos.z),cos(oPos.z));
	vec2 opos = mod(oPos.xy + time * v2, boundary);
	
	// get range between the two points - scaled for use with alpha
	float alpha = (range - distance(pos,opos)) / range; // [-infinity,1]
	
	if (alpha > 0.0) { // only run fragment shader if within range (0,1]
		vec4 object_space_pos = vec4( pos, depth, 1.0);
	    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	    v_vColour = vec4(col,alpha);
	}
}
