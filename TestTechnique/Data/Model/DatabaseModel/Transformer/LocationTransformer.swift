//
//  LocationTransformer.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 08/08/2024.
//

import Foundation

class LocationTransformer: ValueTransformer {
    static let name = NSValueTransformerName(rawValue: "LocationTransformer")
    
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let location = value as? Location else { return nil }
        do {
            let data = try JSONEncoder().encode(location)
            return data
        } catch {
            print("Error encoding Location: \(error)")
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            let location = try JSONDecoder().decode(Location.self, from: data)
            return location
        } catch {
            print("Error decoding Location: \(error)")
            return nil
        }
    }
}



