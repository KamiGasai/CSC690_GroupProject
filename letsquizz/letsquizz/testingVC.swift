import UIKit

class testingVC: UIViewController {
   
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var startbutton: UIButton!
    @IBOutlet weak var pausebutton: UIButton!
    
    var timer = Timer()
    var counter = 0.0
    var isRunning = false
    
    @IBAction func startButton(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        startbutton.isEnabled = false
        pausebutton.isEnabled = true
        isRunning = true
    }
    @objc func UpdateTimer() {
        counter += 0.1
        titlelabel.text = String(format: "%.1f", counter)
    }
    
    
    @IBAction func pauseButton(_ sender: UIButton) {
        
        timer.invalidate()
        startbutton.isEnabled = true
        pausebutton.isEnabled = false
        isRunning = false
    }
    
    
    
    
    let question = Model()
    @IBOutlet weak var questionTitle: UITextView!
    
    @IBOutlet weak var numberOfCurrentQuestion: UILabel!
    
    @IBOutlet weak var answer1Title: UILabel!
    @IBAction func answer1(_ sender: UIButton) {
        question.answerSheet[question.currentNumberOfQuestion] = answer1Title.text!
        question.answersIndex[question.currentNumberOfQuestion] = 1
        answer1Title.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        answer2Title.backgroundColor = UIColor.white
        answer3Title.backgroundColor = UIColor.white
        answer4Title.backgroundColor = UIColor.white
    }
    
    @IBOutlet weak var answer2Title: UILabel!
    @IBAction func answer2(_ sender: UIButton) {
        question.answerSheet[question.currentNumberOfQuestion] = answer2Title.text!
        question.answersIndex[question.currentNumberOfQuestion] = 2
        answer1Title.backgroundColor = UIColor.white
        answer2Title.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        answer3Title.backgroundColor = UIColor.white
        answer4Title.backgroundColor = UIColor.white
    }
    
    @IBOutlet weak var answer3Title: UILabel!
    @IBAction func answer3(_ sender: UIButton) {
        question.answerSheet[question.currentNumberOfQuestion] = answer3Title.text!
        question.answersIndex[question.currentNumberOfQuestion] = 3
        answer1Title.backgroundColor = UIColor.white
        answer2Title.backgroundColor = UIColor.white
        answer3Title.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
        answer4Title.backgroundColor = UIColor.white
    }
    
