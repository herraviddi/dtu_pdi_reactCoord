//
//  UserObject.swift
//  ReactCoord
//
//  Created by Vidar Fridriksson on 12/02/16.
//  Copyright © 2016 herraviddi. All rights reserved.
//

import Foundation


class UserObject{
    private var _name:String
    private var _age:Int
    private var _id:Int
    private var _number_of_drinks:Int
    private var _sex:String
    
    init(name:String,age:Int,id:Int,number_of_drinks:Int,sex:String){
        self._name = name
        self._age = age
        self._id = id
        self._number_of_drinks = number_of_drinks
        self._sex = sex
        
    }
    
    var name:String{
        return _name
    }
    
    var age:Int{
        return _age
    }
    
    var id:Int{
        return _id
    }
    
    var number_of_drinks:Int{
        return _number_of_drinks
    }
    
    var sex:String{
        return _sex
    }
}

