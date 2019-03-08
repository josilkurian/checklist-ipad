//
//  ViewController.swift
//  Checklist
//
//  Created by Josil K M on 9/3/18.
//  Copyright © 2018 Josil K M. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var ref: DatabaseReference!
    
    let soundBoothDevices = ["Mic with stand", "Audio Mixer", "Electronic Keyboard", "Electric Drums", "iMac with Headphones", "Speaker", "Noise pads for acoustic enhancement"]
    
    let vrZoneDevices = ["Oculus Rift", "Oculus Rift Joysticks", "Oculus Rift Sensors", "Dell Visor", "Dell Visor Joysticks", "Dell Laptop", "360 Camera"]
    
    let obStudioDevices = ["Microphone", "Microphone Holder", "XLRF Cable", "Audio Mixer", "Sterio cable", "Canon Camera", "h264 Pro Recorder", "USB Hub", "Micro to USB cable", "USB Extension Cable", "Powermate Button", "Surge Protector", "HDMI Cable", "SpectroLED Lights", "Camera Stand", "iMac"]
    
    let zones = ["Sound Booth", "VR Zone", "One Button Studio"]
    let reps = ["Hamza Khan", "Josil Kurian", "Alina Huda", "Mohammad Wahaj", "Shruti Ganji"]
    var timePickerValues = [""]
    
    
    static var selectedDevices = [""]
    
    @IBOutlet weak var selectRep: UIButton!
    @IBOutlet weak var repTable: UITableView!
    
    @IBOutlet weak var soundBoothButton: UIButton!
    @IBOutlet weak var vrZoneButton: UIButton!
    @IBOutlet weak var obStudioButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var viewData: UIButton!
    
    @IBOutlet weak var dummyView: UIView!
    @IBOutlet weak var viewDataView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var zonePicker: UIPickerView!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var timePickerLabel: UILabel!
    @IBOutlet weak var loadDataButton: UIButton!
    @IBOutlet weak var dataViewTableView: UITableView!
    
    
    var isSoundBoothSelected = true
    var isVRZoneSelected = false
    var isOBStudioSelected = false
    
    var hour:String=""
    var minutes:String=""
    var seconds:String=""
    var keyArray = [""]
    var returnedData:NSDictionary = [:]
    var selectedKeyValue:NSDictionary = [:]
    var repName=""
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == self.tableView{
            if isSoundBoothSelected{
                return soundBoothDevices.count
            }
            else if isVRZoneSelected{
                return vrZoneDevices.count
            }
            else{
                return (obStudioDevices.count)
            }
        }
        if tableView == repTable{
            return reps.count
        }
        else{
            return (keyArray.count)
        }
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if tableView == self.tableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
            if isSoundBoothSelected{
                cell.deviceName.text = soundBoothDevices[indexPath.row]
                cell.deviceChecker.isOn = false
            }
            else if isVRZoneSelected{
                cell.deviceName.text = vrZoneDevices[indexPath.row]
                cell.deviceChecker.isOn = false
            }
            else{
                cell.deviceName.text = obStudioDevices[indexPath.row]
                cell.deviceChecker.isOn = false
            }
            return(cell)
        }
        if tableView == repTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "repCell", for: indexPath)
            cell.textLabel?.text = reps[indexPath.row]
            return(cell)
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "dataViewCell", for: indexPath) as! DataViewTableViewCell
            cell.KeyLabel.text = keyArray[indexPath.row]
            cell.valueLabel.text = selectedKeyValue.value(forKey: keyArray[indexPath.row]) as? String
            return(cell)
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == repTable{
            selectRep.setTitle(reps[indexPath.row], for: .normal)
            repName = reps[indexPath.row]
            repTableToggle()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        soundBoothButton.setBackgroundImage(UIImage(named: "SoundBoothSelected") as UIImage?, for: .normal)
        ViewController.selectedDevices.removeAll()
        ref = Database.database().reference()
        repTable.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func soundBoothButtonClick(_ sender: Any) {
        soundBoothButton.setBackgroundImage(UIImage(named: "SoundBoothSelected") as UIImage?, for: .normal)
        vrZoneButton.setBackgroundImage(UIImage(named: "VRZone") as UIImage?, for: .normal)
        obStudioButton.setBackgroundImage(UIImage(named: "OBS") as UIImage?, for: .normal)
        
        ViewController.selectedDevices.removeAll()
        
        isSoundBoothSelected = true
        isVRZoneSelected = false
        isOBStudioSelected = false
        tableView.reloadData()
        
    }
    
    @IBAction func vrZoneButtonClick(_ sender: Any) {
        vrZoneButton.setBackgroundImage(UIImage(named: "VRZoneSelected") as UIImage?, for: .normal)
        soundBoothButton.setBackgroundImage(UIImage(named: "SoundBoothUnselected") as UIImage?, for: .normal)
        obStudioButton.setBackgroundImage(UIImage(named: "OBS") as UIImage?, for: .normal)
        
        ViewController.selectedDevices.removeAll()
        
        isSoundBoothSelected = false
        isVRZoneSelected = true
        isOBStudioSelected = false
        tableView.reloadData()
    }
    
    @IBAction func obStudioButtonClick(_ sender: Any) {
        obStudioButton.setBackgroundImage(UIImage(named: "OBSSelected") as UIImage?, for: .normal)
        vrZoneButton.setBackgroundImage(UIImage(named: "VRZone") as UIImage?, for: .normal)
        soundBoothButton.setBackgroundImage(UIImage(named: "SoundBoothUnselected") as UIImage?, for: .normal)
        
        ViewController.selectedDevices.removeAll()
        
        isSoundBoothSelected = false
        isVRZoneSelected = false
        isOBStudioSelected = true
        tableView.reloadData()
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let date = Date()
        let calendar = Calendar.current
        var entry:[String : String] = [:]
        var zone = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let dateS = formatter.string(from: Date())
        
        hour = String(calendar.component(.hour, from: date))
        minutes = String(calendar.component(.minute, from: date))
        seconds = String(calendar.component(.second, from: date))
        let timeS = hour+":"+minutes+":"+seconds
        
        entry["Time"] = timeS
        entry["C-Space GA"] = repName
        
        
        if isSoundBoothSelected{
            entry["Zone"] = "Sound Booth"
            zone = "Sound Booth"
            for device in soundBoothDevices{
                if(ViewController.selectedDevices.contains(device)){
                    entry[device] = "YES"
                }
                else{
                    entry[device] = "NO"
                }
            }
        }
        else if isVRZoneSelected{
            entry["Zone"] = "VR Zone"
            zone = "VR Zone"
            for device in vrZoneDevices{
                if(ViewController.selectedDevices.contains(device)){
                    entry[device] = "YES"
                }
                else{
                    entry[device] = "NO"
                }
            }
        }
        else if isOBStudioSelected{
            entry["Zone"] = "One Button Studio"
            zone = "One Button Studio"
            for device in obStudioDevices{
                if(ViewController.selectedDevices.contains(device)){
                    entry[device] = "YES"
                }
                else{
                    entry[device] = "NO"
                }
            }
        }
        if(repName.isEmpty){
            let alert = UIAlertController(title: "Alert", message: "Please select the C-Space Rep. name !", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            self.ref.child("ChecklistApp").child("Dates").child(dateS).child(zone).child(timeS).setValue(entry)
            let alert = UIAlertController(title: "Success", message: "Data saved successfully !", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
            ViewController.selectedDevices.removeAll()
            tableView.reloadData()
        }
        
    }
    
    @IBAction func viewDataOnClick(_ sender: Any) {
        dummyView.isHidden = false
        viewDataView.isHidden = false
        
        self.timePickerValues.removeAll()
        self.keyArray.removeAll()
        self.dataViewTableView.reloadData()
        self.timePicker.isHidden = true
        self.timePickerLabel.isHidden = true
        self.loadDataButton.isHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return zones.count
        }else{
            return timePickerValues.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return "\(zones[row])"
        }else{
            return "\(timePickerValues[row])"
        }
    }
    
    @IBAction func closeButtonOnClick(_ sender: Any) {
        dummyView.isHidden = true
        viewDataView.isHidden = true
    }
    
    @IBAction func fetchData(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let dateS = formatter.string(from: datePicker.date)
        let selectedZone = zones[zonePicker.selectedRow(inComponent: 0)]
        
        ref.child("ChecklistApp").child("Dates").child(dateS).child(selectedZone).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if value != nil{
                self.timePickerValues.removeAll()
                self.keyArray.removeAll()
                self.dataViewTableView.reloadData()
                self.timePickerValues = (value?.allKeys as? [String])!
                self.returnedData = value!
                self.timePicker.isHidden = false
                self.timePickerLabel.isHidden = false
                self.loadDataButton.isHidden = false
            }
            else{
                self.timePickerValues.removeAll()
                self.keyArray.removeAll()
                self.dataViewTableView.reloadData()
                self.timePicker.isHidden = true
                self.timePickerLabel.isHidden = true
                self.loadDataButton.isHidden = true
            }
            self.timePicker.reloadAllComponents()
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func onRepSelectClick(_ sender: Any) {
        repTableToggle()
    }
    
    func repTableToggle(){
        if repTable.isHidden{
            UIView.animate(withDuration: 0.5){
                self.repTable.isHidden = false
            }
        }
        else{
            UIView.animate(withDuration: 0.5){
                self.repTable.isHidden = true
            }
        }
    }
    
    @IBAction func loadData(_ sender: Any) {
        let time = timePickerValues[timePicker.selectedRow(inComponent: 0)]
        selectedKeyValue = (returnedData.value(forKey: time) as? NSDictionary)!
        keyArray.removeAll()
        keyArray = (selectedKeyValue.allKeys as? [String])!
        keyArray.remove(at: keyArray.index(of: "C-Space GA")!)
        keyArray.remove(at: keyArray.index(of: "Time")!)
        keyArray.remove(at: keyArray.index(of: "Zone")!)
        keyArray.sort()
        keyArray.append("Zone")
        keyArray.append("C-Space GA")
        dataViewTableView.reloadData()
    }
}

