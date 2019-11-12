//
//  ManufacturerVC.swift
//  MVVM_RXSwift_Cars
//
//  Created by Anderson F Carvalho on 11/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ManufacturerVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let cellName = "cell"
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "ManufacturerCell", bundle: Bundle.main.self), forCellReuseIdentifier: cellName)
        self.tableView.dataSource = nil
        
        setupTableView()
        
    }
    
    fileprivate func setupTableView() {
        let manufacturerViewModel = ManufacturerViewModel()
        
        manufacturerViewModel.manufacturer.subscribe(onNext: { (result) in
            DispatchQueue.main.async {
                Observable.just(result).bind(to: self.tableView.rx.items(cellIdentifier: self.cellName, cellType: ManufacturerCell.self)) { (row, element, cell) in
                    cell.setupCell(element.code, element.name, row)
                    
                    if row == 9 {
                        self.setupTableView()
                    }
                    
                    }.disposed(by: self.disposeBag)
                self.tableView.reloadData()
                
                
            }
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(ManufacturerViewModel.Output.self).subscribe(onNext: { (item) in
            print(item.code)
        }).disposed(by: disposeBag)
        
    }
    
}
