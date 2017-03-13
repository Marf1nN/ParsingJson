//
//  ViewController.swift
//  ParsingJson
//
//  Created by Vladyslav Filippov on 22.02.17.
//  Copyright © 2017 Vladyslav Filippov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    final let urlString = "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"
    
    var nameArray = [String]()

    var dobArray = [String]()
    
    var imgURLArray = [String]()
    
    var descriptionArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.dowloadJsonWithURL()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func dowloadJsonWithURL() {
        
        let url = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler:
            {(data, response, error) -> Void in
            
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
            {
                print(jsonObj?.value(forKey: "actors"))
                
                
              if  let actorsArray = jsonObj?.value(forKey: "actors") as? NSArray {
                for actor in actorsArray {
                    
                    if let actorDict = actor as? NSDictionary {
                        
                        if let name = actorDict.value(forKey: "name") {
                            
                            self.nameArray.append(name as! String)
                        }
                        if let name = actorDict.value(forKey: "dob") {
                            
                            self.dobArray.append(name as! String)
                        }
                        if let name = actorDict.value(forKey: "image") {
                            
                            self.imgURLArray.append(name as! String)
                        }
                        if let name = actorDict.value(forKey: "description") {
                         
                            self.descriptionArray.append(name as! String)
                        }
                        
                        OperationQueue.main.addOperation({
                            self.tableView.reloadData()
                        })
                       
                        
                    }
                }
                    
            }
        }
            
            
            
            
        }).resume()
        
    }
    
 
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameArray.count
        
    }
    
    
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cell.nameLabel.text  = nameArray[indexPath.row]
        cell.dobLabel.text  = dobArray[indexPath.row]
        cell.descriptionLabel.text = descriptionArray[indexPath.row]
        
        let imgURL = NSURL(string: imgURLArray[indexPath.row])
        if imgURL != nil {
        
            let data = NSData(contentsOf:(imgURL as? URL)!)
            cell.imgView.image = UIImage(data: data as! Data)
        }
        
        return cell
        
    }
        
      

}






// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
