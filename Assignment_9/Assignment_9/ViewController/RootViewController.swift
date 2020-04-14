//
//  RootViewController.swift
//  Assignment_9
//
//  Created by mac on 3/28/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    let stopCoreData = StopCoreData()
    let trainCoreData = TrainCoreData()
    let scheduleCoreData = ScheduleCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared.delegate as! AppDelegate
        let managedContext = app.persistentContainer.viewContext
        // Do any additional setup after loading the view.
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            print("Internet Connection not Available!")
        }
        let lines:[String] = ["Orange","Red"]
        if(trainCoreData.isEmpty(entity: "Train", managedContext: managedContext) == 0){
            for line in lines{
                
                let urlString = "https://api-v3.mbta.com/stops?fields%5Bstop%5D=name%2Caddress%2Clongitude%2Clatitude&filter%5Broute%5D="+line+"&api_key=87a36139dfd2478ca2f5002ca5298340"
                guard let url = URL(string: urlString) else { return }
                var stops = [Stop]()
                let train = self.trainCoreData.saveTrain(line: line, image: UIImage(named: "mbta.png")!.pngData()!, managedContext: managedContext)
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                    guard let data = data else { return }
                    do {
                        //here dataResponse received from a network request
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(StopModel.self, from:data) //Decode JSON Response Data
                        DispatchQueue.main.async {
                            for i in 0..<model.data.count {
                                let stop1 = self.stopCoreData.searchStop(name: model.data[i].attributes.name, managedContext: managedContext)
                                guard stop1 == nil else{
                                    stops.append(stop1!)
                                    continue
                                }
                                let stop = self.stopCoreData.saveStop(name: model.data[i].attributes.name, latitude: model.data[i].attributes.latitude, longditude: model.data[i].attributes.longitude, address: model.data[i].attributes.address, managedContext: managedContext)
                                stops.append(stop)
                            }
                            train.destination = stops[stops.count-1]
                            train.source = stops[0]
                        }
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                }.resume()
                
                
                
                let urlString1 = "https://api-v3.mbta.com/schedules?include=trip&filter%5Broute%5D="+line+"&api_key=87a36139dfd2478ca2f5002ca5298340"
                guard let url1 = URL(string: urlString1) else { return }
                
                URLSession.shared.dataTask(with: url1) { data, response, error in
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                    guard let data = data else { return }
                    do {
                        //here dataResponse received from a network request
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(ScheduleModel.self, from:data) //Decode JSON Response Data
                        DispatchQueue.main.async {
                            for i in 0..<model.data.count {
                                let arrival = model.data[i].attributes.arrival_time != nil ? model.data[i].attributes.arrival_time: model.data[i].attributes.departure_time
                                let departure = model.data[i].attributes.departure_time != nil ? model.data[i].attributes.departure_time : arrival
                               
                                let arrival_time = dateFormatter.date(from:arrival!)!
                                let departure_time = dateFormatter.date(from:departure!)!
                                let schedule = self.scheduleCoreData.saveSchedule(train: train, arrival: arrival_time, departure: departure_time, managedContext: managedContext)
                                for stop in stops {
                                    schedule.addToStops(stop)
            
                                }
                                
                            }
                        }
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                }.resume()
            }
            
            
            
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
