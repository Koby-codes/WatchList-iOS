import SwiftUI

struct FriendsSheetView: View {
    @Binding var friends: [Friend]
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search bar
                TextField("Search by unique friend ID", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Add friend button
                Button(action: {
                    addFriend(by: searchText)
                }) {
                    HStack {
                        Image(systemName: "person.badge.plus")
                        Text("Add Friend")
                    }
                }
                .padding(.bottom)
                .buttonStyle(BorderlessButtonStyle())
                
                Divider()
                
                // Friends list
                List {
                    ForEach(friends) { friend in
                        HStack {
                            Text(friend.name)
                            Spacer()
                            Text(friend.id)
                                .foregroundColor(.gray)
                                .font(.footnote)
                            
                            Button(role: .destructive) {
                                removeFriend(friend)
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
            .navigationBarTitle("Friends", displayMode: .inline)
            .navigationBarItems(leading: Button("Back") {
                dismiss()
            })
        }
    }
    
    private func addFriend(by id: String) {
        guard !id.isEmpty else { return }
        
        if !friends.contains(where: { $0.id == id }) {
            // Real app might do a user lookup here
            let newFriend = Friend(id: id, name: "Friend \(id.prefix(5))")
            friends.append(newFriend)
        }
        searchText = ""
    }
    
    private func removeFriend(_ friend: Friend) {
        friends.removeAll(where: { $0.id == friend.id })
    }
}
