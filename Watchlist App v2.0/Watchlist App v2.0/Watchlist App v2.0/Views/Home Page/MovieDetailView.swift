import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel = MovieDetailViewModel()
    let movieID: Int

    var body: some View {
        ScrollView {
            if let movie = viewModel.movieDetail {
                VStack(spacing: 16) {
                    
                    // ✅ Cover Photo Fully Extended Over Dynamic Island
                    ZStack(alignment: .bottomLeading) {
                        if let backdropPath = movie.backdrop_path {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)")) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width, height: 400)
                                    .clipped()
                                    .ignoresSafeArea(edges: .top) // ✅ Extends over Dynamic Island
                                    .overlay(
                                        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.3), Color.clear]),
                                                       startPoint: .bottom, endPoint: .top)
                                    )
                            } placeholder: {
                                Color.black.frame(height: 400)
                            }
                        }
                        
                        // ✅ Poster on Left & Title Block on Right
                        HStack(spacing: 15) {
                            if let posterPath = movie.poster_path {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w300\(posterPath)")) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.main.bounds.width * 0.35) // ✅ 35% of width
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(movie.title ?? "Unknown Title")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)

                                Text(movie.tagline ?? "")
                                    .italic()
                                    .foregroundColor(.white)

                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text("\(String(format: "%.1f", movie.vote_average ?? 0))/10")
                                        .foregroundColor(.yellow)
                                    Text("(\(movie.vote_count ?? 0) votes)")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    // ✅ Main Content (Centered)
                    VStack(alignment: .center, spacing: 16) {
                        if let genres = movie.genres, !genres.isEmpty {
                            Text("Genres: \(genres.map { $0.name }.joined(separator: ", "))")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }

                        Text(movie.overview ?? "No description available")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal)

                        if let runtime = movie.runtime {
                            Text("Duration: \(runtime) minutes")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }

                        // ✅ Streaming Services
                        if let providers = movie.watchProviders?.results?["US"]?.flatrate, !providers.isEmpty {
                            Text("Available on:").bold().foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(providers) { provider in
                                        VStack {
                                            if let logoPath = provider.logo_path {
                                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(logoPath)")) { image in
                                                    image.resizable().scaledToFit().frame(width: 60)
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                            }
                                            Text(provider.provider_name)
                                                .font(.caption)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                            }
                        }

                        // ✅ Trailer Section
                        if let trailer = movie.videos?.results.first(where: { $0.type == "Trailer" && $0.site == "YouTube" }) {
                            Button(action: {
                                if let url = URL(string: "https://www.youtube.com/watch?v=\(trailer.key)") {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                ZStack {
                                    AsyncImage(url: URL(string: "https://img.youtube.com/vi/\(trailer.key)/hqdefault.jpg")) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(height: 180)
                                            .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Image(systemName: "play.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50)
                                        .foregroundColor(.white)
                                        .opacity(0.8)
                                }
                            }
                        }

                        // ✅ Revenue & Budget
                        Text("Revenue: \(movie.revenue.map { "$\($0)" } ?? "Unknown")")
                            .italicIfUnknown(movie.revenue)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)

                        Text("Budget: \(movie.budget.map { "$\($0)" } ?? "Unknown")")
                            .italicIfUnknown(movie.budget)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 20)
                }
            } else {
                ProgressView("Loading movie details...").padding()
            }
        }
        .background(
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w780\(viewModel.movieDetail?.backdrop_path ?? "")")) { image in
                image.resizable()
                    .scaledToFill()
                    .blur(radius: 30)
                    .opacity(0.5)
                    .ignoresSafeArea()
            } placeholder: {
                Color.black.ignoresSafeArea()
            }
        )
        .onAppear {
            viewModel.loadMovieDetails(movieID: movieID)
            configureNavigationBar() // ✅ Ensures back button is styled correctly
        }
    }

    // ✅ Configure Navigation Bar Appearance
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground() // ✅ Removes shadow
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // ✅ Set text to white
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.buttonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

// ✅ Helper Modifier to Italicize "Unknown"
extension Text {
    func italicIfUnknown(_ value: Any?) -> Text {
        if value == nil || (value as? Int) == 0 {
            return self.italic().foregroundColor(.gray)
        }
        return self
    }
}
