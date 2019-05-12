import Foundation
import AudioToolbox
public class SoundPlayer {
    private static func playSound(_ fileName: String) {
        var soundID: SystemSoundID = 0
        guard let soundURL = Bundle.main.url(forResource: fileName, withExtension: "caf") else { return }
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
        AudioServicesPlaySystemSoundWithCompletion(soundID) {
            AudioServicesDisposeSystemSoundID(soundID)
        }
    }
    private static func playSystemSound(_ filePath: String) {
        var soundID: SystemSoundID = 0
        let sysSoundsDir: NSString = "/System/Library/Audio/UISounds"
        let soundURL = URL(fileURLWithPath: sysSoundsDir.appendingPathComponent(filePath))
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
        AudioServicesPlaySystemSoundWithCompletion(soundID) {
            AudioServicesDisposeSystemSoundID(soundID)
        }
    }
}
public extension SoundPlayer {
    static func playVibrate() {
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, nil)
    }
    static func playCameraShutter() {
        AudioServicesPlaySystemSoundWithCompletion(1108, nil)
    }
    static func playMessageSentSound() {
        AudioServicesPlaySystemSoundWithCompletion(1004, nil)
    }
    static func playMessageSentAlert() {
        AudioServicesPlayAlertSoundWithCompletion(1004, nil)
    }
    static func playMessageReceivedSound() {
        AudioServicesPlaySystemSoundWithCompletion(1003, nil)
    }
    static func playMessageReceivedAlert() {
        AudioServicesPlayAlertSoundWithCompletion(1003, nil)
    }
    static func playMessageReceivedVibrate() {
        playVibrate()
    }
}
