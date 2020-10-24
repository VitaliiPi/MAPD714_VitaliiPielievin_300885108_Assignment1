//
//  ViewController.swift
//  MAPD714_VitaliiPielievin_300885108_Assignment3
//
//  Created by vitalii on 2020-10-21.
//  Copyright © 2020 vitalii. All rights reserved.
//
//  Calculator App Part 3 - Scientific Calculator
//  Version: 3.0 - Final
//
//  Student Name: Vitalii Pielievin
//  Student ID:   300885108
//  Date Started: 2020/09/27
//
//  This app is a scientific calculator that has number buttons, operator buttons, decimal point button, backspace button, plus/minus button, equals button and clear button.
//  Upon addition of logic to this app, it would allow users to do mathmatical calculations within the app, where results will be displayed on the small screen at the top.
//
//

import UIKit
import Darwin

class ViewController: UIViewController
{

        override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //variable to hold value of which number is being pressed
    //(tells that now there will be a new number entered)
    var stillTyping = false
    // variable that stores check value for if dot placed or not
    var dotPlaced = false
    // first number
    var firstOperand: Double = 0
    // second number
    var secondOperand: Double = 0
    // variable for sign button to perform operations on two numbers with, currently empty field
    var operationSign: String = ""
    //variable transform from text to Double, includes getter and setter
    var currentInput: Double
    {
        get {
            return Double(displayResultLabel.text!)!
        }
        //this setter also removes last 0 that is present in every calculated result
        //removes that 0 in array after dot "." (separatedBy)
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            }
            else {
                displayResultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    
    // Calculator Display
    @IBOutlet weak var displayResultLabel: UILabel!
    
    //Entering numbers from 0-9
    @IBAction func numberPressed(_ sender: UIButton)
    {
        //variable number (holds values of pressed buttons)
        let number = sender.currentTitle!
        
        //getting rid of 0 at the start of displayResultLabel (Calculator Display)
        if stillTyping {
            
            //displaying numbers pressed on calculator display
            displayResultLabel.text = displayResultLabel.text! + number
        }
        else
        {
            displayResultLabel.text = number
            stillTyping = true
        }
        
    }
    
    //Function keys for operands(numbers)
    @IBAction func twoOperandsSignPressed(_ sender: UIButton)
    {
        //looks up for what function key is pressed
        operationSign = sender.currentTitle!
        //transforming
        firstOperand = currentInput
        //checks being done
        stillTyping = false
        dotPlaced = false
    }
    
    // Function that lets us make operations using closures
    func operateWithTwoNumbers(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    // Button "=" which performs results actions
    @IBAction func resultSignPressed(_ sender: UIButton)
    {
        // makes stillTyping 'true' which allows numbers not being saved after we made our entry and perform operations on them
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotPlaced = false
        //choosing what operations to do by function keys pressed through switch statement
        switch operationSign {
        case "+":
            operateWithTwoNumbers {$0 + $1}
        case "-":
            operateWithTwoNumbers {$0 - $1}
        case "x":
            operateWithTwoNumbers {$0 * $1}
        case "/":
            operateWithTwoNumbers {$0 / $1}
        
        default: break
            
        }
    }
    
    // Clear button, setting all the values to 0 and text string to "0"
    @IBAction func clearButton(_ sender: UIButton)
    {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        dotPlaced = false
        operationSign = ""
    }
    
    //Percentage button with percentage calculation logic
    @IBAction func percentageButton(_ sender: UIButton)
    {
        if firstOperand == 0{
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        stillTyping = false
    }
    
    //Plus/Minus Button changes display number with - sign, if double pressed it becomes +
    @IBAction func plusminusButton(_ sender: UIButton)
    {
        currentInput = -currentInput
    }
    
    //Dot number
    //have to check if there was dot in the number before or not, as one number can't have two dots
    @IBAction func dotButton(_ sender: UIButton)
    {
        if stillTyping && !dotPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotPlaced = true
        }
        //if there is starting 0 on the display and nothing was entered it puts dot after the 0
        else if !stillTyping && !dotPlaced {
            displayResultLabel.text = "0."
        }
    }
    // Not working
    @IBAction func backspaceButton(_ sender: UIButton) {
        
    }
    
    //SCIENTIFIC CALCULATOR PART
    
    // Square Root
    @IBAction func squareRootButton(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
        
    }
    
    // sin button
    @IBAction func sinButton(_ sender: UIButton) {
        currentInput = sin(currentInput)
    }

    // cos button
    @IBAction func cosButton(_ sender: UIButton) {
        currentInput = cos(currentInput)
    }
    
    // tan button
    @IBAction func tanButton(_ sender: UIButton) {
        currentInput = tan(currentInput)
    }
    
    // to the power of 2 button
    @IBAction func topoweroftwoButton(_ sender: UIButton) {
        currentInput = pow(currentInput, 2)
        
    }
}

