import Foundation

class MovieDetailInteractor: MovieDetailInputInteractorProtocol {
    
    var presenter: MovieDetailOutputInteractorProtocol?
    var moviesService: MoviesServiceProtocol = MoviesService()

    
    func getMoviesRecomended(movieId: Int) {
        moviesService.getMoviesRelated(id: movieId) {[weak self] movies in
            guard let movies else {
                self?.presenter?.serviceFailed(error: "No se pudieron cargar las peliculas")
                return
            }
            self?.presenter?.moviesRecomendedDidFetch(moviesResponse: movies)
        }
    }
    
    func getMovieDetail(movieId: Int) {
        moviesService.getMovieDetail(id: movieId) {[weak self] movie in
            guard let movie else {
                self?.presenter?.serviceFailed(error: "No se pudo cargar los detalles")
                return
            }
            self?.presenter?.movieDetailDidFetch(movieDetail: movie)
        }
    }
}
