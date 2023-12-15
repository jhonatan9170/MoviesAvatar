import UIKit
import Kingfisher

class MovieListTableViewCell: UITableViewCell {
    
    
    @IBOutlet private weak var movieUIImage: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(movie: MovieResponse){
        titleLabel.text = movie.title
        movieUIImage.kf.setImage(with: movie.getURLPoster(),placeholder: UIImage(named: "imagePlaceholder"))
    }
}
