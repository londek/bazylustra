shader_type spatial;

uniform sampler2D mask_texture: hint_screen_texture;
uniform vec4 albedo_a: hint_color = vec4(1.0);
uniform sampler2D texture_a: hint_screen_texture;
uniform vec4 albedo_b:hint_color = vec4(1.0);
uniform sampler2D texture_b: hint_screen_texture;

void fragment() {
	vec3 mask = texture(mask_texture, UV).rgb;
	vec3 a = albedo_a.rgb * texture(texture_a, UV).rgb;
	vec3 b = albedo_b.rgb * texture(texture_b, UV).rgb;
	vec3 color = mix(a, b, mask);
	ALBEDO = color;
}