//
//  DateCodingStrategy.swift
//  PDFoundation
//
//  Created by Walker Stark on 2019/1/2.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

extension JSONEncoder.DateEncodingStrategy {
    public static var iso8601Formatted: JSONEncoder.DateEncodingStrategy {
        return .custom { (date, encoder) in
            var container = encoder.singleValueContainer()
            let dateString = DateFormatter.string(date: date, format: .iso8601MediumDateLongTime)
            
            try container.encode(dateString)
        }
    }
}

extension JSONDecoder.DateDecodingStrategy {
    public static var iso8601Formatted: JSONDecoder.DateDecodingStrategy {
        return .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            var decodedDate = DateFormatter.date(string: dateString, format: .iso8601MediumDateLongTime)
            decodedDate = decodedDate ?? DateFormatter.date(string: dateString, format: .iso8601MediumDateMediumTime)
            
            guard let date = decodedDate else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Can not decode date string \(dateString)")
            }
            
            return date
        }
    }
}
