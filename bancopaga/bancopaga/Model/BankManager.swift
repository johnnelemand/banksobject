//
//  BankManager.swift
//  bancopaga
//
//  Created by Johnne Lemand on 22/05/23.
//


import Foundation
import SQLite3


/*protocol BankManagerDelegate {
    func mostrarBancos(listaBancos: [BankModel])
    func mostrarError(cualError: String)
}

struct BankManager {
    var delegado: BankManagerDelegate?
    let bancosURL = "https://dev.obtenmas.com/catom/api/challenge/banks"
    var db: OpaquePointer?

    init() {
        // Inicializar la base de datos
        if sqlite3_open("bancos.db", &db) == SQLITE_OK {
            createTable()
        }
    }
    
    // Crear la tabla en la base de datos
    func createTable() {
        let createTableQuery = "CREATE TABLE IF NOT EXISTS banks (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, code TEXT)"
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            let error = String(cString: sqlite3_errmsg(db)!)
            print("Error al crear la tabla: \(error)")
        }
    }
    
    // Insertar un banco en la base de datos
    func insertBank(_ bank: BankModel) {
        let insertQuery = "INSERT INTO banks (description,age,url,bankName ) VALUES ('\(bank.description)', '\(bank.age)','\(bank.url)','\(bank.bankName)')"
        if sqlite3_exec(db, insertQuery, nil, nil, nil) != SQLITE_OK {
            let error = String(cString: sqlite3_errmsg(db)!)
            print("Error al insertar un banco: \(error)")
        }
    }
    
    // Obtener la lista de bancos desde la base de datos
    func obtenerListaBancos() {
        let selectQuery = "SELECT * FROM banks"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, selectQuery, -1, &statement, nil) == SQLITE_OK {
            var listaBancos: [BankModel] = []
            
            while sqlite3_step(statement) == SQLITE_ROW {
                let description = String(cString: sqlite3_column_text(statement, 0))
                let age = Int(sqlite3_column_int(statement, 1))
                let url = String(cString: sqlite3_column_text(statement, 2))
                let bankName = String(cString: sqlite3_column_text(statement, 3))
                let bank = BankModel(description: description, age: age, url:url, bankName: bankName)
                listaBancos.append(bank)
            }
            
            sqlite3_finalize(statement)
            
            // Enviar la lista de bancos al delegado
            delegado?.mostrarBancos(listaBancos: listaBancos)
        } else {
            let error = String(cString: sqlite3_errmsg(db)!)
            print("Error al obtener la lista de bancos: \(error)")
            delegado?.mostrarError(cualError: "Error al obtener la lista de bancos")
        }
    }
    
    // Eliminar todos los bancos de la base de datos
    func deleteAllBanks() {
        let deleteQuery = "DELETE FROM banks"
        if sqlite3_exec(db, deleteQuery, nil, nil, nil) != SQLITE_OK {
            let error = String(cString: sqlite3_errmsg(db)!)
            print("Error al eliminar los bancos: \(error)")
        }
    }
    
    // Cerrar la conexión de la base de datos
    func closeDatabase() {
        sqlite3_close(db)
    }
}*/


protocol BankManagerDelegate{
    
    
    func mostrarBancos(listaBancos: [BankModel])
    func mostrarError (cualError: String)
    
}


    
    struct BankManager {
        var delegado: BankManagerDelegate?
        
        let bancosURL = "https://dev.obtenmas.com/catom/api/challenge/banks"
        
        
        
        
        
        func obtenerListaBancos(){
            
            if let url = URL(string: bancosURL){
                let session = URLSession(configuration: .default)
                
                let tarea = session.dataTask(with: url) { datos, respuesta, error in
                    if let e = error {
                        print("error en el servidor: \(e.localizedDescription)")
                    }
                    ///DATA
                    if let datosSeguros = datos {
                        //Decodificamos la data segura
                        let decoder = JSONDecoder()
                        
                        do{
                            let dataDecodificada = try
                            decoder.decode([BankModel].self, from: datosSeguros)
                            
                            
                            
                            
                            //Mandamos la lista de objetos al vc a traves del delegate
                            delegado?.mostrarBancos(listaBancos: dataDecodificada)
                            
                        }catch{
                            print("Debug: error al decodificar \(error.localizedDescription)")
                            delegado?.mostrarError(cualError: "error al decodificar \(error.localizedDescription)")
                        }
                        
                    }
                }
                
                tarea.resume()
            }
        }
        
    }

