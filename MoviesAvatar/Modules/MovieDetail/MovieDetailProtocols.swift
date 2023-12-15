
import UIKit


protocol MovieDetailViewProtocol: AnyObject {
    func showMoviesRecomended()
    func showMovieDetail(movieDetail : MovieDetailResponse)
    func updateRecommendationMoviewsLoading(isLoading:Bool)
    func updateMovieDetailLoading(isLoading:Bool)
    func hideRecomendedSection()

}

protocol MovieDetailPresenterProtocol: AnyObject {
    
    var moviesRecomended: [MovieResponse] {get}
    
    var interactor: MovieDetailInputInteractorProtocol? {get set}
    var view: MovieDetailViewProtocol? {get set}
    var router: MovieDetailRouterProtocol? {get set}
    
    func showMovieSelection(index: Int)
    func loadServices()
    func movieRecomendedByIndex(index: Int) -> MovieResponse
}

protocol MovieDetailInputInteractorProtocol: AnyObject {
    var presenter: MovieDetailOutputInteractorProtocol? {get set}
    func getMoviesRecomended(movieId:Int)
    func getMovieDetail(movieId:Int)
}

protocol MovieDetailOutputInteractorProtocol: AnyObject {
    func moviesRecomendedDidFetch(moviesResponse: MovieListResponse)
    func movieDetailDidFetch(movieDetail: MovieDetailResponse)
    func serviceFailed(error:String)
}

protocol MovieDetailRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    static func createMovieDetailModule(movieId:Int) -> UIViewController
    
    func goMovieDetail(idMovie: Int)
    func showError(error: String)
}
