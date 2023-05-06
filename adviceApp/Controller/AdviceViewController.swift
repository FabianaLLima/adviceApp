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
    
    let network = NetworkAdvice()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        network.getAdvice(completion: { result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let advice):
                    self.mainView.adviceLabel.text = advice.slip.advice
                case .failure(_):
                    break
                }
            }
        })
    }
}
      
 
