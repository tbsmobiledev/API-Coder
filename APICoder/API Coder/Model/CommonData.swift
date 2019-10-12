//
//  CommonData.swift
//  Registration_demo
//
//  Created by TBS17 on 16/09/19.
//  Copyright © 2019 Sazzadhusen Iproliya. All rights reserved.
//

import UIKit
import Foundation

class commonData: NSObject {
    
    //MARK:- Response Model
    var msg:String?
    var data:NSDictionary?
    var status:Bool?
    
    //MARK:- Method Initialization
    override init() {}
    
    required init(coder aDecoder: NSCoder) {
        
        if let msgObj = aDecoder.decodeObject(forKey: kMsg) as? String {
            self.msg = msgObj
        }
        
        self.status = aDecoder.decodeObject(forKey: kStatus) as? Bool ?? aDecoder.decodeBool(forKey: kStatus)
        
        
        if let dataObj = aDecoder.decodeObject(forKey: kData) as? NSDictionary {
            self.data = dataObj
        }
    }
    
    func encode(with aCoder: NSCoder) {
        if let msgObj = self.msg {
            aCoder.encode(msgObj, forKey: kMsg)
        }
        
        if let dataObj = self.data {
            aCoder.encode(dataObj, forKey: kData)
        }
        
        if let statusObj = self.status {
            aCoder.encode(statusObj, forKey: kStatus)
        }
    }
    
    //MARK:-
    func initWithDictionary(_ dictionary:NSDictionary){
        status = dictionary.value(forKey: kStatus ) as?  Bool
        data = dictionary.value(forKey: kData) as? NSDictionary
        msg = dictionary.value(forKey: kMsg) as? String
    }
}

class newCommonData: Codable {
    var msg:String?
    var data:LoginUserData?
    var status:Bool?
}

class LoginUserData: Codable {
    
    var name:String?
    var email:String?
    var status: Int?
    var gender:String?
    var dob:String?
    var profileStatus:String?
}
