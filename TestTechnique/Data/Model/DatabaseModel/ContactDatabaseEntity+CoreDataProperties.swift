//
//  ContactDatabaseEntity+CoreDataProperties.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 08/08/2024.
//
//

import Foundation
import CoreData


extension ContactDatabaseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactDatabaseEntity> {
        return NSFetchRequest<ContactDatabaseEntity>(entityName: "ContactDatabaseEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var gender: String?
    @NSManaged public var name: NSObject?
    @NSManaged public var location: NSObject?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var picture: NSObject?

}

extension ContactDatabaseEntity : Identifiable {

}