    @IBOutlet weak var answer4Title: UILabel!
    @IBAction func answer4(_ sender: UIButton) {
        question.answerSheet[question.currentNumberOfQuestion] = answer4Title.text!
        question.answersIndex[question.currentNumberOfQuestion] = 4
        answer1Title.backgroundColor = UIColor.white
        answer2Title.backgroundColor = UIColor.white
        answer3Title.backgroundColor = UIColor.white
        answer4Title.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.addBackground()
        
        titlelabel.text = "\(counter)" //0.0
        startbutton.isEnabled = true
        pausebutton.isEnabled = false
        
        question.randomlyOrderedAnswers = question.answerOrderRandomGenerator(Answers: question.questions[question.numberOfAnswered].answers)
        questionTitle.text = question.questions[question.numberOfAnswered].questionTitle
        numberOfCurrentQuestion.text = "Question " + String(question.numberOfAnswered + 1) + "/" + String(question.answerSheet.count)
        answer1Title.text = question.questions[question.numberOfAnswered].answers[question.counter]
        //        answer1Title.text = question.randomlyOrderedAnswers[question.counter]
        question.counter += 1
        answer2Title.text = question.questions[question.numberOfAnswered].answers[question.counter]
        //        answer2Title.text = question.randomlyOrderedAnswers[question.counter]
        question.counter += 1
        answer3Title.text = question.questions[question.numberOfAnswered].answers[question.counter]
        //        answer3Title.text = question.randomlyOrderedAnswers[question.counter]
        question.counter += 1
        answer4Title.text = question.questions[question.numberOfAnswered].answers[question.counter]
        //        answer4Title.text = question.randomlyOrderedAnswers[question.counter]
        question.counter = 0
        
        question.numberOfAnswered += 1
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        if (question.answersIndex[question.currentNumberOfQuestion] < 0) {
            return
        }
        if (question.currentNumberOfQuestion == question.totalQuestionNumber - 1
            /*|| (question.answersIndex[question.currentNumberOfQuestion] == -1)*/) {
            let alert = UIAlertController(title: "Finish the test", message: "This is the last question", preferredStyle: .alert)
            let backAction = UIAlertAction(title: "No", style: .default, handler: { _ in
                // add your 
            })
            let finishAction = UIAlertAction(title: "Finish", style: .default, handler: { _ in
                // later
                self.performSegue(withIdentifier: "endTest", sender: self)
            })
            alert.addAction(backAction)
            alert.addAction(finishAction)
            
            self.present(alert, animated: true, completion: nil)
        } else {
            question.currentNumberOfQuestion += 1
            if (question.currentNumberOfQuestion < question.numberOfAnswered) {
                answer1Title.backgroundColor = UIColor.white
                answer2Title.backgroundColor = UIColor.white
                answer3Title.backgroundColor = UIColor.white
                answer4Title.backgroundColor = UIColor.white
                
                switch question.answersIndex[question.currentNumberOfQuestion] {
                case 1: answer1Title.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
                case 2: answer2Title.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
                case 3: answer3Title.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
                case 4: answer4Title.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
                default: 0
                }
            } else {
                answer1Title.backgroundColor = UIColor.white
                answer2Title.backgroundColor = UIColor.white
                answer3Title.backgroundColor = UIColor.white
                answer4Title.backgroundColor = UIColor.white
            }
            //        question.randomlyOrderedAnswers = question.answerOrderRandomGenerator(Answers: question.questions[question.currentNumberOfQuestion].answers)
            questionTitle.text = question.questions[question.currentNumberOfQuestion].questionTitle
            numberOfCurrentQuestion.text = "Qusetion " + String(question.currentNumberOfQuestion + 1) + "/" + String(question.answerSheet.count)
            answer1Title.text = question.questions[question.currentNumberOfQuestion].answers[question.counter]
            question.counter += 1
            answer2Title.text = question.questions[question.currentNumberOfQuestion].answers[question.counter]
            question.counter += 1
            answer3Title.text = question.questions[question.currentNumberOfQuestion].answers[question.counter]
            question.counter += 1
            answer4Title.text = question.questions[question.currentNumberOfQuestion].answers[question.counter]
            question.counter = 0
            
            if (question.currentNumberOfQuestion == question.numberOfAnswered && question.numberOfAnswered <= question.totalQuestionNumber) {
                question.numberOfAnswered += 1
            }
        }
    }
    
    
    @IBAction func lastQuestion(_ sender: UIButton) {
        if (question.currentNumberOfQuestion == 0) {
            
        } else {
            question.currentNumberOfQuestion -= 1
            answer1Title.backgroundColor = UIColor.white
            answer2Title.backgroundColor = UIColor.white
            answer3Title.backgroundColor = UIColor.white
            answer4Title.backgroundColor = UIColor.white
            
            switch question.answersIndex[question.currentNumberOfQuestion] {
            case 1: answer1Title.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
            case 2: answer2Title.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
            case 3: answer3Title.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
            case 4: answer4Title.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
            default: 0
            }
            
            //        question.randomlyOrderedAnswers = question.answerOrderRandomGenerator(Answers: question.questions[question.currentNumberOfQuestion].answers)
            questionTitle.text = question.questions[question.currentNumberOfQuestion].questionTitle
            numberOfCurrentQuestion.text = "Qusetion " + String(question.currentNumberOfQuestion + 1) + "/" + String(question.answerSheet.count)
            answer1Title.text = question.questions[question.currentNumberOfQuestion].answers[question.counter]
            question.counter += 1
            answer2Title.text = question.questions[question.currentNumberOfQuestion].answers[question.counter]
            question.counter += 1
            answer3Title.text = question.questions[question.currentNumberOfQuestion].answers[question.counter]
            question.counter += 1
            answer4Title.text = question.questions[question.currentNumberOfQuestion].answers[question.counter]
            question.counter = 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let Temp = segue.destination as? ResultVC else {
            return
        }
        Temp.model.answerSheet = question.answerSheet
        Temp.model.wrongQuestionsIndex = question.wrongQuestionsIndex
        Temp.model.answersIndex = question.answersIndex
        Temp.model.questions = question.questions
    }
    
    
//    @IBAction func check(_ sender: UIButton) {
//        if (question.answers[0] == question.questions[0].rightAnswer) {
//            print("it works!!")
//            print(question.answers)
//            print("\n")
//        } else {
//            print("error!")
//            print(question.answers)
//            print("\n")
//        }
//    }
}

