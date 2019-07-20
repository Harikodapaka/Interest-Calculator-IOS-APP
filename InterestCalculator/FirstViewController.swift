//
//  FirstViewController.swift
//  InterestCalculator
//
//  Created by Chaitanya Kodapaka on 2019-07-16.
//  Copyright © 2019 Bank. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
   
    var monthlyBalances : [String] = []
    @IBOutlet weak var LoanAmount: UITextField!
    @IBOutlet weak var InterestRate: UITextField!
    @IBOutlet weak var LoanTerm: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func CalculateAmortizaion(_ sender: UIButton) {
        monthlyBalances = []
        if Double(LoanAmount.text!) == nil || Double(LoanAmount.text!)! <= 0{
            LoanAmount.layer.borderColor = UIColor.red.cgColor
            LoanAmount.layer.borderWidth = 1.0
            return
        }
        if Double(InterestRate.text!) == nil{
            InterestRate.layer.borderColor = UIColor.red.cgColor
            InterestRate.layer.borderWidth = 1.0
            return
        }
        if Double(LoanTerm.text!) == nil || Double(LoanTerm.text!)! <= 0{
            LoanTerm.layer.borderColor = UIColor.red.cgColor
            LoanTerm.layer.borderWidth = 1.0
            return
        }
        
        var rate = Double(InterestRate.text!)!
        var principle = Double(LoanAmount.text!)!
        var term = Double(LoanTerm.text!)!
        let monthlyPayment = emi_calculator(p: principle, rate: rate, term: term)
        
        term = term * 12
        rate = rate / 100
        for _ in 1...6 {
            let monthelyInterest = rate / 12
            let interestPayment = monthelyInterest * principle
            let principlePayment = monthlyPayment - interestPayment
            let endingPrinciple = principle - principlePayment
            let result = "Principle-$" + String(format: "%.2f", principle) + ", Interest-$" + String(format: "%.2f", interestPayment)
            monthlyBalances.append(result)
            principle = endingPrinciple
        }
//        print(monthlyBalances)
        tableView.reloadData()
    }
    func emi_calculator(p: Double, rate: Double, term: Double) -> Double
    {
        var emi: Double;
        
        let r = rate / (12 * 100);
        let t = term * 12;
        emi = (p * r * pow(1 + r, t)) / (pow(1 + r, t) - 1);
        return (emi);
    }
    
}
extension FirstViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthlyBalances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text =  monthlyBalances[indexPath.row]
        return cell
    }
    
    
}

