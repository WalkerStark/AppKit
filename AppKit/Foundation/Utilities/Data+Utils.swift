//
//  Data+Utils.swift
//  PDAppKit
//
//  Created by Walker Stark on 2018/9/21.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

public extension Data {
    
    func toJSONDictionary() -> [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: self, options: [])) as? [String: Any]
    }
}
