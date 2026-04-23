shader_type canvas_item;

uniform vec2 light_pos_1 = vec2(300.0, 200.0);
uniform vec2 light_pos_2 = vec2(500.0, 200.0);

uniform float radius = 70.0;
uniform float softness = 40.0;

void fragment() {
    vec2 screen_size = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 pixel_pos = SCREEN_UV * screen_size;

    float d1 = distance(pixel_pos, light_pos_1);
    float d2 = distance(pixel_pos, light_pos_2);

    float light1 = 1.0 - smoothstep(radius, radius + softness, d1);
    float light2 = 1.0 - smoothstep(radius, radius + softness, d2);

    float light = max(light1, light2);
    float alpha = 1.0 - light;

    COLOR = vec4(0.0, 0.0, 0.0, alpha);
}