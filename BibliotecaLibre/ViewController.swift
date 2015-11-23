//
//  ViewController.swift
//  BibliotecaLibre
//
//  Created by Gabriel Urso Santana Reyes on 22/11/15.
//  Copyright © 2015 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var isbn: UITextField!
    @IBOutlet weak var texto: UITextView!
    
    @IBAction func buscar(sender: AnyObject) {
        texto.text = obtenerLibro(isbn.text!) //isbn.text
    }
    
    @IBAction func limpiar(sender: AnyObject) {
        isbn.text = ""
        
    }
    
    func obtenerLibro(identificador : String) -> String{
        let destino = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + identificador
        let url = NSURL(string : destino )
        let datos : NSData? = NSData(contentsOfURL: url!)
        if datos == nil{
            return ("SIN CONEXIÓN")
        }
        var dat = NSString(data: datos!, encoding: NSUTF8StringEncoding)
        if dat! as String == "{}"{
            dat = "NO ENCONTRADO"
        }
        return dat! as String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

