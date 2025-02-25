import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel = MovieListViewModel()
    let title: String
    let endpoint: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.leading, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieID: movie.id)) { // ✅ Wrap inside NavigationLink
                            VStack {
                                if let posterPath = movie.poster_path {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .cornerRadius(10)
                                            .frame(width: 120)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                Text(movie.title ?? "Unknown")
                                    .font(.caption)
                                    .frame(width: 120)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .onAppear {
            viewModel.loadMovies(endpoint: endpoint)
        }
    }
}
