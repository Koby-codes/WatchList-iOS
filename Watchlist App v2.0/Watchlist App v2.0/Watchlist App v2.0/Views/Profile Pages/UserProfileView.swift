import SwiftUI

struct UserProfileView: View {
    // MARK: - Properties
    private let coverPhotoName = "cover_photo"
    private let profilePicName = "profile_picture"
    
    private let userBio = "Hello! I'm a big fan of movies, TV shows, and books."
    private let currentUserName = "Jad"
    
    @State private var showGroupsSheet = false
    @State private var groups: [Group] = [
        Group(id: "1", name: "Group 1", description: "Description 1"),
        Group(id: "2", name: "Group 2", description: "Description 2"),
        Group(id: "3", name: "Group 3", description: "Description 3")
    ]
    
    @State private var showFriendsSheet = false
    @State private var friends: [Friend] = [
        Friend(id: "abc123", name: "Alice"),
        Friend(id: "xyz789", name: "Bob")
    ]
    
    @State private var showAddListSheet = false
    @State private var userLists: [UserList] = []
    @State private var selectedList: UserList? = nil
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // 1) Extracted the profile header into a helper
                profileHeader
                
                // 2) Extracted the "My Lists" header + grid into another helper
                myListsSection
                
                Spacer(minLength: 30)
            }
        }
        .navigationBarTitle("My Profile")
        .sheet(isPresented: $showFriendsSheet) {
            FriendsSheetView(friends: $friends)
        }
        .sheet(isPresented: $showGroupsSheet) {
            GroupsSheetView(groups: $groups) // Pass as Binding
        }
        .sheet(isPresented: $showAddListSheet) {
            AddListSheetView(userName: currentUserName) { newList in
                userLists.append(newList)
            }
        }
        .sheet(item: $selectedList) { list in
            ListDetailSheetView(selectedList: list)
        }
    }
    
    // MARK: - Subviews
    private var profileHeader: some View {
        VStack(spacing: 16) {
            // Cover photo
//            Image(coverPhotoName)
//                .resizable()
//                .scaledToFill()
//                .frame(height: 200)
//                .clipped()
            
            // Profile pic
            Image(profilePicName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 2)
                )
                .shadow(radius: 4)
            
            // Short bio
            Text(userBio)
                .font(.subheadline)
                .padding(.horizontal)
            HStack {
            // Friends button
            Button {
                showFriendsSheet.toggle()
            } label: {
                    Image(systemName: "person.2")
                    Text("Friends")
            }
            Spacer()
            // Groups button
            Button {
                showGroupsSheet.toggle()
            } label: {
                    Image(systemName: "person.3")
                    Text("Groups")
                }
            }
            Spacer()
        }
    }
    
    private var myListsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 1) Extracted header
            myListsHeader
            
            // 2) Extracted grid
            myListsGrid
        }
    }
    
    private var myListsHeader: some View {
        HStack {
            Text("My Lists")
                .font(.title2)
                .bold()
            Spacer()
            Button(action: {
                showAddListSheet.toggle()
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
            }
        }
        .padding(.horizontal)
    }
    
    private var myListsGrid: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(userLists) { list in
                MyListButtonView(list: list, selectedList: $selectedList)
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Subview for Each List
    private struct MyListButtonView: View {
        let list: UserList
        @Binding var selectedList: UserList?
        
        var body: some View {
            Button {
                selectedList = list
            } label: {
                VStack {
                    Text(list.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("By \(list.createdBy)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Text(ratingString(list.ownerRating))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
                .frame(width: 150, height: 100)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            }
        }
        
        private func ratingString(_ rating: Float?) -> String {
            guard let rating = rating else {
                return "N/A"
            }
            return String(format: "%.1f/10", rating)
        }
    }
}
