
import Foundation

extension MovieResponse {
    
    func getURLPoster() -> URL? {
        guard let posterPath = self.posterPath else {
            return nil
        }
        return URL(string: Constants.baseImageURL200 + posterPath)
    }
    
}
