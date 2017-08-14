//
//  ReViewController.swift
//  FansArea
//
//  Created by Wen Jing on 2017/6/11.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit

class ReViewController: UIViewController {
    var rating:String?

    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBAction func ratingTap(_ sender: UIButton) {
        switch sender.tag {
        case 100:
            rating = "dislike"
        case 101:
            rating = "good"
        case 102:
            rating = "great"
        default:
            break
        }
        //代码转场
        performSegue(withIdentifier: "unwindToDetailView", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //背景虚化特效
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurEffectView.frame = view.frame
        bgImageView.addSubview(blurEffectView)
        let startScale = CGAffineTransform(scaleX: 0, y: 0)
        let startPos = CGAffineTransform(translationX: 0, y: 500)
        ratingStackView.transform = startScale.concatenating(startPos)
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //这个事件每次加载页面都会启动
    override func viewDidAppear(_ animated: Bool) {
        //基础动画
//        UIView.animate(withDuration: 0.3) { 
//            self.ratingStackView.transform = CGAffineTransform.identity
//        }
        //IOS7增加的动画效果，带震荡
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            let endScale = CGAffineTransform.identity
            let endPos = CGAffineTransform(translationX: 0, y: 0)
            self.ratingStackView.transform = endPos.concatenating(endScale)
        }, completion: nil)

    }

}
