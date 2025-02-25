import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationView { // ✅ Ensure NavigationView is present
            ScrollView {
                VStack(spacing: 20) {
                    MovieListView(title: "Trending Movies", endpoint: "/trending/movie/week")
                    MovieListView(title: "Trending TV Shows", endpoint: "/trending/tv/week")
                    MovieListView(title: "Now Playing", endpoint: "/movie/now_playing")
                    MovieListView(title: "Top Rated Movies", endpoint: "/movie/top_rated")
                    MovieListView(title: "Top Rated TV Shows", endpoint: "/tv/top_rated")
                    MovieListView(title: "Comedy Movies", endpoint: "/discover/movie?with_genres=35")
                }
            }
            .navigationTitle("Movies & TV Shows")
        }
    }
}
