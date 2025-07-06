import SwiftUICore
import UIKit

final class AppTheme {
    
    static let shared = AppTheme()
    
    static var bg_one: Color = Color.init(hex: "#1d1d1d")
//    static var BB_BGPrimary: Color = Color(hex: "#1a1a1a")
//    static var BB_BGSecondary: Color = .gray
//    static var BB_BGTertiary: Color = .black
//    
//    static var BB_TextUI: Color = .white
//    static var BB_TextHigh: Color = Color(hex: "#ffffff")
//    static var BB_TextPrimary: Color = Color(hex: "#ffffff")
//    static var BB_TextSecondary: Color = .white
//    
//    static var BB_TextMedium: Color = .white.opacity(0.7)
//    static var BB_TextDisabled: Color = .white.opacity(0.5)
//    
//    static var BB_Red: Color = .red
//    static var BB_Green: Color = .green
//    static var BB_Warning: Color = .orange
//    
//    static var Surface_BB_00db: Color = .black
}


extension UIColor {
    
    var hsba:(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h: h, s: s, b: b, a: a)
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
