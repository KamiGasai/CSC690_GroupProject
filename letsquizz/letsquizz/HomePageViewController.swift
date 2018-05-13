//
//  HomePageViewController.swift
//  letsquizz
//
//  Created by Peitong Shi on 5/3/18.
//  Copyright © 2018 letsquizz. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class HomePageViewController: UIViewController {
    @IBOutlet weak var FullNameTF: UILabel!
    

    @IBAction func signOutButtonTapped(_ sender: Any) {
        //print("sign out button tapped")
        KeychainWrapper.standard.removeObject(forKey: "userName")
        
        
        let LoginPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = LoginPage
    }
    
    @IBAction func loadProfileButtonTapped(_ sender: Any) {
       // print("load profile button tapped")
        loadMemberProfile()
    }
    
    func loadMemberProfile(){
        let fullName: String! = KeychainWrapper.standard.string(forKey: "userName")
        FullNameTF.text = FullNameTF.text! + "  \(fullName!)"
    }
    
    @IBAction func startTest(_ sender: UIButton) {
        performSegue(withIdentifier: "toCategoryVC", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
