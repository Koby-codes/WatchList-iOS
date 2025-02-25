import SwiftUI

struct GroupsSheetView: View {
    @Binding var groups: [Group] // Use Binding to match FriendsSheetView
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText = ""
    @State private var groupName = ""
    @State private var groupDescription = ""
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search bar
                SearchBar(text: $searchText)
                    .padding()

                // Create group button
                Button(action: {
                    createGroup()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Create Group")
                    }
                }
                .padding(.bottom)
                .buttonStyle(BorderlessButtonStyle())
                
                Divider()

                // Groups list
                List {
                    ForEach(filteredGroups) { group in
                        NavigationLink(destination: GroupProfileView(group: group)) {
                            HStack {
                                Text(group.name)
                                Spacer()
                                Text(group.id)
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                            }
                        }
                        .contextMenu {
                            Button(role: .destructive) {
                                removeGroup(group)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Groups", displayMode: .inline)
            .navigationBarItems(leading: Button("Back") {
                dismiss() // Dismiss the sheet
            })
        }
    }
    
    // Filter groups based on search text
    private var filteredGroups: [Group] {
        if searchText.isEmpty {
            return groups
        } else {
            return groups.filter { $0.id.contains(searchText) }
        }
    }
    
    // Remove a group from the list
    private func removeGroup(_ group: Group) {
        groups.removeAll { $0.id == group.id }
    }
    
    // Create a new group
    private func createGroup() {
        guard !groupName.isEmpty else { return }
        
        // Generate a unique ID for the new group, can be adjusted as needed
        let newGroup = Group(id: UUID().uuidString, name: groupName, description: groupDescription)
        groups.append(newGroup)
        
        // Reset the group name input after adding
        groupName = ""
    }
}

// MARK: - SearchBar
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Search by unique group ID", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
