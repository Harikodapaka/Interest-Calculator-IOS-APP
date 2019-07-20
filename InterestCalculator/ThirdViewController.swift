//
//  ThirdViewController.swift
//  InterestCalculator
//
//  Created by Chaitanya Kodapaka on 2019-07-16.
//  Copyright © 2019 Bank. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var loan: UITextField!
    @IBOutlet weak var rate: UITextField!
    @IBOutlet weak var term: UITextField!
    @IBOutlet weak var result: UILabel!
  
    @IBAction func loanEMI(_ sender: UIButton) {

        if Double(loan.text!) == nil || Double(loan.text!)! <= 0{
            loan.layer.borderColor = UIColor.red.cgColor
            loan.layer.borderWidth = 1.0
            return
        }
        if Double(rate.text!) == nil || Double(rate.text!)! <= 0{
            rate.layer.borderColor = UIColor.red.cgColor
            rate.layer.borderWidth = 1.0
            return
        }
        if Double(term.text!) == nil || Double(term.text!)! <= 0{
            term.layer.borderColor = UIColor.red.cgColor
            term.layer.borderWidth = 1.0
            return
        }
        
        let Loan = Double(loan.text!)!
        let Rate = Double(rate.text!)!
        let Term = Double(term.text!)!

        result.text = String(format: "%.8f",emi_calculator(p:Loan, rate: Rate, term: Term))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

