//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit



final class Network {
    let apiKey = "5885c445eab51c7004916b9c0313e2d3"
    static var shared = Network()
    var session: URLSession
    
    private init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

extension Network {
    
    func fetchData<T: Decodable> (url:String, completion: @escaping (Result<T, MyError>) -> ()) {
        guard let url = URL(string: url) else {return}
        session.dataTask(with: url) { (data, result, error) in
            guard let data = data else {completion(.failure(.dataError));return}
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    func fetchImage (url:String, completion: @escaping (Result<UIImage, MyError>) -> ()) {
        guard let url = URL(string: url) else {return}
        session.dataTask(with: url) { (data, result, error) in
            guard let data = data else {completion(.failure(.dataError));return}
            guard let resultImage = UIImage(data: data) else {return}
            completion(.success(resultImage))
        }.resume()
    }
    
}
enum MyError: String, Error {
    case urlError = "url error has occured"
    case dataError = "problem when decoding Data"
    case normError = "An error occured"
}
