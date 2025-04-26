extends Control

signal index_changed

var disabled: bool = true:
    set(value):
        disabled = value
        update_visuals()

var is_visible: bool = true:
    set(value):
        is_visible = value
        toggle_visibility()
        update_visuals()

var child_count: int = 4 # デフォルト、_readyで変更
var current_index: int = 0

func _ready():
    child_count = $Container.get_child_count()
    $Cursor.visible = false
    toggle_visibility()

func _unhandled_input(event):
    if disabled:
        return

    if event.is_action_pressed("lane_3"):
        change_index((current_index + 1))

    elif event.is_action_pressed("lane_2"):
        change_index((current_index - 1))

func change_index(new_index: int):
    if disabled or new_index == current_index:
        return

    new_index = clamp(new_index, 0, child_count-1)
    current_index = new_index
    index_changed.emit()

    update_visuals()

func toggle_visibility():
    var tween = create_tween()
    var target_alpha = 1.0 if is_visible else 0.0
    tween.parallel().tween_property(self, "modulate:a", target_alpha, 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

func update_visuals():
    var offset = get_cursor_offset()

    $Cursor.visible = !disabled
    $Cursor.position.x = get_cursor_init()+offset
    $Cursor.trigger_spin()

func get_cursor_init():
    var margin_x = $Container.get_theme_constant("separation")
    var element_size_x = $Container.get_child(0).size.x
    var items_width = (element_size_x+margin_x)*child_count - margin_x
    var first_element_center = ($Container.size.x-items_width+element_size_x)/2
    return first_element_center-$Cursor.size.x/2

func get_cursor_offset() -> float:
    var margin_x = $Container.get_theme_constant("separation")
    var element_size_x = $Container.get_child(0).size.x
    return (element_size_x + margin_x) * current_index
