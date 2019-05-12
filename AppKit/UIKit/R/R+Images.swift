import UIKit
private class BundleToken { }
public extension ImageCollection {
    var nav_bar_back: UIImage { return UIImage(named: "nav_bar_back", bundle: Bundle(for: BundleToken.self)) }
    var nav_bar_close: UIImage { return UIImage(named: "nav_bar_close", bundle: Bundle(for: BundleToken.self)) }
}
