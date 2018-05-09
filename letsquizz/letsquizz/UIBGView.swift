import Foundation

import UIKit
extension UIViewController {
func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

func addBackground() {
    // screen width and height:
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
    imageViewBackground.image = UIImage(named: "iosbg.png")
    
    imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
    
    self.view.addSubview(imageViewBackground)
    self.view.sendSubview(toBack: imageViewBackground)
}
}
