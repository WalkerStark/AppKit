//
//  Crypto+Utils.swift
//  PDAppKit
//
//  Created by roy.cao on 2018/10/30.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation
import CommonCrypto

// MARK: - MD5
extension String {

    public var md5: String? {
        guard let stringData = data(using: .utf8) else {
            return nil
        }
        return stringData.md5
    }
}

extension Data {

    public var md5: String {
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        var digestData = Data(count: digestLen)
        _ = digestData.withUnsafeMutableBytes { digestBytes in
            withUnsafeBytes { messageBytes in
                CC_MD5(messageBytes, CC_LONG(count), digestBytes)
            }
        }
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}

// MARK: - SHA1
extension String {

    public var sha1: String? {
        guard let stringData = data(using: .utf8) else {
            return nil
        }
        return stringData.sha1
    }
}

extension Data {

    public var sha1: String {
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        var digestData = Data(count: digestLen)
        _ = digestData.withUnsafeMutableBytes { digestBytes in
            withUnsafeBytes { messageBytes in
                CC_SHA1(messageBytes, CC_LONG(count), digestBytes)
            }
        }
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}

// MARK: - Base64
extension String {

    public var base64: String? {
        let strData = data(using: .utf8)
        guard let base64String = strData?.base64EncodedString() else { return nil }
        return base64String
    }

    /// This method requires padding with “=“, the length of the string must be multiple of 4.
    /// - Note: Must add this "=" padding, otherwise, the system base64 encode method not working.
    public var paddingBase64: String {
        return padding(toLength: (count + 3) / 4 * 4, withPad: "=", startingAt: 0)
    }
}

// MARK: - AES256
extension Data {

    public func aesCBCEncrypt(key: String) -> Data? {
        guard let keyData = key.data(using: .utf8) else {
            return nil
        }

        let keyLength = keyData.count
        let validKeyLengths = [kCCKeySizeAES128, kCCKeySizeAES192, kCCKeySizeAES256]
        if validKeyLengths.contains(keyLength) == false {
            return nil
        }

        let ivSize = kCCBlockSizeAES128
        let cryptLength = size_t(ivSize + count + kCCBlockSizeAES128)
        var cryptData = Data(count: cryptLength)

        let status = cryptData.withUnsafeMutableBytes { ivBytes in
            SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, ivBytes)
        }
        if status != 0 {
            return nil
        }

        var numBytesEncrypted: size_t = 0
        let options = CCOptions(kCCOptionPKCS7Padding)

        let cryptStatus = cryptData.withUnsafeMutableBytes { cryptBytes in
            withUnsafeBytes {dataBytes in
                keyData.withUnsafeBytes {keyBytes in
                    CCCrypt(CCOperation(kCCEncrypt),
                            CCAlgorithm(kCCAlgorithmAES),
                            options,
                            keyBytes, keyLength,
                            cryptBytes,
                            dataBytes, count,
                            cryptBytes+kCCBlockSizeAES128, cryptLength,
                            &numBytesEncrypted)
                }
            }
        }

        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.count = numBytesEncrypted + ivSize
        } else {
            return nil
        }

        return cryptData
    }

    public func aesCBCDecrypt(key: String) -> Data? {
        guard let keyData = key.data(using: .utf8) else {
            return nil
        }
        let keyLength = keyData.count
        let validKeyLengths = [kCCKeySizeAES128, kCCKeySizeAES192, kCCKeySizeAES256]
        if validKeyLengths.contains(keyLength) == false {
            return nil
        }

        let ivSize = kCCBlockSizeAES128
        let clearLength = size_t(count - ivSize)
        var clearData = Data(count: clearLength)

        var numBytesDecrypted: size_t = 0
        let options = CCOptions(kCCOptionPKCS7Padding)

        let cryptStatus = clearData.withUnsafeMutableBytes { cryptBytes in
            withUnsafeBytes {dataBytes in
                keyData.withUnsafeBytes {keyBytes in
                    CCCrypt(CCOperation(kCCDecrypt),
                            CCAlgorithm(kCCAlgorithmAES128),
                            options,
                            keyBytes, keyLength,
                            dataBytes,
                            dataBytes+kCCBlockSizeAES128, clearLength,
                            cryptBytes, clearLength,
                            &numBytesDecrypted)
                }
            }
        }

        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            clearData.count = numBytesDecrypted
        } else {
            return nil
        }

        return clearData
    }
}
