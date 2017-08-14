//
//  DiscoverTableViewController.swift
//  FansArea
//
//  Created by Wen Jing on 2017/6/18.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController {
    var areas : [AVObject] = []

    @IBOutlet var spinner: UIActivityIndicatorView! //添加滚条
    override func viewDidLoad() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        super.viewDidLoad()
        spinner.center = view.center
        view.addSubview(spinner)
       getDataFromClud()
    }
    
    func getDataFromClud(needUpdate :Bool = false) {
        //查询云端的类
        let query = AVQuery(className: "Area")
        //排序
        query.order(byDescending: "createAt")
        if needUpdate {
            query.cachePolicy = .ignoreCache
        }else {
        //当前从缓存优先查询，设定缓存策略
        query.cachePolicy = .cacheElseNetwork
        query.maxCacheAge = 60 * 2
        if query.hasCachedResult(){
            print("当前从缓存查询结果！")
        }
        }
        
        query.findObjectsInBackground { (results, error) in
            if let results = results as? [AVObject] {
                self.areas = results
                //在IOS里面UI线程是优先级最高的，网络操作及耗时的操作会放在后台线程
                //此时候。从后台线程取出的数据应当放回主线程
                //在info.plist里面加上App Transport Security Settings-> Allow Arbitrary Loads 就可以访问http协议
                OperationQueue.main.addOperation {
                    self.refreshControl?.endRefreshing() //查询结果后关闭刷新效果
                     self.spinner.stopAnimating()//关闭加载效果
                    self.tableView.reloadData()

                    }
                } else {
              print(error ?? "未知错误")
            }
            
        }
    }
    
    func refreshData()  {
        getDataFromClud(needUpdate: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return areas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let area = areas[indexPath.row]
        //添加图像占位符
        cell.imageView?.image = #imageLiteral(resourceName: "photoalbum")
        cell.textLabel?.text = area["name"] as? String
        
        if let imgFile = area["image"] as? AVFile {
            imgFile.getDataInBackground({ (data, error) in
                if let data = data{
                    OperationQueue.main.addOperation {
                        cell.imageView?.image = UIImage(data: data)
                    }
                } else {
                    print(error ?? "获取图像未知错误")
                }
            })
            
        }
        
       
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
