//
//  HomeViewModel.swift
//  AssesmentApp
//
//  Created by Irfan Saeed on 26/10/2022.
//

import Foundation

typealias onSuccess = (Bool)-> Void

final class HomeViewModel {
    
    private var dataArray = [Events]()
    
    
    func eventsArray() -> [Events] {
        return dataArray
    }
    
    func getEvents(completion: @escaping (Result<Bool, Error>)-> Void) {
        guard let path = Bundle.main.path(forResource: "events", ofType: "json") else {return}
        
        do {
            let fileUrl = URL(fileURLWithPath: path)
            // Getting data from JSON file using the file URL
            let data = try Data(contentsOf: fileUrl, options: .alwaysMapped)
            
            do {
                let decoder = try JSONDecoder().decode([Events].self, from: data)
                dataArray = decoder
                completion(.success(true))
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
}
