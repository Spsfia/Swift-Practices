//
//  File.swift
//  SocialGraph
//
//  Created by Adriana Sofia on 17/12/24.
//

/// An in-memory store for users of the service.
public class UserStore {
    var allUsers: [String: User] = [:]
}

extension UserStore {
    /// If the username maps to a User and that user is visible,
    /// returns the User. Returns nil otherwise.
    public func lookUpUser(_ username: String) -> User? {
        guard let user = allUsers[username],
              user.isVisible else {
            return nil
        }
        return user
    }

    /// If the username maps to a User and that user is visible,
    /// returns the User. Otherwise, throws an error.
    public func user(for username: String) throws -> User {
        guard let user = lookUpUser(username) else {
            throw SocialError.userNotFound(username: username)
        }
        return user
    }

    public func friendsOfFriends(_ username: String) throws -> [String] {
        let user = try user(for: username)
        let excluded = Set(user.friends + [username])
        return user.friends
            .compactMap { lookUpUser($0) }      // [String] -> [User]
            .flatMap { $0.friends }             // [User] -> [String]
            .filter { !excluded.contains($0) }  // drop excluded
            .uniqued()
    }
}

extension Collection where Element: Hashable {
    func uniqued() -> [Element] {
        let unique = Set(self)
        return Array(unique)
    }
}
