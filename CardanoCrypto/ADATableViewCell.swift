//
//  ADATableViewCell.swift
//  CardanoCrypto
//
//  Created by Mesut Aygün on 1.06.2021.
//

import UIKit


struct ADATableViewCellModel {
    let title : String
    let value : String
}


class ADATableViewCell: UITableViewCell {

    static let identifier = "ADATableViewCell"
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
   
    private let valueLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    override init(style : UITableViewCell.CellStyle , reuseIdentifier : String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
        contentView.addSubview(valueLabel)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
        valueLabel.sizeToFit()
        titleLabel.frame = CGRect(x: 15, y: 0, width: titleLabel.frame.size.width, height: contentView.frame.size.height)
        valueLabel.frame = CGRect(x: contentView.frame.size.width - valueLabel.frame.size.width  ,
                                  y: 0,
                                  width: valueLabel.frame.size.width,
                                  height: contentView.frame.size.height)
    }
    func configure(with viewModel : ADATableViewCellModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
    
}
