//import SwiftUI
//
//
//struct GroupsView: View {
//    // Sample data for groups (replace with your actual data source)
//    let groups: [GroupModel] = [
//        GroupModel(name: "Group 1", description: "This is Group 1"),
//        GroupModel(name: "Group 2", description: "This is Group 2"),
//        GroupModel(name: "Doha Byeklo", description: "bil sheber"),
//        GroupModel(name: "Drayre Watchlist", description: "Best of Drayre Bois")
//    ]
//
//    // Environment variable to dismiss the sheet
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        NavigationView {
//            List(groups) { group in
//                NavigationLink(destination: GroupProfileView(group: group)) {
//                    Text(group.name)
//                }
//            }
//            .toolbar {
//                // Back button on the top left
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        // Dismiss the sheet
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(.blue)
//                        Text("Back")
//                            .foregroundColor(.blue)
//                    }
//                }
//            }
//        }
//    }
//}
