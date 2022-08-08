//
//  APICall.swift
//  Countries
//
//  Created by Emre Sarı on 5.08.2022.
//
import Foundation

let headers = [
    "X-RapidAPI-Key": "e29f64bf07msh4186f89b9ae0788p127a0ejsn3d1778d15b13",
    "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
]

enum APIError: Error {
    case failedTogetData
}

class APICall{
    static let shared = APICall()
    
    func getCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
    let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(CountriesResponse.self, from: data)
                completion(.success(results.data))
            }
            catch {
                completion(.failure(error))
            }
        })
        dataTask.resume()
    }
    
    func getCountry(with query: String, completion: @escaping (Result<Country, Error>) -> Void) {
            
        let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(query)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                guard let data = data, error == nil else {
                    return
                }		
                
                do {
                    let results = try JSONDecoder().decode(CountryResponse.self, from: data)
                    
                    completion(.success(results.data))
                    

                } catch {
                    completion(.failure(error))
                    print(error)
                }

            })
            dataTask.resume()
        }

}



