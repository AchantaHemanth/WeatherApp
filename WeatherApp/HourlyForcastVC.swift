//
//  HourlyForcastVC.swift
//  WeatherApp
//
//  Created by Hemanth on 26/12/18.
//  Copyright © 2018 Hemanth. All rights reserved.
//

import UIKit
import CoreLocation

class HourlyForcastVC: UIViewController,CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate {
   
    
    let manager = CLLocationManager()
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    let api = ApiCommunication()
    var hourly:[String:Any] = [:]
    var data : [[String:Any]] = []
    var status : Bool = true
    
    @IBOutlet var tablecell: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       }
    
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        //print(location)
        print(location.coordinate.longitude)
        print(location.coordinate.latitude)
        //api.getWeather(lat: location.coordinate.latitude, log: location.coordinate.longitude, appikey: apiKey1)
        //callApi()
        
    }
    
func callApi()
{
    api.getCompletionHandler = {(weather:[String:Any]) -> Void in
        self.hourly = weather[Parameters.hr] as! [String : Any]
        //print("Hourly :\(self.hourly)")
        self.data = self.hourly[Parameters.dat] as! [[String:Any]]
        //print("Data : \(self.data.count)")
        DispatchQueue.main.async {
            self.tablecell.reloadData()
        }
    }
}*/
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
     return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! CustomTableViewCell
        //print(self.data[indexPath.row][Parameters.temp]!)
        //let para = Parameters()
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(lblClick(tapGesture:)))
        //tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 1
        cell.tempLbl.isUserInteractionEnabled = true
        cell.tempLbl.tag = indexPath.row
        cell.tempLbl.addGestureRecognizer(tapGesture)
        
        let temp = self.data[indexPath.row][Parameters.temp]! as! NSNumber
        //print(temp)
        cell.tempLbl.text = String(format: "%0.2f", temp.floatValue)
        cell.units.text = "C"
        cell.summaryLbl.text = data[indexPath.row][Parameters.summary] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    @objc func lblClick(tapGesture:UITapGestureRecognizer){
        //print("Lable tag is:\(tapGesture.view!.tag)")
        let indexPath = NSIndexPath(row: tapGesture.view!.tag, section: 0)
        //print(indexPath.row)
        let cell = tablecell.cellForRow(at: indexPath as IndexPath) as! CustomTableViewCell
        if status == true
        {
            let tempInC = data[indexPath.row][Parameters.temp] as! NSNumber
            //print(tempInC)
            let tempInF = (tempInC.floatValue*1.8) + 32
            //print(tempInF)
            cell.tempLbl.text = String(format: "%0.2f", tempInF)
            cell.units.text = "F"
            status = false
        }
        else
        {
            let tempInF = cell.tempLbl.text!
            print(tempInF)
            if let tempinF = Float(tempInF)
            {
                let tempInC = (tempinF - 32) * 0.5556
                print(tempInC)
                cell.tempLbl.text = String(format: "%0.2f", tempInC)
                cell.units.text = "C"
            }
            else
            {
                print("Invalid")
            }
           
            //let tempInC = (tempinF - 32.0) * 0.5556
            //print(tempInC)
            //cell.tempLbl.text = String(format: "%0.2f C", tempInC)
            status = true
        }
        
    }
}
