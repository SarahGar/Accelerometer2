//
//  ViewController.swift
//  Accelerometer
//
//  Created by Sarah Garrow on 2/15/16.
//  Copyright © 2016 Sarah Garrow. All rights reserved.
//

import UIKit
import CoreMotion
import Foundation

class ViewController: UIViewController {
    
    //Instance Variables
    var currentMaxAccelX: Double = 0.0
    var currentMaxAccelY: Double = 0.0
    var currentMaxAccelZ: Double = 0.0
    var currentMaxRotX: Double = 0.0
    var currentMaxRotY: Double = 0.0
    var currentMaxRotZ: Double = 0.0
    
    var motionManager = CMMotionManager()
    var accArray : [Double] = Array()
    var rotArray : [Double] = Array()
    
    
    //Outlets
    @IBOutlet weak var accX: UILabel!
    @IBOutlet weak var accY: UILabel!
    @IBOutlet weak var accZ: UILabel!
    @IBOutlet weak var maxAccX: UILabel!
    @IBOutlet weak var maxAccY: UILabel!
    @IBOutlet weak var maxAccZ: UILabel!
    @IBOutlet weak var rotX: UILabel!
    @IBOutlet weak var rotY: UILabel!
    @IBOutlet weak var rotZ: UILabel!
    @IBOutlet weak var maxRotX: UILabel!
    @IBOutlet weak var maxRotY: UILabel!
    @IBOutlet weak var maxRotZ: UILabel!
    
    //IBA Functions
    @IBAction func resetMaxValues(sender: AnyObject?) {
        currentMaxAccelX = 0
        currentMaxAccelY = 0
        currentMaxAccelZ = 0
        
        currentMaxRotX = 0
        currentMaxRotY = 0
        currentMaxRotZ = 0
        
        accArray.removeAll()
        rotArray.removeAll()
    }
    
    @IBAction func startDataCollection(sender: AnyObject) {
        
        motionManager.accelerometerUpdateInterval = 0.5
        motionManager.gyroUpdateInterval = 0.5
        
        
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            self.outputAccelerationData(accelerometerData!.acceleration)
            self.storeAccelerationData(accelerometerData!.acceleration)
            if (NSError != nil) {
                print("\(NSError)")
            }
        }
        
        motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!) { (gyroData: CMGyroData?, NSError) -> Void in
            self.outputRotationData(gyroData!.rotationRate)
            self.storeRotationData(gyroData!.rotationRate)
            if (NSError != nil) {
                print("\(NSError)")
            }
        }
    }
    
  
    @IBAction func stopDataCollection(sender: AnyObject) {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }

    //Functions 
    
    override func viewDidLoad() {
        self.resetMaxValues(nil)
        super.viewDidLoad()
    }
    
    //func NumberFormatter (number: Double) -> String {
        //let numberFormatter = NSNumberFormatter()
        //numberFormatter.numberStyle = NSNumberFormatterStyle.ScientificStyle
        //numberFormatter.positiveFormat = "0.###E+0"
        //numberFormatter.exponentSymbol = "e"
        
        //let stringFromNumber = numberFormatter.stringFromNumber(number)
        //return stringFromNumber!
    //}
    
    func storeAccelerationData (acceleration: CMAcceleration) {
        //let accMagnitude = NumberFormatter(sqrt(pow(acceleration.x,2)+pow(acceleration.y,2)+pow(acceleration.z,2)))
        //print(accMagnitude)
        //let accMagnitudeDouble = Double
        //accArray.append(accMagnitude)
        accArray.append(Double(round(sqrt(pow(acceleration.x,2)+pow(acceleration.y,2)+pow(acceleration.z,2))*1000)/1000))
    }
    
    func storeRotationData (rotation: CMRotationRate) {
        rotArray.append(Double(round(sqrt(pow(rotation.x,2)+pow(rotation.y,2)+pow(rotation.z,2))*1000)/1000))
    }
    
    func outputAccelerationData (acceleration: CMAcceleration) {
        let acX = Double(round(1000*acceleration.x)/1000)
        accX?.text = "\(acX) g"
        if fabs(acceleration.x) > fabs(currentMaxAccelX)
        {
            currentMaxAccelX = acceleration.x
        }
        
        let acY = Double(round(1000*acceleration.y)/1000)
        accY?.text = "\(acY) g"
        if fabs(acceleration.y) > fabs(currentMaxAccelY)
        {
            currentMaxAccelY = acceleration.y
        }
        
        let acZ = Double(round(1000*acceleration.z)/1000)
        accZ?.text = "\(acZ) g"
        if fabs(acceleration.z) > fabs(currentMaxAccelZ)
        {
            currentMaxAccelZ = acceleration.z
        }
        
        let maxAcX = Double(round(1000*currentMaxAccelX)/1000)
        let maxAcY = Double(round(1000*currentMaxAccelY)/1000)
        let maxAcZ = Double(round(1000*currentMaxAccelZ)/1000)
        maxAccX?.text = "\(maxAcX) g"
        maxAccY?.text = "\(maxAcY) g"
        maxAccZ?.text = "\(maxAcZ) g"
    }
    
    func outputRotationData (rotation: CMRotationRate) {
        let roX = Double(round(1000*rotation.x)/1000)
        rotX?.text = "\(roX) r/s"
        if fabs(rotation.x) > (currentMaxRotX)
        {
            currentMaxRotX = rotation.x
        }
        
        let roY = Double(round(1000*rotation.y)/1000)
        rotY?.text = "\(roY) r/s"
        if fabs(rotation.y) > (currentMaxRotY)
        {
            currentMaxRotY = rotation.y
        }
        
        let roZ = Double(round(1000*rotation.z)/1000)
        rotZ?.text = "\(roZ) r/s"
        if fabs(rotation.z) > (currentMaxRotZ)
        {
            currentMaxRotZ = rotation.z
        }
        
        let maxRoX = Double(round(1000*currentMaxRotX)/1000)
        let maxRoY = Double(round(1000*currentMaxRotY)/1000)
        let maxRoZ = Double(round(1000*currentMaxRotZ)/1000)
        maxRotX?.text = "\(maxRoX) r/s"
        maxRotY?.text = "\(maxRoY) r/s"
        maxRotZ?.text = "\(maxRoZ) r/s"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "theSegue") {
            
            if let destination = segue.destinationViewController as? ChartViewController {
                destination.accelerationArray = accArray
                destination.rotationalArray = rotArray
                }
        }
    }


}

