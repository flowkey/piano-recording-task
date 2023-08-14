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

    var body: some View {
        ZStack(alignment: .leading) {
            // white keys
            HStack(alignment: .top, spacing: 0) {
                ForEach(notesForWhiteKeys, id: \.self) { midiNumber in
                    WhiteKey(isActive: activeKeys.contains(midiNumber))
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ val in
                                    if val.location == val.startLocation {
                                        activeKeys.insert(midiNumber)
                                        guard let player = audioPlayers[midiNumber] else { return }
                                        player.volume = 1
                                        player.currentTime = 0
                                        player.play()
                                    }
                                })
                                .onEnded({ _ in
                                    activeKeys.remove(midiNumber)
                                    audioPlayers[midiNumber]?.setVolume(0, fadeDuration: Double(KEY_FADEOUT_IN_MS) / 1000)
                                })
                        )
                }
            }

            // black keys
            HStack(alignment: .top, spacing: 0) {
                ForEach(0 ..< notesForWhiteKeys.count, id: \.self) { i in
                    let midiNumber = notesForWhiteKeys[i]
                    let xOffset: CGFloat =
                        CGFloat(i) * (WhiteKey.width - BlackKey.width)
                        + WhiteKey.width - BlackKey.width / 2

                    if midiNumber.pitchClass.precedesBlackKey {
                        let midiNumber = midiNumber + 1
                        BlackKey(isActive: activeKeys.contains(midiNumber))
                            .offset(x: xOffset)
                            .simultaneousGesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged({ val in
                                        if val.location == val.startLocation {
                                            activeKeys.insert(midiNumber)
                                            guard let player = audioPlayers[midiNumber] else { return }
                                            player.volume = 1
                                            player.currentTime = 0
                                            player.play()
                                        }
                                    })
                                    .onEnded({ _ in
                                        activeKeys.remove(midiNumber)
                                        audioPlayers[midiNumber]?.setVolume(0, fadeDuration: Double(KEY_FADEOUT_IN_MS) / 1000)
                                    })
                            )
                    } else {
                        Spacer()
                            .frame(width: BlackKey.width, height: BlackKey.height)
                            .offset(x: xOffset)
                    }
                }
            }
            .offset(y: -(WhiteKey.height - BlackKey.height) / 2)
        }
    }
}

struct WhiteKey: View {
    static let activeColor = Color(red: 0.937254902, green: 0.4901960784, blue: 0)
    static let width: CGFloat = 45
    static let height: CGFloat = 180

    var isActive: Bool

    var body: some View {
        Rectangle()
            .fill(isActive ? WhiteKey.activeColor : Color.white)
            .border(Color.gray)
            .animation(!isActive ? .fadeOutActiveKey : nil, value: isActive)
            .frame(width: WhiteKey.width, height: WhiteKey.height)
    }
}

struct BlackKey: View {
    static let activeColor = Color(red: 0, green: 0.7, blue: 0.7)
    static let width: CGFloat = 24
    static let height: CGFloat = 114

    var isActive: Bool

    var body: some View {
        Rectangle()
            .fill(isActive ? BlackKey.activeColor : Color.black)
            .animation(!isActive ? .fadeOutActiveKey : nil, value: isActive)
            .frame(width: BlackKey.width, height: BlackKey.height)
    }
}

extension Animation {
    static let fadeOutActiveKey = Animation.easeOut(duration: 0.8)
}
