shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
uniform float pixelate_amount: hint_range(2, 512, 4) = 256;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uv = floor(UV * pixelate_amount) / pixelate_amount;
	COLOR = textureLod(screen_texture, uv, 0.0);
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
