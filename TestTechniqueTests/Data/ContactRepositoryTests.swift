//
//  ContactRepositoryTests.swift
//  TestTechniqueTests
//
//  Created by Rayan MEHDI on 09/08/2024.
//

import XCTest

// Mock classes
class MockContactRemoteDataSource: ContactRemoteDataSourceProtocol {
    var shouldFail = false
    var mockContacts: ContactListResponse?
    
    func getContacts(results: Int, page: Int) async throws -> ContactListResponse {
        if shouldFail {
            throw NetworkError.noInternetConnection
        }
        return mockContacts ?? ContactListResponse(results: [])
    }
}

class MockContactDatabaseDataSource: ContactDataBaseDataSourceProtocol {
    var savedContacts: [ContactEntity] = []
    var mockContacts: [ContactEntity] = []
    
    func saveContacts(_ contacts: [ContactEntity]) async throws {
        savedContacts = contacts
    }
    
    func fetchContacts() async throws -> [ContactEntity] {
        return mockContacts
    }
}

final class ContactRepositoryTests: XCTestCase {
    
    var repository: ContactRepository!
    var mockNetworkDataSource: MockContactRemoteDataSource!
    var mockDatabaseDataSource: MockContactDatabaseDataSource!
    
    override func setUp() {
        super.setUp()
        mockNetworkDataSource = MockContactRemoteDataSource()
        mockDatabaseDataSource = MockContactDatabaseDataSource()
        repository = ContactRepository(networkDataSource: mockNetworkDataSource, dataBaseDataSource: mockDatabaseDataSource)
    }
    
    override func tearDown() {
        repository = nil
        mockNetworkDataSource = nil
        mockDatabaseDataSource = nil
        super.tearDown()
    }
    
    // Test for successful network fetch
    func testGetContactsSuccess() async throws {
        // Given
        let mockContactResponse = createMockContactResponse()
        mockNetworkDataSource.mockContacts = ContactListResponse(results: [mockContactResponse])
        let expectedContacts = ContactMapper.mapContactsResponseToDomain(input: ContactListResponse(results: [mockContactResponse]))
        
        // When
        let contacts = try await repository.getContacts(results: 1, page: 1)
        try await mockDatabaseDataSource.saveContacts(contacts)
        
        // Then
        XCTAssertEqual(contacts.count, 1)
        XCTAssertEqual(contacts.first?.email, expectedContacts.first?.email)
        XCTAssertEqual(contacts.first?.name.first, expectedContacts.first?.name.first)
        XCTAssertEqual(contacts.first?.location.city, expectedContacts.first?.location.city)
        
        for (savedContact, expectedContact) in zip(mockDatabaseDataSource.savedContacts, expectedContacts) {
            XCTAssertEqual(savedContact.email, expectedContact.email)
            XCTAssertEqual(savedContact.name.first, expectedContact.name.first)
            XCTAssertEqual(savedContact.location.city, expectedContact.location.city)            
        }
    }
    
    // Test for failed network fetch with fallback to cached contacts
    func testGetContactsFailureWithFallback() async {
        // Given
        mockNetworkDataSource.shouldFail = true
        let mockCachedContact = createMockContactEntity()
        mockDatabaseDataSource.mockContacts = [mockCachedContact]
        
        do {
            // When
            _ = try await repository.getContacts(results: 1, page: 1)
            XCTFail("Expected error to be thrown, but it was not.")
        } catch let error as DataFetchError {
            // Then
            XCTAssertEqual(error.cachedContacts, [mockCachedContact])
            XCTAssertEqual(error.underlyingError as? NetworkError, NetworkError.noInternetConnection)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
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
    
    func createMockContactEntity() -> ContactEntity {
        return ContactEntity(
            id:UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            gender: "male",
            name: Name(title: "Mr", first: "John", last: "Doe"),
            location: Location(
                street: Location.Street(number: 123, name: "Main St"),
                city: "Springfield",
                state: "State",
                country: "Country",
                postcode: .stringPostcode("12345"),
                coordinates: Location.Coordinates(latitude: "0.0", longitude: "0.0"),
                timezone: Location.Timezone(offset: "+0:00", description: "UTC")
            ),
            email: "johndoe@example.com",
            phone: "123-456-7890",
            picture: Picture(large: "https://example.com/large.jpg", medium: "https://example.com/medium.jpg", thumbnail: "https://example.com/thumbnail.jpg")
        )
    }
    
}


