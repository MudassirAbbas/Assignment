//
//  UserModel.swift
//  Assignment
//
//  Created by Mudassir Abbas on 28/11/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class UserModel: NSObject,NSCoding {
    
    var avatarUrl : String!
    var email : String!
    var followersUrl : String!
    var login : String!
    var name : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        avatarUrl = dictionary["avatar_url"] as? String
        email = dictionary["email"] as? String
        followersUrl = dictionary["followers_url"] as? String
        login = dictionary["login"] as? String
        name = dictionary["name"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if avatarUrl != nil{
            dictionary["avatar_url"] = avatarUrl
        }
        if email != nil{
            dictionary["email"] = email
        }
        if followersUrl != nil{
            dictionary["followers_url"] = followersUrl
        }
        if login != nil{
            dictionary["login"] = login
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        avatarUrl = aDecoder.decodeObject(forKey: "avatar_url") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        followersUrl = aDecoder.decodeObject(forKey: "followers_url") as? String
        login = aDecoder.decodeObject(forKey: "login") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if avatarUrl != nil{
            aCoder.encode(avatarUrl, forKey: "avatar_url")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if followersUrl != nil{
            aCoder.encode(followersUrl, forKey: "followers_url")
        }
        if login != nil{
            aCoder.encode(login, forKey: "login")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        
    }
    
}
