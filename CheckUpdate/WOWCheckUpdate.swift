//
//  WOWCheckUpdate.swift
//  CheckUpdate
//
//  Created by 陈旭 on 2016/11/7.
//  Copyright © 2016年 陈旭. All rights reserved.
//

import UIKit
typealias CheckVersion = (_ CheckVersionResult:Bool?) ->()
class WOWCheckUpdate {
    
    open var isUpdateVersion :CheckVersion!
    

    static let sharedCheck = WOWCheckUpdate()
    init(){}
    static func checkUpdateWithDevice(isUpdateTag: @escaping CheckVersion){
        let url = NSURL(string: Itunes_Url)
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            var receiveStatusDic = [String: AnyObject]()
            if data != nil {
                var receiveDic = [String: AnyObject]()
                do {
                    receiveDic = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String : AnyObject]
                    print(receiveDic)
                    if let arr = receiveDic["results"] as? NSArray{
                        if let dict = arr.firstObject as? NSDictionary {
                            if let version = dict["version"] as? String {
                                print(version)
                            }
                        }
                    }
                } catch {
                    print(error)
                }
                
                if (receiveDic["resultCount"]?.integerValue)! > 0 {
                    receiveStatusDic["status"] = "1" as AnyObject?
                    
                } else {
                    receiveStatusDic["status"] = "-1" as AnyObject?
                }
            } else {
                receiveStatusDic["status"] = "-1" as AnyObject?
            }
            
            let infoDictionary = Bundle.main.infoDictionary
            // app版本
            let app_Version = infoDictionary!["CFBundleShortVersionString"] as? String
            
            if app_Version != (receiveStatusDic["version"] as? String) {
                
                isUpdateTag(true)
                
            }else{
                
                isUpdateTag(false)
                
            }
        })
        task.resume()
        
    }
    
}

