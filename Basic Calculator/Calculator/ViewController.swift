//  ViewController.swift
//  Calculator
//  Created by Ishaan Goel on 12/22/2023.
//  Copyright © 2023 Ishaan Goel. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    var expressionString = "";
    var expn = NSExpression();
    var answer: NSNumber? = nil;
    

    @IBOutlet weak var labelCurrent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func operatorPressed(_ sender: UIButton){
        if(answer != nil){
            clearExpressionString();
        }
        
       addCurrentToExpression()
        
        if(expressionString == ""){
            return;
        }
        
        if(sender.tag == 0){
            expressionString += "+";
        } else if (sender.tag == 1){
            expressionString += "-";
        } else if (sender.tag == 2){
            expressionString += "*";
        } else if (sender.tag == 3) {
            expressionString += "/";
        }
        
        clearCurrent();
        
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        clearCurrent();
        clearExpressionString();
        answer = nil;
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if(answer != nil){
            clearCurrent();
        }
        if let unwrapped = labelCurrent.text{
            if(sender.tag == 10){
                labelCurrent.text = unwrapped + ".";
            } else {
                labelCurrent.text = unwrapped + String(sender.tag);
            }
        }
        
    }
    
    
    @IBAction func evalPressed(_ sender: Any) {
        if(expressionString == "" || Array(expressionString)[0] == "."){
            clearExpressionString();
            return;
        }
        
     
        addCurrentToExpression();
        expn = NSExpression(format: expressionString);

        
       guard let result = expn.expressionValue(with: nil, context: nil) as? Double else
       {return}
        let formatter = NumberFormatter();
        formatter.minimumFractionDigits = 0;
        formatter.minimumFractionDigits = 2;
        guard let value = formatter.string(from: NSNumber(value: result)) else {return};
        answer = NSNumber(value: result);
        labelCurrent.text = value;
    }

    @IBAction func negativePressed(_ sender: UIButton) {
        if let unwrapped = labelCurrent.text{
            if(Array(unwrapped)[0] == "-"){
                labelCurrent.text = unwrapped.replacingOccurrences(of: "-", with: "");
            } else {
            labelCurrent.text = "-" + unwrapped;
            }
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        if let unwrapped = labelCurrent.text{
            labelCurrent.text = String(unwrapped.dropLast());
        }
    }
    
    
    func addCurrentToExpression(){
        if let unwrapped = labelCurrent.text{
            expressionString += unwrapped;
        }
    }
    
    func clearCurrent(){
        labelCurrent.text = "";
    }
    
    func clearExpressionString(){
        expressionString = "";
    }
}
