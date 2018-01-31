//
//  ViewController.swift
//  simple-calc-iOS
//
//  Created by Benny on 1/25/18.
//  Copyright © 2018 Benny Souriyadeth. All rights reserved.
//

import UIKit

enum Operation : String {
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case Mod = "%"
    case Count = "count"
    case Avg = "avg"
    case Fact = "fact"
    case Null = "Null"
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //label.text = "0" // changes text to 0
    }
    
    var numbers = ""
    var lValue = ""
    var rValue = ""
    var result = ""
    var curOperation : Operation = .Null
    
    var addCount = 1
    var avgCount = 0
    var addAvg : Double = 0
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbersPressed(_ sender: UIButton) {
        if numbers.count <= 8 {
            numbers += "\(sender.tag)"
            label.text = numbers
        }
    }
    
    @IBAction func dot(_ sender: UIButton) {
        ////contains method
        if !(label.text?.contains("."))! && !numbers.contains(".") {
            if numbers.count <= 7 {
                numbers += "."
                label.text = numbers
            }
        }
    }
    
    @IBAction func allClear(_ sender: UIButton) {
        numbers = ""
        lValue = ""
        rValue = ""
        result = ""
        curOperation = .Null
        label.text = "0"
        
        addCount = 0
        avgCount = 0
        addAvg = 0
    }
    
    @IBAction func equals(_ sender: UIButton) {
        if numbers != "" {
            if curOperation == .Count {
                addCount += 1 //  tick forward
                result = "\(addCount)"
                label.text = result
                lValue = result
            }
            if curOperation == .Avg {
                avgCount += 1 // tick forward
                addAvg += Double(numbers)!
                result = "\((addAvg) / Double(avgCount))"
                label.text = checkTrunc(result: result) //checkTrunc(result: result) // check truncated
                
                // reset Avg values
                avgCount = 0
                addAvg = 0
                lValue = result // keep result for next calculations
            } else {
                operation(operation: curOperation)
            }
        }
    }
    
    @IBAction func add(_ sender: UIButton) {
        operation(operation: .Add)
    }
    @IBAction func subtract(_ sender: UIButton) {
        operation(operation: .Subtract)
    }
    @IBAction func multiply(_ sender: UIButton) {
        operation(operation: .Multiply)
    }
    @IBAction func divide(_ sender: UIButton) {
        operation(operation: .Divide)
    }
    @IBAction func mod(_ sender: UIButton) {
        operation(operation: .Mod)
    }
    
    ///////////
    // multiOperand
    @IBAction func count(_ sender: UIButton) {
        if numbers != "" {
            addCount += 1
        }
        operation(operation: .Count)
    }
    @IBAction func avg(_ sender: UIButton) {
        operation(operation: .Avg)
        if lValue != "" {
            addAvg += Double(lValue)!
        } else  if rValue != "" {
            addAvg += Double(rValue)!
        } else {
            avgCount -= 1 // resets the +1 when nothing is inputted
        }
        avgCount += 1
    }
    @IBAction func fact(_ sender: UIButton) {
        operation(operation: .Fact)
        var big = false
        if numbers == "" && lValue == "" && rValue == "" { // if fact is pressed first
            result = ""
            label.text = "0"
        } else {
            if Int(Double(lValue)!) == 0 || Int(Double(lValue)!) == 1 {
                result = "1"
            } else {
                if Int(Double(lValue)!) >= 1 { // make into double first, then int to avoid exception
                    //if Int(Double(lValue)!) <= 20 {

                        var num = Double(lValue)!
                        var total = 1.0
                        while num > 0 {
                            total *= num
                            num -= 1
                        }
                        result = "\(total)"
                        result = checkTrunc(result: result)
                        if result == "inf" {
                            big = true
                        }
                    
//                    } else {
//                        result = "too big"
//                        big = true
//                    }
                } else {
                    result = "0"
                }
            }
            label.text = result
            if big == true {
                result = "0"
            }
            lValue = result
        }
        curOperation = .Null
    }
    
    func operation(operation: Operation) {
        if curOperation != .Null {
            if numbers != "" && lValue != "" && numbers != "." {
                rValue = numbers
                numbers = ""
                
                if curOperation == .Add {
                    result = "\(Double(lValue)! + Double(rValue)!)"
                } else if curOperation == .Subtract {
                    result = "\(Double(lValue)! - Double(rValue)!)"
                } else if curOperation == .Multiply {
                    result = "\(Double(lValue)! * Double(rValue)!)"
                } else if curOperation == .Divide {
                    result = "\(Double(lValue)! / Double(rValue)!)"
                } else if curOperation == .Mod {
                    result = "\(Double(lValue)!.truncatingRemainder(dividingBy: Double(rValue)!))"
                }

                lValue = result //hold current result for next use
                if curOperation != .Avg && curOperation != .Count {
                    // check truncating
                    result = checkTrunc(result: result)
                    label.text = result
                }
            }
            if numbers != "." { // Handles dots
                if numbers != "" && lValue == "" { // fixes if operants(basic) are pressed first
                    lValue = numbers
                    numbers = ""
                }
            }
            curOperation = operation
        } else {
            if numbers != "." {
                lValue = numbers
                numbers = ""
                 // next time number is pressed, we can calculate it
            } else {
                numbers = ""
            }
            curOperation = operation
        }
    }
    
    // Helper function to check if there are remainders that need to be removed (0)
    private func checkTrunc(result: String) -> String {
        if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) { // check for remainder of 0 (integer)
            return String(Int(Double(result)!))
        }
        return result
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
