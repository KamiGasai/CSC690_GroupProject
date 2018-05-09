//
//  SignInVCViewController.swift
//  letsquizz
//
//  Created by Peitong Shi on 4/20/18.
//  Copyright © 2018 letsquizz. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper


class LoginVC: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var userPasswordTF: UITextField!
    
    @IBOutlet weak var signBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addBackground()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let username = userNameTF.text
        let password = userPasswordTF.text
        
        
        if (username?.isEmpty)! || (password?.isEmpty)! {
            displayMessage(userMessage: "One or both of the required fields is missing")
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        let url = "http://csfun.club/api/user/login?user=" + username! + "&pwd=" + password!
        let api = URL(string:url)
        var request = URLRequest(url:api!)
        
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            self.removeActivityIndicator(activityIndicator: activityIndicator)
            
            if error != nil {
                self.displayMessage(userMessage: "Could not successfully perform this request. Try again later")
                print("error=\(String(describing:error))")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                print("Dictionary: \(json)")
                if let parseJSON = json {
//                    var arrayObject: NSArray!
                    var userInfo: [String: Any]!
                    if let arrayObject: NSArray = parseJSON["user"] as? NSArray {
                        userInfo = arrayObject.firstObject as? [String: String]
                        let userName = userInfo["user_name"] as? String
                        let userID = userInfo["user_id"] as? String
                        let saveuserNameSuccess: Bool = KeychainWrapper.standard.set(userName!, forKey: "userName")
                        let saveuserIDSuccess: Bool = KeychainWrapper.standard.set(userID!, forKey: "userID")
                        print("The userName save result: \(saveuserNameSuccess)")
                        print("The userID save result:\(saveuserIDSuccess)")
                        
                        print(userName!)
                        print ("Access token: \(String(describing:userName))")
                    
                        DispatchQueue.main.async {
                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                            let appDelegate = UIApplication.shared.delegate
                            appDelegate?.window??.rootViewController = homePage
                        }
                    } else {
                        self.displayMessage(userMessage: "Sorry, please check your username and password")
                        return
                    }
                } else {
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                }
                
            } catch {
                self.removeActivityIndicator(activityIndicator: activityIndicator)
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print(error)
            }
        }
        task.resume()
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
