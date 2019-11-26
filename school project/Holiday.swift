//
//  Holiday.swift
//  school project
//
//  Created by Khaleel Elias on 2019-11-26.
//  Copyright © 2019 Khalid Elkilany. All rights reserved.
//

import Foundation

struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetails]
}

//sotrage of name and date
struct HolidayDetails: Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo: Decodable {
    var iso: String
}
