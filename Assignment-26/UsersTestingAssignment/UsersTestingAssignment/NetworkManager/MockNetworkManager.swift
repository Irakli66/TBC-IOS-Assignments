//
//  MockNetworkManager.swift
//  UsersTestingAssignment
//
//  Created by irakli kharshiladze on 17.11.24.
//

import Foundation

final class MockNetworkManager: NetworkManagerProtocol {
    
    var mockUsers: [User] = {
        guard let jsonData = User.jsonMock.data(using: .utf8) else {
            return []
        }
        
        do {
            let userList = try JSONDecoder().decode(UserList.self, from: jsonData)
            return userList.results
        } catch {
            return []
        }
    }()
    
    var shouldReturnError: Bool = false
    
    func fetchUsers(withLimit limit: Int, completionHandler: @escaping ([User]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if self.shouldReturnError {
                completionHandler([])
            } else {
                let users = Array(self.mockUsers.prefix(limit))
                completionHandler(users)
            }
        }
    }
}
