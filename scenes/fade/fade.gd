extends CanvasLayer

signal fade_out_finished
signal fade_in_finished

@onready var color_rect = $colorRect
var tween: Tween

func _ready():
    self.visible = false

func fade_out(duration: float = 0.5):
    self.visible = true
    color_rect.modulate.a = 0.0
    tween = create_tween()
    tween.tween_property(color_rect, "modulate:a", 1.0, duration)
    tween.tween_callback(on_fade_out_finished)

func fade_in(duration := 0.5):
    self.visible = true
    color_rect.modulate.a = 1.0
    tween = create_tween()
    tween.tween_property(color_rect, "modulate:a", 0.0, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
    tween.tween_callback(on_fade_in_finished)

func on_fade_out_finished():
    emit_signal("fade_out_finished")

func on_fade_in_finished():
    self.visible = false
    emit_signal("fade_in_finished")
