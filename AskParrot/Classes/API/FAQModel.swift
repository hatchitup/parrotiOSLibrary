//
//  FAQModel.swift
//  Pods
//
//  Created by Hemant Singh on 08/02/17.
//
//

import UIKit
import SwiftyJSON

class FAQModel: NSObject, NSCoding{
    
    var data : [FAQ]! = []
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    override init() {
        super.init()
        data = []
    }
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [FAQ]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = FAQ(fromJson: dataJson)
            data.append(value)
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if data != nil{
            var dictionaryElements = [NSDictionary]()
            for dataElement in data {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["data"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        data = aDecoder.decodeObject(forKey: "data") as? [FAQ]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        
    }
    
}
 class FAQ : NSObject, NSCoding{
    
    var addedBy : String!
    var answer : String!
    var appID : String!
    var companyID : String!
    var question : String!
    var createdAt : String!
    var id : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        addedBy = json["AddedBy"].stringValue
        answer = json["Answer"].stringValue
        appID = json["AppID"].stringValue
        companyID = json["CompanyID"].stringValue
        question = json["Question"].stringValue
        createdAt = json["createdAt"].stringValue
        id = json["id"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if addedBy != nil{
            dictionary["AddedBy"] = addedBy
        }
        if answer != nil{
            dictionary["Answer"] = answer
        }
        if appID != nil{
            dictionary["AppID"] = appID
        }
        if companyID != nil{
            dictionary["CompanyID"] = companyID
        }
        if question != nil{
            dictionary["Question"] = question
        }
        if createdAt != nil{
            dictionary["createdAt"] = createdAt
        }
        if id != nil{
            dictionary["id"] = id
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        addedBy = aDecoder.decodeObject(forKey: "AddedBy") as? String
        answer = aDecoder.decodeObject(forKey: "Answer") as? String
        appID = aDecoder.decodeObject(forKey: "AppID") as? String
        companyID = aDecoder.decodeObject(forKey: "CompanyID") as? String
        question = aDecoder.decodeObject(forKey: "Question") as? String
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if addedBy != nil{
            aCoder.encode(addedBy, forKey: "AddedBy")
        }
        if answer != nil{
            aCoder.encode(answer, forKey: "Answer")
        }
        if appID != nil{
            aCoder.encode(appID, forKey: "AppID")
        }
        if companyID != nil{
            aCoder.encode(companyID, forKey: "CompanyID")
        }
        if question != nil{
            aCoder.encode(question, forKey: "Question")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        
    }
    
}
