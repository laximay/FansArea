//
//  Area.swift
//  FansArea
//
//  Created by Wen Jing on 2017/6/8.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

struct Area {
    var name : String
    var province : String
    var part : String
    var image :String
    var isVisted :Bool
    var rating = ""
    //新家字段，应该初始化原有的构造器
    init(name: String, province: String, part: String, image: String, isVisted: Bool) {
        self.name = name
        self.province = province
        self.part = part
        self.image = image
        self.isVisted = isVisted
    }
}

//Area(name: "广东省横沥镇西城三区稻香集团", province: "上海", part: "华北", image: "xinzhuang", isVisted: false) ,
//Area(name: "甘肃代理商放假了时间飞逝", province: "甘肃", part: "西北", image: "qilihe", isVisted: false) ,
//Area(name: "福建防守打法两款手机里继续形成飞机上的浪费距离圣诞节", province: "福建", part: "东南", image: "youxi", isVisted: false) ,
//Area(name: "青海发送到解放路口聚少离多会计分录看似简单雷锋精神来得及发牢骚", province: "青海", part: "西北", image: "chengxi", isVisted: false) ,
//Area(name: "广东发送到解放路口聚少离多会计分录看似简单雷锋精神来得及发牢骚", province: "广东", part: "华南", image: "baiyun", isVisted: false) ,
//Area(name: "福建发送到解放路口聚少离多会计分录看似简单雷锋精神来得及发牢骚", province: "福建", part: "东南", image: "shangjie", isVisted: false) ,
//Area(name: "黑龙江发送到解放路口聚少离多会计分录看似简单雷锋精神来得及发牢骚", province: "黑龙江", part: "东北", image: "nangang", isVisted: false) ,
//Area(name: "山西发送到解放路口聚少离多会计分录看似简单雷锋精神来得及发牢骚", province: "江西", part: "华北", image: "yaodu", isVisted: false) ,
//Area(name: "四川发送到解放路口聚少离多会计分录看似简单雷锋精神来得及发牢骚", province: "四川", part: "西南", image: "wuhou", isVisted: false) ,
//Area(name: "广东发送到解放路口聚少离多会计分录看似简单雷锋精神来得及发牢骚", province: "华南", part: "华南", image: "jinping", isVisted: false) ,
//Area(name: "华南发送到解放路口聚少离多会计分录看似简单雷锋精神来得及发牢骚", province: "华中", part: "华中", image: "furong", isVisted: false)


