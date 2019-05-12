import UIKit
public extension UIAlertController {
    static func makeSettingsAlert(with title: String, message: String) -> UIAlertController {
        let cancel = UIAlertAction(title: R.strings.buttonTitleCancel, style: .default, handler: nil)
        let settings = UIAlertAction(title: R.strings.buttonTitleSettings, style: .cancel, handler: { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        })
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(cancel)
        alert.addAction(settings)
        return alert
    }
}
