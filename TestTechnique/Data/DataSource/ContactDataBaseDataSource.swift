//
//  ContactDataBaseDataSource.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 08/08/2024.
//

import Foundation
import CoreData

protocol ContactDataBaseDataSourceProtocol {
    func fetchContacts() async throws -> [ContactEntity]
    func saveContacts(_ contacts: [ContactEntity]) async throws
}

struct ContactDatabaseDataSource: ContactDataBaseDataSourceProtocol {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveContacts(_ contacts: [ContactEntity]) async throws {
        for contact in contacts {
            if let existingContact = try await fetchContact(by: contact.email) {
                try updateContact(existingContact, with: contact)
            } else {
                do {
                    let contactManagedObject = ContactDatabaseEntity(context: context)
                    contactManagedObject.id = contact.id
                    contactManagedObject.gender = contact.gender
                    
                    if let encodedName = try? JSONEncoder().encode(contact.name) {
                        contactManagedObject.name = encodedName as NSData
                    }
                    
                    if let encodedLocation = try? JSONEncoder().encode(contact.location) {
                        contactManagedObject.location = encodedLocation as NSData
                    }
                    
                    contactManagedObject.email = contact.email
                    contactManagedObject.phone = contact.phone
                    
                    if let encodedPicture = try? JSONEncoder().encode(contact.picture) {
                        contactManagedObject.picture = encodedPicture as NSData
                    }
                    try context.save()
                } catch {
                    throw error
                }
                
            }
        }
    }
    
    func fetchContacts() async throws -> [ContactEntity] {
        let fetchRequest = NSFetchRequest<ContactDatabaseEntity>(entityName: "ContactDatabaseEntity")
        
        do {
            let storedContacts = try context.fetch(fetchRequest)
            let contacts: [ContactEntity] = storedContacts.compactMap { (contactManagedObject: ContactDatabaseEntity) -> ContactEntity? in
                return ContactEntity(
                    id: contactManagedObject.id ?? UUID(),
                    gender: contactManagedObject.gender ?? "",
                    name: (try? JSONDecoder().decode(Name.self, from: contactManagedObject.name as! Data)) ?? Name(title: "", first: "", last: ""),
                    location: (try? JSONDecoder().decode(Location.self, from: contactManagedObject.location as! Data)) ?? Location(street: Location.Street(number: 0, name: ""), city: "", state: "", country: "", postcode: .stringPostcode(""), coordinates: Location.Coordinates(latitude: "", longitude: ""), timezone: Location.Timezone(offset: "", description: "")),
                    email: contactManagedObject.email ?? "",
                    phone: contactManagedObject.phone ?? "",
                    picture: (try? JSONDecoder().decode(Picture.self, from: contactManagedObject.picture as! Data)) ?? Picture(large: "", medium: "", thumbnail: "")
                )
            }
            return contacts
        } catch {
            print("Failed to fetch contacts: \(error.localizedDescription)")
            return []
        }
    }
    
    private func fetchContact(by email: String) async throws -> ContactDatabaseEntity? {
        let fetchRequest: NSFetchRequest<ContactDatabaseEntity> = ContactDatabaseEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email as CVarArg)
        let results = try context.fetch(fetchRequest)
        return results.first
    }
    
    func updateContact(_ existingContact: ContactDatabaseEntity, with newContact: ContactEntity) throws {
        do {
            var isModified = false
            
            if existingContact.gender != newContact.gender {
                existingContact.gender = newContact.gender
                isModified = true
            }
            
            if let encodedName = try? JSONEncoder().encode(newContact.name),
               existingContact.name != encodedName as NSData {
                existingContact.name = encodedName as NSData
                isModified = true
            }
            
            if let encodedLocation = try? JSONEncoder().encode(newContact.location),
               existingContact.location != encodedLocation as NSData {
                existingContact.location = encodedLocation as NSData
                isModified = true
            }
            
            if existingContact.email != newContact.email {
                existingContact.email = newContact.email
                isModified = true
            }
            
            if existingContact.phone != newContact.phone {
                existingContact.phone = newContact.phone
                isModified = true
            }
            
            if let encodedPicture = try? JSONEncoder().encode(newContact.picture),
               existingContact.picture != encodedPicture as NSData {
                existingContact.picture = encodedPicture as NSData
                isModified = true
            }
            
            if isModified {
                do {
                    try context.save()
                } catch {
                    throw error
                }
                
            }
        } catch {
            throw error
        }
        
    }

}
