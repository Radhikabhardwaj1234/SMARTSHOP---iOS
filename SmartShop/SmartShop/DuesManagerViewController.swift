//
//  DuesManagerViewController.swift
//  SmartShop
//
//  Created by ARUN KUMAR YADAV on 29/04/25.
//

import UIKit

class DuesManagerViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var names: [String] = []
    var dues: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        duesTableView.delegate = self
        duesTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBAction func homebtn(_ sender: Any) {
        if let loginSignupVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                print("✅ LoginSignupController found!")
                loginSignupVC.modalPresentationStyle = .fullScreen
                present(loginSignupVC, animated: true, completion: nil)
            } else {
                print("❌ Could not find LoginSignupController")
            }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var duesTableView: UITableView!
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: duesTableView)
        if let indexPath = duesTableView.indexPathForRow(at: buttonPosition) {
            
            
        
             
                names.remove(at: indexPath.row)
                dues.remove(at: indexPath.row)
            
            
            // Reload the table to update the UI
            duesTableView.reloadData()
        }
    }
    @IBAction func addDuesButtonTapped(_ sender: Any) {
        guard let product = nameTextField.text, !product.isEmpty,
              let quantityText = dueTextField.text, let quantity = Int(quantityText) else {
                print("❌ Please enter valid product, quantity, and price.")
                return
            }
            
            // Add to arrays
            names.append(product)
            dues.append(quantity)
            
            // Reload TableView
            duesTableView.reloadData()
            
            // Clear text fields after adding
        nameTextField.text = ""
        dueTextField.text = ""
            
            // Dismiss keyboard (optional)
            view.endEditing(true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DuesCell", for: indexPath)
        cell.textLabel?.text = "\(names[indexPath.row]) - \(dues[indexPath.row])"
        return cell
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
