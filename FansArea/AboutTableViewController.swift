//
//  AboutTableViewController.swift
//  FansArea
//
//  Created by Wen Jing on 2017/6/18.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {

    var sectionTitle = ["反馈", "关注我的博客"]
    var selectionContent = [["在App Store给我们平分", "反馈意见"],["网站", "博客", "学习路线图"]]
    var links = ["https://www.xiaoboswift.com/", "http://www.baidu.com", "http://www.163.com"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //去除多余空行,或则拖一个空白view到tableview的页脚，高度为0
        //tableView.tableFooterView = UIView(frame: CGRect.zero)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return section == 0 ? 2 : 3
    }
    
   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = selectionContent[indexPath.section][indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                //1.跳出APP在Safari 里面打开网页
                let urlString = "http://www.163.com/"
                if let url = URL(string: urlString){
                    UIApplication.shared.open(url)
                }
            }else{
                //2.用uiwebview/wkWebview打开
                performSegue(withIdentifier: "showWebview", sender: self)
            }
        case 1:
            //3.使用SFSafariViewController，一个全功能的Safari浏览器
            if let url = URL(string: links[indexPath.row]){
               let sfvc = SFSafariViewController(url: url)
                present(sfvc, animated: true, completion: nil)
            }
            
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
