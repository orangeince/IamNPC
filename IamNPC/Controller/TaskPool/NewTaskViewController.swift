//
//  NewTaskViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/8/7.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit


protocol LabelWithTextFieldCellDelegate: class {
    func actionForInput(text: String, atIndex: NSIndexPath)
}

enum TextFieldInputType {
    case Number
    case Decimal
    case Text
}
class LabelWithTextFieldCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    var indexPath: NSIndexPath!
    var inputType = TextFieldInputType.Text
    weak var delegate: LabelWithTextFieldCellDelegate?
    
    func setupCellWith(title: String, count: Int?, atIndex: NSIndexPath, delegate: LabelWithTextFieldCellDelegate) {
        let  content = String(count ?? 1)
        textField.keyboardType = .NumberPad
        inputType = .Number
        textField.clearButtonMode = .Never
        setupCellWith(title, content: content, atIndex: atIndex, delegate: delegate)
        
    }
    func setupCellWith(title: String, bonus: Float?, atIndex: NSIndexPath, delegate: LabelWithTextFieldCellDelegate) {
        let content = String(format: "%.1f", bonus ?? 0)
        textField.keyboardType = .DecimalPad
        inputType = .Decimal
        textField.clearButtonMode = .Never
        textField.textColor = UIColor.orangeColor()
        setupCellWith(title, content: content, atIndex: atIndex, delegate: delegate)
    }
    
    func setupCellWith(title: String, content: String?, atIndex: NSIndexPath, delegate: LabelWithTextFieldCellDelegate) {
        label.text = title
        textField.text = content
        textField.delegate = self
        indexPath = atIndex
        self.delegate = delegate
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField.text ?? "").isEmpty {
            if inputType == .Number {
                textField.text = "1"
            } else if inputType == .Decimal {
                textField.text = "0"
            }
        }
        delegate?.actionForInput(textField.text!, atIndex: indexPath)
    }
}

class NewTaskViewController: npcTableViewController, LabelWithTextFieldCellDelegate, NPCListViewControllerDelegate {

    var task: Task?
    var selectedIndex: NSIndexPath!
    
    enum RowContentType {
        case TitleFiled(String?)
        case BonusFiled(Float?)
        case Npc(NPC?)
        case AppearanceType(TaskAppearanceType?)
        case NeedCompletedCount(Int?)
        
        var title: String {
            switch self {
            case .TitleFiled(_):
                return "内容"
            case .BonusFiled(_):
                return "奖金"
            case .Npc(_):
                return "NPC"
            case .AppearanceType(_):
                return "重复类型"
            case .NeedCompletedCount(_):
                return "可接收次数"
            }
        }
    }
    
    var datasource: [[RowContentType]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "新建任务"
        setupTableView(iTableView) {
            
        }
        loadDatasourceWith(task)
    }
    
    // MARK: TableView datasource & delegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 52
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return datasource.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let content = datasource[indexPath.section][indexPath.row]
        switch content {
        case .TitleFiled(let title):
            let cell = tableView.dequeueReusableCellWithIdentifier("LabelWithTextFieldCell") as! LabelWithTextFieldCell
            cell.setupCellWith(content.title, content: title, atIndex: indexPath, delegate: self)
            return cell
        case .BonusFiled(let bonus):
            let cell = tableView.dequeueReusableCellWithIdentifier("LabelWithTextFieldCell") as! LabelWithTextFieldCell
            cell.setupCellWith(content.title, bonus: bonus, atIndex: indexPath, delegate: self)
            return cell
        case .Npc(let npc):
            let normalCell = UITableViewCell(style: .Value1, reuseIdentifier: nil)
            normalCell.accessoryType = .DisclosureIndicator
            normalCell.textLabel?.text = content.title
            normalCell.detailTextLabel?.text = npc?.name ?? "无"
            return normalCell
        case .AppearanceType(let type):
            let normalCell = UITableViewCell(style: .Value1, reuseIdentifier: nil)
            normalCell.textLabel?.text = content.title
            normalCell.detailTextLabel?.text = type?.description ?? "无"
            return normalCell
        case .NeedCompletedCount(let count):
            let cell = tableView.dequeueReusableCellWithIdentifier("LabelWithTextFieldCell") as! LabelWithTextFieldCell
            cell.setupCellWith(content.title, count: count, atIndex: indexPath, delegate: self)
            return cell
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? LabelWithTextFieldCell {
            cell.textField.becomeFirstResponder()
        } else {
            tableView.endEditing(true)
            let content = datasource[indexPath.section][indexPath.row]
            switch content {
            case .Npc(_):
                let NPCListVC = npcViewController(.TaskPool, identifier: "NPCListViewController") as! NPCListViewController
                NPCListVC.delegate = self
                self.selectedIndex = indexPath
                self.navigationController?.pushViewController(NPCListVC, animated: true)
                return
            case .AppearanceType(_):
                let sheet = UIAlertController(title: "请选择重复类型", message: nil, preferredStyle: .ActionSheet)
                let onceAction = UIAlertAction(title: "仅一次", style: .Default) {
                    [weak self] action in self?.pickedAppearanceType(TaskAppearanceType.Once, atIndex: indexPath)
                }
                let dailyAction = UIAlertAction(title: "每天", style: .Default) {
                    [weak self] action in self?.pickedAppearanceType(TaskAppearanceType.Daily, atIndex: indexPath)
                }
                let weeklyAction = UIAlertAction(title: "每周", style: .Default) {
                    [weak self] action in self?.pickedAppearanceType(TaskAppearanceType.Weekly, atIndex: indexPath)
                }
                let monthlyAction = UIAlertAction(title: "每月", style: .Default) {
                    [weak self] action in self?.pickedAppearanceType(TaskAppearanceType.Mounthly, atIndex: indexPath)
                }
                sheet.addAction(onceAction)
                sheet.addAction(dailyAction)
                sheet.addAction(weeklyAction)
                sheet.addAction(monthlyAction)
                sheet.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
                self.presentViewController(sheet, animated: true, completion: nil)
                return
            default:
                break
            }
        }
    }
    
