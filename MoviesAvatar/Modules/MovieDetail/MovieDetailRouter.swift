
import UIKit

class MovieDetailRouter: MovieDetailRouterProtocol{
    
    weak var viewController: UIViewController?
    
    static func createMovieDetailModule(movieId:Int) -> UIViewController {
        let presenter: MovieDetailPresenter & MovieDetailOutputInteractorProtocol = MovieDetailPresenter(movieId: movieId)
        let view = MovieDetailViewController(presenter: presenter)
        let interactor: MovieDetailInputInteractorProtocol = MovieDetailInteractor()
        let router: MovieDetailRouter = MovieDetailRouter()
        router.viewController = view
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    func goMovieDetail(idMovie: Int) {
        let vc = MovieDetailRouter.createMovieDetailModule(movieId: idMovie)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.showErrorAlert(error: error){ [weak self] in
                self?.back()
            }
        }
    }
    func back() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
