shader_type spatial;
render_mode unshaded;

uniform sampler2D refl_tx : source_color;

void fragment() {
	vec2 uv = vec2(1.0 - SCREEN_UV.x, SCREEN_UV.y);
	ALBEDO = texture(refl_tx, uv).rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
