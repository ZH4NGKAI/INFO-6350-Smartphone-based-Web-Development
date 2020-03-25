//
//  TrainList.swift
//  Assignment_6
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import Foundation

class TrainList {
    var trains: Array<Train>
    
    init() {
        self.trains = [Train]()
    }
    
    func addTrain(line: String) -> Train{
        let train = Train(line: line)
        trains.append(train)
        return train
    }
    
    func deleteTrain(id: Int) -> Bool{
        for i in 0...trains.count-1{
            if trains[i].id == id {
                trains.remove(at: i)
                return true
            }
        }
        return false
    }
    
    func searchTrain(id: Int) -> Train? {
        for train in trains {
            if train.id == id {
                return train
            }
        }
        return nil
    }
}
