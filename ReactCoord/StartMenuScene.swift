//
//  StartMenuScene.swift
//  ReactCoord
//
//  Created by Vidar Fridriksson on 11/02/16.
//  Copyright © 2016 herraviddi. All rights reserved.
//

import UIKit
import SpriteKit
import Alamofire
import SwiftyJSON



class StartMenuScene: SKScene , UITextFieldDelegate{
    
    var userObjectData = NSMutableDictionary()
    
    let apiUrl = "https://group23api.herokuapp.com/api/user"
    
    var nameTextField = UITextField()
    var ageTextField = UITextField()
    var maleButton = UIButton()
    var femaleButton = UIButton()
    
    var resultLabel = SKLabelNode()
    
    var userInfo = [String:String]()
    
    var username = String()
    var userAge = Int()
    var userSex = String()
    var userID = Int()
    var numberOfDrinks = Int()
    
    var sexErrorLabel = UILabel()
    
    
    var jsonArray:NSMutableArray?

    var isMale = false
    var isFemale = false
    
    var userExists = false
    
    
    var startGameButton = SKSpriteNode()
    
    
    override func didMoveToView(view: SKView) {
    
        checkForUser()
        
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
        maleButton.layer.borderColor = SKColor.whiteColor().CGColor
        self.view?.addSubview(maleButton)

        femaleButton.frame = CGRectMake(210, size.height/2, 150, 50)
        femaleButton.setTitle("FEMALE", forState: UIControlState.Normal)
        femaleButton.addTarget(self, action: "femaleButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        femaleButton.layer.cornerRadius = 5
        femaleButton.layer.borderWidth = 1
        femaleButton.layer.borderColor = SKColor.whiteColor().CGColor
        self.view?.addSubview(femaleButton)
 
        sexErrorLabel.frame = CGRectMake(50, size.height/2-50, size.width-100, 50)
        sexErrorLabel.text = "Please select your sex"
        sexErrorLabel.textColor = UIColor.redColor()
        sexErrorLabel.hidden = true
        sexErrorLabel.textAlignment = .Center
        self.view?.addSubview(sexErrorLabel)
 
        startGameButton = SKSpriteNode(imageNamed: "Start-Test.png")
        startGameButton.position = CGPointMake(size.width/2, size.height/2-200)
        startGameButton.setScale(0.5)
        startGameButton.name = "startgame"
        addChild(startGameButton)
        
        resultLabel.text = "Result History"
        resultLabel.fontColor = SKColor.yellowColor()
        resultLabel.fontSize = 30
        resultLabel.name = "results"
        resultLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-300)
        self.addChild(resultLabel)
        resultLabel.hidden = true
        
        

    }
    
    func removeMyObjectsFromView(){
        nameTextField.removeFromSuperview()
        ageTextField.removeFromSuperview()
        maleButton.removeFromSuperview()
        femaleButton.removeFromSuperview()
        sexErrorLabel.removeFromSuperview()
        startGameButton.removeFromParent()
    }
    
    func maleButtonPressed(){
        maleButton.backgroundColor = SKColor.whiteColor()
        maleButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        femaleButton.backgroundColor = SKColor.clearColor()
        femaleButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        userSex = "M"
        isMale = true
        
    }

