
import Foundation

class MovieHomeInteractor: MovieListInputInteractorProtocol {

    
    var presenter: MovieListOutputInteractorProtocol?
    var moviesService: MoviesServiceProtocol = MoviesService()

    func getMovieList(page: Int) {
        moviesService.getPopularMovies(page: page) {[weak self] movies in
            guard let movies else {
                self?.presenter?.moviesListFailed(error: "No se pudieron cargar las peliculas")
                return
            }
            self?.presenter?.moviestListDidFetch(moviesResponse: movies)
        }
    }
}
