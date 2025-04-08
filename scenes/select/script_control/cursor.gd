extends Control

@onready var part1 = $cursor_1
@onready var part2 = $cursor_2

# 中央の点滅
@export var blink_speed: float = 0.5  # 点滅の速さ（Hz）
@export var blink_amplitude: float = 0.2  # 明滅の強さ
@export var blink_offset: float = 0.5  # 最小アルファ値（0にすると完全に消える）

var tween: Tween

func _ready():
    tween = create_tween()
    tween.kill()

func _process(delta):
    if not visible:
        return

    var time = Time.get_ticks_msec() / 1000.0
    var alpha = sin(time * PI * 2.0 * blink_speed) * blink_amplitude + blink_offset
    $Center.modulate.a = clamp(alpha, 0.0, 1.0)

func trigger_spin():
    # アニメーション中なら一度止める
    if tween.is_running():
        tween.kill()

    tween = create_tween()

    var rotate_1 = deg_to_rad(-60)
    var rotate_2 = deg_to_rad(-180)

    # 回転
    tween.tween_property(part1, "rotation", rotate_1, 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
    tween.parallel().tween_property(part2, "rotation", rotate_2, 0.1).set_trans(Tween.TRANS_SINE)

    # 戻す
    tween.tween_property(part1, "rotation", 0.0, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
    tween.parallel().tween_property(part2, "rotation", 0.0, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
