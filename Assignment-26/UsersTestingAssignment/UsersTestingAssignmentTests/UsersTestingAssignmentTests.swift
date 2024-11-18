//
//  UsersTestingAssignmentTests.swift
//  UsersTestingAssignmentTests
//
//  Created by irakli kharshiladze on 17.11.24.
//


import XCTest
@testable import UsersTestingAssignment

final class UsersTestingAssignmentTests: XCTestCase {
    
    var userViewModel: UserViewModel!
    var user: User?
    
    override func setUpWithError() throws {
        let jsonData = Data(User.jsonMock.utf8)
        let userList = try JSONDecoder().decode(UserList.self, from: jsonData)
        
        guard let firstUser = userList.results.first else {
            XCTFail("User not found")
            return
        }
        
        user = firstUser
        userViewModel = UserViewModel(user: firstUser)
    }
    
    override func tearDownWithError() throws {
        userViewModel = nil
        user = nil
    }
    
    func testFullName() throws {
        guard let user = user else {
            return
        }
        
        XCTAssertEqual(userViewModel.fullName, "\(user.name.title) \(user.name.first) \(user.name.last)", "Full name should be formatted correctly.")
    }
    
    func testIncompleteFullName() throws {
        guard let user = user else {
            return
        }
        
        XCTAssertNotEqual(userViewModel.fullName, "\(user.name.first) \(user.name.last)", "Full name should be formatted correctly.")
    }
    
    func testContactNumber() throws {
        guard let user = user else {
            return
        }
        
        XCTAssertEqual(userViewModel.contactNumber, [user.cell, user.phone].joined(separator: " / "), "Contact number should be formatted correctly.")
    }
    
    func testThubmanilImageURL() throws {
        guard let user = user else {
            return
        }
        
        XCTAssertEqual(userViewModel.thumbnailImageUrl, URL(string: user.picture.thumbnail), "Thumbnail image should be formatted correctly.")
    }
    
    func testEMail() throws {
        guard let user = user else {
            return
        }
        
        XCTAssertEqual(userViewModel.email, user.email, "Email should be formatted correctly.")
    }
}

