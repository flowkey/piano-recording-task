import SwiftUI

struct ContentView: View {
    let instrument = Instrument(noteRange: 48..<72)

    var body: some View {
        VStack {
            Text("Piano Recorder")
                .font(.largeTitle)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(8)
                .padding(.bottom)

            Piano(noteRange: instrument.noteRange) { midiNumber in
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
