//
//  ViewController.swift
//  adviceApp
//
//  Created by Fabiana Limma on 20/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://api.adviceslip.com/advice") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                let model = try! JSONDecoder().decode(Model.self, from: data)
                DispatchQueue.main.sync {
                    self.adviceLabel.text = model.slip.advice
                }
            } else if let error = error {
                print("Something went wrong")
            }
        }
        
        dataTask.resume()
    }
}

struct Model: Decodable {
    let slip: Slip
}

struct Slip: Decodable {
    let id: Int
    let advice: String
}
