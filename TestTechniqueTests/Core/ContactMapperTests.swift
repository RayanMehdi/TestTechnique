//
//  ContactMapperTests.swift
//  TestTechniqueTests
//
//  Created by Rayan MEHDI on 09/08/2024.
//

import XCTest

final class ContactMapperTests: XCTestCase {
    
    func testMapContactsResponseToDomain_withValidResponse_shouldReturnContactEntities() {
        // Given: A valid ContactListResponse
        let contactResponse = createMockContactListResponse()
        
        // When: We map the response to domain entities
        let contactEntities = ContactMapper.mapContactsResponseToDomain(input: contactResponse)
        
        // Then: The mapped entities should match the response
        XCTAssertEqual(contactEntities.count, contactResponse.results.count)
        for (index, entity) in contactEntities.enumerated() {
            let result = contactResponse.results[index]
            XCTAssertEqual(entity.gender, result.gender)
            XCTAssertEqual(entity.name, result.name)
            XCTAssertEqual(entity.location, result.location)
            XCTAssertEqual(entity.email, result.email)
            XCTAssertEqual(entity.phone, result.phone)
            XCTAssertEqual(entity.picture, result.picture)
        }
    }
    
    func testMapContactsResponseToDomain_withEmptyResponse_shouldReturnEmptyArray() {
        let contactResponse = ContactListResponse(results: [])
        
        let contactEntities = ContactMapper.mapContactsResponseToDomain(input: contactResponse)
        
        XCTAssertTrue(contactEntities.isEmpty)
    }
    
    private func createMockContactListResponse() -> ContactListResponse {
        let mockContactResponse = createMockContactResponse()
        
        return ContactListResponse(results: [mockContactResponse])
    }
    
    func createMockContactResponse() -> ContactResponse {
        // Create mock data for each property
        let mockName = Name(title: "Mr", first: "John", last: "Doe")
        let mockStreet = Location.Street(number: 123, name: "Main St")
        let mockCoordinates = Location.Coordinates(latitude: "0.0", longitude: "0.0")
        let mockTimezone = Location.Timezone(offset: "+0:00", description: "UTC")
        
        let mockLocation = Location(
            street: mockStreet,
            city: "Springfield",
            state: "State",
            country: "Country",
            postcode: .stringPostcode("12345"),
            coordinates: mockCoordinates,
            timezone: mockTimezone
        )
        
        let mockLogin = Login(
            uuid: "unique-uuid",
            username: "johndoe",
            password: "password",
            salt: "salt",
            md5: "md5hash",
            sha1: "sha1hash",
            sha256: "sha256hash"
        )
        
        let mockDob = Dob(
            date: "1980-01-01T00:00:00Z",
            age: 42
        )
        
        let mockRegistered = Registered(
            date: "2010-01-01T00:00:00Z",
            age: 12
        )
        
        let mockID = ID(
            name: "SSN",
            value: "123-45-6789"
        )
        
        let mockPicture = Picture(
            large: "https://example.com/large.jpg",
            medium: "https://example.com/medium.jpg",
            thumbnail: "https://example.com/thumbnail.jpg"
        )
        
        // Create and return the mock ContactResponse
        return ContactResponse(
            gender: "male",
            name: mockName,
            location: mockLocation,
            email: "johndoe@example.com",
            login: mockLogin,
            dob: mockDob,
            registered: mockRegistered,
            phone: "123-456-7890",
            cell: "098-765-4321",
            id: mockID,
            picture: mockPicture,
            nat: "US"
        )
    }

}
