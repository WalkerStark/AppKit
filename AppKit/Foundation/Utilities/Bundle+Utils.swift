//
//  Bundle+Utils.swift
//  PDFoundation
//
//  Created by Walker Stark on 2018/11/5.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

public extension Bundle {
    
    var bundleID: String {
        return bundleIdentifier ?? ""
    }
    
    var bundleName: String {
        return infoDictionary?["CFBundleName"] as! String
    }
    
    var version: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
    
    var displayName: String? {
        return infoDictionary?["CFBundleDisplayName"] as? String
    }
    
    var copyright: String? {
        return infoDictionary?["NSHumanReadableCopyright"] as? String
    }
    
    var suiteName: String {
        return bundleID
    }
    
    var groupName: String {
        let name = "group.\(bundleID)"
        return isExtension ? (name as NSString).deletingPathExtension : name
    }
    
    var keychainName: String {
        let name = "keychain.\(bundleID)"
        return isExtension ? (name as NSString).deletingPathExtension : name
    }
}

private extension Bundle {
    
    var isExtension: Bool {
        return ((infoDictionary?["NSExtension"] as? [String: Any]) != nil)
    }
}
