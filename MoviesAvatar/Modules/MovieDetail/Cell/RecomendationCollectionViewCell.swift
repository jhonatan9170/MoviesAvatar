
import UIKit
import SkeletonView
import Kingfisher

class RecomendationCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var movieImage: UIImageView! {
        didSet{
            movieImage.isSkeletonable = true
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet{
            titleLabel.isSkeletonable = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSkeletonable = true
    }

    func configure(movie: MovieResponse){
        titleLabel.text = movie.title
        movieImage.kf.setImage(with: movie.getURLPoster(),placeholder: UIImage(named: "imagePlaceholder"))
    }
}
