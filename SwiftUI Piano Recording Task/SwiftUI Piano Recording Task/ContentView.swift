import SwiftUI

struct ContentView: View {
    let noteRange: NoteRange
    let instrument: Instrument
    
    init() {
        noteRange = 48..<72
        instrument = Instrument(noteRange: noteRange)
    }

    var body: some View {
        VStack {
            Text("Piano Recorder")
                .font(.largeTitle)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(8)
                .padding(.bottom)

            Piano(noteRange: noteRange) { midiNumber in
                instrument.playNote(midiNumber: midiNumber)
            } onStopNote: { midiNumber in
                instrument.stopNote(midiNumber: midiNumber)
            }
        }
        .padding()
        .onAppear {
            Task {
                print(try await getSongs())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
