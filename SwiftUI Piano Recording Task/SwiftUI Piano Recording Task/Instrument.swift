import AVFoundation

public typealias MIDINumber = Int
public typealias NoteRange = CountableRange<MIDINumber>

extension MIDINumber {
    var pitchClass: MusicalNote {
        let rawValue = self % MusicalNote.allCases.count
        let musicalNote = MusicalNote(rawValue: rawValue)
        return musicalNote!
    }
    
    var octave: Int {
        return (self / MusicalNote.allCases.count) - 1
    }
}

class Instrument {
    private static let KEY_FADEOUT_IN_SEC: Double = 450 / 1000

    let noteRange: NoteRange
    private let audioPlayers: [MIDINumber: AVAudioPlayer]
    
    init(noteRange: NoteRange) {
        self.noteRange = noteRange
        audioPlayers = noteRange.createAudioPlayers()
    }
    
    func playNote(midiNumber: MIDINumber) {
        guard let player = audioPlayers[midiNumber] else { return }
        player.volume = 1
        player.currentTime = 0
        player.play()
    }
    
    func stopNote(midiNumber: MIDINumber) {
        audioPlayers[midiNumber]?.setVolume(0, fadeDuration: Instrument.KEY_FADEOUT_IN_SEC)
    }
}


private extension NoteRange {
    func createAudioPlayers() -> [MIDINumber: AVAudioPlayer] {
        var audioPlayers: [MIDINumber: AVAudioPlayer] = [:]
        self.forEach { midiNumber in
            let noteName = midiNumber.pitchClass.noteName.replacing("♯", with: "#")
            let filename = "acoustic_grand_piano-mp3-2-\(noteName)\(midiNumber.octave)"
            
            let url = Bundle.main.url(forResource: filename, withExtension: "mp3")!
            let player = try! AVAudioPlayer(contentsOf: url)
            audioPlayers[midiNumber] = player
        }
        return audioPlayers
    }
}
