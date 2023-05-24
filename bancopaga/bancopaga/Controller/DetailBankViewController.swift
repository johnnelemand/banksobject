//
//  DetailBankViewController.swift
//  bancopaga
//
//  Created by Johnne Lemand on 22/05/23.
//

import UIKit

class DetailBankViewController: UIViewController {
    
    
    
    var recibirDatosBancos : BankModel?
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
   
    @IBOutlet weak var imageToLoad: UIImageView!
    
    
    
    @IBOutlet weak var ageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        configurarUI()
        cargarImagen()
        
    }
    
    
    
    
    func configurarUI() {
            nombreLabel.text = recibirDatosBancos?.bankName
            descriptionLabel.text = recibirDatosBancos?.description
            ageLabel.text = "\(recibirDatosBancos?.age ?? 0)"
        }
    
    func cargarImagen() {
            guard let imageUrlString = recibirDatosBancos?.url,
                  let imageUrl = URL(string: imageUrlString) else {
                return
            }
            
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.imageToLoad.image = image
                    }
                }
            }
        }
    

    

}
