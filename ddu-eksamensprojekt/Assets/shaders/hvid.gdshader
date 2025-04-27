shader_type canvas_item;

// Fixed colors
const vec4 target_color = vec4(1.0, 1.0, 1.0, 1.0);  // White
const vec4 replace_color = vec4(1.0, 1.0, 1.0, 1.0); // Red

uniform float tolerance : hint_range(0, 1);

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    float dist = distance(tex_color.rgb, target_color.rgb);

    if (dist < tolerance) {
        tex_color.rgb = replace_color.rgb;
    }

    COLOR = tex_color;
}
