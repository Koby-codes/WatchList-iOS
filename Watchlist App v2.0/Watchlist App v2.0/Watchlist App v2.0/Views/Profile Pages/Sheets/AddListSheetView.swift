import SwiftUI

struct AddListSheetView: View {
    let userName: String
    var onCreate: (UserList) -> Void

    @Environment(\.presentationMode) var presentationMode
    
    @State private var listTitle: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("List Details")) {
                    TextField("Enter list title", text: $listTitle)
                    Text("By \(userName)")
                        .foregroundColor(.secondary)
                }
            }
            .navigationBarTitle("Create New List", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Create") {
                    let newList = UserList(
                        title: listTitle,
                        createdBy: userName,
                        ownerRating: 7.5 // or 0.0, etc.
                    )
                    onCreate(newList)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(listTitle.isEmpty)
            )
        }
    }
}
