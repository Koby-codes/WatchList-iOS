import SwiftUI


struct ProfilePageView: View {

    var body: some View {
        NavigationView {
            VStack {
                // Default view is UserProfileView
                UserProfileView()

                // Buttons for Friends and Groups
                

                    
                }
                .padding(.top, 10)
            }
            .navigationTitle("Profiles")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}
