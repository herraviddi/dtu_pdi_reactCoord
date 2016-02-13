//
//  GameOverScene.swift
//  ReactCoord
//
//  Created by Vidar Fridriksson on 12/02/16.
//  Copyright © 2016 herraviddi. All rights reserved.
//

import UIKit
import SpriteKit
import Alamofire
import SwiftyJSON

class GameOverScene: SKScene {
    
    var gameOverLabel = SKLabelNode()
    
    var titleReactionLabel = SKLabelNode()
    var reactionLabel = SKLabelNode()
    var titleDistanceLabel = SKLabelNode()
    var distanceLabel = SKLabelNode()
    
    var resultLabel = SKLabelNode()
    var playAgain = SKLabelNode()
    
    var avgDistance = Double()
    var avgReaction = Double()
    
    var beerCount = Int()
    
    override func didMoveToView(view: SKView) {
        
        
        
        avgDistance = (self.userData?.valueForKey("avgDistance"))! as! Double
        avgReaction = (self.userData?.valueForKey("avgReaction"))! as! Double
        
        beerCount = self.userData?.valueForKey("number_of_drinks") as! Int
        
        postData()
        gameOverLabel.text = "Finished!"
        gameOverLabel.position = CGPointMake(size.width/2, size.height/2+100)
        gameOverLabel.fontSize = 60
        gameOverLabel.fontColor = SKColor.redColor()
        self.addChild(gameOverLabel)
        
        

        titleDistanceLabel.text = "Avg. Distance"
        titleDistanceLabel.fontColor = SKColor.whiteColor()
        titleDistanceLabel.fontSize = 30
        titleDistanceLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(titleDistanceLabel)
        
        // timelabel
        distanceLabel.text = String(format: "%.02f",avgDistance)
        distanceLabel.fontColor = SKColor.whiteColor()
        distanceLabel.fontSize = 30
        distanceLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-40)
        self.addChild(distanceLabel)
        
        
        titleReactionLabel.text = "Your avg reaction time"
        titleReactionLabel.fontColor = SKColor.whiteColor()
        titleReactionLabel.fontSize = 30
        titleReactionLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-80)
        self.addChild(titleReactionLabel)
        
        reactionLabel.text = String(format: "%.02f",avgReaction) + " seconds"
        reactionLabel.fontColor = SKColor.whiteColor()
        reactionLabel.fontSize = 30
        reactionLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-120)
        self.addChild(reactionLabel)
        
        
        resultLabel.text = "Result History"
        resultLabel.fontColor = SKColor.whiteColor()
        resultLabel.fontSize = 30
        resultLabel.name = "results"
        resultLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-220)
        self.addChild(resultLabel)
        
        playAgain.text = "Test Again"
        playAgain.name = "playagain"
        playAgain.fontColor = SKColor.blueColor()
        playAgain.fontSize = 50
        playAgain.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-320)
        self.addChild(playAgain)

    }
    
    func postData(){

        let resultsDict: [String : AnyObject] = [
                "distance_from_centre": avgDistance,
                "number_of_drinks": beerCount,
                "reaction_time": avgReaction,
            "user_id" : (self.userData?.valueForKey("id"))!
        ]

        let url = NSURL(string: "https://group23api.herokuapp.com/api/result")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(resultsDict, options: [])
        
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .Failure(let error):
                    print(error)
                case .Success(let responseObject):
                    print(responseObject)
                }
        }
        
        
        
        
//        Alamofire.request(.POST, "https://group23api.herokuapp.com/api/results=", parameters: resultsDict, encoding: .JSON).responseJSON(completionHandler: { (response) -> Void in
//            // check if the result has a vales
//            if let JSON = response.result.value{
//                print(JSON)
//            }
//            
//        })
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        
        if(touchedNode.name == "results"){

            
        }
        if(touchedNode.name == "playagain"){
            let gamescene = StartMenuScene(size: size)
            gamescene.scaleMode = scaleMode
            let transitionType = SKTransition.fadeWithDuration(0.5)
            
            view?.presentScene(gamescene, transition: transitionType)
            
        }

        
    }

}
