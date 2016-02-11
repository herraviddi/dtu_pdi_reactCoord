//
//  GameScene.swift
//  ReactCoord
//
//  Created by Vidar Fridriksson on 10/02/16.
//  Copyright (c) 2016 herraviddi. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    
    // MARK: - Properties
    
    var gameOverBool = Bool()
    
    // sprite nodes properties
    let sprite = SKShapeNode(circleOfRadius: 200)
    let centerBall = SKShapeNode(circleOfRadius: 50)
    
    // timer properties
    var tapStartTime = NSTimeInterval()
    var newColorTime = NSTimeInterval()
    var gameStartTime = NSTimeInterval()
    var gameTime = NSTimeInterval()

    // label properties
    let yourTimeLabel = SKLabelNode()
    let timeLabel = SKLabelNode()
    let startLabel = SKLabelNode()
    let avgReactLabel = SKLabelNode()
    let avgReactTime = SKLabelNode()
    let gameOverLabel = SKLabelNode()
    
    // screen properties
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var screenWidth = CGFloat()
    var screenHeight = CGFloat()
    
    // coremotion(gyro) properties
    var motionManager = CMMotionManager()
    var destX:CGFloat = 0.0
    var destY:CGFloat = 0.0
    var currentX = CGFloat()
    var currentY = CGFloat()
    
    // distance properties
    var xDist = CGFloat()
    var yDist = CGFloat()
    var distance = CGFloat()

    // touch properties
    var touchLocation = CGPoint()
    var previousNumber = Int()
    var countOfAttempts = 0
    let colorArray = [SKColor.blackColor(),SKColor.greenColor(),SKColor.redColor(),SKColor.blueColor(),SKColor.yellowColor(),SKColor.orangeColor(),SKColor.whiteColor(),SKColor.magentaColor(),SKColor.cyanColor(),SKColor.brownColor()]

    // result arrays
    let reactionTimeResultsArr = NSMutableArray()
    var distanceArray = NSMutableArray()

    
    // MARK: - SpriteKit Methods
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        startNewGame()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        if countOfAttempts == 0{
            self.sprite.position = CGPointMake(frame.size.width/2, frame.size.height/2)
            self.addChild(self.sprite)
            countOfAttempts = 1
            centerBall.hidden = false
        }
        
        startLabel.hidden = true
        
        
        let randomSecondDelay = Int(arc4random_uniform(UInt32(3)))+1
        
        if let touch = touches.first{
            self.touchLocation = touch.locationInNode(self.sprite)
            
        }
        calculateDistance()
        
        if gameOverBool{
            self.removeAllChildren()
            gameOverBool = false
            NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "startGame", userInfo: nil, repeats: false)
        }
        
        
        if self.touchLocation.y <= 0{
            self.destY = self.currentY + (touchLocation.y * (-1))
            print(self.destY)
        }
        else{
            self.destY = self.currentY - (touchLocation.y * 1)
            print(self.destY)
        }
        if self.touchLocation.x <= 0 {
            self.destX = self.currentX + (touchLocation.x * (-1))
            print(self.destX)
        }
        else{
            self.destX = self.currentX - (touchLocation.x * 1)
            print(self.destX)
        }
        
        self.sprite.fillColor = SKColor.clearColor()
        
        NSTimer.scheduledTimerWithTimeInterval(Double(randomSecondDelay), target: self, selector: "updateSpriteColor", userInfo: nil, repeats: false)
        tapStartTime = NSDate.timeIntervalSinceReferenceDate()
        
        if newColorTime == 0.0{
            timeLabel.text = "0.00 seconds"
            avgReactTime.text = "0.00 seconds"
        }
        else{
            let deltaTime = tapStartTime - newColorTime
            timeLabel.text = String(format: "%.02f",calculateDistance())
            reactionTimeResultsArr.addObject(deltaTime)
            avgReactTime.text = String(format: "%.02f", avgReaction()) + " seconds"
        }

        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if (!intersectsNode(self.sprite)) || reactionTimeResultsArr.count >= 20{
            
            if reactionTimeResultsArr.count >= 10 {
                gameOverLabel.text = "Finished Test"
            }
            
            self.removeChildrenInArray([self.sprite])
            gameOverLabel.hidden = false
            timeLabel.hidden = false
            yourTimeLabel.hidden = false
            avgReactLabel.hidden = false
            avgReactTime.hidden = false
            gameOverBool = true
            centerBall.hidden = true
        }
        
        let actionX = SKAction.moveToX(self.destX, duration: 0.5)
        let actionY = SKAction.moveToY(self.destY, duration: 0.5)
        let groupAction = SKAction.group([actionY,actionX])
        self.sprite.runAction(groupAction)
    }
    
    // MARK: - My Methods
    
    func startNewGame(){
        
        setupLabels()
        
        gameOverBool = false
        gameStartTime = NSDate.timeIntervalSinceReferenceDate()
        
        NSTimer.scheduledTimerWithTimeInterval(0.02,
            target: self,
            selector: Selector("timerUpdate:"),
            userInfo: nil,
            repeats: true)
        
        
        screenHeight = screenSize.height
        screenWidth = screenSize.width
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        
        sprite.zPosition = 2
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        sprite.runAction(SKAction.repeatActionForever(action))
        self.sprite.fillColor = colorArray[randomIndex()]
        
        
        if motionManager.accelerometerAvailable == true {
            // 2
            motionDetection()
        }

        
    }
    
    func motionDetection(){
        // 2
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:{
            data, error in
            
            self.currentX = self.sprite.position.x
            self.currentY = self.sprite.position.y
            
            var multiplier: Double = 3000
            
            if self.gameTime > 5.0{
                multiplier += 1000
            }
            if self.gameTime > 10.0{
                multiplier += 1500
            }
            if self.gameTime > 15.0{
                multiplier += 1500
            }
            if self.gameTime > 20.0{
                multiplier += 2000
            }
            // 3
            if data!.acceleration.x < 0 {
                self.destX = self.currentX + CGFloat(data!.acceleration.x * multiplier)
            }
            else if data!.acceleration.x > 0 {
                self.destX = self.currentX + CGFloat(data!.acceleration.x * multiplier)
            }
            if data!.acceleration.y < 0 {
                self.destY = self.currentY + CGFloat(data!.acceleration.y * multiplier)
            }
            else if data!.acceleration.y > 0{
                self.destY = self.currentY + CGFloat(data!.acceleration.y * multiplier)
            }
        })
    }
    
    
    
    func randomIndex() -> Int{
        var randomNumber = Int(arc4random_uniform(UInt32(colorArray.count)))
        while previousNumber == randomNumber {
            randomNumber = Int(arc4random_uniform(UInt32(colorArray.count)))
        }
        previousNumber = randomNumber
        return randomNumber
    }
    
    func timerUpdate(timer:NSTimer){
        gameTime = NSDate.timeIntervalSinceReferenceDate() - gameStartTime
    }
    
    // MARK : - Calculations
    
    func avgReaction() -> Double{
        
        var total = 0.0
        for time in reactionTimeResultsArr{
            total += Double(time as! NSNumber)
        }
        let totalTimes = Double(reactionTimeResultsArr.count)
        return total/totalTimes
    }
    
    func calculateDistance() -> Double{
        self.xDist = (self.size.width/2 - self.currentX)
        self.yDist = (self.size.height/2 - self.currentY)
        self.distance = sqrt((self.xDist*self.xDist) + (self.yDist * self.yDist))
        
        distanceArray.addObject(distance)
        
        var totalDist = 0.0
        for dist in distanceArray{
            totalDist += Double(dist as! NSNumber)
        }
        let totalCount = Double(distanceArray.count)
        return totalDist/totalCount
    }
    
    // MARK: - UI Setup
    
    func updateSpriteColor(){
        self.sprite.fillColor = colorArray[randomIndex()]
        newColorTime = NSDate.timeIntervalSinceReferenceDate()
    }
    
    func setupLabels(){
        // startLabel
        startLabel.text = "Tap to Start!"
        startLabel.fontColor = SKColor.blueColor()
        startLabel.fontSize = 70
        startLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        startLabel.hidden = false
        self.addChild(startLabel)
        
        yourTimeLabel.text = "Avg. Distance"
        yourTimeLabel.fontColor = SKColor.blackColor()
        yourTimeLabel.fontSize = 30
        yourTimeLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-200)
        yourTimeLabel.hidden = true
        self.addChild(yourTimeLabel)
        
        // timelabel
        timeLabel.text = "00:00"
        timeLabel.fontColor = SKColor.blackColor()
        timeLabel.fontSize = 30
        timeLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-240)
        timeLabel.hidden = true
        self.addChild(timeLabel)
        
        avgReactLabel.text = "Your avg reaction time"
        avgReactLabel.fontColor = SKColor.blackColor()
        avgReactLabel.fontSize = 30
        avgReactLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-280)
        avgReactLabel.hidden = true
        self.addChild(avgReactLabel)
        
        avgReactTime.text = "0.00 seconds"
        avgReactTime.fontColor = SKColor.blackColor()
        avgReactTime.fontSize = 30
        avgReactTime.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-320)
        avgReactTime.hidden = true
        self.addChild(avgReactTime)
        
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.fontColor = SKColor.redColor()
        gameOverLabel.fontSize = 40
        gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) )
        gameOverLabel.hidden = true
        self.addChild(gameOverLabel)
        
        centerBall.xScale = 0.5
        centerBall.yScale = 0.5
        centerBall.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        centerBall.fillColor = SKColor.blackColor()
        //        centerBall.cir = 50
        centerBall.hidden = true
        self.addChild(centerBall)

    }
    
    
    
    
    
}
