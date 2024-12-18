//
//  User.swift
//  SocialGraph
//
//  Created by Adriana Sofia on 17/12/24.
//

/// Represents a user in the social graph.
public struct User: Equatable, Hashable {
    /// The user's username, which must be unique in the service.
    public let username: String

    /// Whether or not the user should be considered visible
    /// when performing queries.
    public var isVisible: Bool

    /// The usernames of the user's friends.
    public private(set) var friends: [String]

    public init(
        username: String,
        isVisible: Bool = true,
        friends: [String] = []
    ) {
        self.username = username
        self.isVisible = isVisible
        self.friends = friends
    }

    /// Adds a username to the user's list of friends. Throws an
    /// error if the username cannot be added.
    public mutating func addFriend(username: String) throws {
        guard username != self.username else {
            throw SocialError.befriendingSelf
        }
        guard !friends.contains(username) else {
            throw SocialError.alreadyFriend(username: username)
        }
        
        
        
        friends.append(username)
    }
}
