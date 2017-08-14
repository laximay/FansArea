//
//  AddAreaController.swift
//  FansArea
//
//  Created by Wen Jing on 2017/6/11.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import CoreData

class AddAreaController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var area : AreaMO!
    var isVisited = false

    @IBAction func saveTap(_ sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        area = AreaMO(context: appDelegate.persistentContainer.viewContext)
        area.name = tfName.text
        area.part = tfPart.text
        area.province = tfProvince.text
        area.isVisted = isVisited
        if let imageData = UIImageJPEGRepresentation(coverImageView.image!, 0.7){
            area.image = NSData(data : imageData)
        }
        print("正在保存。。")
        appDelegate.saveContext()
        saveToCloud(area: area)
        performSegue(withIdentifier: "unwindToHomeList", sender: self)
    }
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfProvince: UITextField!
    @IBOutlet weak var tfPart: UITextField!
    @IBOutlet weak var lableVisited: UILabel!
    @IBAction func isVisitedBtnTap(_ sender: UIButton) {
        if sender.tag == 8001 {
            isVisited = true
            lableVisited.text = "我来过"
        } else {
            isVisited = false
            lableVisited.text = "我没去"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //选择图片的出发的方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        coverImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        //代码布局约束
        let converWidthCons = NSLayoutConstraint(item: coverImageView, attribute: .width, relatedBy: .equal, toItem: coverImageView.superview, attribute: .width, multiplier: 1, constant: 0)
        let converHeightCons = NSLayoutConstraint(item: coverImageView, attribute: .height, relatedBy: .equal, toItem: coverImageView.superview, attribute: .height, multiplier: 1, constant: 0)
        converWidthCons.isActive = true
        converHeightCons.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
    //保存数据到云端
    func saveToCloud(area: AreaMO!) {
        //保存到云端的时候一定不可以是可选类型！
        let cloudObject = AVObject(className: "Area")
        cloudObject["name"] = area.name!
        cloudObject["province"] = area.province!
        cloudObject["part"] = area.part!
        cloudObject["isVisted"] = area.isVisted
        let originImg = UIImage(data: area.image! as Data)!
        
        let factor = (originImg.size.width > 1024) ? ( 1024 / originImg.size.width) : 1
        let scaledImg = UIImage(data: area.image! as Data , scale: factor)!
        let imgFile = AVFile(name: "\(area.name!).jpg", data: UIImageJPEGRepresentation(scaledImg, 0.7)!)
        cloudObject["image"] = imgFile
        
        cloudObject.saveInBackground{(succeed, error) in
            if succeed {
                print("云端保存成功！")
            } else {
                print(error ?? "云端保存失败！")
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //如果是拍照则，选择.camera
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                print("相册不可用")
                return
            }
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary //如果是拍照则，选择.camera
            picker.delegate = self //一定要实现代理，要不然选择不生效
            self.present(picker, animated: true, completion: nil)
            
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
