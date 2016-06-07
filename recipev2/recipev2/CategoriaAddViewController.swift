//
//  CategoriaAddViewController.swift
//  recipev2
//
//  Created by Reinaldo B Camargo on 6/7/16.
//  Copyright © 2016 Reinaldo B Camargo. All rights reserved.
//

import UIKit

class CategoriaAddViewController: UIViewController {

    @IBOutlet weak var btnDone: UIBarButtonItem!
    @IBOutlet weak var txtNomeCategoria: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnDone_click(sender: AnyObject) {
        txtNomeCategoria.resignFirstResponder()
    }
    
    
    @IBAction func btnCadastrar_click(sender: AnyObject) {
        let nome = txtNomeCategoria.text!
        let categoria = Categoria(title: nome, ativo: true)
        
        CategoriaManager.sharedInstance.addCategoria(categoria) { erro -> Void in
            if (erro != nil) {
                let alert = UIAlertView(title: "Deu ruim", message: erro?.localizedDescription, delegate: nil, cancelButtonTitle: "Valeu!")
                alert.show()
            }
            else {
                NSNotificationCenter.defaultCenter().postNotificationName("addCat", object: categoria)
                self.navigationController?.popViewControllerAnimated(true)
            }
            
        }
    }
    
}
