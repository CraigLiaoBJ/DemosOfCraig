//
//  AddressTableViewCell.swift
//  AddressBookSwift
//
//  Created by Craig Liao on 15/8/21.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    var nameLabel : UILabel?
    var phoneLabel : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.nameLabel = UILabel()
        self.phoneLabel = UILabel()
        
        self.contentView.addSubview(self.nameLabel!)
        self.contentView.addSubview(self.phoneLabel!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nameLabel?.frame = CGRectMake(10, 10, self.frame.size.width - 20, 30)
        
        self.phoneLabel?.frame = CGRectMake(10, 50, self.frame.size.width - 20, 30)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
