//
//  DetailTableViewController.swift
//  FansArea
//
//  Created by Wen Jing on 2017/6/8.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
//图像选择平铺莫斯，启用属性栏的Drawing的“Clip To Bounds” 进行裁剪，否则会延伸出去覆盖其他视图
    @IBOutlet weak var largeImageView: UIImageView!
   
    @IBOutlet weak var ratingButton: UIButton!
    var area : AreaMO!
    override func viewDidLoad() {
        super.viewDidLoad()
        largeImageView.image = UIImage(data: area.image! as Data)
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线
        self.title = area.name //设置标题
        tableView.estimatedRowHeight = 100 //自适应行高
        tableView.rowHeight = UITableViewAutomaticDimension //自适应行高 ，还需设置宽度约束，动态行数设为0，0代表动态行数
        
        if let rating = area.rating {
            self.ratingButton.setImage(UIImage(named: rating), for: .normal)
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
        cell.backgroundColor = UIColor.clear //透明色
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "地名"
            cell.valueLable.text = area.name
        case 1:
            cell.fieldLabel.text = "省"
            cell.valueLable.text = area.province
        case 2:
            cell.fieldLabel.text = "区域"
            cell.valueLable.text = area.part
        case 3:
            cell.fieldLabel.text = "是否去过"
            cell.valueLable.text = area.isVisted ? "去过" : "没去过"
        default:
            break
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

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //转场前传递实实例
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showMap" {
            let destVc = segue.destination as! MapViewController
            destVc.area = self.area
        }
    }
 
    //反向转场，传值
    @IBAction func close(segue: UIStoryboardSegue){
            let reviewVc = segue.source as! ReViewController
        
        if let rating = reviewVc.rating{
            self.area.rating = rating
            self.ratingButton.setImage(UIImage(named: rating), for: .normal)
        }
        
        //关闭之后保存进数据库
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
               appDelegate.saveContext()
    }
    
    

}
