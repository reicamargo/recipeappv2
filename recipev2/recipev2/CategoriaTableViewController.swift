//
//  CategoriaTableViewController.swift
//  recipev2
//
//  Created by Reinaldo B Camargo on 6/7/16.
//  Copyright © 2016 Reinaldo B Camargo. All rights reserved.
//

import UIKit

class CategoriaTableViewController: UITableViewController {

    @IBOutlet weak var ind: UIActivityIndicatorView!
    var categories = [Categoria]()
    var observer:NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ind.startAnimating()
        
        CategoriaManager.sharedInstance.getCategorias { categorias, erro -> Void in
            self.categories = categorias
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.ind.stopAnimating()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoriaCell", forIndexPath: indexPath) as! CategoriaTableViewCell

        cell.category = self.categories[indexPath.row]
        cell.textLabel?.text = cell.category?.title
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "add" {
            observer = NSNotificationCenter.defaultCenter().addObserverForName("addCat", object: nil, queue: nil, usingBlock: { (notification) in
                self.categories = CategoriaManager.sharedInstance.categorias
                NSNotificationCenter.defaultCenter().removeObserver(self.observer!)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            })
        }
    }

}
