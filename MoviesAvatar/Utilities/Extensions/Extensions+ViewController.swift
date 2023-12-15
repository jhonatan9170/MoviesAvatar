
import UIKit

extension UIViewController {
    func showErrorAlert(error: String, completion:@escaping() -> Void = {}){
        let alert = UIAlertController(title: "Error",
                                      message: error,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){ _ in
            completion()
        }
                                     
                                     alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

