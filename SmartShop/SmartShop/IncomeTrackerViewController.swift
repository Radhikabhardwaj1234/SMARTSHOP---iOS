//
//  IncomeTrackerViewController.swift
//  SmartShop
//
//  Created by ARUN KUMAR YADAV on 29/04/25.
//

import UIKit

class IncomeTrackerViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @IBAction func addIncomeButtonTapped(_ sender: Any) {
        guard let date1 = dateTextField1.text, !date1.isEmpty,
              let income1 = Double(incomeTextField1.text ?? ""),
              let date2 = dateTextField2.text, !date2.isEmpty,
              let income2 = Double(incomeTextField2.text ?? ""),
              let date3 = dateTextField3.text, !date3.isEmpty,
              let income3 = Double(incomeTextField3.text ?? "") else {
            // Optionally show an alert for invalid input
            return
        }
        
        let dates = [date1, date2, date3]
        let incomes = [income1, income2, income3]
        
        // Remove old graph
        chartViewContainer.subviews.forEach { $0.removeFromSuperview() }
        
        // Create and add a new graph view
        let graphView = GraphView(frame: chartViewContainer.bounds, incomes: incomes, labels: dates)
        graphView.backgroundColor = .white
        graphView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        chartViewContainer.addSubview(graphView)
        
    }

    
    
    @IBOutlet weak var dateTextField1: UITextField!
    @IBOutlet weak var incomeTextField1: UITextField!
    @IBOutlet weak var dateTextField2: UITextField!

    @IBOutlet weak var incomeTextField2: UITextField!
    @IBOutlet weak var dateTextField3: UITextField!
    @IBOutlet weak var incomeTextField3: UITextField!
    
    @IBOutlet weak var chartViewContainer: UIView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
class GraphView: UIView {
    var incomes: [Double]
    var labels: [String]

    init(frame: CGRect, incomes: [Double], labels: [String]) {
        self.incomes = incomes
        self.labels = labels
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(), !incomes.isEmpty else { return }

        let width = rect.width
        let height = rect.height
        let padding: CGFloat = 20
        let barSpacing: CGFloat = 20
        let numberOfBars = incomes.count
        let availableWidth = width - 2 * padding - (CGFloat(numberOfBars - 1) * barSpacing)
        let barWidth = availableWidth / CGFloat(numberOfBars)
        let maxIncome = incomes.max() ?? 1

        for (index, income) in incomes.enumerated() {
            let barHeight = CGFloat(income / maxIncome) * (height - 40)
            let x = padding + CGFloat(index) * (barWidth + barSpacing)
            let y = height - barHeight - 20

            // Draw bar
            context.setFillColor(UIColor.systemGreen.cgColor)
            context.fill(CGRect(x: x, y: y, width: barWidth, height: barHeight))

            // Draw label below bar
            let label = labels[index]
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 10),
                .foregroundColor: UIColor.black
            ]
            let labelSize = label.size(withAttributes: attributes)
            let labelX = x + (barWidth - labelSize.width) / 2
            let labelY = height - 18
            label.draw(at: CGPoint(x: labelX, y: labelY), withAttributes: attributes)

            // Optional: Show income value above bar
            let incomeText = "\(Int(income))"
            let incomeSize = incomeText.size(withAttributes: attributes)
            let incomeX = x + (barWidth - incomeSize.width) / 2
            let incomeY = y - 15
            incomeText.draw(at: CGPoint(x: incomeX, y: incomeY), withAttributes: attributes)
        }
    }
}
