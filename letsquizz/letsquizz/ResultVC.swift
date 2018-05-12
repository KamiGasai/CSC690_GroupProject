

import UIKit

class ResultVC: UIViewController {
    let answer = Model()
    
    @IBOutlet weak var scores: UILabel!
    
    @IBOutlet weak var comments: UILabel!
    
    override func viewDidLoad() {
        answer.scores = answer.evaluateTestResult()
        scores.text = String(answer.scores)
        
        if (answer.scores == 100.0) {
            comments.text = "Perfect!"
        } else if (answer.scores > 0.0) {
            comments.text = "You should work harder."
        } else if (answer.scores > 60.0) {
            comments.text = "Not bad, review and try again."
        } else if (answer.scores > 80.0) {
            comments.text = "Good job."
        } else {
            
        }
        
        
    }
}
