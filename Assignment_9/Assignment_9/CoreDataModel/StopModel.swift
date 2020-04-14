//
//  StopModel.swift
//  Assignment_9
//
//  Created by mac on 4/9/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import Foundation

struct StopModel: Codable {
    struct Data: Codable {
        let attributes: Attributes
        struct Attributes: Codable {
            let address:String
            let latitude:Double
            let longitude:Double
            let name:String
        }
    }
    let data: [Data]
}
