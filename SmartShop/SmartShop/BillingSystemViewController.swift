//
//  BillingSystemViewController.swift
//  SmartShop
//
//  Created by ARUN KUMAR YADAV on 29/04/25.
//

import UIKit

class BillingSystemViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIDocumentInteractionControllerDelegate {
    var products: [String] = []
    var quantities: [Int] = []
    var prices: [Double] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let product = productTextField.text, !product.isEmpty,
                  let quantityText = quantityTextField.text, let quantity = Int(quantityText),
                  let priceText = priceTextField.text, let price = Double(priceText) else {
                print("❌ Please enter valid product, quantity, and price.")
                return
            }
            
            // Add to arrays
            products.append(product)
            quantities.append(quantity)
            prices.append(price)
            
            // Reload TableView
            tableView.reloadData()
            
            // Update total
            updateTotal()
            
            // Clear text fields after adding
            productTextField.text = ""
            quantityTextField.text = ""
            priceTextField.text = ""
            
            // Dismiss keyboard (optional)
            view.endEditing(true)
    }
    func updateTotal() {
        var total: Double = 0.0
        for (index, quantity) in quantities.enumerated() {
            total += Double(quantity) * prices[index]
        }
        totalLabel.text = "Total: ₹\(total)"
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
                    prices.remove(at: indexPath.row)
                }
                
                // Reload the table to update the UI
                tableView.reloadData()
                
                // Optionally, update the total after deletion
                updateTotal()
            }
    }
    
    @IBAction func printButtonTapped(_ sender: Any) {
        if let pdfURL = generatePDF() {
                // Now show the PDF using UIDocumentInteractionController
                previewPDF(at: pdfURL)
            }
    }
    func previewPDF(at url: URL) {
        let documentController = UIDocumentInteractionController(url: url)
        
        // Present the document interaction controller
        documentController.delegate = self  // Optional delegate
        documentController.presentPreview(animated: true)
    }

    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
            return self
        }

        func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
            // You can handle any action after the preview ends, if needed.
        }
    func generatePDF() -> URL? {
        // Set the file path to save the PDF
        let fileName = "BillingReport.pdf"
        let path = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        // Create PDF context
        UIGraphicsBeginPDFContextToFile(path.path, CGRect.zero, nil)
        UIGraphicsBeginPDFPage()

        // Draw the table headers
        let headerFont = UIFont.boldSystemFont(ofSize: 18)
        let titleFont = UIFont.systemFont(ofSize: 14)
        let margin: CGFloat = 20
        var yOffset: CGFloat = 30
        
        // Product name, quantity, price header
        var header = "Product Name        Quantity        Price"
        header.draw(at: CGPoint(x: margin, y: yOffset), withAttributes: [.font: headerFont])
        
        yOffset += 30

        // Loop through the products to draw rows
        for (index, product) in products.enumerated() {
            let quantity = quantities[index]
            let price = prices[index]
            
            let rowText = "\(product)        \(quantity)        ₹\(price)"
            rowText.draw(at: CGPoint(x: margin, y: yOffset), withAttributes: [.font: titleFont])
            
            yOffset += 25
        }
        
        // End the PDF context
        UIGraphicsEndPDFContext()

        // Return the file URL
        return path
    }


    // MARK: - TableView Methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return products.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillingCell", for: indexPath)
            cell.textLabel?.text = "\(products[indexPath.row])  - \(quantities[indexPath.row])    x \(prices[indexPath.row])"
            return cell
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
