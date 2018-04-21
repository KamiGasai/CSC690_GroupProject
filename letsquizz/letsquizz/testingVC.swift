//
//  testingVC.swift
//  letsquizz
//
//  Created by Peitong Shi on 4/20/18.
//  Copyright © 2018 letsquizz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let question = Model()
    
    
    @IBOutlet weak var questionTitle: UITextView!
    
    @IBOutlet weak var numberOfCurrentQuestion: UILabel!
    
    @IBOutlet weak var answer1Title: UILabel!
    
    @IBAction func answer1(_ sender: UIButton) {
        if (question.currentNumberOfQuestion < question.numberOfAnswered) {
            question.answers[question.currentNumberOfQuestion] = answer1Title.text!
        } else {
            if (question.answers[question.numberOfAnswered] == "") {
                question.answers[question.currentNumberOfQuestion] = answer1Title.text!
            }
        }
        print("check1! /n")
    }
    
    @IBOutlet weak var answer2Title: UILabel!
    @IBAction func answer2(_ sender: UIButton) {
        if (question.currentNumberOfQuestion < question.numberOfAnswered) {
            question.answers[question.currentNumberOfQuestion] = answer2Title.text!
        } else {
            if (question.answers[question.numberOfAnswered] == "") {
                question.answers[question.currentNumberOfQuestion] = answer2Title.text!
            }
        }
        print("check2! /n")
    }
    
    @IBOutlet weak var answer3Title: UILabel!
    @IBAction func answer3(_ sender: UIButton) {
        if (question.currentNumberOfQuestion < question.numberOfAnswered) {
            question.answers[question.currentNumberOfQuestion] = answer3Title.text!
        } else {
            if (question.answers[question.numberOfAnswered] == "") {
                question.answers[question.currentNumberOfQuestion] = answer3Title.text!
            }
        }
        print("check3! /n")
    }
    
    @IBOutlet weak var answer4Title: UILabel!
    @IBAction func answer4(_ sender: UIButton) {
        if (question.currentNumberOfQuestion < question.numberOfAnswered) {
            question.answers[question.currentNumberOfQuestion] = answer4Title.text!
        } else {
            if (question.answers[question.numberOfAnswered] == "") {
                question.answers[question.currentNumberOfQuestion] = answer4Title.text!
            }
        }
        print("check4! /n")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTitle.text = question.questions[question.numberOfAnswered].questionTitle
        numberOfCurrentQuestion.text = "Qusetion " + String(question.numberOfAnswered + 1)
        answer1Title.text = question.questions[question.numberOfAnswered].answers[question.counter]
        question.counter += 1
        answer2Title.text = question.questions[question.numberOfAnswered].answers[question.counter]
        question.counter += 1
        answer3Title.text = question.questions[question.numberOfAnswered].answers[question.counter]
        question.counter += 1
        answer4Title.text = question.questions[question.numberOfAnswered].answers[question.counter]
        question.counter = 0
        question.numberOfAnswered += 1
    }
    
    
    @IBAction func check(_ sender: UIButton) {
        if (question.answers[0] == question.questions[0].rightAnswer) {
            print("it works!!")
            print(question.answers)
            print("\n")
        } else {
            print("error!")
            print(question.answers)
            print("\n")
        }
    }
}

