//
//  SocialError.swift
//  SocialGraph
//
//  Created by Adriana Sofia on 17/12/24.
//

///An enmumeration of errors that can be thrown by social graph
///operations.

public enum SocialError: Error, Equatable, Hashable{
    ///The friends on the list of a user cannot contain themselves.
    case befriendingSelf
    
    ///The friends list of a user cannot contain the given username more than once.
    case alreadyFriend(username: String)
    
    
    case userNotFound
}
