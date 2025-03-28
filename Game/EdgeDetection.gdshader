shader_type spatial;
render_mode unshaded, depth_draw_opaque;

// Outline color and thickness
uniform vec3 shadow_color : source_color = vec3(0.0);
uniform float shadow_thickness = 1.5; 

// Viewport texture of the entire scene
uniform sampler2D VIEWPORT_TEXTURE;  

void fragment() {
    // Map the UVs of the mesh to screen space
    vec2 uv = SCREEN_UV;

    vec2 e = vec2(1.0 / VIEWPORT_SIZE.x, 1.0 / VIEWPORT_SIZE.y);
    float outline = 0.0;

    vec3 color = texture(VIEWPORT_TEXTURE, uv).rgb;

    for (float x = -shadow_thickness; x <= shadow_thickness; x += 1.0) {
        for (float y = -shadow_thickness; y <= shadow_thickness; y += 1.0) {
            if (x == 0.0 && y == 0.0) continue;

            vec3 neighbor = texture(VIEWPORT_TEXTURE, uv + vec2(x, y) * e).rgb;
            
            // Basic color difference outline detection
            float diff = length(color - neighbor);
            
            outline = max(outline, diff);
        }
    }

    outline = smoothstep(0.05, 0.15, outline);

    // Mix outline with the scene color
    vec3 final_color = mix(color, shadow_color, outline);
    
    ALBEDO = final_color;
    ALPHA = 1.0;
}
