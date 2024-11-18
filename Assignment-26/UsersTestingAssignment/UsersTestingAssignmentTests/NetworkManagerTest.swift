//
//  NetworkManagerTest.swift
//  UsersTestingAssignmentTests
//
//  Created by irakli kharshiladze on 17.11.24.
//

import XCTest
@testable import UsersTestingAssignment


final class NetworkManagerTest: XCTestCase {
    
    var mockNetworkManager: NetworkManagerProtocol!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testFetchUsersSuccess() {
        
        mockNetworkManager.fetchUsers(withLimit: 1) { users in
            XCTAssertEqual(users.count, 1)
            XCTAssertEqual(users.first?.name.first, "Christian")
        }
    }
    
    func testFetchUsersFailure() {
        if let mock = mockNetworkManager as? MockNetworkManager {
            mock.shouldReturnError = true
        }
        mockNetworkManager.fetchUsers(withLimit: 1) { users in
            XCTAssertTrue(users.isEmpty)
        }
    }
    
    func testFetchUsersWithExceedingLimit() {
        mockNetworkManager.fetchUsers(withLimit: 10) { users in
            XCTAssertEqual(users.count, 1)
            XCTAssertEqual(users.first?.name.first, "Christian")
        }
    }
}
