import Foundation



struct NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "e577f3394a629d69efa3a9414e172237"
    private let baseURL = "https://api.themoviedb.org/3"
    
    func fetchMovies(endpoint: String, completion: @escaping ([Movie]?) -> Void) {
        let urlString = "\(baseURL)\(endpoint)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        Foundation.URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data:", error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.results)
                }
            } catch {
                print("Error decoding JSON:", error)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    func fetchMovieDetails(movieID: Int, completion: @escaping (MovieDetail?) -> Void) {
        let urlString = "\(baseURL)/movie/\(movieID)?api_key=\(apiKey)&append_to_response=videos,credits,watch/providers"

        print("📡 Fetching movie details: \(urlString)")

        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Network Error:", error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("📡 HTTP Response Code: \(httpResponse.statusCode)")
            }

            guard let data = data else {
                print("❌ No data received")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            // ✅ Print the entire JSON response to check if "runtime" exists
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📡 API Response JSON: \(jsonString)")
            }

            do {
                let response = try JSONDecoder().decode(MovieDetail.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("❌ JSON Decoding Error:", error)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }




}

