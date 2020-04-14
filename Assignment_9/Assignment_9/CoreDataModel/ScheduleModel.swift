//
//  ScheduleModel.swift
//  Assignment_9
//
//  Created by mac on 4/9/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import Foundation

struct ScheduleModel: Codable {
    struct Data: Codable {
        let attributes: Attributes
        struct Attributes: Codable {
            let arrival_time: String?
            let departure_time: String?
        }
    }
    let data: [Data]
}
