import SwiftUI
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

typealias NoteCallback = ((_ midiNumber: MIDINumber) -> Void)

struct Piano: View {
    
    let notesForWhiteKeys: [MIDINumber]
    @State var activeKeys: Set<MIDINumber> = []

    var onPlayNote: NoteCallback?
    var onStopNote: NoteCallback?
    
    init(noteRange: NoteRange, onPlayNote: NoteCallback? = nil, onStopNote: NoteCallback? = nil) {
        notesForWhiteKeys = noteRange.filter { $0.pitchClass.pianoKeyColor == .white }
        self.onPlayNote = onPlayNote
        self.onStopNote = onStopNote
    }
    
    private func playNote(midiNumber: MIDINumber) {
        activeKeys.insert(midiNumber)
        onPlayNote?(midiNumber)
    }
    
    private func stopNote(midiNumber: MIDINumber) {
        activeKeys.remove(midiNumber)
        onStopNote?(midiNumber)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            // white keys
            HStack(alignment: .top, spacing: 0) {
                ForEach(notesForWhiteKeys, id: \.self) { midiNumber in
                    PianoKey(style: .white,
                             isActive: activeKeys.contains(midiNumber),
                             onKeyDown: { playNote(midiNumber: midiNumber) },
                             onKeyUp: { stopNote(midiNumber: midiNumber) }
                    )
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
                                 onKeyDown: { playNote(midiNumber: midiNumber) },
                                 onKeyUp: { stopNote(midiNumber: midiNumber) }
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