    func femaleButtonPressed(){
        femaleButton.backgroundColor = SKColor.whiteColor()
        femaleButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        maleButton.backgroundColor = SKColor.clearColor()
        maleButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        userSex = "F"
        isFemale = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // hide keyboard
        username = nameTextField.text!
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()

        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        
        if(touchedNode.name == "results"){
            let gamescene = ResultsScene(size: size)
            gamescene.scaleMode = scaleMode
            let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
            gamescene.userData = ["id":userID]

            removeMyObjectsFromView()
            view?.presentScene(gamescene, transition: transitionType)
            
        }
        
        if(touchedNode.name == "startgame"){
            if (username != "" && userSex != "" && ageTextField.text != "" ){

                checkForUser()
                
                let beerScene = BeerCounter(size: size)
                beerScene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
                userAge = Int(ageTextField.text!)!
                
                removeMyObjectsFromView()
                
                if !self.userExists{
                    postData()
                }else{

                }

                delay(1.0){
                    self.setUserData()
                    beerScene.userData = self.userObjectData
                    
                    print(self.userObjectData)
                    
                    self.view?.presentScene(beerScene,transition: transitionType)
                }
            
            }else{
                
                if nameTextField.text == ""{
                    nameTextField.placeholder = "your name is missing"
                }
                
                if (userSex == ""){
                    sexErrorLabel.hidden = false
                }else{
                    sexErrorLabel.hidden = true
                }
                
                if (ageTextField.text == ""){
                    ageTextField.placeholder = "your age is missing"
                }
            }

        }else{
            checkForUser()
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    
    func setUserData(){
        self.userObjectData = ["name": self.username, "age": self.userAge, "number_of_drinks": self.numberOfDrinks, "sex": self.userSex, "id": self.userID]
    }
    
    func checkForUser(){
        
        if let url = NSURL(string: apiUrl + "?name=" + nameTextField.text!) {
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let json = JSON(data: data)
                parseJSON(json)

            }
            else{
                self.userExists = false
                self.resultLabel.hidden = true
                turnOnUserInput()
                ageTextField.clearsOnBeginEditing = true
                femaleButton.backgroundColor = SKColor.clearColor()
                femaleButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                maleButton.backgroundColor = SKColor.clearColor()
                maleButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                userAge = 0
                userSex = ""
            }
        }
    }
    
    func turnOnUserInput(){
        ageTextField.userInteractionEnabled = true
        maleButton.enabled = true
        femaleButton.enabled = true
    }
    
    func turnOffUserInput(){
        ageTextField.userInteractionEnabled = false
        maleButton.enabled = false
        femaleButton.enabled = false
    }
    
    func parseJSON(json: JSON) {
                
        for result in json["user"].dictionaryValue{
            
            if result.0 == "age"{
                ageTextField.text = result.1.stringValue
                self.username = result.1.stringValue
            }
            if result.0 == "sex"{
                self.userSex = result.1.stringValue
                
                if result.1 == "M"{
                    maleButtonPressed()
                }
                if result.1 == "F"{
                    femaleButtonPressed()
                }
            }
            if result.0 == "id"{
                self.userID = Int(result.1.stringValue)!
            }
            if result.0 == "age"{
                self.userAge = Int(result.1.stringValue)!
            }
            
            if result.0 == "number_of_drinks" {
                if (result.1 != nil){
                    self.numberOfDrinks = result.1.intValue
                    print(self.numberOfDrinks)
                }else{
                    self.numberOfDrinks = 0
                }
            }
            
            self.resultLabel.hidden = false
            
            
            self.userExists = true

            turnOffUserInput()
         }
    }

    func postData(){
        let parameters: [String : AnyObject] = [
            "age" : userAge,
            "name" : username,
            "sex" : userSex,
            "number_of_drinks" : 0
        ]
        
        Alamofire.request(.POST, "https://group23api.herokuapp.com/api/user", parameters: parameters, encoding: .JSON).responseJSON(completionHandler: { (response) -> Void in
            // check if the result has a vales
            if let JSON = response.result.value{
                if let userDict = JSON.valueForKey("user"){
//                    print(userDict.valueForKey("id"))
                    self.userID = userDict.valueForKey("id") as! Int
                    print(self.userID)
                 }
            }
        })

    }
    
    
    // MARK: - TextField Methods
    
    func textFieldDidBeginEditing(textField: UITextField) {

        checkForUser()

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        if (textField == ageTextField){
            userAge = Int(ageTextField.text!)!
        }
        
        if (textField == nameTextField){
            username = nameTextField.text!
            checkForUser()
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
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
        
    }
    func doneButtonAction(){
        userAge = Int(ageTextField.text!)!
        ageTextField.resignFirstResponder() //Hide the keyboard
    }
    
}
