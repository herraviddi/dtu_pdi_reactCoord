//
//  StartMenuScene.swift
//  ReactCoord
//
//  Created by Vidar Fridriksson on 11/02/16.
//  Copyright © 2016 herraviddi. All rights reserved.
//

import UIKit
import SpriteKit


class StartMenuScene: SKScene , UITextFieldDelegate{
    
    
    var nameTextField = UITextField()
    var ageTextField = UITextField()
    var maleButton = UIButton()
    var femaleButton = UIButton()
    
    
    var userInfo = [String:String]()
    
    var username : String!
    var userAge : Int!
    var userSex : String!
    

    
    
    override func didMoveToView(view: SKView) {
        
        
        nameTextField.frame = CGRectMake(50, size.height/2-200, size.width-100, 50)
        nameTextField.placeholder = "your name please"
        nameTextField.textColor = SKColor.blackColor()
        view.addSubview(nameTextField)
        nameTextField.delegate = self
        nameTextField.borderStyle = UITextBorderStyle.RoundedRect
        nameTextField.autocorrectionType = UITextAutocorrectionType.Yes
        nameTextField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        self.view?.addSubview(nameTextField)
        
        
        ageTextField.frame = CGRectMake(50, size.height/2-100, size.width-100, 50)
        ageTextField.placeholder = "your age please"
        ageTextField.textColor = SKColor.blackColor()
        view.addSubview(ageTextField)
        ageTextField.delegate = self
        ageTextField.keyboardType = UIKeyboardType.NumberPad
        ageTextField.borderStyle = UITextBorderStyle.RoundedRect
        addDoneButtonOnKeyboard(ageTextField)
        self.view?.addSubview(ageTextField)
        
        
        
        maleButton.frame = CGRectMake(50, size.height/2, 150, 50)
        maleButton.setTitle("MALE", forState: UIControlState.Normal)
        maleButton.addTarget(self, action: "maleButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        maleButton.layer.cornerRadius = 5
        maleButton.layer.borderWidth = 1
        maleButton.layer.borderColor = SKColor.blackColor().CGColor
        self.view?.addSubview(maleButton)
        

        femaleButton.frame = CGRectMake(210, size.height/2, 150, 50)
        femaleButton.setTitle("FEMALE", forState: UIControlState.Normal)
        femaleButton.addTarget(self, action: "femaleButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        femaleButton.layer.cornerRadius = 5
        femaleButton.layer.borderWidth = 1
        femaleButton.layer.borderColor = SKColor.blackColor().CGColor
        self.view?.addSubview(femaleButton)
        
        
        
        let startGameButton = SKSpriteNode(imageNamed: "Start-Test.png")
        startGameButton.position = CGPointMake(size.width/2, size.height/2-200)
        startGameButton.setScale(0.5)
        startGameButton.name = "startgame"
        addChild(startGameButton)
        
        backgroundColor = SKColor.blueColor()

    }
    
    func maleButtonPressed(){
        print("you are a male")
        maleButton.backgroundColor = SKColor.whiteColor()
        maleButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        femaleButton.backgroundColor = SKColor.clearColor()
        femaleButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        userSex = "M"
    }

    func femaleButtonPressed(){
        print("you are a female")
        femaleButton.backgroundColor = SKColor.whiteColor()
        femaleButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        maleButton.backgroundColor = SKColor.clearColor()
        maleButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        userSex = "F"
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // hide keyboard
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        
        
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        if(touchedNode.name == "startgame"){
            let gameOverScene = GameScene(size: size)
            gameOverScene.scaleMode = scaleMode
            let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
            nameTextField.hidden = true
            ageTextField.hidden = true
            view?.presentScene(gameOverScene,transition: transitionType)
        }
    }
    
    
    // MARK: - TextField Methods
    
    func textFieldDidBeginEditing(textField: UITextField) {

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == ageTextField){
            userAge = Int(ageTextField.text!)
            print(userAge)
        }
        
        if (textField == nameTextField){
            username = nameTextField.text
            print(username)
        }
        // Hides the keyboard
        textField.resignFirstResponder()
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
        userAge = Int(ageTextField.text!)
        print(userAge)
        ageTextField.resignFirstResponder() //Hide the keyboard
    }
    
}
