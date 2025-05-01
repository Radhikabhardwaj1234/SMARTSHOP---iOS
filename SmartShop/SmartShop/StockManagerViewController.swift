//
//  StockManagerViewController.swift
//  SmartShop
//
//  Created by ARUN KUMAR YADAV on 29/04/25.
//

import UIKit

class StockManagerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var products: [String] = []
    var quantities: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var productNameTextField: UITextField!
    
    @IBOutlet weak var quantityTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    // UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        cell.textLabel?.text = "\(products[indexPath.row]) - \(quantities[indexPath.row])"
        return cell
    }


    @IBAction func addProductButtonTapped(_ sender: Any) {
        guard let product = productNameTextField.text, !product.isEmpty,
                  let quantityText = quantityTextField.text, let quantity = Int(quantityText) else {
                print("❌ Please enter valid product, quantity, and price.")
                return
            }
            
            // Add to arrays
            products.append(product)
            quantities.append(quantity)
            
            // Reload TableView
            tableView.reloadData()
            
            // Clear text fields after adding
            productNameTextField.text = ""
            quantityTextField.text = ""
            
            // Dismiss keyboard (optional)
            view.endEditing(true)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: buttonPosition) {
            // Decrease quantity
            quantities[indexPath.row] -= 1
            
            // If quantity reaches 0, remove the item from the arrays
            if quantities[indexPath.row] == 0 {
                products.remove(at: indexPath.row)
                quantities.remove(at: indexPath.row)
            }
            
            // Reload the table to update the UI
            tableView.reloadData()
        }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
