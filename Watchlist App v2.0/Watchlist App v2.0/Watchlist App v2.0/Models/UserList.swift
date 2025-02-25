import Foundation

struct UserList: Identifiable {
    let id = UUID()
    let title: String
    let createdBy: String
    var ownerRating: Float?  //optional
}
