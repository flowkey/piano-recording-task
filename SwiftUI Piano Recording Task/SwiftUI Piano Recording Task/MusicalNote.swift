public enum MusicalNote: Int, CaseIterable {
    case c = 0, cSharp, d, dSharp, e, f, fSharp, g, gSharp, a, aSharp, b
}

extension MusicalNote: CustomStringConvertible {
    public var noteName: String {
        switch self {
        case .c:        return "C"
        case .cSharp:   return "C♯"
        case .d:        return "D"
        case .dSharp:   return "D♯"
        case .e:        return "E"
        case .f:        return "F"
        case .fSharp:   return "F♯"
        case .g:        return "G"
        case .gSharp:   return "G♯"
        case .a:        return "A"
        case .aSharp:   return "A♯"
        case .b:        return "B"
        }
    }

    public var description: String {
        return "♪" + noteName
    }
}

extension MusicalNote {
    var pianoKeyColor: PianoKeyColor {
        switch self {
        case .c, .d, .e, .f, .g, .a, .b:
            return .white
        default:
            return .black
        }
    }
}

extension MusicalNote {
    var precedesBlackKey: Bool {
        switch self {
        case .e, .b: return false
        default: return true
        }
    }
}
