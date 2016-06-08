//
//  CategoriaManager.swift
//  recipev2
//
//  Created by Reinaldo B Camargo on 6/7/16.
//  Copyright © 2016 Reinaldo B Camargo. All rights reserved.
//

import Foundation
import SwiftyJSON

class CategoriaManager: NSObject {
    static let sharedInstance = CategoriaManager()
    var endPointUrl = "categorias/"
    var restApiManager = RestApiManager()
    var categorias = [Categoria]()
    
    func getCategorias(onComplete: ([Categoria], NSError?) -> Void) {
        
        if self.categorias.count == 0 {
            restApiManager.makeHTTPGetRequest(endPointUrl) { (categoriasJson, erro) in
                for (_, categoria) in categoriasJson {
                    let cat = Categoria(id: categoria["Id"].int32Value, title: categoria["Titulo"].string!, ativo: categoria["Ativo"].boolValue)
                    self.categorias.append(cat)
                }
                onComplete(self.categorias, erro)
            }
        }
        onComplete(self.categorias, nil)
    }
    
    func getCategoria(idCategoria: Int32, onComplete: (Categoria, NSError?) -> Void) {
        
        endPointUrl = endPointUrl + String(idCategoria)
        restApiManager.makeHTTPGetRequest(endPointUrl) { (categoriaJson, erro) in
            let categoria = Categoria(id: categoriaJson["Id"].int32Value, title: categoriaJson["Titulo"].string!, ativo: categoriaJson["Ativo"].boolValue)
            onComplete(categoria, erro)
        }
        
    }
    
    
    func addCategoria(categoria: Categoria, onComplete: (NSError?) -> Void) {
        
        let categoriaJson = JSON(["Titulo": categoria.title, "Ativo":categoria.ativo])
        
        restApiManager.makeHTTPPostRequest(endPointUrl, body: categoriaJson) { (categoriaJson, erro) in
            var cat: Categoria
            if categoriaJson != nil {
                cat = Categoria(id: categoriaJson["Id"].int32Value,
                                title: categoriaJson["Titulo"].string!,
                                ativo: categoriaJson["Ativo"].boolValue)
            
                self.categorias.append(cat)
            }
            
            onComplete(erro)
        }
    }
    
}