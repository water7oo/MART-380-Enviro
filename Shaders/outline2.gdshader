shader_type canvas_item;
render_mode world_vertex_coords;

uniform int pixel_size = 8;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

varying vec2 world_pos;

void vertex() {
	world_pos = VERTEX;
}

void fragment() {
	vec2 texture_size = vec2(textureSize(screen_texture, 0));
	vec2 screen_position = world_pos - SCREEN_UV * texture_size;
	vec2 pixel = vec2(ivec2(world_pos / float(pixel_size)));
	vec2 relative_pixel = pixel - screen_position / float(pixel_size);
	vec2 pixel_uv = relative_pixel / (texture_size / float(pixel_size)) ;

	vec4 c = textureLod(screen_texture, pixel_uv, 0);

	if (c.a > 0.0001) {
		c.rgb /= c.a;
	}
	COLOR *= c;
}