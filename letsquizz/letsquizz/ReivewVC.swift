import UIKit

class ReviewVC: UIViewController {
    let model = Model()
    var counter: Int = 0
    
    
    @IBAction func finishReview(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var questionIndex: UILabel!
    
    
    @IBOutlet weak var questionTitle: UITextView!
    
    
    
    @IBOutlet weak var answer1: UILabel!
    @IBAction func answer1Button(_ sender: UIButton) {
    }
    
    
    @IBOutlet weak var answer2: UILabel!
    @IBAction func answer2Button(_ sender: UIButton) {
    }
    
    @IBOutlet weak var answer3: UILabel!
    @IBAction func answer3Button(_ sender: UIButton) {
    }
    
    @IBOutlet weak var answer4: UILabel!
    @IBAction func answer4Button(_ sender: UIButton) {
    }
    
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        counter += 1
        if (counter >= model.wrongQuestionsIndex.count) {counter -= 1}
        
        answer1.backgroundColor = UIColor.white
        answer2.backgroundColor = UIColor.white
        answer3.backgroundColor = UIColor.white
        answer4.backgroundColor = UIColor.white
        
        questionIndex.text = "Question " + String(model.wrongQuestionsIndex[counter]+1) + "/" + String(model.totalQuestionNumber)
        
        questionTitle.text = model.questions[model.wrongQuestionsIndex[counter]].questionTitle
        
        answer1.text = model.questions[model.wrongQuestionsIndex[counter]].answers[0]
        if (answer1.text == model.questions[model.wrongQuestionsIndex[counter]].rightAnswer) {
            answer1.backgroundColor = UIColor.green
        }
        
        answer2.text = model.questions[model.wrongQuestionsIndex[counter]].answers[1]
        if (answer2.text == model.questions[model.wrongQuestionsIndex[counter]].rightAnswer) {
            answer2.backgroundColor = UIColor.green
        }
        
        answer3.text = model.questions[model.wrongQuestionsIndex[counter]].answers[2]
        if (answer3.text == model.questions[model.wrongQuestionsIndex[counter]].rightAnswer) {
            answer3.backgroundColor = UIColor.green
        }
        
        answer4.text = model.questions[model.wrongQuestionsIndex[counter]].answers[3]
        if (answer4.text == model.questions[model.wrongQuestionsIndex[counter]].rightAnswer) {
            answer4.backgroundColor = UIColor.green
        }
        
        switch model.answersIndex[model.wrongQuestionsIndex[counter]] {
        case 1:
            answer1.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        case 2:
            answer2.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        case 3:
            answer3.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        case 4:
            answer4.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        default:
            0 + 1
        }
    }
    
    @IBAction func lastQuestion(_ sender: UIButton) {
        counter -= 1
        if (counter < 0) {counter += 1}
        
        answer1.backgroundColor = UIColor.white
        answer2.backgroundColor = UIColor.white
        answer3.backgroundColor = UIColor.white
        answer4.backgroundColor = UIColor.white
        
        questionIndex.text = "Question " + String(model.wrongQuestionsIndex[counter]+1) + "/" + String(model.totalQuestionNumber)
        
        questionTitle.text = model.questions[model.wrongQuestionsIndex[counter]].questionTitle
        
        answer1.text = model.questions[model.wrongQuestionsIndex[counter]].answers[0]
        if (answer1.text == model.questions[model.wrongQuestionsIndex[counter]].rightAnswer) {
            answer1.backgroundColor = UIColor.green
        }
        
        answer2.text = model.questions[model.wrongQuestionsIndex[counter]].answers[1]
        if (answer2.text == model.questions[model.wrongQuestionsIndex[counter]].rightAnswer) {
            answer2.backgroundColor = UIColor.green
        }
        
        answer3.text = model.questions[model.wrongQuestionsIndex[counter]].answers[2]
        if (answer3.text == model.questions[model.wrongQuestionsIndex[counter]].rightAnswer) {
            answer3.backgroundColor = UIColor.green
        }
        
        answer4.text = model.questions[model.wrongQuestionsIndex[counter]].answers[3]
        if (answer4.text == model.questions[model.wrongQuestionsIndex[counter]].rightAnswer) {
            answer4.backgroundColor = UIColor.green
        }
        
        switch model.answersIndex[model.wrongQuestionsIndex[counter]] {
        case 1:
            answer1.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        case 2:
            answer2.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        case 3:
            answer3.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        case 4:
            answer4.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        default:
            0 + 1
        }
        
    }
    
    override func viewDidLoad() {
//        print(model.answersIndex)
//        print(model.wrongQuestionsIndex)
//        print(model.answerSheet)
//        print(model.questions[model.wrongQuestionsIndex[counter]].rightAnswer)
        questionIndex.text = "Question " + String(model.wrongQuestionsIndex[counter]+1) + "/" + String(model.totalQuestionNumber)
        
        questionTitle.text = model.questions[model.wrongQuestionsIndex[counter]].questionTitle
        
        answer1.text = model.questions[model.wrongQuestionsIndex[counter]].answers[0]
        if (answer1.text == model.questions[model.wrongQuestionsIndex[counter]].rightAnswer) {
            answer1.backgroundColor = UIColor.green
        }
        
        answer2.text = model.questions[model.wrongQuestionsIndex[counter]].answers[1]
        if (answer2.text == model.questions[model.wrongQuestionsIndex[counter]].rightAnswer) {
            answer2.backgroundColor = UIColor.green
        }
        
        answer3.text = model.questions[model.wrongQuestionsIndex[counter]].answers[2]
        if (answer3.text == model.questions[model.wrongQuestionsIndex[counter]].rightAnswer) {
            answer3.backgroundColor = UIColor.green
        }
        
        answer4.text = model.questions[model.wrongQuestionsIndex[counter]].answers[3]
        if (answer4.text == model.questions[model.wrongQuestionsIndex[counter]].rightAnswer) {
            answer4.backgroundColor = UIColor.green
        }
        
        switch model.answersIndex[model.wrongQuestionsIndex[counter]] {
        case 1:
            answer1.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        case 2:
            answer2.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        case 3:
            answer3.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        case 4:
            answer4.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        default:
            0 + 1
        }
    }
}
