

import UIKit
import SkeletonView

class MovieDetailViewController: UIViewController {
    
    var presenter : MovieDetailPresenterProtocol
    
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var companyLabel: UILabel!
    @IBOutlet private weak var companyImage: UIImageView!
    @IBOutlet private weak var recomendacionesLabel: UILabel!
    @IBOutlet private weak var recomendacionesheightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var recomendacionesCollecionView: UICollectionView! {
        didSet {
            recomendacionesCollecionView.register(UINib(nibName: "RecomendationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecomendationCollectionViewCell")
            recomendacionesCollecionView.backgroundColor = .clear
        }
    }
    
    init(presenter: MovieDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: MovieDetailViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setSkeletonables()
        presenter.loadServices()
    }

    private func setDelegates(){
        recomendacionesCollecionView.dataSource = self
        recomendacionesCollecionView.delegate = self
    }
    
    private func setMovieDetail(movie: MovieDetailResponse){
        self.title = movie.title
        movieImage.kf.setImage(with: movie.getURLPoster(),placeholder: UIImage(named: "imagePlaceholder"))
        titleLabel.text = movie.title
        reviewLabel.text = String(movie.voteAverage)+"/10"
        releaseDateLabel.text = movie.releaseDate.toLegibleDate(inputFormat: "yyyy-MM-dd")
        overviewLabel.text = movie.overview
        companyLabel.text = movie.productionCompanies.first?.name
        companyImage.kf.setImage(with: movie.getURLCompanyImage(),placeholder: UIImage(named: "imagePlaceholder"))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "")
    }
    
    private func setSkeletonables(){
        movieImage.isSkeletonable = true
        titleLabel.isSkeletonable = true
        reviewLabel.isSkeletonable = true
        releaseDateLabel.isSkeletonable = true
        overviewLabel.isSkeletonable = true
        companyLabel.isSkeletonable = true
        companyImage.isSkeletonable = true
        recomendacionesCollecionView.isSkeletonable = true
        recomendacionesCollecionView.isSkeletonable = true
    }

    private func initSkeleton(){
        movieImage.showAnimatedGradientSkeleton()
        titleLabel.showAnimatedGradientSkeleton()
        reviewLabel.showAnimatedGradientSkeleton()
        releaseDateLabel.showAnimatedGradientSkeleton()
        overviewLabel.showAnimatedGradientSkeleton()
        companyLabel.showAnimatedGradientSkeleton()
        companyImage.showAnimatedGradientSkeleton()
        recomendacionesLabel.showAnimatedSkeleton()
    }
    
    private func stopSkeleton() {
        movieImage.hideSkeleton()
        titleLabel.hideSkeleton()
        reviewLabel.hideSkeleton()
        releaseDateLabel.hideSkeleton()
        overviewLabel.hideSkeleton()
        companyLabel.hideSkeleton()
        companyImage.hideSkeleton()
        recomendacionesLabel.hideSkeleton()
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, SkeletonCollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.moviesRecomended.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecomendationCollectionViewCell", for: indexPath) as! RecomendationCollectionViewCell
        let movieRecomended = presenter.movieRecomendedByIndex(index: indexPath.row)
        cell.configure(movie: movieRecomended)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showMovieSelection(index: indexPath.row)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "RecomendationCollectionViewCell"
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    func showMoviesRecomended() {
        DispatchQueue.main.async { [weak self] in
            self?.recomendacionesCollecionView.reloadData()
        }
    }
    
    func showMovieDetail(movieDetail : MovieDetailResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.setMovieDetail(movie: movieDetail)
        }
    }
    
    func updateRecommendationMoviewsLoading(isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            isLoading ? self?.recomendacionesCollecionView.showAnimatedSkeleton() : self?.recomendacionesCollecionView.hideSkeleton()
        }
    }
    
    func updateMovieDetailLoading(isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            isLoading ? self?.initSkeleton() : self?.stopSkeleton()
        }
    }
    
    func hideRecomendedSection() {
        DispatchQueue.main.async { [weak self] in
            self?.recomendacionesCollecionView.isHidden = true
            self?.recomendacionesLabel.isHidden = true
            self?.recomendacionesheightConstraint.constant = 0
        }
    }
    
}

