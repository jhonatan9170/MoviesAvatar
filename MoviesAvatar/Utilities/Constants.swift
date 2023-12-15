
import Foundation

class Constants {
    
    static let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    static let baseImageURL = Bundle.main.infoDictionary?["BASE_IMAGE_URL"] as? String ?? ""
    static let baseImageURL200 = baseImageURL+"w200"
    static let baseImageURL500 = baseImageURL+"w500"

    static let getMoviesByPageURL = baseURL + "popular?page="
    
    static let authorizacionKey = (Bundle.main.infoDictionary?["AUTORIZACION_KEY"] as? String ?? "").replacingOccurrences(of: "\"", with: "")

    static let pinnedPublicKeyHash = (Bundle.main.infoDictionary?["PINNED_PUBLIC_KEY_HASH"] as? String ?? "").replacingOccurrences(of: "\"", with: "")
}

