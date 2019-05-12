import UIKit
public class R {
    public static let strings = LocalizableStrings()
    public static let colors = ColorCollection()
    public static let fonts = FontCollection()
    public static let images = ImageCollection()
}
public class LocalizableStrings: NSObject { }
public class ColorCollection: NSObject { }
public class FontCollection: NSObject { }
public class ImageCollection: NSObject { }
public func localizedString(_ key: String, table: String, bundle: Bundle, _ argvs: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
    return String(format: format, locale: Locale.current, arguments: argvs)
}
extension UIColor {
    public convenience init(hexString: String) {
        let charactetSet = CharacterSet(charactersIn: "#")
        var hex = hexString.trimmingCharacters(in: charactetSet)
        let prefix = "0x"
        if hex.lowercased().hasPrefix(prefix) {
            hex = hex.replacingOccurrences(of: prefix, with: "")
        }
        if hex.count == 6 {
            hex = "FF\(hex)"
        } else if hex.count == 2 {
            hex = "FF\(hex)\(hex)\(hex)"
        }
        var rgbVal: UInt32 = 0
        Scanner(string: hex).scanHexInt32(&rgbVal)
        self.init(red: CGFloat((rgbVal & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbVal & 0xFF00) >> 8) / 255.0,
                  blue: CGFloat(rgbVal & 0xFF) / 255.0,
                  alpha: CGFloat((rgbVal & 0xFF000000) >> 24) / 255.0)
    }
}
extension UIImage {
    public convenience init(named: String, bundle: Bundle = Bundle.main) {
        self.init(named: named, in: bundle, compatibleWith: nil)!
    }
}
