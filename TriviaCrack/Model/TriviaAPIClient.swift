//
//  TriviaAPIClient.swift
//  TriviaCrack
//
//  Created by Manny Yusuf on 1/14/19.
//  Copyright © 2019 Manny Yusuf. All rights reserved.
//

import Foundation

enum TriviaAPIError: Error {
    case badURL(String)
    case networkError(Error)
    case decodingError(Error)
}

final class TriviaAPIClient {
    static public func retrieveTriviaQuestions(completionHandler: @escaping (([TriviaQuestion]?, TriviaAPIError?) -> Void)) {
        guard let url = URL.init(string: "https://opentdb.com/api.php?amount=100&difficulty=hard&type=multiple") else {
            completionHandler(nil, .badURL("url failed"))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, .networkError(error))
            } else if let data = data {
                do {
                    let triviaData = try JSONDecoder().decode(TriviaCrack.self, from: data)
                    completionHandler(triviaData.results, nil)
                } catch {
                    completionHandler(nil, .decodingError(error))
                }
            }
        }.resume()
    }
}
