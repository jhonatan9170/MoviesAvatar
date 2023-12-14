
import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView! {
        didSet {

            moviesTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
            moviesTableView.backgroundColor = .clear
            moviesTableView.backgroundColor = .clear
        }
    }

    init() {
        super.init(nibName: String(describing: MovieListViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
    }

    func setupDelegates() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
    
    func setupViews() {
        self.title = "Upcoming Movies"
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "")
    }
}

extension MovieListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
