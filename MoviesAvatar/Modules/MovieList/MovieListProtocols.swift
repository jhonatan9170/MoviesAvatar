
import UIKit

protocol MovieListViewProtocol: AnyObject {
        
    func showMovies()
    func updateLoading(isLoading:Bool)

}

protocol MovieListPresenterProtocol: AnyObject {
    
    var movies: [MovieResponse] {get}
    
    var interactor: MovieListInputInteractorProtocol? {get set}
    var view: MovieListViewProtocol? {get set}
    var router: MovieListRouterProtocol? {get set}

    func loadMovies()
    func showMovieSelection(index: Int)
    func movieByIndex(index: Int) -> MovieResponse
}

protocol MovieListInputInteractorProtocol: AnyObject {
    var presenter: MovieListOutputInteractorProtocol? {get set}
    func getMovieList(page:Int)
}

protocol MovieListOutputInteractorProtocol: AnyObject {
    func moviestListDidFetch(moviesResponse: MovieListResponse)
    func moviesListFailed(error:String)
}

protocol MovieListRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    static func createMovieListModule() -> UIViewController

    func goMovieDetail(idMovie: Int)
    func showError(error: String)
}
