//
//  LoginSignupViewController.swift
//  SmartShop
//
//  Created by ARUN KUMAR YADAV on 29/04/25.
//

import UIKit

class LoginSignupViewController: UIViewController {
    var users: [(username: String, password: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty,
                  let password = passwordTextField.text, !password.isEmpty else {
                // Show an error if any field is empty
                print("Both fields are required")
                return
            }
            
            // Add user data to the array
            users.append((username: username, password: password))
            print("User signed up: \(users)")
            
            // Show success message
            let alert = UIAlertController(title: "Success", message: "Account created successfully!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
    }
    @IBAction func homebtn(_ sender: Any) {
        if let loginSignupVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                
                loginSignupVC.modalPresentationStyle = .fullScreen
                present(loginSignupVC, animated: true, completion: nil)
            } else {
                print("❌ Could not find LoginSignupController")
            }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty,
                  let password = passwordTextField.text, !password.isEmpty else {
                // Show an error if any field is empty
                print("Both fields are required")
                return
            }
            
            // Check if the user exists in the array
            if let user = users.first(where: { $0.username == username && $0.password == password }) {
                print("Login successful: \(user)")
                
                
                // Transition to the Tab Bar Controller
                if let loginSignupVC = storyboard?.instantiateViewController(withIdentifier: "TabBarController") {
                        print("✅ LoginSignupController found!")
                        loginSignupVC.modalPresentationStyle = .fullScreen
                        present(loginSignupVC, animated: true, completion: nil)
                    } else {
                        print("❌ Could not find LoginSignupController")
                    }

                
            } else {
                print("Login failed: User not found or incorrect password")
                let alert = UIAlertController(title: "Error", message: "Invalid username or password.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
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
