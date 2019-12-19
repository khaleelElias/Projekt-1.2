//
//  HolidayRequest.swift
//  school project
//
//  Created by Khaleel Elias on 2019-11-26.
//  Copyright © 2019 Khalid Elkilany. All rights reserved.
//

import Foundation


enum HolidayError: Error{
    case noDataAvailable
    case canNotProcessData
}


struct HolidayRequest {
    
    var resourceURL: URL
        
    //my API key
    let API_KEY = "9aaf739f3c2e679361ec0e22d2ef6398293b886f"
    
    init(countryCode : String) {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat  = "yyyy"
        let currentYear = format.string(from: date)
        
        let destinationURL = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: destinationURL) else {fatalError()}
        
        self.resourceURL = resourceURL
        
    }
    //MARK: get holidays data 
    //asynchronous
     func getHolidays (compleation: @escaping(Result<[HolidayDetails], HolidayError>) ->Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in

            guard let jsonData = data else {
                compleation(.failure(.noDataAvailable))
                return
            }

            do{
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidaysResponse.response.holidays
                compleation(.success(holidayDetails))
            }catch{
                compleation(.failure(.canNotProcessData))
            }

        }// start the fetching of the data 
        dataTask.resume()
    }
}
