
import Foundation

extension MovieDetailResponse {
    
    func getURLPoster() -> URL? {
        return URL(string: Constants.baseImageURL500 + self.posterPath)
    }
    
    func getURLCompanyImage() -> URL? {
        guard let companyImagePath = self.productionCompanies.first?.logoPath else{
            return nil
        }
        return URL(string: Constants.baseImageURL200 + companyImagePath)
    }
}
