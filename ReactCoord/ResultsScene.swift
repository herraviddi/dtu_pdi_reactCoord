//
//  ResultsScene.swift
//  ReactCoord
//
//  Created by Vidar Fridriksson on 13/02/16.
//  Copyright © 2016 herraviddi. All rights reserved.
//

import UIKit
import SpriteKit
import Alamofire
import SwiftyJSON
import Charts

class ResultsScene: SKScene {
    
    var chartView = LineChartView()
    var chartView2 = LineChartView()
    
    var beers = [String]()
    var reactionTimeArray = [Double]()
    var distanceArray = [Double]()
    
    let apiUrl = "https://group23api.herokuapp.com/api/user"
    var userID = Int()
    
    var line1dataEntries : [BarChartDataEntry] = []
    var line2dataEntries : [BarChartDataEntry] = []
    
    var playAgain = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        
//        self.backgroundColor = SKColor.whiteColor()
        
        fetchUserData()
        
        chartView.frame = CGRectMake(30, 20, size.width-60, size.height/2-60)
        chartView.tintColor = SKColor.redColor()
        chartView.backgroundColor = SKColor.clearColor()
        chartView.descriptionTextColor = UIColor.whiteColor()
        chartView.leftAxis.labelTextColor = UIColor.whiteColor()
        chartView.rightAxis.labelTextColor = UIColor.whiteColor()
        chartView.xAxis.labelTextColor = UIColor.whiteColor()
        chartView.legend.textColor = UIColor.whiteColor()
        
        
        chartView2.frame = CGRectMake(20, 340, size.width-40, size.height/2-60)
        chartView2.tintColor = SKColor.redColor()
        chartView2.backgroundColor = SKColor.clearColor()
        chartView2.descriptionTextColor = UIColor.whiteColor()
        chartView2.leftAxis.labelTextColor = UIColor.whiteColor()
        chartView2.rightAxis.labelTextColor = UIColor.whiteColor()
        chartView2.xAxis.labelTextColor = UIColor.whiteColor()
        chartView2.legend.textColor = UIColor.whiteColor()
        
        
        chartView.noDataText = "there is no data here"
        
        
        // Reaction Time Line
        for i in 0..<self.beers.count {
            let dataEntry = BarChartDataEntry(value: self.reactionTimeArray[i], xIndex: i)
            line1dataEntries.append(dataEntry)
        }
        let line1dataSet = LineChartDataSet(yVals: line1dataEntries, label: "Reaction Time")
        line1dataSet.setColor(UIColor.redColor())
        line1dataSet.setCircleColor(UIColor.redColor())
        line1dataSet.valueTextColor = UIColor.clearColor()
        
        
        // Distance Line
        for i in 0..<self.beers.count {
            let dataEntry = BarChartDataEntry(value: self.distanceArray[i], xIndex: i)
            line2dataEntries.append(dataEntry)
        }
        let line2dataSet = LineChartDataSet(yVals: line2dataEntries, label: "Distance from center")
        line2dataSet.valueTextColor = UIColor.clearColor()
        
        let chart1Data = LineChartData(xVals: self.beers, dataSet: line1dataSet)
        let chart2Data = LineChartData(xVals: self.beers, dataSet: line2dataSet)
        
    
        
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        chartView2.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        chartView.data = chart1Data
        chartView2.data = chart2Data
        
        
        
        delay(0.5){
            self.view?.addSubview(self.chartView)
            self.view?.addSubview(self.chartView2)
        }
        
        
        playAgain.text = "Test Again"
        playAgain.name = "playagain"
        playAgain.fontColor = SKColor.yellowColor()
        playAgain.fontSize = 30
        playAgain.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-330)
        self.addChild(playAgain)

    }

    func fetchUserData(){
        
        userID = (self.userData?.valueForKey("id")) as! Int

        if let url = NSURL(string: apiUrl + "?id=" + String(userID)) {
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let json = JSON(data: data)
                parseJSON(json)
            }
        }
   }
    
    func parseJSON(json: JSON) {
        
        for result in json["user"].dictionaryValue{
            if result.0 == "results"{
                for item in result.1.arrayValue{
                    reactionTimeArray.append(item["reaction_time"].doubleValue)
                    distanceArray.append(item["distance_from_centre"].doubleValue)
                    beers.append(item["number_of_drinks"].stringValue)
                }
            }
        }
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        

        if(touchedNode.name == "playagain"){
            restart()
            let gamescene = StartMenuScene(size: size)
            gamescene.scaleMode = scaleMode
            let transitionType = SKTransition.fadeWithDuration(0.5)

            view?.presentScene(gamescene, transition: transitionType)
            
        }
    }
    func restart() {
        self.chartView.removeFromSuperview()
        self.chartView2.removeFromSuperview()
        self.removeAllChildren()
        self.removeAllActions()
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
