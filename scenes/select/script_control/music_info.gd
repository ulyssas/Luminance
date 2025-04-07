extends Panel

@export var music_name: String = "":
    set(value):
        music_name = value
        $music_name.music_name = music_name

@export var composer: String = "":
    set(value):
        composer = value
        $composer.creator_name = composer

@export var note_designer: String = "":
    set(value):
        note_designer = value
        $note_designer.creator_name = note_designer

@export var is_selected: bool = false:
    set(value):
        is_selected = value
        animated_selection()

func animated_selection():
    var tween = create_tween()
    var center_pos_x: float = (get_viewport_rect().size.x - self.size.x) / 2
    var target_x = center_pos_x if is_selected else 1000
    var target_alpha = 1.0 if is_selected else 0.0

    tween.tween_property(self, "position:x", target_x, 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    tween.parallel().tween_property($PressEnter, "modulate:a", target_alpha, 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
