
import UIKit

var spinnerView : UIView?

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset : CGSize{
        
        get{
            return layer.shadowOffset
        }set{
            
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var shadowOpacity : Float {
        
        get{
            return layer.shadowOpacity
        }
        set {
            
            layer.shadowOpacity = newValue
            
        }
    }
    func addSpinner() {
         spinnerView = UIView(frame: self.bounds)
         guard let spinnerView = spinnerView else {
             return
         }
         spinnerView.backgroundColor = .gray.withAlphaComponent(0.5)
         
         let activityIndicator = UIActivityIndicatorView(style: .medium)
         activityIndicator.center = self.center
         activityIndicator.startAnimating()
         spinnerView.addSubview(activityIndicator)
         addSubview(spinnerView)
         
     }
     
     func removeSpinner() {
         spinnerView?.removeFromSuperview()
         spinnerView = nil
     }
}
