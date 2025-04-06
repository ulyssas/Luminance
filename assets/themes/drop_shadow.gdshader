shader_type canvas_item;

void fragment() {
    vec4 sum = vec4(0.0);
    float blur_size = 0.005; // ぼかしの強さ（調整可）

    // 簡易ガウシアンブラー
    for (float x = -2.0; x <= 2.0; x++) {
        for (float y = -2.0; y <= 2.0; y++) {
            sum += texture(TEXTURE, UV + vec2(x, y) * blur_size);
        }
    }
    sum /= 25.0; // 平均化してぼかす

    COLOR = sum;
}
