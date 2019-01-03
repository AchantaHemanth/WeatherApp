//
//  ViewController.swift
//  WeatherApp
//
//  Created by Hemanth on 18/12/18.
//  Copyright © 2018 Hemanth. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet var cityLbl: UILabel!
    @IBOutlet var tempType: UILabel!
    @IBOutlet var temp: UILabel!
    @IBOutlet var humidityLbl: UILabel!
    let api = ApiCommunication()
    let manager = CLLocationManager()
    var hourly:[String:Any] = [:]
    var data : [[String:Any]] = []
    var para : [[String:Any]] = []
    
  
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //getWeather(lat:37.8267, log:-122.4233, appikey: apiKey1)
        self.manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        print(location)
        /*let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        map.setRegion(region, animated: true)
        print(location.coordinate.longitude)
        print(location.coordinate.latitude)
        self.map.showsUserLocation = true*/
        DispatchQueue.global(qos: .background).async {
            self.api.getWeather(lat:location.coordinate.latitude, log:location.coordinate.longitude, appikey: apiKey1)
            self.callApi()
        }
    }
    func callApi()
    {
        api.getCompletionHandler = {(weather:[String:Any]) -> Void in
            print(weather)
            print(weather["timezone"]!)
            let timeZone:String = weather["timezone"]! as! String
            var timeZoneName = timeZone.components(separatedBy: "/")
            
            var current:[String:AnyObject] = weather["currently"] as! [String : AnyObject]
            let tempType:String = current["summary"]! as! String
            //print(tempType)
            
            let temperture = current["temperature"]!
            //print(temperture)
            let h = "humidity"
            let humidity = current[h]!
            print(humidity)
            DispatchQueue.main.async
                {
                        self.cityLbl.text = timeZoneName[1]
                        self.tempType.text = tempType
                        self.temp.text = "\(temperture)"
                        self.humidityLbl.text = "\(humidity)"
                }
            
        self.hourly = weather[Parameters.hr] as! [String : Any]
            //print("Hourly :\(self.hourly)")
            self.data = self.hourly[Parameters.dat] as! [[String:Any]]
            //print("Data : \(self.data)")
        }
    }
    
//    func getWeather(lat:Double,log:Double,appikey:String)
//    {
//        let url = URL(string:"\(urlString1)/\(apiKey1)/\(lat),\(log)")
//        //print("URL : \(url!)")
//        var request = URLRequest.init(url: url!)
//        request.httpMethod = "GET"
//        let session = URLSession.shared
//        let task = session.dataTask(with: url!,completionHandler: { (data, response, error) in
//            if let error = error
//            {
//                print("Error : \(error)")
//            }
//            else
//            {
//                do
//                {
//                    let weather = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
//                    print(weather)
//                    print(weather["timezone"]!)
//                    let city:String = weather["timezone"]! as! String
//                    var cityName = city.components(separatedBy: "/")
//
//                    var current:[String:AnyObject] = weather["currently"] as! [String : AnyObject]
//                    let tempType:String = current["summary"]! as! String
//                    //print(tempType)
//
//                    var temperture = current["temperature"]!
//                    //static
//                    //final
//
//                    //print(temperture)
//                    let h = "humidity"
//                    let humidity = current[h]!
//                    print(humidity)
//
//                    DispatchQueue.main.async {
//                        self.cityLbl.text = cityName[1]
//                        self.tempType.text = tempType
//                        self.temp.text = "\(temperture)"
//                        self.humidityLbl.text = "\(humidity)"
//                    }
//                }
//                catch
//                {
//                 print("Error")
//                }
//            }
//        })
//        task.resume()
//    }
    @IBAction func nxtPage(_ sender: UIButton)
    {
        let nxt = self.storyboard?.instantiateViewController(withIdentifier: "HourlyForcastVC") as! HourlyForcastVC
        nxt.data = self.data
        //print(nxt.data)
        self.navigationController?.pushViewController(nxt, animated: true)
        
    }
}


