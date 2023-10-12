// NOTE: Shader automatically converted from Godot Engine 4.2.dev6's StandardMaterial3D.

shader_type spatial;
render_mode unshaded;

void vertex() {
}

void fragment() {
	//EMISSION = vec3( mix(0, 0.1, UV.y), 0, mix(0, 0.1, UV.y));
	ALBEDO.rgb = vec3(0.01, 0.01, 0.01);
}
