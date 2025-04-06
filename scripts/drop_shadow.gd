@tool
extends Label

@export_range(-20, 20) var offset_x: float = 0
@export_range(-20, 20) var offset_y: float = 0
@export_range(0, 10) var blur_amount: float = 0
@export_range(0, 10) var opacity: float = 0


func _process(delta: float) -> void:
    material.set_shader_parameter("offsetX", offset_x)
    material.set_shader_parameter("offsetY", offset_y)
    material.set_shader_parameter("blurAmount", blur_amount)
    material.set_shader_parameter("opacity", opacity)
