//
//  StudyViewController.swift
//  E-specialist
//
//  Created by YhamIVan on 2020/11/15.
//

import UIKit
import Firebase

class StudyViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDelegate,
                           UITableViewDataSource{
    //    チャットの配列を定義
    var wordArray = [WordModel]()
    
    //    FirebaseDatabaseから取得するテスト
    @IBOutlet weak var testFirebaseLabel: UILabel!
    
    //学習範囲テキストフィールド
    @IBOutlet weak var textField: UITextField!

    //①選択肢のリスト
    let list:[String] = ["600点台問題","700点台問題","800点台問題","900点台問題"]
    
    //②pickerViewの定義
    var pickerView:UIPickerView = UIPickerView()
    
    //      tableviewの定義
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "WordCell", bundle:nil), forCellReuseIdentifier: "Cell")
        
        //        可変
        tableView.rowHeight = UITableView.automaticDimension
        
        //        セルサイズの見積もり
        //        tableView.estimatedRowHeight = 90
        
        //追加するコード
        //③ピッカーの設定
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        //      テーブルビューの設定
        tableView.delegate = self
        tableView.dataSource = self
        
        //④決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定
        textField.inputView = pickerView
        textField.inputAccessoryView = toolbar
        
        let chatDB = Database.database().reference()
        //        Firebaseからデータをfetchしてくる
        fetchChatData()
    }//viewdid
    
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // ドラムロールの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    // 決定ボタン押下
    @objc func done() {
        textField.endEditing(true)
        textField.text = "\(list[pickerView.selectedRow(inComponent: 0)])"
    }
    
    //    テーブルビューの記述
    //    ②[TableView]セクションの中のセルの数を確認しに行く
    //    numberOfRowsInSectionの数だけcellForRowAtが呼ばれる
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //    セルをタップできないようにする
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        
        //        メッセージをセルに配置する
        //        単語名
        cell.textLabel?.text = wordArray[indexPath.row].name
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let wordVC = self.storyboard?.instantiateViewController(identifier: "word") as! WordViewController
        self.navigationController?.pushViewController(wordVC, animated: true)
        
    }
    
    //    FirebaseDatabaseからデータを取得する
    func fetchChatData(){
        //    chatデータをどこから引っ張ってくるか
        let fetchDataRef =
            Database.database().reference().child("600score")
        //      新しく更新が入ってきたときに取得したい
        //        snapShotにデータが入ると中身が実行されるメソッド
        fetchDataRef.observe(.childAdded){(snapShot) in
            let snapShotData = snapShot.value as AnyObject
            let name = snapShotData.value(forKey: "name")
            let honyaku = snapShotData.value(forKey: "honyaku")
            let example = snapShotData.value(forKey: "example")
            
            let wordList = WordModel()
            wordList.name = name as! String
            wordList.honyaku = honyaku as! String
            wordList.example = example as! String
            
            self.wordArray.append(wordList)
            self.tableView.reloadData()
        }
        
    }
        
}
