
import UIKit

class MovieListViewController: UIViewController {

    var presenter: MovieListPresenterProtocol
    
    @IBOutlet private weak var moviesTableView: UITableView! {
        didSet {
            moviesTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        }
    }

    init(presenter: MovieListPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: MovieListViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
        presenter.loadMovies()
    }

    private func setupDelegates() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
    
    private func setupViews() {
        self.title = "Upcoming Movies"
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "")
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    }
}

extension MovieListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        let movie = presenter.movieByIndex(index: indexPath.row)
        cell.configure(movie: movie)
        if indexPath.row == presenter.movies.count - 1 {
            presenter.loadMovies()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.showMovieSelection(index: indexPath.row)
    }


}

extension MovieListViewController: MovieListViewProtocol {
    func showMovies() {
        DispatchQueue.main.async {[weak self] in
            self?.moviesTableView.reloadData()
        }
    }
    func updateLoading(isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isLoading {
                self?.view.addSpinner()
            } else {
                self?.view.removeSpinner()
            }
        }
    }
}

