class Model {
    struct question {
        let questionTitle: String
        let rightAnswer: String
        let answers: [String]
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
    
    
    var answers: [String] = ["", "", ""]
    var counter: Int = 0
    var currentNumberOfQuestion = 0
    
    init() {
        totalQuestionNumber = 2
        numberOfAnswered = 0
        numberOfRight = 0
        questions = []
        questions.append(question1)
        questions.append(question2)
        questions.append(question3)
    }
    
    func answerOrderGenerator() -> Int {
        return 1
    }
}

