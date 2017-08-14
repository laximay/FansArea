//: Playground - noun: a place where people can play

import UIKit


var  areas = ["上海","甘肃", "福建", "青海", "广东", "福建", "黑龙江", "山西", "四川", "广东", "华南"]

var visited = [Bool](repeatElement(false, count: 11))

var provinces = ["上海","甘肃", "福建", "青海", "广东", "福建", "黑龙江", "江西", "四川", "华南", "华中"]

var areaImages = ["xinzhuang", "qilihe", "yaoxi","chengxi","baiyun","shangjie",
                    "nangang", "yaodu", "wuhuo", "jinping", "furong"]

var parts = ["华北","西北","东南","西北","华南","东南","东北","华北","西南","华南","华中"]

for i in 0..<areas.count{
    print("Area(name: \"\(areas[i])\", province: \"\(provinces[i])\", part: \"\(parts[i])\", image: \"\(areaImages[i])\", isVisted: \(visited[i]))",",")
}

