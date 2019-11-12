//
//  ManufacturerDataModule.swift
//  MVVM_RXSwift_Cars
//
//  Created by Anderson F Carvalho on 11/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ManufacturerDataModule {
    let disposeBag = DisposeBag()
    
    func manufacturerFetch(_ page: Int) -> Observable<Manufacturer> {
        
        let apiRequest = APIRequest()
        apiRequest.baseURL = URL(string: "http://api-aws-eu-qa-1.auto1-test.com/v1/car-types/manufacturer?page=\(page)&pageSize=10&wa_key=coding-puzzle-client-449cc9d")
        
        let result: Observable<Manufacturer> = APICalling().fetch(apiRequest: apiRequest)
        
        return result
    }
}
