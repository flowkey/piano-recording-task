import SwiftUI
import AVFoundation

public typealias MIDINumber = Int
public typealias NoteRange = CountableRange<MIDINumber>

private extension MIDINumber {
    var pitchClass: MusicalNote {
        let rawValue = self % MusicalNote.allCases.count
        let musicalNote = MusicalNote(rawValue: rawValue)
        return musicalNote!
    }
    
    var octave: Int {
        return (self / MusicalNote.allCases.count) - 1
    }
}

enum PianoKeyColor {
    case black
    case white
}

extension PianoKeyColor {
    var width: CGFloat {
        return self == .black ? 24 : 45
    }
    
    var height: CGFloat {
        return self == .black ? 114 : 180
    }
}


private let KEY_FADEOUT_IN_MS = 450

struct Piano: View {
    let notesForWhiteKeys: [MIDINumber]
    let audioPlayers: [MIDINumber: AVAudioPlayer]
    @State var activeKeys: Set<MIDINumber> = []
    
    init(noteRange: NoteRange) {
        notesForWhiteKeys = noteRange.filter { $0.pitchClass.pianoKeyColor == .white }
        var audioPlayers: [MIDINumber: AVAudioPlayer] = [:]
        noteRange.forEach { midiNumber in
            let noteName = midiNumber.pitchClass.noteName.replacing("♯", with: "#")
            let filename = "acoustic_grand_piano-mp3-2-\(noteName)\(midiNumber.octave)"
            
            let url = Bundle.main.url(forResource: filename, withExtension: "mp3")!
            let player = try! AVAudioPlayer(contentsOf: url)
            audioPlayers[midiNumber] = player
        }
        self.audioPlayers = audioPlayers
    }
    
    private func playNote(midiNumber: MIDINumber) {
        activeKeys.insert(midiNumber)
        guard let player = audioPlayers[midiNumber] else { return }
        player.volume = 1
        player.currentTime = 0
        player.play()
    }
    
    private func endNote(midiNumber: MIDINumber) {
        activeKeys.remove(midiNumber)
        audioPlayers[midiNumber]?.setVolume(0, fadeDuration: Double(KEY_FADEOUT_IN_MS) / 1000)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            // white keys
            HStack(alignment: .top, spacing: 0) {
                ForEach(notesForWhiteKeys, id: \.self) { midiNumber in
                    PianoKey(style: .white,
                             isActive: activeKeys.contains(midiNumber),
                             onKeyDown: {playNote(midiNumber: midiNumber)},
                             onKeyUp: {endNote(midiNumber: midiNumber)})
                }
            }
            
            // black keys
            HStack(alignment: .top, spacing: 0) {
                ForEach(0 ..< notesForWhiteKeys.count, id: \.self) { i in
                    let midiNumber = notesForWhiteKeys[i]
                    let xOffset: CGFloat = CGFloat(i) * (PianoKeyColor.white.width - PianoKeyColor.black.width)
                    + PianoKeyColor.white.width - PianoKeyColor.black.width / 2
                    
                    if midiNumber.pitchClass.precedesBlackKey {
                        let midiNumber = midiNumber + 1
                        PianoKey(style: .black,
                                 isActive: activeKeys.contains(midiNumber),
                                 onKeyDown: {playNote(midiNumber: midiNumber)},
                                 onKeyUp: {endNote(midiNumber: midiNumber)}
                        )
                        .offset(x: xOffset)
                    } else {
                        Spacer()
                            .frame(width: PianoKeyColor.black.width, height: PianoKeyColor.black.height)
                            .offset(x: xOffset)
                    }
                }
            }
            .offset(y: -(PianoKeyColor.white.height - PianoKeyColor.black.height) / 2)
        }
    }
}
