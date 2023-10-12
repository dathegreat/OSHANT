// NOTE: Shader automatically converted from Godot Engine 4.2.dev6's StandardMaterial3D.

shader_type spatial;


void vertex() {
}

void fragment() {
	EMISSION = vec3( 0, 0, mix(0, 1, UV.y));
	ALBEDO.rgb = vec3(0.5, 0.5, 0.5);
}
