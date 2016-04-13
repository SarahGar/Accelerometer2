//
//  ChartViewController.swift
//  Accelerometer
//
//  Created by Sarah Garrow on 2/18/16.
//  Copyright © 2016 Sarah Garrow. All rights reserved.
//

import Foundation
import UIKit
import Charts
import CoreMotion

class ChartViewController: UIViewController {
    
    var accelerationArray: [Double] = Array()
    var rotationalArray: [Double] = Array()
    var xAxisArray = [String]()
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    //@IBAction func dismissChartView(sender: AnyObject) {
        //self.dismissViewControllerAnimated(true, completion: nil)
    //}
    
    func setChart(dataPoints: [String], values: [Double]) {
        //lineChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Acceleration, *g")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
    }
    
    func setXScale () {
        let length = accelerationArray.count
        var i = 0
        for i=0; i < length; i++ {
            var value = String(i+1)
            xAxisArray.append(value)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setXScale()
        setChart(xAxisArray, values: accelerationArray)
    }
    
    
}