//
//  ViewController.swift
//  ListViewAppInSwift
//
//  Created by Reetesh Kumar on 08/04/18.
//  Copyright © 2018 Reetesh Kumar. All rights reserved.
//

import UIKit
let getURLString:String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, JSONParserDelegate {
    
    var myTableView: UITableView!
    var rowArray : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.cyan
        
        self.startLoadingData()
        
        myTableView = UITableView(frame: self.view.bounds, style: .grouped)
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //load data from server
    func startLoadingData()
    {
        let jsonParserObj: JSONParseController = JSONParseController()
        
        jsonParserObj.parseTheJSONData(jsonURLStr: getURLString)
        
        jsonParserObj.delegate = self
    }
    
    //Implementing the Protocol method - fetchDataWithModelArray
    func fetchDataWithModelArray(model:NSMutableArray, titleString:String)
    {
        self.navigationController?.navigationBar.topItem?.title = titleString //update title of navigation bar
        rowArray = model //update model data
        myTableView.reloadData() //reload table view
    }
    
    // download the image using session download task
    func downloadImageFromServerURL(imgURL:String?, completion:@escaping (UIImage?)->Void)
    {
        var task: URLSessionDownloadTask!
        var session: URLSession!
        session = URLSession.shared
        task = URLSessionDownloadTask()
        
        var img:UIImage!
        
        if let url = URL(string: imgURL ?? ""){
            task = session.downloadTask(with: url, completionHandler: { (data, response, error) -> Void in
                if let data = try? Data(contentsOf: url){
                    DispatchQueue.main.async(execute: { () -> Void in
                        img = UIImage(data: data)
                        completion(img)
                    })
                }
                completion(nil)
            })
        }
        else
        {
            completion(nil)
            return
        }
        task.resume()
    }
    
    //tableview delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = self.rowArray{
          return array.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier:String = "Cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style:UITableViewCellStyle(rawValue:3)!,reuseIdentifier:CellIdentifier)
        }
        
        // display title in cell
        if let obj = rowArray[indexPath.row] as? DataModel{
            cell?.textLabel!.text = obj.titleToRow
        }
        
        //display description in cell
        if let obj = rowArray[indexPath.row] as? DataModel{
            cell?.detailTextLabel!.text = obj.descriptionToRow
            cell?.detailTextLabel?.numberOfLines = 0
        }
        
        //display image in imageview of cell
        if let obj = rowArray[indexPath.row] as? DataModel{
            downloadImageFromServerURL(imgURL: obj.imageHrefToRow, completion: { (img) in
                if let imgObj = img {
                    DispatchQueue.main.async {
                        cell?.imageView?.image = imgObj
                    }
                }
            })
        }
        return cell!
    }
}

