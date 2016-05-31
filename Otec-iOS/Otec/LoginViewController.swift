    //
//  LoginViewController.swift
//  Otec
//
//  Created by El gera de la gente on 5/11/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var newspaperTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        id = dictionary["id"],
//        title = dictionary["title"],
//        body = dictionary["body"],
//        newspaper = dictionary["newspaper_name"],
//        createdAt = News.creationDateFromDateString(dictionary["created_at"])
//
//        let newDictionary = ["id":"ABCDE12345",
//                             "title":"Titulo",
//                             "body":"Este es el contenido de la noticia. Ampliaremos.",
//                             "newspaper_name":"Daily Planet",
//                             "created_at":"19-12-1989"]
//        
//        guard let new = News.init(dictionary:newDictionary) else {
//            print ("failure creating new")
//            return
//        }
//        let future3 = NewsRepository().findAll()
        
        
        
//        let future2 = NewsRepository().findAll()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        let newspaperDictionary = ["name":newspaperTextfield.text!,
                                   "description":"El diario de Clark Kent"]
        
        let newspaper = Newspaper.init(dictionary:newspaperDictionary)
        let future = NewspaperRepository().findByID(newspaper!.id)
        future.start() { result in
            switch result {
            case .Success(let new):
                print ("newspaper \(new.id)")
            // You've got your users fetched in this array!
            case .Failure(let error):
                print ("error : \(error)")
                // You've got a discrete ServerBackendError indicating what happened
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
