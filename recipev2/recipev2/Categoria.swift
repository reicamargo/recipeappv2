//
//  Categoria.swift
//  recipev2
//
//  Created by Reinaldo B Camargo on 6/7/16.
//  Copyright © 2016 Reinaldo B Camargo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Categoria {
    var id: Int32?
    var title: String
    var ativo: Bool
    
    init(id: Int32, title: String, ativo: Bool) {
        self.id = id
        self.title = title
        self.ativo = ativo
    }
    
    init(title: String, ativo: Bool){
        self.title = title
        self.ativo = ativo
    }
    
    func returnJSONObject() -> JSON {
        let jsonObject = JSON(["Titulo": self.title, "Ativo": self.ativo])
        return jsonObject
    }
}