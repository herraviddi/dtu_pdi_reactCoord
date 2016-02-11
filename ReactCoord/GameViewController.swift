//
//  GameViewController.swift
//  ReactCoord
//
//  Created by Vidar Fridriksson on 10/02/16.
//  Copyright (c) 2016 herraviddi. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController,UITextFieldDelegate{

    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var screenWidth = CGFloat()
    var screenHeight = CGFloat()
    var textfieldWidth = CGFloat()
    var buttonWidth = CGFloat()
    var elementHeight = CGFloat()
    var spacing = CGFloat()
    
    
    let startButton = UIButton()
    let userNameTextField = UITextField()
    let userAgeTextField = UITextField()
    
    var userAge = Int()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView = UIView()
        backgroundView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
        backgroundView.backgroundColor = UIColor.blueColor()
        self.view.addSubview(backgroundView)
        
        self.view.backgroundColor = UIColor.blueColor()
        
        setSizeConstants()
        
        
        setupUI()
    
    }
    
    func setSizeConstants(){
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        print("screenwidth : ",screenWidth)
        print("screenheight : ",screenHeight)
        textfieldWidth = screenWidth/1.4
        buttonWidth = screenWidth/1.8
        elementHeight = 50
        spacing = elementHeight/2
        
    }
    
    func setupUI(){
//        self.view.backgroundColor = UIColor.whiteColor()
        startButton.frame = CGRectMake(screenWidth/2-(buttonWidth/2), screenHeight/2 + 200, buttonWidth, elementHeight)
        startButton.setTitle("Start Test", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "startGame", forControlEvents: .TouchUpInside)
        startButton.titleLabel?.font = UIFont.systemFontOfSize(36, weight: UIFontWeightLight)
        startButton.tintColor = UIColor.blueColor()
        self.view.addSubview(startButton)
        
        userNameTextField.frame = CGRectMake(screenWidth/2 - (textfieldWidth/2), screenHeight/2 - spacing*2, textfieldWidth, elementHeight)
        userNameTextField.textColor = UIColor.blackColor()
        userNameTextField.placeholder = "yourname"
        userNameTextField.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        userNameTextField.textAlignment = .Left
        self.view.addSubview(userNameTextField)
        
        userAgeTextField.frame = CGRectMake(screenWidth/2 - (textfieldWidth/2), screenHeight/2, textfieldWidth, elementHeight)
        userAgeTextField.textColor = UIColor.blackColor()
        userAgeTextField.placeholder = "your age"
        userAgeTextField.keyboardType = .NumberPad
        userAgeTextField.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        userAgeTextField.textAlignment = .Left
        addDoneButtonOnKeyboard(userAgeTextField)
        self.view.addSubview(userAgeTextField)
        
    }
    
    
    
    func startGame(){
        startButton.hidden = true
        userNameTextField.hidden = true
        userAgeTextField.hidden = true
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }

    // MARK: - TextField Delegate functions
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)  {
        
        //Hide the keyboard
        userNameTextField.resignFirstResponder()
        userAgeTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder() //Hide the keyboard
        return true
    }
    
    func addDoneButtonOnKeyboard(textField:UITextField)
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.BlackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneButtonAction"))
        
        done.tintColor = UIColor.whiteColor()
        var items = [AnyObject]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items as! [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction(){
        userAge = Int(userAgeTextField.text!)!
        userAgeTextField.resignFirstResponder() //Hide the keyboard
    }
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
