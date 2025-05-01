//
//  HomeViewController.swift
//  SmartShop
//
//  Created by ARUN KUMAR YADAV on 29/04/25.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func aboutbtn(_ sender: Any) {
        if let loginSignupVC = storyboard?.instantiateViewController(withIdentifier: "About") {
                loginSignupVC.modalPresentationStyle = .fullScreen
                present(loginSignupVC, animated: true, completion: nil)
            } else {
                print("❌ Could not find LoginSignupController")
            }
    }
    @IBAction func contactbtn(_ sender: Any) {
        if let loginSignupVC = storyboard?.instantiateViewController(withIdentifier: "Contact") {
                loginSignupVC.modalPresentationStyle = .fullScreen
                present(loginSignupVC, animated: true, completion: nil)
            } else {
                print("❌ Could not find LoginSignupController")
            }
    }
    @IBAction func signupButtonTapped(_ sender: Any) {
        if let loginSignupVC = storyboard?.instantiateViewController(withIdentifier: "LoginSignupController") {
                loginSignupVC.modalPresentationStyle = .fullScreen
                present(loginSignupVC, animated: true, completion: nil)
            } else {
                print("❌ Could not find LoginSignupController")
            }

    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let loginSignupVC = storyboard?.instantiateViewController(withIdentifier: "LoginSignupController") {
                loginSignupVC.modalPresentationStyle = .fullScreen
                present(loginSignupVC, animated: true, completion: nil)
            } else {
                print("❌ Could not find LoginSignupController")
            }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
