import Foundation

@MainActor
final class DataBaseViewModel: ObservableObject {
    // Movies
    @Published private(set) var trendings: [MovieModel] = []
    @Published private(set) var popular: [MovieModel] = []
    @Published private(set) var upcoming: [MovieModel] = []
    @Published private(set) var topRated: [MovieModel] = []
    
    // Series
    @Published private(set) var airingToday: [SeriesModel] = []
    @Published private(set) var popularSeries: [SeriesModel] = []
    @Published private(set) var onTheAirSeries: [SeriesModel] = []
    @Published private(set) var topRatedSeries: [SeriesModel] = []
    
    // Search
    @Published var searchDB: [SearchDBModel] = []
    
    private let favoritesManager = FavoritesService()
    private let webService = WebService()
    
    // Favorites
    @Published var favoriteMoviesAndSeries: Set<String> {
        didSet {
            favoritesManager.favoriteMoviesAndSeries = favoriteMoviesAndSeries
        }
    }
    
    init() {
        self.favoriteMoviesAndSeries = favoritesManager.favoriteMoviesAndSeries
        
        Task {
            await fetchAllData()
        }
    }
    
    private func fetchAllData() async {
        await withTaskGroup { group in
            group.addTask {
                await self.getTrendingsData()
            }
            
            group.addTask {
                await self.getPopularData()
            }
            
            group.addTask {
                await self.getUpcomingData()
            }
            
            group.addTask {
                await self.getTopRatedData()
            }
            
            group.addTask {
                await self.getAiringTodayData()
            }
            
            group.addTask {
                await self.getPopularSeriesData()
            }
            
            group.addTask {
                await self.getTopRatedSeriesData()
            }
            
            group.addTask {
                await self.getOnTheAirSeriesData()
            }
        }
    }

    func addFavorite(posterPath: String) {
        favoriteMoviesAndSeries.insert(posterPath)
    }

    func removeFavorite(posterPath: String) {
        favoriteMoviesAndSeries.remove(posterPath)
    }
    
    private func sortUpcomingMoviesByDate() {
        upcoming.sort { $1.releaseDate > $0.releaseDate }
    }
    
    private func sortTopRatedMoviesByRating() {
        topRated.sort { $0.voteAverage > $1.voteAverage }
    }
    
    private func sortTopRatedSeriesByRating() {
        topRatedSeries.sort { $0.voteAverage ?? 0 > $1.voteAverage ?? 0 }
    }
    
    func getYear(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return String(year)
        } else {
            return ""
        }
    }
    
    private func getTrendingsData() async {
        do {
            let result: MovieResults = try await webService.getTrendingsData()
            self.trendings = result.results
        } catch {
            print("Error fetching trendings: \(error)")
        }
    }
    
    private func getPopularData() async {
        do {
            let result: MovieResults = try await webService.getPopularData()
            self.popular = result.results
        } catch {
            print("Error fetching popular movies: \(error)")
        }
    }
    
    private func getUpcomingData() async {
        do {
            let result: MovieResults = try await webService.getUpcomingData()
            self.upcoming = result.results
            sortUpcomingMoviesByDate()
        } catch {
            print("Error fetching upcoming movies: \(error)")
        }
    }
    
    private func getTopRatedData() async {
        do {
            let result: MovieResults = try await webService.getTopRatedData()
            self.topRated = result.results
            sortTopRatedMoviesByRating()
        } catch {
            print("Error fetching top-rated movies: \(error)")
        }
    }
    
    private func getAiringTodayData() async {
        do {
            let result: SeriesResults = try await webService.getAiringTodayData()
            self.airingToday = result.results
        } catch {
            print("Error fetching airing today series: \(error)")
        }
    }
    
    private func getPopularSeriesData() async {
        do {
            let result: SeriesResults = try await webService.getTrendingSeriesData()
            self.popularSeries = result.results
        } catch {
            print("Error fetching popular series: \(error)")
        }
    }
    
    private func getTopRatedSeriesData() async {
        do {
            let result: SeriesResults = try await webService.getTopRatedSeriesData()
            self.topRatedSeries = result.results
            sortTopRatedSeriesByRating()
        } catch {
            print("Error fetching top-rated series: \(error)")
        }
    }
    
    private func getOnTheAirSeriesData() async {
        do {
            let result: SeriesResults = try await webService.getOnTheAirSeriesData()
            self.onTheAirSeries = result.results
        } catch {
            print("Error fetching on-the-air series: \(error)")
        }
    }
    
    func getSearchDBData(query: String) async {
        do {
            let result: SearchDBResults = try await webService.getSearchDBData(query: query)
            self.searchDB = result.results
        } catch {
            print("Error fetching search results: \(error)")
        }
    }
}