    // IBAction
    @IBAction func goBack() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save() {
        let contents = datasource.flatMap{$0}
        var taskDict: [String: AnyObject] = [:]
        for content in contents {
            switch content {
            case .TitleFiled(let title):
                if (title ?? "").isEmpty {
                    alertWith("任务内容不能为空", inContainer: self)
                    return
                }
                taskDict["content"] = title
            case .BonusFiled(let bonus):
                taskDict["bonus"] = bonus
            case .Npc(let npc):
                if npc == nil {
                    alertWith("NPC不能为空", inContainer: self)
                    return
                }
                taskDict["npc"] = npc
            case .AppearanceType(let type):
                if type == nil {
                    alertWith("要选择重复类型哦", inContainer: self)
                    return
                }
                taskDict["appearance"] = type?.rawValue
            case .NeedCompletedCount(let count):
                if (count ?? 1) < 1 {
                    alertWith("可完成次数要大于0哦", inContainer: self)
                    return
                }
                taskDict["needCompletedCount"] = count ?? 1
            }
        }
        if task == nil {
            Task.createTaskWith(taskDict)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // MARK: LabelWithTextFieldCellDelegate
    func actionForInput(text: String, atIndex: NSIndexPath) {
        let content = datasource[atIndex.section][atIndex.row]
        switch content {
        case .TitleFiled(_):
            datasource[atIndex.section][atIndex.row] = RowContentType.TitleFiled(text)
        case .BonusFiled(_):
            datasource[atIndex.section][atIndex.row] = RowContentType.BonusFiled(Float(text))
        case .NeedCompletedCount(_):
            datasource[atIndex.section][atIndex.row] = RowContentType.NeedCompletedCount(Int(text))
        default:
            break
        }
    }
    
    // MARK: NPCListViewControllerDelegate
    func actionForPicked(npc: NPC) {
        let content = datasource[selectedIndex.section][selectedIndex.row]
        switch content {
        case .Npc(_):
            datasource[selectedIndex.section][selectedIndex.row] = RowContentType.Npc(npc)
            iTableView.reloadRowsAtIndexPaths([selectedIndex], withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    // MARK: Class Methods
    func loadDatasourceWith(task: Task?) {
        datasource.append([RowContentType.TitleFiled(task?.content),
                           RowContentType.BonusFiled(task?.bonus)])
        
        datasource.append([RowContentType.AppearanceType(task?.appearanceType),
                           RowContentType.NeedCompletedCount(task?.needCompletedCount)])
        
        datasource.append([RowContentType.Npc(task?.npc)])
    }
    
    func pickedAppearanceType(type: TaskAppearanceType, atIndex: NSIndexPath) {
        let content = datasource[atIndex.section][atIndex.row]
        if case .AppearanceType(_) = content {
            datasource[atIndex.section][atIndex.row] = RowContentType.AppearanceType(type)
            iTableView.reloadRowsAtIndexPaths([atIndex], withRowAnimation: .Automatic)
        }
    }
}
