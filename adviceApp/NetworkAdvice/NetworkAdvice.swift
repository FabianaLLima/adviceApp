//
//  netWorkAdvice.swift
//  adviceApp
//
//  Created by Fabiana Limma on 06/05/23.
//

import Foundation

struct NetworkAdvice {
    func getAdvice(
        completion: @escaping (Result<Advice,Error>) -> Void
    ) {
        guard let url = URL(string: "https://api.adviceslip.com/advice") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                let model = try! JSONDecoder().decode(Advice.self, from: data)
                completion(.success(model))
            } else if let error = error {
                completion(.failure(error))
                print("Something went wrong")
            }
        }
        
        dataTask.resume()
    }
}
