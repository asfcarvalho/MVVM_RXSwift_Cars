//
//  ManufacturerViewModel.swift
//  MVVM_RXSwift_Cars
//
//  Created by Anderson F Carvalho on 11/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ManufacturerViewModel {
    var page: Int = 1
    var pageMax: Int = 15
    var manufacturer: Observable<[Output]>
    
    let manuvacturerDataModule = ManufacturerDataModule()
    let disposeBag = DisposeBag()
    
    struct Input {
        let page: PublishRelay<Int>
    }
    
    struct Output {
        let code: String
        let name: String
    }
    
    init() {
        let obsMauvacturer: Observable<Manufacturer> = manuvacturerDataModule.manufacturerFetch(page)
        
        var list = [Output]()
        
        let pageInput =  PublishRelay<Int>()
        
        self.manufacturer = Observable.create { obs in
            obsMauvacturer.debug("r").subscribe(onNext: { (item) in
                
                if let manufacturerList = item.wkda {
                    for value in manufacturerList {
                        list.append(Output(code: value.key, name: value.value))
                    }
                }
                return obs.onNext(list)
            }, onError: { (error) in
                obs.onError(error)
            })
        }
        
        self.page += 1
    }
}
