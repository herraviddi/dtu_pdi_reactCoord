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
    let colorArray = [SKColor.blackColor(),SKColor.greenColor(),SKColor.redColor(),SKColor.blueColor(),SKColor.yellowColor(),SKColor.orangeColor(),SKColor.blueColor(),SKColor.magentaColor(),SKColor.cyanColor(),SKColor.brownColor()]

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
        
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        
        if touchedNode.name == "gameball"{
            if(self.sprite.fillColor != SKColor.clearColor()){
                
                self.sprite.fillColor = SKColor.clearColor()
                
                
                let randomSecondDelay = Int(arc4random_uniform(UInt32(3)))+1
                NSTimer.scheduledTimerWithTimeInterval(Double(randomSecondDelay), target: self, selector: "updateSpriteColor", userInfo: nil, repeats: false)
                tapStartTime = NSDate.timeIntervalSinceReferenceDate()
                
                if newColorTime == 0.0{

                }
                else{
                    let deltaTime = tapStartTime - newColorTime
                    reactionTimeResultsArr.addObject(deltaTime)
                }
            }
        }
    }
    
    func restart() {
        self.motionManager.stopAccelerometerUpdates()
        self.sprite.removeFromParent()
        self.centerBall.removeFromParent()
        self.removeAllChildren()
        self.removeAllActions()
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
//        if (!intersectsNode(self.sprite)) || gameTime >= 10.0{
        if (gameTime >= 30.0){
            let avgDistance = calculateDistance()
            let avgReact = avgReaction()
            
            self.userData?.setValue(avgDistance, forKey: "avgDistance")
            self.userData?.setValue(avgReact, forKey: "avgReaction")
            
            
            let gamescene = GameOverScene(size: size)
            gamescene.scaleMode = scaleMode
            let transitionType = SKTransition.flipHorizontalWithDuration(0.5)
            
//            self.removeAllChildren()
            restart()
            
            gamescene.userData = self.userData
            
            
            view?.presentScene(gamescene, transition: transitionType)
        }
        calculateDistance()

        
        let actionX = SKAction.moveToX(self.destX, duration: 0.5)
        let actionY = SKAction.moveToY(self.destY, duration: 0.5)
        let groupAction = SKAction.group([actionY,actionX])
        self.sprite.runAction(groupAction)
    }
    
    
    // MARK: - My Methods
    
    func startNewGame(){
        
        restart()
        
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
        sprite.lineWidth = 2.0
        sprite.name = "gameball"
        
        sprite.zPosition = 2
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        sprite.runAction(SKAction.repeatActionForever(action))
        self.sprite.fillColor = SKColor.clearColor()
        self.sprite.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        self.addChild(self.sprite)

        
        centerBall.hidden = false
        
        if motionManager.accelerometerAvailable == true {
            // 2
            motionDetection()
        }
        let randomSecondDelay = Int(arc4random_uniform(UInt32(3)))+1
        NSTimer.scheduledTimerWithTimeInterval(Double(randomSecondDelay), target: self, selector: "updateSpriteColor", userInfo: nil, repeats: false)


        
    }
    
    func motionDetection(){
        // 2
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:{
            data, error in
            
            self.currentX = self.sprite.position.x
            self.currentY = self.sprite.position.y
            
            var multiplier: Double = 4000
            
            if self.gameTime > 5.0{
                multiplier += 1000
                self.centerBall.xScale = 0.75
                self.centerBall.yScale = 0.75
            }
            if self.gameTime > 10.0{
                multiplier += 1500
                self.centerBall.xScale = 0.5
                self.centerBall.yScale = 0.5
            }
            if self.gameTime > 15.0{
                multiplier += 2000
                self.centerBall.xScale = 0.25
                self.centerBall.yScale = 0.25
            }
            if self.gameTime > 20.0{
                multiplier += 2500
                self.centerBall.xScale = 0.1
                self.centerBall.yScale = 0.1
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
        
        centerBall.xScale = 1
        centerBall.yScale = 1
        centerBall.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        centerBall.fillColor = SKColor.blackColor()
        //        centerBall.cir = 50
        centerBall.hidden = true
        self.addChild(centerBall)

    }
    
    
    
    
    
}
