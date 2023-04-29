//
//  ViewController.swift
//  adviceApp
//
//  Created by Fabiana Limma on 20/02/23.
//

import UIKit

class AdviceViewController: UIViewController {

    var mainView: AdviceView {
        guard let mainView = view as? AdviceView else {
            fatalError(" não foi possível fazer o cast de UIView para adviceView")
        }
        return mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://api.adviceslip.com/advice") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                let model = try! JSONDecoder().decode(Advice.self, from: data)
                DispatchQueue.main.sync {
                    self.mainView.adviceLabel.text = model.slip.advice
                }
            } else if let error = error {
                print("Something went wrong")
            }
        }
        
        dataTask.resume()
    }
}


