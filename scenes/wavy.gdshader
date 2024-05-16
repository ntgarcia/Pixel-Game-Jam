shader_type canvas_item;

uniform sampler2D existing_screen_texture: hint_screen_texture, filter_linear_mipmap;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform float frequency = 100;
uniform float amplitude = 0.002;
uniform int levels = 3;
uniform float spread = 0.01;

vec3 chromatic_slice(float t) {
    vec3 res = vec3(1.0 - t, 1.0 - abs(t - 1.0), t - 1.0);
    return max(res, 0.0);
}

void fragment() {
    vec2 uv = UV;
    
    // Apply wavy effect
    vec2 wavy_uv = uv;
    wavy_uv.x += sin(uv.y * frequency + TIME) * amplitude;
    vec3 wavy_colors = textureLod(existing_screen_texture, wavy_uv, 0.0).rgb;
    
    // Apply chromatic aberration
    vec3 sum = vec3(0.0);
    vec2 offset = (uv - vec2(0.5)) * vec2(1, -1);
    for (int i = 0; i < levels; i++) {
        float t = 2.0 * float(i) / float(levels - 1); // range 0.0->2.0
        vec3 slice = chromatic_slice(t);
        sum += slice;
        vec2 slice_offset = (t - 1.0) * spread * offset;
        vec3 chromatic_colors = slice * texture(SCREEN_TEXTURE, SCREEN_UV + slice_offset).rgb;
        wavy_colors += chromatic_colors;
    }
    
    COLOR.rgb = wavy_colors;
}
