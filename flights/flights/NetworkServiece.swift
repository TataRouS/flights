//
//  NetworkServiece.swift
//  flights
//
//  Created by Nata Kuznetsova on 03.11.2023.
//

import Foundation

final class NetworkService {
    
    enum NetworkError: Error {
        case dataError
    }
    
    private let session = URLSession.shared
    
    
    func getDeparture(completion: @escaping (Result<[Flight], Error>) -> Void ) {
        let url = URL(string: "https://api.rasp.yandex.net/v3.0/schedule/?apikey=4890529e-d248-44de-8689-5e0545b839c6&station=s9628674&transport_types=plane&event=departure")
        
        
        guard let url else {
            return
        }
        session.dataTask(with: url) { (data, response,error) in
            guard let data else {
                completion(.failure(NetworkError.dataError))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let departure = try
                JSONDecoder().decode(Schedule.self, from: data)
                completion(.success(departure.schedule))
                print(departure)
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
        .resume()
    }
    
    
    func getArrival(completion: @escaping(Result<[Flight], Error>) -> Void) {
        let url = URL(string: "https://api.rasp.yandex.net/v3.0/schedule/?apikey=4890529e-d248-44de-8689-5e0545b839c6&station=s9628674&transport_types=plane&event=arrival")
        
        
        guard let url else {
            return
        }
        session.dataTask(with: url) { (data, response,error) in
            guard let data else {
                completion(.failure(NetworkError.dataError))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let departure = try
                JSONDecoder().decode(Schedule.self, from: data)
                completion(.success(departure.schedule))
                print(departure)
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
        .resume()
    }
}
