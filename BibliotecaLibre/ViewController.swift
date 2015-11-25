//
//  ViewController.swift
//  BibliotecaLibre2
//
//  Created by Gabriel Urso Santana Reyes on 22/11/15.
//  Copyright © 2015 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var isbn: UITextField!
    @IBOutlet weak var texto: UITextView!
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autores: UILabel!
    @IBOutlet weak var portada: UIImageView!
    
    @IBAction func buscar(sender: AnyObject) {
        var libro = obtenerLibro(isbn.text!)
        if libro == nil{
            let alert = UIAlertController(title: "Error", message: "ISBN no encontrado", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    print("default")
                    
                case .Cancel:
                    print("cancel")
                    
                case .Destructive:
                    print("destructive")
                }
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            self.titulo.text = (libro!["titulo"])
            self.autores.text = (libro!["autores"])
            let url:NSURL? = NSURL(string: "https://ia700809.us.archive.org/zipview.php?zip=/15/items/olcovers541/olcovers541-L.zip&file=5413481-L.jpg")
            let data:NSData? = NSData(contentsOfURL : url!)
            self.portada.image = UIImage(data : data!)
            
        }
    }
    
    @IBAction func limpiar(sender: AnyObject) {
        isbn.text = ""
        
    }
    
    func obtenerLibro(identificador : String) -> [String:String]?{
        let destino = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + identificador
        let url = NSURL(string : destino )
        let datos : NSData? = NSData(contentsOfURL: url!)
        if datos == nil{
            let alert = UIAlertController(title: "Error", message: "Error de conexión", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    print("default")
                    
                case .Cancel:
                    print("cancel")
                    
                case .Destructive:
                    print("destructive")
                }
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            return (nil)
        }
        let dat = NSString(data: datos!, encoding: NSUTF8StringEncoding)
        if dat! as String == "{}"{
            return (nil)
        }
        
        do{
            var resultado : [String: String]
            if datos == nil{
                return (nil)
            }else{
                let json  = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                let libro = json as! NSDictionary
                var autores = ""
                for i in libro["ISBN:978-84-376-0494-7"]!["authors"]! as! NSArray{
                    autores = autores + (i["name"] as! String ) + " - "
                }

                resultado = ["titulo" : libro["ISBN:978-84-376-0494-7"]!["title"]! as! String]
                resultado["autores"] = autores
                if libro["ISBN:978-84-376-0494-7"]!["cover"]! == nil{
                    resultado["portada"] = ""
                }else{
                    resultado["portada"] = libro["ISBN:978-84-376-0494-7"]!["cover"]! as! String
                }

                return resultado
            }
        }catch _{
            return (nil)
        }
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

