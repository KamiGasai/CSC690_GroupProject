import Foundation

class Model {
    struct question {
        let questionTitle: String
        let rightAnswer: String
        var answers: [String]
    }
    
    let totalQuestionNumber: Int
    var numberOfAnswered: Int
    var numberOfRight: Int
    var questions: [question]
    
    let question1 = question(questionTitle: "When driving in foggy road conditions, you should:",
                             rightAnswer: "turn on your low-beam headlights",
                             answers: ["turn on your low-beam headlights", "turn off your headlights", "turn on your high-beam headlights", "turn on your high-beam headlights only if there is no other traffic"])
    
    let question2 = question(questionTitle: "To stop in an emergency situation when your car does not have ABS brakes, you should:",
                             rightAnswer: "gently pump your brakes to slow your vehicle",
                             answers: ["gently pump your brakes to slow your vehicle", "slam on your brakes", "apply hard steady pressure without locking up your wheels", "lock up all the wheels to slow down your acceleration"])
    
    let question3 = question(questionTitle: "Safety belts should be worn:",
                             rightAnswer: "at all times as a driver and as a passenger",
                             answers: ["only when driving at higher speeds", "loosely on your lap", "only when riding in the front seat", "at all times as a driver and as a passenger"])
    
    let question4 = question(questionTitle: "Unless otherwise posted the speed limit in a residential area is:",
                             rightAnswer: "25 mph",
                             answers: ["20 mph", "25 mph", "30 mph", "35 mph"])
    
    let question5 = question(questionTitle: "With a Class C drivers license a person may drive:",
                             rightAnswer: "A 3-axle vehicle if the Gross Vehicle Weight is less than 6,000 pounds.",
                             answers: ["A 3-axle vehicle if the Gross Vehicle Weight is less than 6,000 pounds.", "Any 3-axle vehicle regardless of the weight.", "A vehicle pulling two trailers.", "All of above."])
    
    var answers: [String] = ["", "", "", "", ""]
    var answersIndex: [Int] = [-1, -1, -1, -1, -1]
    var counter: Int = 0
    var currentNumberOfQuestion = 0
    var randomlyOrderedAnswers: [String] = []
    
    init() {
        totalQuestionNumber = 5
        numberOfAnswered = 0
        numberOfRight = 0
        questions = []
        questions.append(question1)
        questions.append(question2)
        questions.append(question3)
        questions.append(question4)
        questions.append(question5)
        for i in 0..<totalQuestionNumber {
            questions[i].answers = answerOrderRandomGenerator(Answers: questions[i].answers)
        }
    }
    
    
    func answerOrderRandomGenerator(Answers: [String]) -> [String] {
        var temp: [String] = Answers
        var result: [String] = []
        var index: UInt32
        for i in 0..<4 {
            //            print(temp)
            //            print("\n")
            index = arc4random_uniform(4 - UInt32(i))
            result.append(temp[Int(index)])
            for j in index..<4 {
                if (j < 3) {
                    temp[Int(j)] = temp[Int(j) + 1]
                }
            }
        }
        return result
    }
}
