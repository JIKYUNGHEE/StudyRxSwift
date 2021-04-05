//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by 지경희 on 2021/04/02.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift

class MenuListViewModel {
    
//    lazy var menuObservable = PublishSubject<[Menu]>()
    lazy var menuObservable = BehaviorSubject<[Menu]>(value: [])
    init() {
        let menus: [Menu] = [
            Menu(id: 1, name: "튀김1", price: 100, count: 0),
            Menu(id: 2, name: "튀김2", price: 100, count: 0),
            Menu(id: 3, name: "튀김3", price: 100, count: 0),
            Menu(id: 4, name: "튀김4", price: 100, count: 0),
            Menu(id: 5, name: "튀김5", price: 100, count: 0),
            Menu(id: 6, name: "튀김6", price: 100, count: 0)
        ]
        menuObservable.onNext(menus)
    }
    
    lazy var itemCount = menuObservable.map {
        $0.map{ $0.count }.reduce(0, +)
    }
    lazy var totalPrice = menuObservable.map {
        $0.map{ $0.price * $0.count }.reduce(0, +)
    }
    
    func clearAllItemSelected() {
        _ = menuObservable
            .map { menus in
                menus.map { menu in
                    Menu(id: menu.id, name: menu.name, price: menu.price, count: 0)
                }
            }
            .take(1)    //1번만 수행할거다.
            .subscribe(onNext: {
                self.menuObservable.onNext($0)
            })
    }
    
    func changeCount(item: Menu, increase: Int) {
        _ = menuObservable
            .map { menus in
                menus.map { menu in
                    if menu.id == item.id {
                        return Menu(id: menu.id, name: menu.name, price: menu.price, count: menu.count + increase)
                    } else {
                        return Menu(id: menu.id, name: menu.name, price: menu.price, count: menu.count)
                    }
                }
            }
            .take(1)    //1번만 수행할거다.
            .subscribe(onNext: {
                self.menuObservable.onNext($0)
            })
    }
    
    func onOrder() {
        
    }
}
