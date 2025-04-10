extends Node

var music_player: AudioStreamPlayer
var se_pool: Node

func _ready():
    music_player = AudioStreamPlayer.new()
    music_player.name = "MusicPlayer"
    music_player.bus = "Music"
    music_player.autoplay = false
    add_child(music_player)

    se_pool = Node.new()
    se_pool.name = "SEPlayerPool"
    add_child(se_pool)

func play_music(stream: AudioStream):
    if not stream:
        return
    music_player.stream = stream
    music_player.play()

func stop_music(fade_duration: float = 1.0):
    if music_player.playing:
        if fade_duration > 0.0:
            var tween: Tween = create_tween()
            tween.tween_property(music_player, "volume_db", -80, fade_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
            tween.tween_callback(Callable(self, "_stop_music_immediately"))
        else:
            _stop_music_immediately()

func _stop_music_immediately():
    music_player.stop()
    music_player.volume_db = 0

func play_se(stream: AudioStream):
    if not stream:
        return
    var se_player := AudioStreamPlayer.new()
    se_player.stream = stream
    se_player.bus = "SE"
    se_player.connect("finished", Callable(self, "_on_button_down"))
    se_pool.add_child(se_player)
    se_player.play()
