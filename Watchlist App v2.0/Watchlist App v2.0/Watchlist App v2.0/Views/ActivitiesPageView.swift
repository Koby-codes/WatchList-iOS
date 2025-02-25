import SwiftUI

struct ActivitiesPageView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Recent Activities")
                    .font(.title)
                    .padding()

                Spacer()
            }
            .navigationTitle("Activities")
        }
    }
}
