extends Control

signal index_changed

var disabled: bool = true:
    set(value):
        disabled = value
        update_visuals()

var child_count: int = 4
var current_index: int = 0

var cursor_origin: Vector2

func _ready():
    child_count = $Container.get_child_count()
    cursor_origin = $Cursor.position
    $Cursor.visible = false

func _unhandled_input(event):
    if disabled:
        return

    if event.is_action_pressed("lane_3"):
        change_index((current_index + 1) % child_count)

    elif event.is_action_pressed("lane_2"):
        change_index((current_index - 1 + child_count) % child_count)

func change_index(new_index: int):
    if disabled or new_index == current_index:
        return

    current_index = new_index
    index_changed.emit()

    update_visuals()

func update_visuals():
    var margin_x = $Container.get_theme_constant("separation")
    var element_size_x = $Container/easy.size.x
    var offset = (element_size_x + margin_x) * current_index

    $Cursor.visible = !disabled
    $Cursor.position.x = cursor_origin.x+offset
    $Cursor.trigger_spin()
