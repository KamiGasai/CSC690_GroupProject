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
    
    var answerSheet: [String] = ["", "", "", "", ""]
    var answersIndex: [Int] = [-1, -1, -1, -1, -1]
    var counter: Int = 0
    var currentNumberOfQuestion = 0
    var randomlyOrderedAnswers: [String] = []
    var scores: Double = 0
    var wrongQuestionsIndex: [Int] = []
    
    init() {
        totalQuestionNumber = 5
        numberOfAnswered = 0
        numberOfRight = 0
        questions = []
        
        self.readingJsonFile(fileName: "QA")
        
        for i in 0..<totalQuestionNumber {
            questions[i].answers = answerOrderRandomGenerator(Answers: questions[i].answers)
        }
        
        
    }
    
    func evaluateTestResult() -> Double {
        var result: Double
        var counter: Int = 0
        for i in 0..<totalQuestionNumber {
            if (answerSheet[i] == questions[i].rightAnswer) {
                counter += 1
            } else {
                wrongQuestionsIndex.append(i)
            }
        }
        result = Double(counter)/Double(totalQuestionNumber)*100
        return result
    }
    
    // save json into file
    func saveJsontoFile(fileName:String, dictonary: Array<Any>) {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("\(fileName).json")
        
        var file: FileHandle = FileHandle()
        do{
            file = try FileHandle(forWritingTo: fileUrl)
        }catch{
            
        }
        
        do{
            if let jsonData = try JSONSerialization.data(withJSONObject: dictonary, options: .init(rawValue: 0)) as? Data
            {
                try jsonData.write(to: fileUrl)
            }
        }
        catch {
            
        }
        
        file.closeFile()
    }
    
    // retrive json file
    func readingJsonFile(fileName: String){
        let fileManager = FileManager.default
        let filePath:String = NSHomeDirectory() + "/Documents/\(fileName).json"
        let exist = fileManager.fileExists(atPath: filePath)
        if(exist == false){
            print("loading file")
            self.loadingQA(fileName: "QA")
            sleep(4)
        }
        
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("\(fileName).json")

        // read data from .json file and transform data into an array
        do {
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            //print(jsonResult)
            let arrayQAList = jsonResult as? NSArray
            
            var questionTitle : String!
            var rightAnswer : String!
            var answerOptions = [String]()
            
            for objQA in arrayQAList as! [Dictionary<String, Any>]{
                //print(objQA)
                questionTitle = objQA["questionTitle"] as! String?
                rightAnswer = objQA["rightAnswer"] as! String
                
                let arrayAnsList = objQA["answerOptions"] as! NSArray?
                for objAns in arrayAnsList!{
                    answerOptions.append(objAns as! String)
                }

                self.questions.append(question(questionTitle: questionTitle,
                                        rightAnswer: rightAnswer,
                                        answers: answerOptions))
                
                questionTitle = ""
                rightAnswer = ""
                answerOptions.removeAll()
            }
            
            
        } catch {
            print(error)
        }
    }
    
    func loadingQA(fileName:String){
            let URL_SAVE_TEAM = "http://csfun.club/api/question/list"
//            let URL_SAVE_TEAM = "http://localhost/IOSWebService/api/question/list"
            //created NSURL
            let requestURL = NSURL(string: URL_SAVE_TEAM)
            
            //creating NSMutableURLRequest
            let request = NSMutableURLRequest(url: requestURL! as URL)
            //setting the method to post
            request.httpMethod = "POST"
            
            let postParameters = "cat_id=1"
            //adding the parameters to request body
            request.httpBody = postParameters.data(using: String.Encoding.utf8)
            
            //creating a task to send the post request
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
                if error != nil{
                    print("error is \(String(describing: error))")
                    return;
                }
                
                //parsing the response
                do {
                    let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    //print(myJSON)
                    
                    //parsing the json
                    var dictonary = Array<Any>()
                    
                    if let parseJSON = myJSON {
                        var arrayQAList: NSArray!
                        var msg : String!
                        var ack : Bool!
                        
                        // loop response
                        var questionTitle : String!
                        var rightAnswer : String!
                        var answerOptions = [String]()
                        
                        arrayQAList = parseJSON["ques_ans_list"] as! NSArray
                        for objQA in arrayQAList as! [Dictionary<String, Any>]{
                            questionTitle = objQA["ques_name"] as! String?
                            
                            let arrayAnsList = objQA["answers"] as! NSArray?
                            for objAns in arrayAnsList as! [Dictionary<String, Any>]{
                                answerOptions.append(objAns["ans_answer"] as! String)
                                if(Int(objAns["ans_is_correct"] as! String)! == 1){
                                    rightAnswer = objAns["ans_answer"] as! String
                                }
                            }
                            
                            /**
                                 print(questionTitle)
                                 print(answerOptions)
                                 print(rightAnswer)
                                print("----------------")
                            **/
                            
                            dictonary.append(["questionTitle":questionTitle,
                                              "answerOptions":answerOptions,
                                              "rightAnswer": rightAnswer
                            ])
                            
                            // re-init
                            questionTitle = ""
                            rightAnswer = ""
                            answerOptions.removeAll()
                        }

                        if(dictonary.count > 0){
                            print("Saving Json file")
                            self.saveJsontoFile(fileName: "QA", dictonary: dictonary)
                        }
                        
                        msg = parseJSON["msg"] as! String?
                        ack = parseJSON["ack"] as! Bool?
                    }
                } catch {
                    print(error)
                }
            }
            task.resume()
    }
    
    
    func answerOrderRandomGenerator(Answers: [String]) -> [String] {
        var temp: [String] = Answers
        var result: [String] = []
        var index: UInt32
        for i in 0..<4 {
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
