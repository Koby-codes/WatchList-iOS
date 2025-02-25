import Foundation

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []

    func loadMovies(endpoint: String) {
        NetworkManager.shared.fetchMovies(endpoint: endpoint) { [weak self] movies in
            DispatchQueue.main.async {
                self?.movies = movies ?? []
            }
        }
    }
}
