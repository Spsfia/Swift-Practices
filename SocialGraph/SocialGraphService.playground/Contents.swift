// A Swift Tour: Explore Swift’s features and design
// December 17 2024

struct User {
    let username : String
    var isVisible : Bool = true
    private(set) var friends : [String] = []
    
    
    //By default methods on a struct can't modify the struct's properties
    //So it has to be declares mutating so it can change friends
    mutating func addFriends(username : String) throws {
        
        //We are going to chec if the input in addFriend func is invalid
        //and throw an error if it is
        //And if has to be specified on the function
        //In this case guards are better than ifs because it require
        //that we return from the function if the guard condition isn't met
        
        guard username != self.username else{
            throw SocialError.befriendingSelf
        }
        
        guard !friends.contains(username) else {
            throw SocialError.duplicateFriend (username: username)
        }

        friends.append(username)
    }
}

//A way to represent errors
enum SocialError: Error {
    case befriendingSelf
    case duplicateFriend(username : String)
}

var alice = User(username: "Alice")
//try alice.addFriends(username: "Charlie") //Should be marked with try keyword to indicate that an error my occur

//Triggering an error
do {
    try alice.addFriends(username: "Charlie")
    try alice.addFriends(username: "Charlie")
}catch{
    error
}
 
var allUsers = [
    "Alice" : alice
]


//In this function the return value becomes optional by adding a question mark
func findUser (_ username: String) -> User? {
    allUsers[username]
}


//One of the most common ways to unwrap an optional is to use the if let syntax
//Also in a situation where its 100% sure that there will be a valid value at runtime
//it can also use an exclamation point to to force unwrap an optional

if let charile = findUser("Charlie"){
    print("Found \(charile)")
} else {
    print ("Charlie not found")
}
