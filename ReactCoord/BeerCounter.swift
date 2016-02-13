//
//  BeerCounter.swift
//  ReactCoord
//
//  Created by Vidar Fridriksson on 12/02/16.
//  Copyright © 2016 herraviddi. All rights reserved.
//

import UIKit
import SpriteKit
import Alamofire
import SwiftyJSON

class BeerCounter: SKScene {

    
    var beerCount = Int()
    
    var beer1 = SKSpriteNode()
    var beer2 = SKSpriteNode()
    var beer3 = SKSpriteNode()
    var beer4 = SKSpriteNode()
    var beer5 = SKSpriteNode()
    var beer6 = SKSpriteNode()
    var beer7 = SKSpriteNode()
    var beer8 = SKSpriteNode()
    var beer9 = SKSpriteNode()
    var beer10 = SKSpriteNode()
    var beer11 = SKSpriteNode()
    var beer12 = SKSpriteNode()
    var beer13 = SKSpriteNode()
    var beer14 = SKSpriteNode()
    var beer15 = SKSpriteNode()
    var beer16 = SKSpriteNode()
    var beer17 = SKSpriteNode()
    var beer18 = SKSpriteNode()
    var beer19 = SKSpriteNode()
    var beer20 = SKSpriteNode()
    
    var startLabel = SKLabelNode()
    
    var initialBeerCount = Int()
    
