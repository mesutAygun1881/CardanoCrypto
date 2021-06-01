//
//  ViewController.swift
//  CardanoCrypto
//
//  Created by Mesut Aygün on 1.06.2021.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
  
    private var data : AdaCoinData?

    private var viewModel = [ADATableViewCellModel]()
    
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register( ADATableViewCell.self, forCellReuseIdentifier: ADATableViewCell.identifier)
        return table
    }()
    
    static let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter
    }()
    
    static let dateFormatter : ISO8601DateFormatter = {
       let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFractionalSeconds
        formatter.timeZone = .current
        return formatter
        
    }()
    
    static let prettyDate : DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cardano"
        self.tableView.backgroundColor = UIColor.systemBlue
    
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds

    }
    
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        createTable()
    }
    
   private func createTable() {
    
    guard let price = data?.quote["USD"]?.price else {
        return
    }
    
        // view ölçülerini header a tanımladık
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        header.clipsToBounds = true
        
    let imageView = UIImageView(image: UIImage(named: "cardano"))
        imageView.contentMode = .scaleAspectFill
        //size genişliğin yarısı
        let size : CGFloat = view.frame.size.width / 2
        imageView.frame = CGRect(x: (view.frame.size.width - size) / 2 , y: 40, width: size, height: size)
        header.addSubview(imageView)
   
    let number = NSNumber(value: price)
    let string = Self.formatter.string(from: number)
    
    let label = UILabel()
    label.text = string
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 40, weight: .medium)
    label.frame = CGRect(x: 10, y: 60 + size, width: view.frame.size.width - 20 , height: 30)
    header.addSubview(label)
        tableView.tableHeaderView = header
    
    }
    private func fetchData() {
        APIService.shared.getADAData { [weak self]result in
            switch result {
            case .success(let data):
                self?.data = data
                DispatchQueue.main.async {
                    self?.setUpViewModels()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
   
    private func setUpViewModels() {
        guard let model = data else {
            return
        }
        guard let data = Self.dateFormatter.date(from: model.date_added) else {
            return
        }
        
        
        viewModel = [
            ADATableViewCellModel(title: "Name", value: model.name) ,
            ADATableViewCellModel(title: "Symbol", value: model.symbol) ,
            ADATableViewCellModel(title: "Identifier", value: String(model.id)) ,
            ADATableViewCellModel(title: "Date Added", value: Self.prettyDate.string(from: data)) ,
            
           
        ]
        
        setUpTable()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    private func tableView(tableView: UITableView, willDisplayCell cell: ADATableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.contentView.backgroundColor = UIColor.yellow
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ADATableViewCell.identifier,
                                                       for: indexPath) as? ADATableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModel[indexPath.row])
        cell.backgroundColor = UIColor.yellow
        return cell
    }

}

