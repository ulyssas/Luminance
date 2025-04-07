extends ColorRect

@export var is_selected: bool = false:
    set(value):
        is_selected = value
        animated_selection()

var shader_mat: ShaderMaterial
var initial_blur_amount := 0.0
var initial_mix_amount := 0.0

func _ready():
    shader_mat = material as ShaderMaterial
    initial_blur_amount = shader_mat.get_shader_parameter("blur_amount")
    initial_mix_amount = shader_mat.get_shader_parameter("mix_amount")
    shader_mat.set_shader_parameter("blur_amount", 0.0)
    shader_mat.set_shader_parameter("mix_amount", 0.0)

func animated_selection():
    var tween = create_tween()
    var blur_target = initial_blur_amount if is_selected else 0.0
    var mix_target = initial_mix_amount if is_selected else 0.0

    tween.parallel().tween_property(shader_mat, "shader_parameter/blur_amount", blur_target, 0.4)\
        .set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    tween.parallel().tween_property(shader_mat, "shader_parameter/mix_amount", mix_target, 0.4)\
        .set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
