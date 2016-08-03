//
//  ViewController.swift
//  DelegatePattern
//
//  Created by Admin on 8/3/16.
//  Copyright © 2016 Yohoho. All rights reserved.
//

import UIKit

public extension Int {
    /// Swift Random extension
    public static func random(lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}

public extension Double {
    /// Swift Random extension
    public static func random(lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension Float {
    /// Swift Random extension
    public static func random(lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension CGFloat {
    /// Swift Random extension
    public static func random(lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}

// -+== Протокол ==+- требование выполнить то-то
protocol colorReciving{
    func didReciveColor(color: UIColor)
    func didReciveColorFailed()
}

// -+== Делегат ==+- подписан на протокол, выполняет то-то
class SomeDrawing: colorReciving{
    var drawingColor: UIColor? {
        didSet {
            print("\(drawingColor?.description)")
            // Some color updates
        }
    }
    
    func didReciveColor(color: UIColor) {
        self.drawingColor = color
    }
    
    func didReciveColorFailed() {
        print("Color reciving failed! =(")
    }
}

// -+== Делегатор ==+- нужен делегат, который может выполнить то-то
class RandomColorPerformer {
    var delegate: colorReciving?
    
    var performingColor: UIColor?
    
    func performRandomColor() {
        
        performingColor = UIColor.init(red: CGFloat(Float.random(0.0, 1.0)),
                                       green: CGFloat(Float.random(0.0, 1.0)),
                                       blue: CGFloat(Float.random(0.0, 1.0)),
                                       alpha: CGFloat(Float.random(0.5, 1.0)))
        
        if let delegate = delegate {
            if let color = performingColor {
                delegate.didReciveColor(color)
            } else {
                delegate.didReciveColorFailed()
            }
        }
    }
    
    init() {
        
    }
    
    convenience init(color: UIColor) {
        self.init()
        self.performingColor = color
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateButtonPressed(self)
    }
    
    @IBAction func updateButtonPressed(sender: AnyObject) {
        let drawing = SomeDrawing()
        let randomColorPerformer = RandomColorPerformer()
        
        randomColorPerformer.delegate = drawing
        
        randomColorPerformer.performRandomColor()
        self.view.backgroundColor = drawing.drawingColor
        ()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

