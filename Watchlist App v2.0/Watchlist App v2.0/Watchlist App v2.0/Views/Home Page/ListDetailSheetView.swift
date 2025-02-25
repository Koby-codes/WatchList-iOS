import SwiftUI

struct ListDetailSheetView: View {
    // The selected list with an optional ownerRating
    let selectedList: UserList
    
    // Local state for editing the owner's rating
    @State private var localOwnerRating: Float? = nil

    @Environment(\.dismiss) var dismiss
    
    // Search bar text (no button; user taps Return)
    @State private var searchQuery: String = ""
    
    // Toggle for showing the overlay
    @State private var showRatingsPopup = false
    
    // Dummy friend ratings for demonstration
    private let dummyFriendRatings: [(name: String, rating: Float)] = [
        ("Steve", 8.6),
        ("Alice", 7.4),
        ("Bob",   9.1),
        ("Carol", 6.8),
        ("Eve",   7.9)
    ]
    
    var body: some View {
        ZStack {
            // Entire sheet: one background color
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)

            // Main content
            NavigationView {
                VStack(spacing: 0) {
                    // Top search bar (no button)
                    searchBar

                    // Scrollable content
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            // Title + "By creator" on the same line
                            titleRow

                            Divider()

                            // Dummy items to showcase layout
                            ForEach(0..<5) { i in
                                Text("Dummy Item #\(i+1)")
                                    .font(.body)
                                    .padding(.vertical, 2)
                            }

                            Spacer(minLength: 20)
                        }
                        .padding()
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        // Back button on the left
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Back") {
                                dismiss()
                            }
                        }
                        // Ratings button on the right
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Ratings") {
                                if localOwnerRating == nil {
                                    localOwnerRating = selectedList.ownerRating
                                }
                                withAnimation {
                                    showRatingsPopup = true
                                }
                            }
                        }
                    }
                }
            }
            
            // Ratings overlay popup
            if showRatingsPopup {
                overlayBackground
                ratingsPopup
            }
        }
        .onAppear {
            // Initialize local rating if needed
            if localOwnerRating == nil {
                localOwnerRating = selectedList.ownerRating
            }
        }
    }
    
    // MARK: - Subviews
    
    // Simple text field at the top. User can press Return to search.
    private var searchBar: some View {
        TextField("Search movies / TV shows", text: $searchQuery)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
//            /*.background(Color(UIColor.secondarySystemBackground)*/)
    }
    
    // Centered title + right-aligned "By ..."
    private var titleRow: some View {
        HStack {
            // Center the title
            Spacer()
            Text(selectedList.title)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)              // Limit to one line
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            // Right-aligned creator label
            Text("By \(selectedList.createdBy)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    // Semi-transparent background overlay that dismisses on tap
    private var overlayBackground: some View {
        Color.black.opacity(0.4)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                // Dismiss popup when user taps outside
                withAnimation {
                    showRatingsPopup = false
                }
            }
    }
    
    // The card showing friend ratings and a slider for the owner's rating
    private var ratingsPopup: some View {
        VStack(spacing: 16) {
            Text("Friend Ratings")
                .font(.headline)
            
            // Display dummy friend ratings
            ForEach(dummyFriendRatings, id: \.name) { item in
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(item.name)
                    Spacer()
                    Text(String(format: "%.1f/10", item.rating))
                        .foregroundColor(.secondary)
                }
            }
            
            Divider()
                .padding(.vertical, 8)
            
            // Let the owner adjust their rating if they created this list
            if selectedList.createdBy == "Ray" {
                Text("Your Rating")
                    .font(.subheadline)
                
                HStack {
                    let displayRating = localOwnerRating ?? 0.0
                    Text(String(format: "%.1f", displayRating))
                    
                    Slider(
                        value: Binding(
                            get: { localOwnerRating ?? 0.0 },
                            set: { newValue in localOwnerRating = newValue }
                        ),
                        in: 0...10,
                        step: 0.1
                    )
                }
                .padding(.horizontal)
                
                Button("Save Rating") {
                    // Save rating changes if needed, then dismiss
                    withAnimation {
                        showRatingsPopup = false
                    }
                }
                .padding(.top, 8)
            }
        }
        .padding()
        .frame(width: 320)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 8)
    }
}
