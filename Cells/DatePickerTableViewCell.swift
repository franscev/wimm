
import UIKit

protocol DatePickerDelegate: class {
    func didChangeDate(date: Date, indexPath: IndexPath)
}

class DatePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var indexPath: IndexPath!
    weak var delegate: DatePickerDelegate?
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "DatePickerTableViewCellIdentifier"
    }

    
    
    
    // Nib name
    class func nibName() -> String {
        return "DatePickerTableViewCell"
    }
    
    // Cell height
    class func cellHeight() -> CGFloat {
        return 90
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView() {
        datePicker.setValue(UIColor.init(named: "DarkBlue"), forKeyPath: "textColor")

        datePicker.setValue(false, forKey: "highlightsToday")
        datePicker.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
    }

    func updateCell(date: Date, indexPath: IndexPath) {
        datePicker.setDate(date, animated: true)
        
        self.indexPath = indexPath
    }
    
    @objc func dateDidChange(_ sender: UIDatePicker) {
        let indexPathForDisplayDate = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        delegate?.didChangeDate(date: sender.date, indexPath: indexPathForDisplayDate)
    }
    
    

}
