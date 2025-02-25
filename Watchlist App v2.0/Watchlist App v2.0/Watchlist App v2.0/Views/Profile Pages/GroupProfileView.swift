import SwiftUICore
struct GroupProfileView: View {
    let group: Group
        
        var body: some View {
            VStack {
                Text(group.name)
                    .font(.title)
                    .padding()
                Text(group.description) // Ensure `Group` has a `description` property
                    .font(.body)
                    .foregroundColor(.gray)
                Spacer()
            }
            .navigationTitle(group.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
