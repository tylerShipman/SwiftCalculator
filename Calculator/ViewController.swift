//
//  ViewController.swift
//  Calculator
//
//  Created by Tyler Shipman on 8/23/16.
//  Copyright © 2016 Shipman Enterprise. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    @IBOutlet weak var outputLbl: UILabel!
    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
    }
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath:path!)
        
        do{
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
       
    }

    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    
    }
    
    @IBAction func dividePressed(btn: UIButton!){
      processOperation(Operation.Divide)
    }
    
    @IBAction func multiplyPressed(btn: UIButton!){
      processOperation(Operation.Multiply)
    }
    
    @IBAction func addPressed(btn: UIButton!){
      processOperation(Operation.Add)
    }
    
    @IBAction func subtractPressed(btn: UIButton!){
      processOperation(Operation.Subtract)
    }
    
    @IBAction func equalsPressed(btn: UIButton!){
      processOperation(currentOperation)
    }
    
    @IBAction func clearPressed(btn: UIButton!){
        playSound()
        runningNumber = ""
        leftValString = ""
        rightValString = ""
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = "0"
    }
    
    func processOperation(op: Operation){
       playSound()
        
        if currentOperation != Operation.Empty{
            // Math
            
            if runningNumber != ""{
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                }
                
                leftValString = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        } else {
            //First time operation is selected
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }

       
        
    }
  
    func playSound(){
        
        if buttonSound.playing{
            buttonSound.stop()
        }
        
        buttonSound.play()
        
    }


}

