import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?

    func loadMovieDetails(movieID: Int) {
        NetworkManager.shared.fetchMovieDetails(movieID: movieID) { [weak self] details in
            self?.movieDetail = details
        }
    }
}
