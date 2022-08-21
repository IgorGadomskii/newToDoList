

import UIKit

class MyCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var colorTegView: UIView!
    @IBOutlet weak var taskLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        colorTegView.layer.cornerRadius = 10
    }
    
    

}
