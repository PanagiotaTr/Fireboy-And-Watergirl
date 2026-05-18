shader_type canvas_item;

uniform vec2 light_pos_1 = vec2(300.0, 200.0);
uniform vec2 light_pos_2 = vec2(500.0, 200.0);
uniform vec2 light_pos_3 = vec2(415.0, 23.0);

uniform float radius = 70.0;
uniform float softness = 40.0;

void fragment() {
    vec2 screen_size = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 pixel_pos = SCREEN_UV * screen_size;

    float d1 = distance(pixel_pos, light_pos_1);
    float d2 = distance(pixel_pos, light_pos_2);

    float light1 = 1.0 - smoothstep(radius, radius + softness, d1);
    float light2 = 1.0 - smoothstep(radius, radius + softness, d2);

    vec2 diff3 = abs(pixel_pos - light_pos_3);
    float rect_dist = max(diff3.x / 50.0, diff3.y / 12.0);
    float light3 = 1.0 - smoothstep(1.0, 1.4, rect_dist);

    float light = max(max(light1, light2), light3);
    float alpha = 1.0 - light;

    COLOR = vec4(0.0, 0.0, 0.0, alpha);
}