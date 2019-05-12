import Foundation
private class BundleToken {}
public extension LocalizableStrings {
    var buttonTitleOkay: String { return localizedString("button_title_okay", table: "Localizable", bundle: Bundle(for: BundleToken.self)) }
    var buttonTitleCancel: String { return localizedString("button_title_cancel", table: "Localizable", bundle: Bundle(for: BundleToken.self)) }
    var buttonTitleDone: String { return localizedString("button_title_done", table: "Localizable", bundle: Bundle(for: BundleToken.self)) }
    var buttonTitleSelect: String { return localizedString("button_title_select", table: "Localizable", bundle: Bundle(for: BundleToken.self)) }
    var buttonTitleSettings: String { return localizedString("button_title_settings", table: "Localizable", bundle: Bundle(for: BundleToken.self)) }
    var alertTitlePhotos: String { return localizedString("alert_title_photos", table: "Localizable", bundle: Bundle(for: BundleToken.self)) }
    var alertTitleCamera: String { return localizedString("alert_title_camera", table: "Localizable", bundle: Bundle(for: BundleToken.self)) }
    var alertAccessPhotosSettings: String { return localizedString("alert_access_photos_settings", table: "Localizable", bundle: Bundle(for: BundleToken.self)) }
    var alertAccessCameraSettings: String { return localizedString("alert_access_camera_settings", table: "Localizable", bundle: Bundle(for: BundleToken.self)) }
    var alertPhotosSettingsPath: String { return localizedString("alert_photos_settings_path", table: "Localizable", bundle: Bundle(for: BundleToken.self)) }
    var alertCameraSettingsPath: String { return localizedString("alert_camera_settings_path", table: "Localizable", bundle: Bundle(for: BundleToken.self)) }
}
