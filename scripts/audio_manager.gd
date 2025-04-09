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

func stop_music():
    music_player.stop()

func play_se(stream: AudioStream):
    if not stream:
        return
    var se_player := AudioStreamPlayer.new()
    se_player.stream = stream
    se_player.bus = "SE"
    se_player.connect("finished", Callable(self, "_on_button_down"))
    se_pool.add_child(se_player)
    se_player.play()
