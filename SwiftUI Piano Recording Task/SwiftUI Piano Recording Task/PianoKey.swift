//
//  PianoKey.swift
//  SwiftUI Piano Recording Task
//
//  Created by Chetan Agarwal on 14.08.23.
//

import SwiftUI

private extension PianoKeyColor {
    var keyColor: Color {
        return self == .black ? Color.black : Color.white
    }
    
    var activeColor: Color {
        return self == .black ? Color(red: 0, green: 0.7, blue: 0.7) : Color(red: 0.937254902, green: 0.4901960784, blue: 0)
    }
    
    var borderColor: Color? {
        return self == .black ? nil : Color.black
    }
}

private extension Animation {
    static let fadeOutActiveKey = Animation.easeOut(duration: 0.8)
}

struct PianoKey: View {
    typealias EventHandler = () -> Void
    
    private let style: PianoKeyColor
    private var isActive: Bool
    
    var onKeyDown: EventHandler?
    var onKeyUp: EventHandler?
    
    init(style: PianoKeyColor,
         isActive: Bool,
         onKeyDown: EventHandler? = nil,
         onKeyUp: EventHandler? = nil) {
        self.style = style
        self.isActive = isActive
        self.onKeyDown = onKeyDown
        self.onKeyUp = onKeyUp
    }
    
    var body: some View {
        Rectangle()
            .fill(isActive ? style.activeColor : style.keyColor)
            .border(style.borderColor ?? .clear)
            .animation(!isActive ? .fadeOutActiveKey : nil, value: isActive)
            .frame(width: style.width, height: style.height)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ val in
                        if val.location == val.startLocation {
                            onKeyDown?()
                        }
                    })
                    .onEnded({ _ in
                        onKeyUp?()
                    })
            )
    }
}

struct PianoKey_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack(spacing: 0) {
                PianoKey(style: .black, isActive: false)
                PianoKey(style: .black, isActive: true)
            }
            HStack(spacing: 0) {
                PianoKey(style: .white, isActive: false)
                PianoKey(style: .white, isActive: true)
            }
        }
    }
}


