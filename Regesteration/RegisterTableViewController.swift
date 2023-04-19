//
//  RegisterTableViewController.swift
//  Regesteration
//
//  Created by Eman on 24/01/2023.
//

import UIKit

class RegisterTableViewController: UITableViewController,SelectRoomTypeTableViewControllerDelegate {
    var roomType: RoomType?
    
    @IBOutlet weak var roomTypeLabel: UILabel!
   
  

 
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    
    
    @IBOutlet weak var checkOutDateLabel: UILabel!
    
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    

    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    
    
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    
    
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    
    @IBOutlet weak var SwithOut: UISwitch!
    
    
    var registration: Registration? {
        guard let roomType = roomType else { return nil }
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = SwithOut.isOn
        return Registration(firstName: firstName,
                            lastName: lastName,
                            emailAddress: email,
                            checkInDate: checkInDate,
                            checkOutDate: checkOutDate,
                            numberOfAdults: numberOfAdults,
                            numberOfChildren: numberOfChildren,
                            wifi: hasWifi, roomType: roomType)
    }
   
    
    
    
    
    
    
    
    
    
    
    
    
    
//    var checkInDateLabelCellIndexPath = IndexPath(row: 2, section: 2)
//    var checkOutDateLabelCellIndexPath = IndexPath(row: 4, section: 2)
//    
//    
//    
//    let checkInDatePickerCellIndexPath = IndexPath(row: 2, section: 2)
//    let checkOutDatePickerCellIndexPath = IndexPath(row: 4, section: 2)
//    var isCheckInDatePickerVisible: Bool = false {
//        didSet {
//            checkInDatePicker.isHidden = !isCheckInDatePickerVisible
//        }
//    }
//    var isCheckOutDatePickerVisible: Bool = false {
//        didSet {
//            checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
//        }
//    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New guesr Regestiration"
        let Today = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = Today
        checkInDatePicker.date = Today
        updateDateViews()
        updateNumberOfGuests()
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
  func  updateDateViews()
    {
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding:
           .day, value: 1, to: checkInDatePicker.date)



        checkInDateLabel.text = dateFormatter.string(from:
           checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from:
           checkOutDatePicker.date)




    }

    
    @IBAction func DatePicker(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    
    
//    @IBAction func savebtm(_ sender: Any) {
//        
//       let firstName = firstNameTextField.text ?? ""
//            let lastName = lastNameTextField.text ?? ""
//            let email = emailTextField.text ?? ""
//      
//            let checkInDate = checkInDatePicker.date
//            let checkOutDate = checkOutDatePicker.date
//            let numberOfAdults = Int(numberOfAdultsStepper.value)
//            let numberOfChildren = Int(numberOfChildrenStepper.value)
//        let WIFI = SwithOut.isOn
//        let roomChoice = roomType?.name ?? "Not Set"
//
//    
//        
//        
//    }
    
   
   
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text =
           "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text =
           "\(Int(numberOfChildrenStepper.value))"
    }
    
    @IBAction func stepeer(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
   
    
    @IBAction func SwitchAct(_ sender: UISwitch) {
    }
  
    @IBAction func cancelbtm(_ sender: UIBarButtonItem) {
        
         dismiss(animated: true, completion: nil)

     
        
    }
    
   
    @IBSegueAction func seguCell(_ coder: NSCoder) -> RoomTableViewController? {
     let selectRoomTypeController =
      RoomTableViewController(coder: coder)
       // let selectRoomTypeController = self.storyboard?.instantiateViewController(withIdentifier: "room")as!RoomTableViewController
        selectRoomTypeController!.delegate = self
        selectRoomTypeController!.roomType = roomType
  return selectRoomTypeController

    }
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
    func selectRoomTypeTableViewController(_ controller:
                                           RoomTableViewController, didSelect roomType:
           RoomType) {
            self.roomType = roomType
            updateRoomType()
        }

    
//    override func tableView(_ tableView: UITableView,
//       heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath {
//        case checkInDatePickerCellIndexPath where
//           isCheckInDatePickerVisible == false:
//            return 0
//        case checkOutDatePickerCellIndexPath where
//           isCheckOutDatePickerVisible == false:
//            return 0
//        default:
//            return UITableView.automaticDimension
//        }
//    }
   
   
//    override func tableView(_ tableView: UITableView,
//       didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if indexPath == checkInDateLabelCellIndexPath &&
//           isCheckOutDatePickerVisible == false {
//            // check-in label selected, check-out picker is not
//               //visible, toggle check-in picker
//            isCheckInDatePickerVisible.toggle()
//        } else if indexPath == checkOutDateLabelCellIndexPath &&
//           isCheckInDatePickerVisible == false {
//            // check-out label selected, check-in picker is not
//           //    visible, toggle check-out picker
//            isCheckOutDatePickerVisible.toggle()
//        } else if indexPath == checkInDateLabelCellIndexPath ||
//           indexPath == checkOutDateLabelCellIndexPath {
//            // either label was selected, previous conditions failed
//            //   meaning at least one picker is visible, toggle both
//            isCheckInDatePickerVisible.toggle()
//            isCheckOutDatePickerVisible.toggle()
//        } else {
//            return
//        }
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
//
   
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
