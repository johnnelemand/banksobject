//
//  ViewController.swift
//  bancopaga
//
//  Created by Johnne Lemand on 22/05/23.
//

import UIKit

import UIKit
import CoreData


   

class ViewController: UIViewController {

    var listaBancos: [BankModel] = []
    
    var bankManager = BankManager()
    
    var bancosMostrar: BankModel?
    
    var activityView: UIActivityIndicatorView?
    
    
    
    
    
    @IBOutlet weak var bucarBancosTextField: UITextField!
    
    @IBOutlet weak var tableBank: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        
        bankManager.delegado = self
        
        tableBank.delegate = self
        tableBank.dataSource = self
        
        bankManager.obtenerListaBancos()
        
    }
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }

}

//adopta el protocolo BankManagerDelegate
extension ViewController: BankManagerDelegate{
    func mostrarBancos(listaBancos: [BankModel]) {
        //Muestra la UI
        self.listaBancos = listaBancos
        DispatchQueue.main.async {
            self.tableBank.reloadData()
            
            self.hideActivityIndicator()
        }
        //print(listaBancos.count)
        //print(listaBancos[0])
    }
    func mostrarError(cualError: String) {
        
    }
}




// métodos de tableview

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaBancos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        
        //let bank = listaBanks[indexPath.row]
        
        celda.textLabel?.text = listaBancos[indexPath.row].bankName
        celda.detailTextLabel?.text = listaBancos[indexPath.row].description
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bancosMostrar = listaBancos[indexPath.row]
        performSegue(withIdentifier: "detalles", sender: self)
    }
    
    //manda info atraves del segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalles"{
            let objDestino = segue.destination as! DetailBankViewController
            objDestino.recibirDatosBancos = bancosMostrar
        }
    }
    
}

