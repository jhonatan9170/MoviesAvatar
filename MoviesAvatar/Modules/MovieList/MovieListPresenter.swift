
import UIKit

class MovieListPresenter: MovieListPresenterProtocol {

    var movies: [MovieResponse] {
        return _movies
    }
    
    private var _movies = [MovieResponse]()
    private var page = 1
    private var totalPages:Int = 1

    
    var router: MovieListRouterProtocol?
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInputInteractorProtocol?
    
    func loadMovies() {
        if  page <= totalPages {
            view?.updateLoading(isLoading: true)
            interactor?.getMovieList(page: page)
        }
    }
    
    func showMovieSelection(index: Int) {
        let idMovie = _movies[index].id
        router?.goMovieDetail(idMovie: idMovie)
    }
    
    func movieByIndex(index: Int) -> MovieResponse {
        return _movies[index]
    }
    
}

extension MovieListPresenter: MovieListOutputInteractorProtocol {
    
    func moviesListFailed(error: String) {
        view?.updateLoading(isLoading: false)
        router?.showError(error: error)
    }
    
    func moviestListDidFetch(moviesResponse: MovieListResponse) {
        view?.updateLoading(isLoading: false)
        self._movies.append(contentsOf: moviesResponse.results)
        page+=1
        self.totalPages = moviesResponse.totalPages
        view?.showMovies()
    }
}
