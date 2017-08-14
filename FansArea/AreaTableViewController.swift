//
//  AreaTableViewController.swift
//  FansArea
//
//  Created by Wen Jing on 2017/6/3.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import CoreData

class AreaTableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchResultsUpdating {
    //定义model
    var  areas : [AreaMO] = []
    var fc : NSFetchedResultsController<AreaMO>!
    var sc: UISearchController!
    var searchResult: [AreaMO] = []
    
    func searchFilter(text: String)  {
        searchResult = areas.filter({ (area) -> Bool in
            return area.name!.localizedCaseInsensitiveContains(text)||(area.part?.localizedCaseInsensitiveContains(text))!
            
        })
    }
    
    
    //没有导航条设置状态条颜色--局部设置，如果想要全局则可以在AppDelegate里面设置  UIApplication.shared.statusBarStyle = .lightContent
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }
    

    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        //系统分配的存储空间，可以存储一般小的数据
        if defaults.bool(forKey: "GuiderShow"){
            return
        }
        //如果分割了Storyboard 则需要这样引入
       // let aboutSB = UIStoryboard(name: "about", bundle: Bundle.main)
        
        if let pageVC = storyboard?.instantiateViewController(withIdentifier: "GuideConntroller") as? GuiderViewController {
            present(pageVC, animated: true, completion: nil)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // fetchAllData()
        //tableView.reloadData()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if var text = searchController.searchBar.text{
            text = text.trimmingCharacters(in: .whitespaces)//去除空格
            searchFilter(text: text)
            tableView.reloadData()
        }
    }

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
            // 有导航条的情况下，设置状态栏颜色 或直接在storyborad上直接设置 style 为black
             self.navigationController?.navigationBar.barStyle = .black
        //取消导航条的般透明色，如果用到搜索条就要取消，要不然就会看不见，也可以在storyboard里面设置under opaque Bars属性
        self.navigationController?.extendedLayoutIncludesOpaqueBars = true
        sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        tableView.tableHeaderView = sc.searchBar
        //搜索条的背景色不变,如果不设置这个属性，搜索结果是点不了的
        sc.dimsBackgroundDuringPresentation = false
        //搜索条的占位符
        sc.searchBar.placeholder = NSLocalizedString("Enter area Name for search...", comment: "placeholder for searchbar")
        //前景色
        //sc.searchBar.tintColor = UIColor.white
        //背景色
        //sc.searchBar.barTintColor = UIColor.orange
        
        //使用透明样式，
        sc.searchBar.searchBarStyle = .minimal
        
        
        tableView.estimatedRowHeight = 150 //自适应行高
        tableView.rowHeight = UITableViewAutomaticDimension //自适应行高 ，还需设置宽度约束，动态行数设为0，0代表动态行数

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //设置导航栏的返回箭头样式
             self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        fetchAllData2()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let menu = UIAlertController(title: "提示", message: "您选择了第\(indexPath.row)行", preferredStyle: .actionSheet)
//        let optionOK = UIAlertAction(title: "确定", style: .default, handler: nil)
        let optionGo = UIAlertAction(title: "我去过", style: .default) { (_) in
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.visited[indexPath.row] = true //1.修复复选BUG 加入复选标记
            let cell = tableView.cellForRow(at: indexPath)as! CustomTableViewCell
            cell.goodImage.isHidden = false

           
            
        }
        let optionCancel = UIAlertAction(title: "取消", style: .cancel){(_) in
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            self.visited[indexPath.row] = false //1.修复复选BUG 加入复选标记
            let cell = tableView.cellForRow(at: indexPath)as! CustomTableViewCell
            cell.goodImage.isHidden = true
            

        }
        menu.addAction(optionGo)
        menu.addAction(optionCancel)
        self.present(menu, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }*/


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sc.isActive ? searchResult.count : areas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let area = sc.isActive ? searchResult[indexPath.row]:areas[indexPath.row]

        cell.nameLabel.text = area.name
        cell.partLable.text = area.part
        cell.provinceLabel.text = area.province
        cell.thumbImage.image = UIImage(data: area.image! as Data)
        cell.thumbImage.layer.cornerRadius = cell.thumbImage.frame.size.width/2
        cell.thumbImage.clipsToBounds = true
        cell.goodImage.image = #imageLiteral(resourceName: "good")
        cell.goodImage.isHidden = !area.isVisted
