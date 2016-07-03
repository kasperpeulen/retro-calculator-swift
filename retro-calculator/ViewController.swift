//
//  ViewController.swift
//  retro-calculator
//
//  Created by Kasper Peulen on 03/07/16.
//  Copyright © 2016 Kasper Peulen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var operant: Operator = Operator.None
    
    var currentNumber: String = ""
    
    var leftValStr = "", rightValStr = ""
    
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLbl.text = "0"
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        let theNumberPressed = btn.tag
        
        currentNumber += "\(theNumberPressed)"
        
        outputLbl.text = currentNumber
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operator.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operator.Multiply)
    }
    
    @IBAction func onSubstractPressed(sender: AnyObject) {
        processOperation(Operator.Substract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operator.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(Operator.None)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentNumber = ""
        operant = Operator.None
        outputLbl.text = "0"
    }
    
    
    func processOperation(op: Operator) {
        playSound()
        
        if operant == Operator.None {
            leftValStr = currentNumber
            currentNumber = ""
            operant = op
        } else {
            
            if currentNumber != "" {
                rightValStr = currentNumber
                currentNumber = ""
                
                switch operant {
                case Operator.Add:
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                case Operator.Multiply:
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                case Operator.Divide:
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                case Operator.Substract:
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                case Operator.None:
                    break
                }
                
                leftValStr = result
                outputLbl.text = result

            }
            
            operant = op
        }
    }
    
    func playSound() {
        if (btnSound.playing) {
            btnSound.stop()
        }
        btnSound.play()
    }
}

enum Operator {
    case None
    case Add
    case Divide
    case Multiply
    case Substract
}
