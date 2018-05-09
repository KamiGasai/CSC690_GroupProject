//
//  SignUpVC.swift
//  letsquizz
//
//  Created by Peitong Shi on 4/20/18.
//  Copyright © 2018 letsquizz. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var userPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if ((userNameTF.text?.isEmpty)! ||
            (userPasswordTF.text?.isEmpty)! ||
            (confirmPasswordTF.text?.isEmpty)! ||
            (emailTF.text?.isEmpty)!)
        {
            displayMessage(userMessage: "Please fill in all fields")
        }
        
        if ((userPasswordTF.text?.elementsEqual(confirmPasswordTF.text!))! != true) {
            displayMessage(userMessage: "Please make sure two passwords field match")
        }
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        
        let api = "http://csfun.club/api/user/register"
        let requestURL = NSURL(string: api)
        let request = NSMutableURLRequest(url: requestURL! as URL)
        request.httpMethod = "POST"
        let user = userNameTF.text!
        let pwd = userPasswordTF.text!
        let email = emailTF.text!
        
        let postParameter = "user=\(user)&pwd=\(pwd)&email=\(email)"
        request.httpBody = postParameter.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            self.removeActivityIndicator(activityIndicator: activityIndicator)
            
            if error != nil {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            
            do {
                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = myJSON {
                    var msg: String!
                    var ack: Bool!
                    msg = parseJSON["msg"] as! String?
                    ack = parseJSON["ack"] as! Bool?
                    print(ack)
                    print(msg)
                }
            } catch {
                print(error)
                self.removeActivityIndicator(activityIndicator: activityIndicator)
            }
            
        }
        task.resume()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }

}