//        //修复复选BUG ，判断是否由于有了复选标志，如果有，则保留复选标志，不是的则取消
//        if visited[indexPath.row]{
//            
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        //可以使用三元运算
//        cell.accessoryType = visited[indexPath.row] ? .checkmark : .none
        
        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !sc.isActive
    }
 
    //自定义右滑菜单
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let actionShare = UITableViewRowAction(style: .normal, title: NSLocalizedString("Share", comment: "title for Share")) { (_, indexPath) in
            let actionSheet = UIAlertController(title: NSLocalizedString("Share", comment: "title for Share"), message: nil, preferredStyle: .actionSheet)
            let option1 = UIAlertAction(title: "QQ", style: .default, handler: nil)
            let option2 = UIAlertAction(title: NSLocalizedString("Wechat", comment: "option for Wechat"), style: .default, handler: nil)
            let optionCancel = UIAlertAction(title: NSLocalizedString("Cancel", bundle: Bundle(for: UIButton.classForCoder()), comment: "Cancel for option "), style: .cancel, handler: nil)
            actionSheet.addAction(option1)
            actionSheet.addAction(option2)
            actionSheet.addAction(optionCancel)
            self.present(actionSheet, animated: true, completion: nil)
            
        }
        actionShare.backgroundColor = UIColor.orange
        //NSLocalizedString 国际化参数
        let actionDel = UITableViewRowAction(style: .destructive, title: NSLocalizedString("Delete", bundle:Bundle(for: UIButton.classForCoder()), comment: "title fro delete action")) { (_, indexPath) in
           // self.areas.remove(at: indexPath.row)  //如果是用了NSFetchedResultsControllerDelegate 则不需要再手动删除模型，与更新页面
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(self.fc.object(at: indexPath))
            appDelegate.saveContext()
            
            // Delete the row from the data source
           // tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let actionVisted = UITableViewRowAction(style: .normal, title: NSLocalizedString("Visted", comment: "Visted for option")) { (_, indexPath) in
            self.areas[indexPath.row].isVisted = true
          //  tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            let cell = tableView.cellForRow(at: indexPath)as! CustomTableViewCell
            cell.goodImage.isHidden = false
            
            
        }
        let actionNovisted = UITableViewRowAction(style: .normal, title: NSLocalizedString("NotVisted", comment: "NotVisted")) { (_, indexPath) in
            self.areas[indexPath.row].isVisted = false
            //  tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            let cell = tableView.cellForRow(at: indexPath)as! CustomTableViewCell
            cell.goodImage.isHidden = true
            
            
        }
        if self.areas[indexPath.row].isVisted {
            return [actionShare, actionDel, actionNovisted]

        }else{
        
            return [actionShare, actionDel, actionVisted]}
        
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //界面跟数据都要同步删除
            self.areas.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            //整体刷新,效果不如上句代码体验好
            //tableView.reloadData();
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    //取出所有数据
//    func fetchAllData()  {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        do{
//         areas =  try appDelegate.persistentContainer.viewContext.fetch(AreaMO.fetchRequest())
//        } catch {
//            print(error)
//        }
//        
//    }
    
 
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            tableView.reloadData()
        }
        
        if let object = controller.fetchedObjects{
            areas = object as! [AreaMO]
        }
    }
    
    func fetchAllData2()  {
        let request : NSFetchRequest<AreaMO> = AreaMO.fetchRequest()
        let sd = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sd]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        fc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fc.delegate = self
        
        do {
            try fc.performFetch()
            if let objects = fc.fetchedObjects{
                areas = objects
            }
        } catch{
            print(error)
        }
        
    }
    

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showAreaDetail"{
            let dest = segue.destination as! DetailTableViewController
            //隐藏底部导航条
        //  dest.hidesBottomBarWhenPushed = true
            dest.area = sc.isActive ? searchResult[tableView.indexPathForSelectedRow!.row]: areas[tableView.indexPathForSelectedRow!.row]
            
        }
        
        
        
    }
    //在退回的控制器添加返场的方法
  @IBAction  func close(segue: UIStoryboardSegue){
        
    }
    

}
