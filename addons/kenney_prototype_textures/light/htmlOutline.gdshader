shader_type spatial;
render_mode unshaded;

uniform vec4 base_color : source_color = vec4(1.0);
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float edge_thickness : hint_range(0.0, 0.1) = 0.02;

void fragment() {
    float u = UV.x;
    float v = UV.y;

    float edge = smoothstep(0.0, edge_thickness, u) +
                 smoothstep(1.0, 1.0 - edge_thickness, u) +
                 smoothstep(0.0, edge_thickness, v) +
                 smoothstep(1.0, 1.0 - edge_thickness, v);

    if (edge > 0.0) {
        ALBEDO = outline_color.rgb;
        ALPHA = outline_color.a;
    } else {
        ALBEDO = base_color.rgb;
        ALPHA = base_color.a;
    }
}
