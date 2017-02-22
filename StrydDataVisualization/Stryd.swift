//
//  StrydAPI.swift
//  StrydDataVisualization
//
//  Created by Ryuji Mano on 2/21/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import Foundation
import UIKit

class Stryd {
    
    var power: [Int]
    var heartRate: [Int]
    
    init(forURL url:URL, callBack:@escaping () -> ()) {
        self.power = []
        self.heartRate = []
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task:URLSessionTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let data = data, let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    self.power = dataDictionary["total_power_list"] as! [Int]
                    self.heartRate = dataDictionary["heart_rate_list"] as! [Int]
                    callBack()
                }
            }
        }
        task.resume()
    }
    
}
