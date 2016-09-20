//
//  ViewController.swift
//  BullsEye
//
//  Created by Rama Milaneh on 9/14/16.
//  Copyright © 2016 RAMA. All rights reserved.
//

import UIKit
import QuartzCore


class ViewController: UIViewController {
    
    var firstCurrentValue: Int = 0
    
    var secondCurrentValue: Int = 0
    
    var currentValue: Int = 0
    
    var targetValue: Int = 0
    
    var score: Int = 0
    
    var round: Int = 0
    
    @IBOutlet weak var slider1: UISlider!
    
    @IBOutlet weak var slider2: UISlider!
    
    @IBOutlet weak var target: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var minFirstSlider: UILabel!
    
    @IBOutlet weak var maxFirstSlider: UILabel!
    
    @IBOutlet weak var minSecondSlider: UILabel!
    
    @IBOutlet weak var maxSecondSlider: UILabel!
    
    @IBOutlet weak var operation: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let thumbImageNormal1 = UIImage(named: "SliderThumb-Normal")
        slider1.setThumbImage(thumbImageNormal1, for: .normal)
        
        let thumbImageHighlighted1 = UIImage(named: "SliderThumb-Highlighted")
        slider1.setThumbImage(thumbImageHighlighted1, for: .highlighted)
        
        let thumbImageNormal2 = UIImage(named: "SliderThumb-Normal")
        slider2.setThumbImage(thumbImageNormal2, for: .normal)
        
        let thumbImageHighlighted2 = UIImage(named: "SliderThumb-Highlighted")
        slider2.setThumbImage(thumbImageHighlighted2, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        if let trackLeftImage1 = UIImage(named: "SliderTrackLeft") { let trackLeftResizable = trackLeftImage1.resizableImage(withCapInsets: insets)
            slider1.setMinimumTrackImage(trackLeftResizable, for: .normal)
        }
        if let trackRightImage1 = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage1.resizableImage(withCapInsets: insets)
            slider1.setMaximumTrackImage(trackRightResizable, for: .normal)
        }
        if let trackLeftImage2 = UIImage(named: "SliderTrackLeft") { let trackLeftResizable = trackLeftImage2.resizableImage(withCapInsets: insets)
            slider2.setMinimumTrackImage(trackLeftResizable, for: .normal)
        }
        if let trackRightImage2 = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage2.resizableImage(withCapInsets: insets)
            slider2.setMaximumTrackImage(trackRightResizable, for: .normal)
        }
        startOver()
        updateLabel()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startOver(_ sender: AnyObject) {
        startOver()
        updateLabel()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    
    
    @IBAction func showAlert(_ sender: AnyObject) {
        
        let difference = abs(targetValue - currentValue)
        let title: String
        let points = abs(100 - difference)
        if difference == 0 {
            title = "Perfect!"
            
        } else if difference < 10 {
            
            title = "You almost had it!"
            
        } else if difference < 20 {
            
            title = "Pretty good!"
            
        } else {
            
            title = "Not even close..."
            
        }
        score += points
        
        let alert = UIAlertController(title: title,
                                      message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.startNewRound()
            self.updateLabel()})
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func firstSliderMoves(slider1: UISlider) {
        
        firstCurrentValue = lroundf(slider1.value)
    }
    @IBAction func secondSliderMove(slider2: UISlider){
        secondCurrentValue = lroundf(slider2.value)
    }
    
    func startOver() {
        score = 0
        round = 0
        startNewRound()
        updateLabel()
    }
    
    func startNewRound() {
        round += 1
        createRandomOperation()
        createMinAndMax()
        slider1.minimumValue = Float(minFirstSlider.text!)!
        slider1.maximumValue = Float(maxFirstSlider.text!)!
        slider2.minimumValue = Float(minSecondSlider.text!)!
        slider2.maximumValue = Float(maxSecondSlider.text!)!
        firstCurrentValue = (Int(minFirstSlider.text!)! + Int(maxFirstSlider.text!)!)/2
        secondCurrentValue = (Int(minSecondSlider.text!)! + Int(maxSecondSlider.text!)!)/2
        slider1.value = Float(firstCurrentValue)
        slider2.value = Float(secondCurrentValue)
        currentValue = doTheOperation()
    }
    
    func updateLabel() {
        
        scoreLabel.text = ("\(score)")
        roundLabel.text = String(round)
       }
    
    func createRandomOperation(){
        let random = arc4random_uniform(4)
        switch random {
        case 0:
            operation.text = "+"
        case 1:
            operation.text = "-"
        case 2:
            operation.text = "*"
        case 3:
            operation.text = "/"
        default:
            print("Invalid operation")
        }
    }
    func createMinAndMax() {
        
        minFirstSlider.text = String(Int(arc4random_uniform(50))+1)
        maxFirstSlider.text = String(Int(arc4random_uniform(50) + 50))
        minSecondSlider.text = String(Int(arc4random_uniform(50))+1)
        maxSecondSlider.text = String(Int(arc4random_uniform((50))+50))
        
        //to create the min and the max for the target
        var min = 0
        var max = 0
        switch operation.text! {
        case "+":
            min = Int(minFirstSlider.text!)! + Int(minSecondSlider.text!)!
            max = Int(maxFirstSlider.text!)! + Int(maxSecondSlider.text!)!
            targetValue = Int(arc4random_uniform(UInt32(max-min))) + min
            target.text = String(targetValue)
        case "-":
            min = abs(Int(minFirstSlider.text!)! - Int(minSecondSlider.text!)!)
            max = abs(Int(maxFirstSlider.text!)! - Int(maxSecondSlider.text!)!)
            if (min > max){
                targetValue = Int(arc4random_uniform(UInt32(min-max))) + max}
            else{
                targetValue = Int(arc4random_uniform(UInt32(max-min))) + min
            }
            target.text = String(targetValue)
        case "*":
            min = Int(minFirstSlider.text!)! * Int(minSecondSlider.text!)!
            max = Int(maxFirstSlider.text!)! * Int(maxSecondSlider.text!)!
            targetValue = Int(arc4random_uniform(UInt32(max-min))) + min
            target.text = String(targetValue)
        case "/":
            
            min = Int(minFirstSlider.text!)! / Int(minSecondSlider.text!)!
            
            max = Int(maxFirstSlider.text!)! / Int(maxSecondSlider.text!)!
            if(min<max){
                targetValue = Int(arc4random_uniform(UInt32(max-min))) + min
            }
            else{
                targetValue = Int(arc4random_uniform(UInt32(min-max))) + max
            }
            target.text = String(targetValue)
        default:
            targetValue = 1 + Int(arc4random_uniform(100))
            target.text = String(targetValue)
            
        }
    }
    
    func doTheOperation() ->Int{
        switch operation.text! {
        case "+":
            currentValue = Int(firstCurrentValue + secondCurrentValue)
           
        case "-":
            currentValue = abs(Int(firstCurrentValue - secondCurrentValue))
           
        case "*":
            currentValue = Int(firstCurrentValue * secondCurrentValue)
           
        case "/":
            currentValue = Int(firstCurrentValue / secondCurrentValue)
        default:
            currentValue = Int(firstCurrentValue + secondCurrentValue)
        }
        return currentValue
    }
    
    
}

