import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Piano Recording Task")
                .font(.largeTitle)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(8)
                .padding(.bottom)

            Piano(noteRange: 48 ..< 72)
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
