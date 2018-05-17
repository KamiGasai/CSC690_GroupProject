

import UIKit

class ResultVC: UIViewController {
    let model = Model()
    
    @IBOutlet weak var scores: UILabel!
    
    @IBOutlet weak var comments: UILabel!
    
    override func viewDidLoad() {
        model.scores = model.evaluateTestResult()
        scores.text = String(model.scores)
        self.addBackground()
        
        if (model.scores == 100.0) {
            comments.text = "Perfect!"
        } else if (model.scores > 0.0) {
            comments.text = "You should work harder."
        } else if (model.scores > 60.0) {
            comments.text = "Not bad, review and try again."
        } else if (model.scores > 80.0) {
            comments.text = "Good job."
        } else {
            
        }
    
    }
    
    @IBAction func reviewWrongQuestions(_ sender: UIButton) {
       performSegue(withIdentifier: "review", sender: self)
    }
    
    @IBAction func quitTest(_ sender: Any) {
//        self.dismiss(animated: false, completion: {self.presentingViewController?.dismiss(animated: false, completion: nil)})
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let Temp = segue.destination as? ReviewVC else {
            return
        }
        Temp.model.answerSheet = model.answerSheet
        Temp.model.wrongQuestionsIndex = model.wrongQuestionsIndex
        Temp.model.answersIndex = model.answersIndex
        Temp.model.questions = model.questions
    }
    
    
    
}
