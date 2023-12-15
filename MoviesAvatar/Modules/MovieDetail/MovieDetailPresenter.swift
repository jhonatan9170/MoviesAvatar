
import UIKit

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    var movieId:Int
    
    var moviesRecomended: [MovieResponse] {
        return _moviesRecomended
    }
    
    private var _moviesRecomended = [MovieResponse]()
    
    var interactor: MovieDetailInputInteractorProtocol?
    
    var view: MovieDetailViewProtocol?
    
    var router: MovieDetailRouterProtocol?
    
    init(movieId: Int){
        self.movieId = movieId
    }
    
    func loadServices() {
        view?.updateMovieDetailLoading(isLoading: true)
        view?.updateRecommendationMoviewsLoading(isLoading: true)
        interactor?.getMovieDetail(movieId: movieId)
    }
    
    func showMovieSelection(index: Int) {
        let movieId = _moviesRecomended[index].id
        router?.goMovieDetail(idMovie: movieId)
    }
    
    func movieRecomendedByIndex(index: Int) -> MovieResponse {
        return _moviesRecomended[index]
    }

}

extension MovieDetailPresenter: MovieDetailOutputInteractorProtocol {
    
    func moviesRecomendedDidFetch(moviesResponse: MovieListResponse) {
        self._moviesRecomended = moviesResponse.results
        view?.updateRecommendationMoviewsLoading(isLoading: false)
        self._moviesRecomended.isEmpty ? view?.hideRecomendedSection() : view?.showMoviesRecomended()
    }
    
    func movieDetailDidFetch(movieDetail: MovieDetailResponse) {
        interactor?.getMoviesRecomended(movieId: movieId)
        view?.updateMovieDetailLoading(isLoading: false)
        view?.showMovieDetail(movieDetail: movieDetail)
    }
    
    func movieDetailFetchFail(error: String) {
        view?.updateMovieDetailLoading(isLoading: false)
        router?.showError(error: error)

    }
    
    func movieRecomendedFetchFail(error: String) {
        view?.updateRecommendationMoviewsLoading(isLoading: false)
        view?.hideRecomendedSection()
        router?.showError(error: error)
    }
    
}
