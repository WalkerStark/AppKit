//
//  Obfuscator.swift
//  PDFoundation
//
//  Created by Walker Stark on 2019/3/4.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

public class Obfuscator {
    
    public static let `default` = Obfuscator()
    private var salt: String
    
    public init(salt: String = "\(String(describing: Obfuscator.self))") {
        self.salt = salt
    }
    
    public func obfuscatedKey(for string: String) -> String {
        let text = [UInt8](string.utf8)
        let cipher = [UInt8](salt.sha1!.utf8)
        let length = cipher.count
        
        var encrypted = [String]()
        
        for item in text.enumerated() {
            let str = String(format: "0x%02x", item.element ^ cipher[item.offset % length])
            encrypted.append(str)
        }
        
        return encrypted.joined(separator: ", ")
    }
    
    // This method reveals the original string from the obfuscated byte array passed in.
    // The salt must be the same as the one used to encrypt it in the first place.
    public func reveal(keyBytes: [UInt8]) -> String {
        let cipher = [UInt8](salt.sha1!.utf8)
        let digestLen = cipher.count
        var decrypted = [UInt8]()
        
        // XOR the class name against the obfuscated key, to form the real key.
        for key in keyBytes.enumerated() {
            decrypted.append(key.element ^ cipher[key.offset % digestLen])
        }
        
        return String(bytes: decrypted, encoding: .utf8) ?? ""
    }
}
