
import UIKit

class MovieListRouter: MovieListRouterProtocol{
    
    var viewController: UIViewController?
    
    static func createMovieListModule() -> UIViewController {
        let presenter: MovieListPresenter & MovieListOutputInteractorProtocol = MovieListPresenter()
        let view = MovieListViewController(presenter: presenter)
        let interactor: MovieListInputInteractorProtocol = MovieHomeInteractor()
        let router: MovieListRouter = MovieListRouter()
        router.viewController = view
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: view)

        return navigationController
    }
    
    func goMovieDetail(idMovie: Int) {
    
    }
    
    func showError(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.showErrorAlert(error: error)
        }
    }
}
