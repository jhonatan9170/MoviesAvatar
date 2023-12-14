
import UIKit

extension UIViewController {
    func showErrorAlert(error: String){
        let alert = UIAlertController(title: "Error",
                                      message: error,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