    override func didMoveToView(view: SKView) {
        
        beerCount = Int((self.userData?.valueForKey("number_of_drinks"))! as! NSNumber)
        
        initialBeerCount = beerCount
                
        if(beerCount < 1){
            beer1 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer1 = SKSpriteNode(imageNamed: "emptyBeer")
            beer1.userInteractionEnabled = false
        }
        beer1.name = "beer1"
        beer1.position = CGPointMake(50, size.height-100-50)
        self.addChild(beer1)
        
        
        
        if(beerCount < 2){
            beer2 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer2 = SKSpriteNode(imageNamed: "emptyBeer")
            beer2.userInteractionEnabled = false
        }
        beer2.name = "beer2"
        beer2.position = CGPointMake(150, size.height-100-50)
        self.addChild(beer2)
        
        
        
        if(beerCount < 3){
            beer3 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer3 = SKSpriteNode(imageNamed: "emptyBeer")
            beer3.userInteractionEnabled = false
        }
        beer3.name = "beer3"
        beer3.position = CGPointMake(250, size.height-100-50)
        self.addChild(beer3)
        
        
        
        if(beerCount < 4){
            beer4 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer4 = SKSpriteNode(imageNamed: "emptyBeer")
            beer4.userInteractionEnabled = false
        }
        beer4.name = "beer4"
        beer4.position = CGPointMake(350, size.height-100-50)
        self.addChild(beer4)

        
        
        if(beerCount < 5){
            beer5 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer5 = SKSpriteNode(imageNamed: "emptyBeer")
            beer5.userInteractionEnabled = false
        }
        beer5.name = "beer5"
        beer5.position = CGPointMake(50, size.height-100-150)
        self.addChild(beer5)
        
        
        
        if(beerCount < 6){
            beer6 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer6 = SKSpriteNode(imageNamed: "emptyBeer")
            beer6.userInteractionEnabled = false
        }
        beer6.name = "beer6"
        beer6.position = CGPointMake(150,size.height-100-150)
        self.addChild(beer6)
        
        
        
        if(beerCount < 7){
            beer7 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer7 = SKSpriteNode(imageNamed: "emptyBeer")
            beer7.userInteractionEnabled = false
        }
        beer7.name = "beer7"
        beer7.position = CGPointMake(250, size.height-100-150)
        self.addChild(beer7)
        
        
        
        if(beerCount < 8){
            beer8 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer8 = SKSpriteNode(imageNamed: "emptyBeer")
            beer8.userInteractionEnabled = false
        }
        beer8.name = "beer8"
        beer8.position = CGPointMake(350, size.height-100-150)
        self.addChild(beer8)
        
        
        
        if(beerCount < 9){
            beer9 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer9 = SKSpriteNode(imageNamed: "emptyBeer")
            beer9.userInteractionEnabled = false
        }
        beer9.name = "beer9"
        beer9.position = CGPointMake(50, size.height-100-250)
        self.addChild(beer9)
        
        
        
        if(beerCount < 10){
            beer10 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer10 = SKSpriteNode(imageNamed: "emptyBeer")
            beer10.userInteractionEnabled = false
        }
        beer10.name = "beer10"
        beer10.position = CGPointMake(150, size.height-100-250)
        self.addChild(beer10)
        
        
        
        if(beerCount < 11){
            beer11 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer11 = SKSpriteNode(imageNamed: "emptyBeer")
            beer11.userInteractionEnabled = false
        }
        beer11.name = "beer11"
        beer11.position = CGPointMake(250, size.height-100-250)
        self.addChild(beer11)
        
        
        
        if(beerCount < 12){
            beer12 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer12 = SKSpriteNode(imageNamed: "emptyBeer")
            beer12.userInteractionEnabled = false
        }
        beer12.name = "beer12"
        beer12.position = CGPointMake(350, size.height-100-250)
        self.addChild(beer12)
        
        
        
        if(beerCount < 13){
            beer13 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer13 = SKSpriteNode(imageNamed: "emptyBeer")
            beer13.userInteractionEnabled = false
        }
        beer13.name = "beer13"
        beer13.position = CGPointMake(50, size.height-100-350)
        self.addChild(beer13)
        
        
        
        if(beerCount < 14){
            beer14 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer14 = SKSpriteNode(imageNamed: "emptyBeer")
            beer14.userInteractionEnabled = false
        }
        beer14.name = "beer14"
        beer14.position = CGPointMake(150, size.height-100-350)
        self.addChild(beer14)
        
        
        
        if(beerCount < 15){
            beer15 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer15 = SKSpriteNode(imageNamed: "emptyBeer")
            beer15.userInteractionEnabled = false
        }
        beer15.name = "beer15"
        beer15.position = CGPointMake(250, size.height-100-350)
        self.addChild(beer15)
        
        
        
        if(beerCount < 16){
            beer16 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer16 = SKSpriteNode(imageNamed: "emptyBeer")
            beer16.userInteractionEnabled = false
        }
        beer16.name = "beer16"
        beer16.position = CGPointMake(350, size.height-100-350)
        self.addChild(beer16)
        
        
        
        if(beerCount < 17){
            beer17 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer17 = SKSpriteNode(imageNamed: "emptyBeer")
            beer17.userInteractionEnabled = false
        }
        beer17.name = "beer17"
        beer17.position = CGPointMake(50, size.height-100-450)
        self.addChild(beer17)
        
        
        
        if(beerCount < 18){
            beer18 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer18 = SKSpriteNode(imageNamed: "emptyBeer")
            beer18.userInteractionEnabled = false
        }
        beer18.name = "beer18"
        beer18.position = CGPointMake(150, size.height-100-450)
        self.addChild(beer18)
        
        
        
        if(beerCount < 19){
            beer19 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer19 = SKSpriteNode(imageNamed: "emptyBeer")
            beer19.userInteractionEnabled = false
        }
        beer19.name = "beer19"
        beer19.position = CGPointMake(250, size.height-100-450)
        self.addChild(beer19)
        
        
        
        if(beerCount < 20){
            beer20 = SKSpriteNode(imageNamed: "fullBeer")
        }else{
            beer20 = SKSpriteNode(imageNamed: "emptyBeer")
            beer20.userInteractionEnabled = false
        }
        beer20.name = "beer20"
        beer20.position = CGPointMake(350, size.height-100-450)
        self.addChild(beer20)

        
        startLabel.text = "GO!"
        startLabel.position = CGPointMake(200, size.height-650)
        startLabel.fontSize = 40
        startLabel.color = SKColor.blueColor()
        startLabel.name = "startLabel"
        startLabel.hidden = true
        self.addChild(startLabel)

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)

        
        if(touchedNode.name == "beer1" && beerCount==initialBeerCount){
            beerCount += 1
            beer1.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer2" && beerCount==initialBeerCount){
            beerCount += 1
            beer2.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer3" && beerCount==initialBeerCount){
            beerCount += 1
            beer3.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer4" && beerCount==initialBeerCount){
            beerCount += 1
            beer4.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer5" && beerCount==initialBeerCount){
            beerCount += 1
            beer5.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer6" && beerCount==initialBeerCount){
            beerCount += 1
            beer6.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer7" && beerCount==initialBeerCount){
            beerCount += 1
            beer7.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer8" && beerCount==initialBeerCount){
            beerCount += 1
            beer8.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer9" && beerCount==initialBeerCount){
            beerCount += 1
            beer9.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer10" && beerCount==initialBeerCount){
            beerCount += 1
            beer10.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer11" && beerCount==initialBeerCount){
            beerCount += 1
            beer11.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer12" && beerCount==initialBeerCount){
            beerCount += 1
            beer12.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer13" && beerCount==initialBeerCount){
            beerCount += 1
            beer13.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer14" && beerCount==initialBeerCount){
            beerCount += 1
            beer14.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer15" && beerCount==initialBeerCount){
            beerCount += 1
            beer15.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer16" && beerCount==initialBeerCount){
            beerCount += 1
            beer16.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer17" && beerCount==initialBeerCount){
            beerCount += 1
            beer17.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer18" && beerCount==initialBeerCount){
            beerCount += 1
            beer18.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer19" && beerCount==initialBeerCount){
        
            
            beerCount += 1
            beer19.texture = SKTexture(imageNamed: "emptyBeer")
        }
        if(touchedNode.name == "beer20" && beerCount==initialBeerCount){
            beerCount += 1
            beer20.texture = SKTexture(imageNamed: "emptyBeer")
        }
        
        if(touchedNode.name == "startLabel"){
            
            let gamescene = CountInGameScene(size: size)
            gamescene.scaleMode = scaleMode
            let transitionType = SKTransition.doorsOpenHorizontalWithDuration(1.0)
            
            self.userData?.setValue(beerCount, forKey: "number_of_drinks")
            gamescene.userData = self.userData
            view?.presentScene(gamescene, transition: transitionType)

        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if(beerCount != initialBeerCount || initialBeerCount == 0){
            startLabel.hidden = false
        }
    }
    
}
