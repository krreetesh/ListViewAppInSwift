//
//  JSONParseController.swift
//  ListViewAppInSwift
//
//  Created by Reetesh Kumar on 14/04/18.
//  Copyright © 2018 Reetesh Kumar. All rights reserved.
//

import Foundation

protocol JSONParserDelegate: class {
    func fetchDataWithModelArray(model:NSMutableArray, titleString:String)
}

class JSONParseController : NSObject
{
    var _responseData:NSMutableData!
    var dataArray:NSArray!
    var titleStr:String!
    weak var delegate: JSONParserDelegate?

    //parse the JSON Data
    func parseTheJSONData(jsonURLStr:String) {
        
        //Do your parsing here and fill it into data_array
        let task = URLSession.shared.dataTask(with: NSURL(string: jsonURLStr)! as URL, completionHandler: { (data, response, error) -> Void in
            let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.isoLatin1)
            let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8)
            do{
                let jsonObject = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format!, options: []) as! NSDictionary
                
                self.titleStr = jsonObject.object(forKey: "title") as! String
                self.dataArray = jsonObject.object(forKey: "rows") as! NSArray
                
                if let array=self.dataArray
                {
                    self.setDataModelClassAndDelegate(localArray: array)
                }
                
            } catch {
                print("json error: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    // setting data model into array and using protocol delegate method
    func setDataModelClassAndDelegate(localArray:NSArray)
    {
        var objModel: DataModel!
        
        let ar: NSMutableArray = NSMutableArray()
        
        for obj in localArray
        {
            objModel = DataModel()
            
            objModel.titleToRow = (obj as AnyObject).value(forKey:"title") as? NSString
            objModel.descriptionToRow = (obj as AnyObject).value(forKey:"description") as? NSString
            objModel.imageHrefToRow = (obj as AnyObject).value(forKey:"imageHref") as? NSString
            ar.add(objModel)
        }
        
        // Using the Protocol delegate method - fetchDataWithModelArray
        
        delegate?.fetchDataWithModelArray(model: ar, titleString: titleStr)
    }
}
