

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var companyImage: UILabel!
    @IBOutlet weak var recomendacionesCollecionView: UICollectionView! {
        didSet {
            recomendacionesCollecionView.register(UINib(nibName: "RecomendationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecomendationCollectionViewCell")
            recomendacionesCollecionView.backgroundColor = .clear
        }
    }
    
    init() {
        super.init(nibName: String(describing: MovieDetailViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }


    func setDelegates(){
        recomendacionesCollecionView.dataSource = self
        recomendacionesCollecionView.delegate = self
    }

}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecomendationCollectionViewCell", for: indexPath) as! RecomendationCollectionViewCell
        return cell
        
    }
}
