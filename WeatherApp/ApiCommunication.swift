//
//  ApiCommunication.swift
//  WeatherApp
//
//  Created by Hemanth on 26/12/18.
//  Copyright © 2018 Hemanth. All rights reserved.
//

import UIKit
import CoreLocation

let urlString1 = "https://api.darksky.net/forecast"
let apiKey1 = "36f7164f0660226b40b7c4ee996abf14"

class ApiCommunication: NSObject
{
    var getCompletionHandler:([String:Any])-> Void = {_ in}
    
    func getWeather(lat:Double,log:Double,appikey:String)
    {
        let url = URL(string:"\(urlString1)/\(apiKey1)/\(lat),\(log)")
        //print("URL : \(url!)")
        var request = URLRequest.init(url: url!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: url!,completionHandler: { (data, response, error) in
            if let error = error
            {
                print("Error : \(error)")
            }
            else
            {
                do
                {
                    let weather = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                    //print(weather)
                    self.getCompletionHandler(weather)
                }
                catch
                {
                    print("Error")
                }
            }
        })
        task.resume()
    }
    
    

}
