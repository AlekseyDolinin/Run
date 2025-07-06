import SwiftUICore

extension Font {

    enum FontSize: CGFloat {
        case size_12 = 12
        case size_14 = 14
        case size_16 = 16
        case size_18 = 18
        case size_20 = 20
        case size_24 = 24
        case size_30 = 30
        case size_32 = 32
        case size_34 = 34
        case size_48 = 48
    }
    
    static func regular_(size: FontSize) -> Font {
        return Font.system(
            size: size.rawValue,
            weight: .regular,
            design: .rounded
        )
    }
    static func medium(size: FontSize) -> Font {
        return Font.system(
            size: size.rawValue,
            weight: .medium,
            design: .rounded
        )
    }
    static func bold(size: FontSize) -> Font {
        return Font.system(
            size: size.rawValue,
            weight: .bold,
            design: .rounded
        )
    }
}


