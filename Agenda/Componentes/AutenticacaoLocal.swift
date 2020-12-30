//
//  AutenticacaoLocal.swift
//  Agenda
//
//  Created by Breno Luizetto Cintra on 30/12/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import LocalAuthentication

class AutenticacaoLocal: NSObject {
    
    var error:NSError?

    func autorizaUsuario(completion:@escaping(_ autenticado:Bool) -> Void){
        let contexto = LAContext()
        
        if contexto.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
            contexto.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "autenticação para apagar um aluno") { (resposta, erro) in
                completion(resposta)
            }
        }
    }
}
