//
//  ViewController.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 05.11.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loadingImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let tabBarVC = TabBarViewController()
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true)
        }
        
        rotate(imageView: loadingImageView, aCircleTime: 5.0)
        
    }
    
    private func rotate(imageView: UIImageView, aCircleTime: Double) {
        UIView.animate(withDuration: aCircleTime/2, delay: 0.0, options: .curveLinear, animations: {
            imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: { finished in
            UIView.animate(withDuration: aCircleTime/2, delay: 0.0, options: .curveLinear, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2))
            }, completion: { finished in
                self.rotate(imageView: imageView, aCircleTime: aCircleTime)
            })
        })
    }
}

